const cmd = process.argv[2];
if (!cmd) {
	console.error('ERROR: "cmd" required\n\nUsage: SCRIPT <cmd>');
	process.exit(1);
}
const config = require('../config');
if (!config[cmd]) {
	console.error(`ERROR: Unknown command: "${cmd}"`);
	process.exit(1);
}
let options;
switch (cmd) {
	case 'init':
		options = { create: true };
		break;
}
config[cmd](options).then(() => {
	process.exit();
}).catch(error => {
	console.error('ERROR: ' + error.message);
	process.exit(1);
});

