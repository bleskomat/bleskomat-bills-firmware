const _ = require('underscore');
const crypto = require('crypto');

const apiKeyId = process.argv[2];
const useDummyValues = !apiKeyId;

if (!useDummyValues && !require('../config').fileExists(false)) {
	// Intent to use real configuration values.
	// Config file is required.
	if (!require('../config').fileExists(true)) {
		// No configuration file exists.
		console.error('ERROR: Config file not found. Use `npm run config -- init` to create it.');
	} else {
		// An encrypted config file exists.
		// But the build process requires it to be unencrypted.
		console.error('ERROR: Unencrypted config file not found. Use `npm run config -- decrypt` to create it.');
	}
	process.exit(1);
}

const fiatCurrencyCoinValues = {
	'CZK': '1,2,5,10,20,50',
	'EUR': '0.05,0.10,0.20,0.50,1,2',
};

const fiatCurrencyBillValues = {
	'CZK': '100,200,500,1000,2000,5000',
	'EUR': '5,10,20,50,100,200',
};

const prepareDummyValues = function() {
	const encoding = 'hex';
	const fiatCurrency = 'CZK';
	return {
		'apiKey.id': crypto.randomBytes(8).toString(encoding),
		'apiKey.key': crypto.randomBytes(32).toString(encoding),
		'apiKey.encoding': encoding,
		'callbackUrl': 'https://localhost:3000/lnurl',
		'fiatCurrency': fiatCurrency,
		'shorten': true,
		'coinValues': fiatCurrencyCoinValues[fiatCurrency],
		'billValues': fiatCurrencyBillValues[fiatCurrency],
	};
};

const printDummyValues = function() {
	const values = prepareDummyValues();
	writeConfigFileLines(values);
};

const writeConfigFileLines = function(values) {
	const output = Object.keys(values).map(function(key) {
		const value = values[key];
		// Use single quotes around whole build flag definition + double-quotes around value:
		return `${key}=${value}`;
	}).join('\n');
	process.stdout.write(output);
};

if (useDummyValues) {
	printDummyValues();
	process.exit();
}

require('../config').load().then(config => {
	if (!config) {
		// Use dummy values for required build flags.
		return prepareDummyValues();
	}
	const db = require('../db')(config);
	return db.onReady().then(() => {
		return db.getApiKey(apiKeyId).then(apiKey => {
			if (!apiKey) {
				throw new Error(`API key not found: "${apiKeyId}"`);
			}
			const { host, port, url, protocol, endpoint } = config.lnurl;
			const fiatCurrency = apiKey.fiatCurrency || 'CZK';
			return {
				'apiKey.id': apiKey.id,
				'apiKey.key': apiKey.key,
				'apiKey.encoding': apiKey.encoding,
				'callbackUrl': (url ? url : `${protocol}://${host}:${port}`) + endpoint,
				'fiatCurrency': fiatCurrency,
				'shorten': true,
				'coinValues': fiatCurrencyCoinValues[fiatCurrency],
				'billValues': fiatCurrencyBillValues[fiatCurrency],
			};
		});
	});
}).then(values => {
	writeConfigFileLines(values);
	process.exit();
}).catch(error => {
	console.error(error);
	process.exit(1);
});

