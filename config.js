const _ = require('underscore');
const async = require('async');
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');
const readline = require('readline');
const { Writable } = require('stream');

const configFilePath = path.join(__dirname, 'config.json');
const encryptedConfigFilePath = configFilePath + '.enc';

const getExampleConfig = function() {
	// Use the example config file as a starting point.
	return require(path.join(__dirname, 'node_modules', 'bleskomat-server', 'config-example.json'));
};

const encryptedConfigFileExists = function() {
	return configFileExists(true);
};

const configFileExists = function(encrypted) {
	try {
		fs.statSync(encrypted ? encryptedConfigFilePath : configFilePath);
	} catch (error) {
		if (error.message.substr(0, 'ENOENT: no such file or directory'.length) !== 'ENOENT: no such file or directory') {
			console.error(error);
			process.exit(1);
		}
		return false;
	}
	return true;
};

const saveConfigFile = function(config, password) {
	const filePath = password ? encryptedConfigFilePath : configFilePath;
	return new Promise((resolve, reject) => {
		let data;
		try {
			// Save to config.json.
			data = JSON.stringify(config, null, 4);
			if (password) {
				data = encrypt(data, password);
			}
		} catch (error) {
			return reject(error);
		}
		fs.writeFile(filePath, data, error => {
			if (error) return reject(error);
			resolve();
		});
	});
};

const readConfigFile = function(password) {
	const filePath = password ? encryptedConfigFilePath : configFilePath;
	return new Promise((resolve, reject) => {
		fs.readFile(filePath, (error, contents) => {
			if (error) return reject(error);
			let data = contents.toString();
			if (password) {
				try {
					data = decrypt(data, password);
				} catch (error) {
					return reject(new Error('Unable to decrypt config file. Did you enter the correct password?'));
				}
			}
			const config = JSON.parse(data);
			if (!config || !_.isObject(config) || !_.isObject(config.web)) {
				return reject(new Error('Unexpected data structure.'));
			}
			resolve(config || null);
		});
	});
};

const askForManyInputs = function(optionsArray) {
	return new Promise((resolve, reject) => {
		let values = {};
		async.eachSeries(optionsArray, (options, next) => {
			askForInput(options).then(value => {
				values[options.name] = value;
				next();
			}).catch(next);
		}, error => {
			if (error) return reject(error);
			resolve(values);
		});
	});
};

const askForInput = function(options) {
	options = options || {};
	options.hide = options.hide === true;
	const { name, text, defaultValue } = options;
	let promptText = `${text}`;
	if (!_.isUndefined(defaultValue)) {
		promptText += ` (default: "${defaultValue}")`;
	}
	promptText += ': ';
	let muted = false;
	// Use "mutable" stdout to be able to hide output - e.g for passwords.
	const mutableStdout = new Writable({
		write: function(chunk, encoding, callback) {
			if (!muted) {
				process.stdout.write(chunk, encoding);
			}
			callback();
		},
	});
	const rl = readline.createInterface({
		input: process.stdin,
		output: mutableStdout,
		terminal: true,
	});
	return new Promise((resolve, reject) => {
		let value;
		let asked = false;
		async.until(function(next) {
			next(null, !!value);
		}, function(next) {
			muted = false;
			if (asked) {
				promptText = 'ERROR: Please provide a non-empty value to continue.';
			}
			rl.question(promptText, answer => {
				value = answer || defaultValue;
				next();
			});
			if (options.hide) {
				console.log();// Print new line.
				muted = true;
			}
			asked = true;
		}, function(error) {
			rl.close();
			mutableStdout.destroy();
			if (error) return reject(error);
			resolve(value);
		});
	});
};

const encrypt = function(plaintext, password) {
	const encrypt = crypto.createCipher('aes256', password);
	let encrypted = encrypt.update(plaintext, 'utf8', 'hex');
	encrypted += encrypt.final('hex');
	return encrypted;
};

const decrypt = function(encrypted, password) {
	const decrypt = crypto.createDecipher('aes256', password);
	let decrypted = decrypt.update(encrypted, 'hex', 'utf8');
	decrypted += decrypt.final();
	return decrypted;
};

const checkDbConnectionInfo = function(config) {
	const db = require('./db')(config);
	process.stdout.write('Checking database connection info...');
	return db.onReady().then(() => {
		return db.knex('apiKeys').count().then(() => {
			process.stdout.write('OK\n');
			return true;
		});
	});
};

