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

// Config
var ddpclient = new DDPClient({
  // Remote
  // Source: https://github.com/oortcloud/node-ddp-client/issues/21
  host: "redbarbikes.com",
  port: 80,
  auto_reconnect: true

  // // Local
  // host: "localhost",
  // port: 3000,
  // /* optional: */
  // auto_reconnect: true,
  // auto_reconnect_timer: 500,
  // use_ejson: true,  // default is false
  // use_ssl: false, //connect to SSL server,
  // use_ssl_strict: true, //Set to false if you have root ca trouble.
  // maintain_collections: true //Set to false to maintain your own collections.
});
// Connect to Meteor
ddpclient.connect(function(error) {
  // Error Checking
  if (error) throw error;
  console.log('connected to Meteor!');
  // // Login - Note may not work?
  // login(ddpclient,
  //   {  // Options below are the defaults
  //      env: 'METEOR_TOKEN',  // Name of an environment variable to check for a
  //                            // token. If a token is found and is good,
  //                            // authentication will require no user interaction.
  //      method: 'email',    // Login method: account, email, username or token
  //      account: 'admin@example.com',        // Prompt for account info by default
  //      pass: 'password',           // Prompt for password by default
  //      retry: 2,             // Number of login attempts to make
  //      plaintext: false      // Do not fallback to plaintext password compatibility
  //                            // for older non-bcrypt accounts
  //   },
  //   function (error, userInfo) {
  //     if (error) {
  //       // Something went wrong...
  //       console.log('error');
  //     } else {
  //       // We are now logged in, with userInfo.token as our session auth token.
  //       token = userInfo.token;
  //     }
  //   }
  // );

  // Configure serial port
  var serialPort = new SerialPort(currentPort, {
    // baudrate: 115200,
    baudrate: 9600,
    parser: xbeeAPI.rawParser()
  });

  // SerialPort events - trigger specific functions upon specific events
  serialPort.on('open', function() {
    console.log('port open. Data rate: ' + serialPort.options.baudRate);

    var frame_obj = {
      type: 0x17, // xbee_api.constants.FRAME_TYPE.REMOTE_AT_COMMAND_REQUEST
      id: 0x01, // optional, nextFrameId() is called per default
      // destination64: "0013A20040B7B31F", // End
      destination64: "0013A20040C5F8BA", // R
      destination16: "fffe", // optional, "fffe" is default
      remoteCommandOptions: 0x02, // optional, 0x02 is default
      command: "d1", // MUST BE LOWERCASE
      commandParameter: [ 0x05 ] // Can either be string or byte array.
    };
    // { // AT Request to be sent to
    //   type: C.FRAME_TYPE.AT_COMMAND,
    //   command: "NI",
    //   commandParameter: [],
    // };

    serialPort.write(xbeeAPI.buildFrame(frame_obj));
    console.log(xbeeAPI.buildFrame(frame_obj));
  });

  // // All frames parsed by the XBee will be emitted here
  // xbeeAPI.on("frame_object", function(frame) {
  //   data = frame.data.toString();
  //   console.log("Serial: " + data);
  //   // console.log("OBJ> " + util.inspect(frame));

  //   var array = data.split(','); // CSV Data Parse:
  //   array.push( (new Date()).getTime() );
  //   var dataSet = {
  //     USER_ID: array[0],
  //     LATITUDE: array[1],
  //     LONGITUDE: array[2],
  //     LOCKSTATEE: array[3],
  //     TIMESTAMP: array[4]
  //   };

  //   // Call Meteor actions with "dataSet"
  //   ddpclient.call('RFIDStreamData', [dataSet], function(err, result) {
  //     console.log('Sent to Meteor: ' + array);

  //     // // P-J's Suggestion
  //     // var CryptoJS = require("crypto-js");
  //     // var info = { message: "This is my message !", key: "Dino" };

  //     // var encrypted = CryptoJS.AES.encrypt(info.message, info.key, {
  //     //     mode: CryptoJS.mode.CBC,
  //     //     padding: CryptoJS.pad.Pkcs7
  //     // });
  //     // var decrypted = CryptoJS.AES.decrypt(result, info.key, {
  //     //     mode: CryptoJS.mode.CBC,
  //     //     padding: CryptoJS.pad.Pkcs7
  //     // });
  //     // // console.log(encrypted.toString());
  //     // console.log('Decrypted result: '+ decrypted.toString(CryptoJS.enc.Utf8));

  //     console.log('Result: ' + result);
  //     if (result != undefined) {
  //       serialPort.write(result);
  //     }
  //     console.log(' ');
  //   });
  // });

  serialPort.on('close', function() {
    console.log('port closed.');
  });
  serialPort.on('error', function(error) {
    console.log('Serial port error: ' + error);
  });
});