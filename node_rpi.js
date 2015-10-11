// Name serial port - there should be a smarter way to do this, but this seems easiest
// Using terminal, identify with:
// ls /dev/cu.*
// ls /dev/tty.usbserial-* # for zigbee
// ls /dev/cu.usbmodem* # for arduino

var currentPort = "/dev/tty.usbserial-AH016D5G"; // Direct left Zigbee

var DDPClient = require("ddp");
var moment = require('moment');
moment().format();

var util = require('util');
var SerialPort = require('serialport').SerialPort;

var xbee_api = require('xbee-api');
var C = xbee_api.constants;
var xbeeAPI = new xbee_api.XBeeAPI({
  api_mode: 2
});

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
  var serialPort = new SerialPort(currentPort, {
    // baudrate: 115200,
    baudrate: 9600,
    parser: xbeeAPI.rawParser()
  });

  // SerialPort events - trigger specific functions upon specific events
  serialPort.on('open', function() {
    console.log('port open. Data rate: ' + serialPort.options.baudRate);
  });

  // All frames parsed by the XBee will be emitted here
  xbeeAPI.on("frame_object", function(frame) {
    data = frame.data.toString();
    console.log("Serial: " + data);
    // console.log("OBJ> " + util.inspect(frame));

    var array = data.split(','); // CSV Data Parse:
    array.push( (new Date()).getTime() );
    var dataSet = {
      USER_ID: array[0],
      LATITUDE: array[1],
      LONGITUDE: array[2],
      LONGITUDE: array[3],
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