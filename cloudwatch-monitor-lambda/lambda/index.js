import { uuid as _uuid } from '/opt/node_modules/uuidv4';

export async function handler() { 
	console.log(_uuid);
	return '';
}