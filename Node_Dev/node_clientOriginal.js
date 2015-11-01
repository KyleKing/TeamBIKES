// Name serial port - there should be a smarter way to do this, but this seems easiest
// var currentPort = "/dev/ttyACM0"; // A PC serial port
// var currentPort = "/dev/cu.usbmodem" + "1411"; // direct left port
var currentPort = "/dev/tty.usbserial-AH016D5G"; // Direct left Zigbee
// var currentPort = "/dev/cu.usbmodem" + "1421"; // direct right port
// var currentPort = "/dev/cu.usbmodem" + "14211"; // indirect right port: closest to aux power

var DDPClient = require("ddp");
var moment = require('moment');
moment().format();

var xbee = require("xbee");

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
    // baudrate: 115200,
    baudrate: 9600,
    // look for return and newline at the end of each data packet:
    // parser: serialport.parsers.readline("\r\n")
    // look for ; character to signify end of line
    // parser: serialport.parsers.readline(";")
    parser: xbee.packetParser()
  });

  function showPortOpen() {
    console.log('port open. Data rate: ' + serialPort.options.baudRate);
  }

  function saveLatestData(data) {

    console.log('xbee data received:', data.data);

    // var array = data.split(';'); // CSV Data Parse:
    // array[1] = (new Date()).getTime();
    // var dataSet = {
    //   RFIDCode: array[0],
    //   time: array[1]
    // };

    // // Call Meteor actions with "data"
    // ddpclient.call('RFIDStreamData', [dataSet], function(err, result) {
    //   console.log('data sent: ' + array);

    //   // // P-J's Suggestion
    //   // var CryptoJS = require("crypto-js");
    //   // var info = { message: "This is my message !", key: "Dino" };

    //   // var encrypted = CryptoJS.AES.encrypt(info.message, info.key, {
    //   //     mode: CryptoJS.mode.CBC,
    //   //     padding: CryptoJS.pad.Pkcs7
    //   // });
    //   // var decrypted = CryptoJS.AES.decrypt(result, info.key, {
    //   //     mode: CryptoJS.mode.CBC,
    //   //     padding: CryptoJS.pad.Pkcs7
    //   // });
    //   // // console.log(encrypted.toString());
    //   // console.log('Decrypted result: '+ decrypted.toString(CryptoJS.enc.Utf8));

    //   console.log('called RFIDStreamData function, result: ' + result);
    //   if (result != undefined) {
    //     serialPort.write(result);
    //   }
    //   console.log(' ');
    // });
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