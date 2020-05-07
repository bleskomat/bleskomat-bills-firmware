const path = require('path');

module.exports = function(config) {
	const dbServicePath = path.join(__dirname, 'node_modules', 'bleskomat-server', 'services', 'database');
	return require(dbServicePath)(config);
};
