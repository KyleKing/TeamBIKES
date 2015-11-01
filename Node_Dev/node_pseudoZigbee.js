// Name serial port - there should be a smarter way to do this, but this seems easiest
// Using terminal, identify with:
// ls /dev/cu.*
// ls /dev/tty.usbserial-* # for zigbee
// ls /dev/cu.usbmodem* # for arduino

var currentPort = "/dev/cu.usbmodem" + "1411"; // direct left port

var DDPClient = require("ddp");
var login = require('ddp-login');
var moment = require('moment');
moment().format();

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