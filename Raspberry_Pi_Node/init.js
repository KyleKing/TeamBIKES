// Connects to a serial device (Arduino or XBee/ZIgbee) automatically
// Then reacts to incoming serial data in a csv format with ';' or
//    XBee frames respectively
// Collected data is parsed into a specific array that is then sent over a
//    DDP connection to a locally hosted meteor application by calling the
//    RFIDStream method

// TODO
// Currently installed:
// npm install serialport util moment cli-color ddp xbee-api --save
// Still need:
// npm install ddp-login --save

var lastID = '',
  lastModule_ID = '';

var util = require('util');
var clc = require('cli-color'),
  info = clc.blue,
  h1 = info.bold,
  warn = clc.yellow;

var PythonShell = require('python-shell'),
  pyshell = new PythonShell('lcd.py');
pyshell.send('Coordinator Initialized');
pyshell.on('message', function (message) {
  console.log(message);
});
// Breaks function...
// pyshell.end(function (err) {
//   if (err) throw err;
//   console.log(warn('Python Shell Closed'));
// });

var moment = require('moment');
moment().format();

var xbee_api = require('xbee-api'),
  C = xbee_api.constants;
xbeeAPI = new xbee_api.XBeeAPI({
  api_mode: 2
});


var currentHost = ['localhost', 3000];
// var currentHost = ['somewebsite', 3000];

// var serialport = require('serialport'),
//   SerialPort = serialport.SerialPort,
//   DDPClient = require('ddp');
// var ddpclient = new DDPClient({
//   host: currentHost[0],
//   port: currentHost[1],
//   auto_reconnect: true,
//   auto_reconnect_timer: 500,
//   use_ejson: true,
//   use_ssl: false,
//   use_ssl_strict: true,
//   maintain_collections: true
// });

// function parseInput(frame) {
//   data = frame.data.toString();
//   console.log('* Converted To: ' + data);
//   array = data.split(',');
//   return dataSet = {
//     USER_ID: array[0],
//     LATITUDE: array[1],
//     LONGITUDE: array[2],
//     LOCKSTATEE: array[3],
//     Module_ID: array[4],
//     TIMESTAMP: (new Date).getTime()
//   };
// }


// ddpclient.connect(function(error) {
//   if (error) {
//     throw error;
//   } else {
//     console.log(info('Connected to Meteor!'));
//   }
//   serialport.list(function(err, ports) {
//     return ports.forEach(function(port) {
//       console.log(port);
//       console.log(port.comName + '\n');

//       // See rpi.coffee in Raspberry_Pi_Meteor for example Crypto.js script

//       // Figure out active Serial Port - Automatic Method
//       // Using terminal, identify with:
//       // ls /dev/cu.*
//       if (port.comName.match(/\/dev\/tty.usbserial-*/)) {
//         xbee_createSerial(port.comName);
//       }
//       if (port.comName.match(/\/dev\/cu.usbmodem*/)) {
//         arduino_createSerial(port.comName);
//       }
//     });
//   });
// });

// arduino_createSerial = function(currentPort) {
//   console.log(warn('Created New Serial Port Connection to ' +
//     currentPort));
//   var arduino_serialPort = new SerialPort(currentPort, {
//     baudrate: 9600,
//     parser: serialport.parsers.readline("\n")
//   });
//   arduino_serialPort.on('open', function() {
//     return console.log('SerialPort is open with rate of ' +
//       arduino_serialPort.options.baudRate);
//   });
//   arduino_serialPort.on('data', function(frame) {
//     var array, data, dataSet;
//     console.log(h1('----------*----------'));
//     console.log('* Received Frame:');
//     console.log(frame);
//     dataSet = parseInput(frame);
//     return ddpclient.call('RFIDStreamData', [dataSet], function(err, res) {
//       console.log('>> Sent to Meteor: ' + array);
//       if (res !== void 0 && res.data !== void 0) {
//         if (res.Address === void 0) {
//           console.log(warn("Warning: BROADCASTING TO ALL XBEE's, " +
//             "I hope you know what you are doing."));
//         }
//         console.log('>> Writing ' + res.data);
//         arduino_serialPort.write(res.data);
//       }
//     });
//   });
//   arduino_serialPort.on('close', function() {
//     return console.log(warn('port closed.'));
//   });
//   return arduino_serialPort.on('error', function(error) {
//     return console.log(warn('Serial port error: ' + error));
//   });
// };

// xbee_createSerial = function(currentPort) {
//   console.log(warn('Created New Serial Port Connection to ' +
//     currentPort));
//   var xbee_serialPort = new SerialPort(currentPort, {
//     baudrate: 9600,
//     parser: xbeeAPI.rawParser()
//   });
//   xbee_serialPort.on('open', function() {
//     return console.log('SerialPort is open with rate of ' +
//       xbee_serialPort.options.baudRate);
//   });
//   xbeeAPI.on('frame_object', function(frame) {
//     var array, data, dataSet;
//     console.log(h1('----------*----------'));
//     console.log('* Received Frame:');
//     console.log(frame);
//     if (frame.data === undefined) {
//       if (frame.deliveryStatus === 0) {
//         console.log(info('>> Data was delivered!'));
//         return console.log(info(frame + '\n'));
//       } else {
//         console.log(warn('>> No data in frame received'));
//         console.log(warn('   Data was not received'));
//         return console.log(warn('   ' + frame + '\n'));
//       }
//     } else {
//       dataSet = parseInput(frame);
//       // Not sure if this is necessary:
//       // if dataSet.USER_ID isnt lastID
//       if (true === true && false === false) {
//         lastID = dataSet.USER_ID;
//         return ddpclient.call('RFIDStreamData', [dataSet], function(err, res) {
//           var frame_obj;
//           console.log('>> Sent to Meteor: ' + array);
//           if (res !== void 0 && res.data !== void 0) {
//             if (res.Address === void 0) {
//               console.log(warn("Warning: BROADCASTING TO ALL XBEE's, " +
//                 "I hope you know what you are doing."));
//             }
//             frame_obj = {
//               type: 0x10,
//               id: 0x01,
//               destination64: res.Address,
//               destination16: 'fffe',
//               broadcastRadius: 0x00,
//               options: 0x00,
//               data: res.data
//             };
//             xbee_serialPort.write(xbeeAPI.buildFrame(frame_obj));
//             console.log(h1('Frame sent to specific xbee: ' + res.Address));
//             console.log(h1(xbeeAPI.buildFrame(frame_obj)));
//           }
//           console.log('----------!----------');
//           return console.log('');
//         });
//       } else {
//         return console.log('Received a duplicate frame');
//       }
//     }
//   });
//   xbee_serialPort.on('close', function() {
//     return console.log(warn('port closed.'));
//   });
//   return xbee_serialPort.on('error', function(error) {
//     return console.log(warn('Serial port error: ' + error));
//   });
// };
