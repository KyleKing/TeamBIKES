// //
// // Basic Example: https://github.com/jankolkmeier/xbee-api#examples

// var util = require('util');
// var SerialPort = require('serialport').SerialPort;
// var xbee_api = require('xbee-api');

// var C = xbee_api.constants;

// var xbeeAPI = new xbee_api.XBeeAPI({
//   api_mode: 1
//   // api_mode: 2 ?
// });

// var serialport = new SerialPort("/dev/ttyUSB0", {
//   baudrate: 9600,
//   parser: xbeeAPI.rawParser()
// });

// serialport.on("open", function() {
//   console.log('port open. Data rate: ' + serialport.options.baudRate);
// });

// // All frames parsed by the XBee will be emitted here
// xbeeAPI.on("frame_object", function(frame) {
//     console.log(">>", frame);
//     console.log('hex2a(frame.data)');
//     console.log(hex2a(frame.data));
//     console.log('hex2d(frame.data)');
//     console.log(hex2d(frame.data));
// });

//
// Sample Code Used to Open and Close this issue:
// https://github.com/jankolkmeier/xbee-api/issues/41

var xbee_api = require('xbee-api');
var C = xbee_api.constants;
var xbeeAPI = new xbee_api.XBeeAPI();

// // Something we might want to send to an XBee...
// var frame_obj = {
//   type: C.FRAME_TYPE.AT_COMMAND,
//   command: "NI",
//   commandParameter: [],
// };
// console.log(xbeeAPI.buildFrame(frame_obj));
// // <Buffer 7e 00 04 08 01 4e 49 5f>

// Something we might receive from an XBee...
var raw_frame = new Buffer([
    0x7E, 0x00, 0x13, 0x97, 0x55, 0x00, 0x13, 0xA2, 0x00, 0x40, 0x52, 0x2B,
    0xAA, 0x7D, 0x84, 0x53, 0x4C, 0x00, 0x40, 0x52, 0x2B, 0xAA, 0xF0
]);

console.log(xbeeAPI.parseFrame(raw_frame));
// { type: 151,
//   id: 85,
//   remote64: '0013a20040522baa',
//   remote16: '7d84',
//   command: 'SL',
//   commandStatus: 0,
//   commandData: [ 64, 82, 43, 170 ] }

var raw = xbeeAPI.parseFrame(raw_frame);
var data = raw.commandData;


// Hex -> Ascii
// Source: http://stackoverflow.com/a/3745677/3219667
function hex2a(hexx) {
  var hex = hexx.toString('hex'); // ensure conversion
  var str = '';
  for (var i = 0; i < hex.length; i += 2) {
    str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
  }
  console.log(str);
  return str;
}
hex2a('32343630'); // returns '2460'
// hex2a('40522baa'); // this should only be converted to decimal (see below)


// Just Hex->Decimal
function hex2d(hexx) {
  var hex = hexx.toString('hex');
  var decimal = [];
  for (var i = 0; i < hex.length; i += 2) {
    decimal.push(parseInt(hex.substr(i, 2), 16));
  }
  console.log(decimal);
  return decimal;
}

hex2d(data);
