
// NOTE: Use "/opt/" to get dependencies from layer
const uuid = require('/opt/node_modules/uuidv4');
var fs = require('fs');

exports.handler = async () => { 
	console.log(uuid.uuid());
	const files = fs.readdirSync('/opt');
	console.log(files);
	return '';
};