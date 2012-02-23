exports.settings = 
	descr: 'local'
	web:
		host: 'localhost'
		port: process.argv.slice(2)[0] or "1080"
		account: 'vip32'
		name: 'testclient1'
	tracker:
		host: 'localhost'
		port: 1200  
