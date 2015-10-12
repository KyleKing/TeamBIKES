// Name serial port - there should be a smarter way to do this, but this seems easiest
// Using terminal, identify with:
// ls /dev/cu.*
// ls /dev/tty.usbserial-* # for zigbee
// ls /dev/cu.usbmodem* # for arduino

var currentPort = "/dev/cu.usbmodem" + "1411"; // direct left port

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

  // Configure serial port note: three different version of (Ss)eriel(Pp)ort
  var serialport = require("serialport");
  var SerialPort = serialport.SerialPort; // localize object constructor
  var serialPort = new SerialPort(currentPort, {
    // baudrate: 115200,
    baudrate: 9600,
    parser: serialport.parsers.readline("\n")
  });

  // SerialPort events - trigger specific functions upon specific events
  serialPort.on('open', function() {
    console.log('port open. Data rate: ' + serialPort.options.baudRate);
  });


  serialPort.on("data", function(data) {
    // data = frame.data.toString();
    console.log("Serial: " + data);

    var array = data.trim().split(','); // CSV Data Parse and remove excess whitespace
    array.push( (new Date()).getTime() );
    var dataSet = {
      USER_ID: array[0],
      LATITUDE: array[1],
      LONGITUDE: array[2],
      LOCKSTATEE: array[3],
      TIMESTAMP: array[4]
    };

    // Call Meteor actions with "dataSet"
    ddpclient.call('RFIDStreamData', [dataSet], function(err, result) {
      console.log('Sent to Meteor: ' + array);

      // // P-J's Suggestion
      // var CryptoJS = require("crypto-js");
      // var info = { message: "This is my message !", key: "Dino" };

      // var encrypted = CryptoJS.AES.encrypt(info.message, info.key, {
      //     mode: CryptoJS.mode.CBC,
      //     padding: CryptoJS.pad.Pkcs7
      // });
      // var decrypted = CryptoJS.AES.decrypt(result, info.key, {
      //     mode: CryptoJS.mode.CBC,
      //     padding: CryptoJS.pad.Pkcs7
      // });
      // // console.log(encrypted.toString());
      // console.log('Decrypted result: '+ decrypted.toString(CryptoJS.enc.Utf8));

      console.log('Result: ' + result);
      if (result != undefined) {
        serialPort.write(result);
      }
      console.log(' ');
    });
  });

  serialPort.on('close', function() {
    console.log('port closed.');
  });
  serialPort.on('error', function(error) {
    console.log('Serial port error: ' + error);
  });
});