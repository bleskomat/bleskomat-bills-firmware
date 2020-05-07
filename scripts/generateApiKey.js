require('../config').load({ create: true }).then(config => {
	if (!config) return;
	const db = require('../db')(config);
	return db.generateApiKey({ save: true }).then(apiKey => {
		// Print generated API key to console.
		console.log(JSON.stringify(apiKey));
		process.exit();
	});
}).catch(error => {
	console.error('ERROR: ' + error.message);
	process.exit(1);
});
