// Name serial port - there should be a smarter way to do this, but this seems easiest
// var currentPort = "/dev/ttyACM0"; // A PC serial port
// var currentPort = "/dev/cu.usbmodem" + "1411"; // direct left port
var currentPort = "/dev/cu.usbmodem" + "1421"; // direct right port
// var currentPort = "/dev/cu.usbmodem" + "14211"; // indirect right port: closest to aux power

var DDPClient = require("ddp");
var moment = require('moment');
moment().format();

// var CryptoJS = (require('cryptojs')).Crypto;

// Guide: https://blog.nraboy.com/2014/10/implement-aes-strength-encryption-javascript/
// var forge = require('node-forge');

// // Remote connections:
// var ddpclient = new DDPClient({
//   host: "teambikes.me",
//   port: 80,
//   auto_reconnect: true,
//   auto_reconnect_timer: 500
// });
// // Source: https://github.com/oortcloud/node-ddp-client/issues/21

// Connect to Meteor
var ddpclient = new DDPClient({
  host: "localhost",
  port: 3000,
  /* optional: */
  auto_reconnect: true,
  auto_reconnect_timer: 500,
  use_ejson: true,  // default is false
  use_ssl: false, //connect to SSL server,
  use_ssl_strict: true, //Set to false if you have root ca trouble.
  maintain_collections: true //Set to false to maintain your own collections.
});

ddpclient.connect(function(error) {
  // Error Checking
  if (error) {
    console.log('DDP connection error!');
    return;
  }
  console.log('connected to Meteor!');

  // Configure serial port
  var serialport = require("serialport");
  var SerialPort = serialport.SerialPort; // localize object constructor
  var serialPort = new SerialPort(currentPort, {
    baudrate: 115200,
    // look for return and newline at the end of each data packet:
    // parser: serialport.parsers.readline("\r\n")
    // look for ; character to signify end of line
    parser: serialport.parsers.readline(";")
  });

  function showPortOpen() { console.log('port open. Data rate: ' + serialPort.options.baudRate); }
  function saveLatestData(data) {

    var array = data.split(','); // CSV Data Parse:
    array[1] = (new Date()).getTime();
    var dataSet = {
      RFIDCode: array[0],
      time: array[1]
    };

    // Call Meteor actions with "data"
    ddpclient.call('RFIDStreamData', [dataSet], function(err, result) {
      console.log('data sent: ' + array);


key = 'Dino';
message = 'hi';

// Alt #1: Source: http://lollyrock.com/articles/nodejs-encryption/
// Nodejs encryption with cbc
var crypto = require('crypto'),
    algorithm = 'aes-256-cbc',
    password = key;

function encrypt(text){
  var cipher = crypto.createCipher(algorithm,password);
  var crypted = cipher.update(text,'utf8','hex');
  crypted += cipher.final('hex');
  return crypted;
}

function decrypt(text){
  var decipher = crypto.createDecipher(algorithm,password);
  var dec = decipher.update(text,'hex','utf8');
  dec += decipher.final('utf8');
  return dec;
}

var encrypted = encrypt(message);
console.log(encrypted);
console.log(decrypt(encrypted));
// console.log(decrypt(result));



// // Alt #2: SOurce: http://stackoverflow.com/questions/21292142/decyrpting-aes256-with-node-js-returns-wrong-final-block-length
// var crypto = require('crypto');

// var AESCrypt = {};

// AESCrypt.decrypt = function(cryptkey, iv, encryptdata) {
//   encryptdata = new Buffer(encryptdata, 'base64').toString('binary');

//   var decipher = crypto.createDecipheriv('aes-256-cbc', cryptkey, iv),
//   decoded = decipher.update(encryptdata, 'binary', 'utf8');

//   decoded += decipher.final('utf8');
//   return decoded;
// };

// AESCrypt.encrypt = function(cryptkey, iv, cleardata) {
//   var encipher = crypto.createCipheriv('aes-256-cbc', cryptkey, iv),
//   encryptdata = encipher.update(cleardata, 'utf8', 'binary');

//   encryptdata += encipher.final('binary');
//   encode_encryptdata = new Buffer(encryptdata, 'binary').toString('base64');
//   return encode_encryptdata;
// };

// var cryptkey = crypto.createHash('sha256').update('Nixnogen').digest(),
// iv = 'a2xhcgAAAAAAAAAA',
// buf = "Here is some data for the encrypt", // 32 chars
// enc = AESCrypt.encrypt(cryptkey, iv, buf);
// var dec = AESCrypt.decrypt(cryptkey, iv, enc);

// console.warn("encrypt length: ", enc.length);
// console.warn("encrypt in Base64:", enc);
// console.warn("decrypt all: " + dec);
      // var encrypted = CryptoJS.AES.encrypt(dataSet.RFIDCode.toString(), 'Dino');
      // console.log(encrypted.toString());
      // decrypted = CryptoJS.AES.decrypt('qMZPtYQliAsqvXJtWfg3Fjg=', "Dino");
      // console.log(decrypted);
      // decrypted2 = CryptoJS.AES.decrypt('U2FsdGVkX1/SNhyKDLJTeZfy58CaAlzvVdc03tH9Syk=', "Dino");
      // console.log(decrypted2.toString());
      console.log('called RFIDStreamData function, result: ' + result);
      console.log(' ');
    });
  }

  // Error Checking
  function showPortClose() { console.log('port closed.'); }
  function showError(error) { console.log('Serial port error: ' + error); }

  // Node events - trigger specific functions upon specific events
  serialPort.on('open', showPortOpen);
  serialPort.on('data', saveLatestData);
  serialPort.on('close', showPortClose);
  serialPort.on('error', showError);
});