const checkEncryptionKey = function(config) {
	const db = require('./db')(config);
	const { encryptionKey } = config;
	process.stdout.write('Checking encryption key...');
	return db.knex('apiKeys').select().limit(3).then(results => {
		_.every(results, result => {
			decrypt(result.key, encryptionKey);
		});
		process.stdout.write('OK\n');
		return true;
	});
};

module.exports = {
	fileExists: function(encrypted) {
		return configFileExists(encrypted);
	},
	encrypt: function() {
		if (!configFileExists()) {
			return Promise.reject(new Error('Unencrypted config file not found.'));
		}
		return readConfigFile().then(config => {
			return askForManyInputs([
				{
					name: 'password',
					text: 'Password (to encrypt local config file)',
					hide: true,
				},
				{
					name: 'passwordAgain',
					text: 'Password (again)',
					hide: true,
				},
			]).then(values => {
				if (values.password !== values.passwordAgain) {
					throw new Error('"Password" and "Password (again)" didn\'t match!');
				}
				return saveConfigFile(config, values.password);
			});
		});
	},
	decrypt: function() {
		if (!encryptedConfigFileExists()) {
			return Promise.reject(new Error('Encrypted config file not found.'));
		}
		return askForInput({
			text: 'Enter password to decrypt config file',
			hide: true,
		}).then(password => {
			return readConfigFile(password).then(config => {
				return saveConfigFile(config);
			});
		});
	},
	load: function(options) {
		options = _.defaults(options || {}, {
			create: false,
		});
		if (configFileExists()) {
			// Unencrypted config file exists.
			return readConfigFile();
		} else if (encryptedConfigFileExists()) {
			// Encrypted configuration file exists.
			// Ask for the password to decrypt it.
			return askForInput({
				text: 'Enter password to decrypt config file',
				hide: true,
			}).then(password => {
				return readConfigFile(password);
			});
		}
		// Configuration file doesn't exist yet.
		if (!options.create) {
			// Do not start the creation process.
			return Promise.resolve(null);
		}
		// Let's create one.
		return askForInput({
			text: 'Configuration file not found. Create a new one? (y/n)',
			defaultValue: 'y',
		}).then(answer => {
			if (answer.toLowerCase() !== 'y') {
				console.log('Aborting...');
				return null;
			}
			return askForInput({
				text: 'Do you want to encrypt the configuration file generated by this script? (y/n)',
				defaultValue: 'n',
			}).then(answer => {
				const encryptConfigFile = answer.toLowerCase() === 'y';
				let config = getExampleConfig();
				let inputOptions = [
					{
						name: 'url',
						text: 'Server URL (externally reachable)',
						defaultValue: 'http://' + config.lnurl.host + ':' + config.lnurl.port,
					},
					{
						name: 'db.user',
						text: 'Database Host',
						defaultValue: config.web.knex.connection.host,
					},
					{
						name: 'db.port',
						text: 'Database Port',
						defaultValue: config.web.knex.connection.port,
					},
					{
						name: 'db.user',
						text: 'Database User',
						defaultValue: config.web.knex.connection.user,
					},
					{
						name: 'db.pass',
						text: 'Database Password',
						defaultValue: config.web.knex.connection.password,
						hide: true,
					},
					{
						name: 'db.name',
						text: 'Database Name',
						defaultValue: config.web.knex.connection.database,
					},
					{
						name: 'encryptionKey',
						text: 'Encryption Key',
						hide: true,
					},
				];
				if (encryptConfigFile) {
					inputOptions.push({
						name: 'password',
						text: 'Password (to encrypt local config file)',
						hide: true,
					});
					inputOptions.push({
						name: 'passwordAgain',
						text: 'Password (again)',
						hide: true,
					});
				}
				return askForManyInputs(inputOptions).then(values => {
					if (encryptConfigFile) {
						if (values.password !== values.passwordAgain) {
							throw new Error('"Password" and "Password (again)" didn\'t match!');
						}
					}
					config.lnurl.url = values['url'];
					config.web.knex.connection.host = values['db.host'];
					config.web.knex.connection.port = parseInt(values['db.port']);
					config.web.knex.connection.user = values['db.user'];
					config.web.knex.connection.password = values['db.pass'];
					config.web.knex.connection.database = values['db.name'];
					config.encryptionKey = values['encryptionKey'];
					// Don't do migrations - the server can (and should) handle that on its own:
					config.web.knex.migrations = null;
					return checkDbConnectionInfo(config).then(() => {
						return checkEncryptionKey(config).then(() => {
							return saveConfigFile(config, values.password || null).then(() => {
								return config;
							});
						});
					});
				});
			});
		});
	},
};
