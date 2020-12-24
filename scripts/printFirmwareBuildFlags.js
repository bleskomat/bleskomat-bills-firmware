const printBuildFlags = function(buildFlags) {
	const output = Object.keys(buildFlags).map(function(name) {
		const value = buildFlags[name];
		// Use single quotes around whole build flag definition + double-quotes around value:
		return `'-D ${name}="${value}"'`;
	}).join('\n');
	process.stdout.write(output);
};

const pkg = require('../package.json');
const { spawn } = require('child_process');
const cli = [];
const child = spawn('git', [ 'rev-parse', 'HEAD' ]);
let stdout = '';
let stderr = '';
child.stdout.on('data', function(data) {
	if (data) {
		stdout += data.toString();
	}
});
child.stderr.on('data', function(data) {
	if (data) {
		stderr += data.toString();
	}
});
child.stdin.end();
child.on('close', () => {
	if (stderr) {
		console.error(stderr.trim());
		process.exit(1);
	}
	const commitHash = stdout.trim();
	const buildFlags = {
		FIRMWARE_VERSION: pkg.version,
		FIRMWARE_COMMIT_HASH: commitHash,
	};
	printBuildFlags(buildFlags);
});
