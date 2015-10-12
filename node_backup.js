var util = require('util');
var SerialPort = require('serialport').SerialPort;
var xbee_api = require('xbee-api');

var C = xbee_api.constants;

var xbeeAPI = new xbee_api.XBeeAPI({
  api_mode: 2
});

var serialport = new SerialPort("/dev/tty.usbserial-AH016D5G", {
  baudrate: 9600,
  parser: xbeeAPI.rawParser()
});

serialport.on("open", function() {
  console.log('port open. Data rate: ' + serialport.options.baudRate);
});

// All frames parsed by the XBee will be emitted here
xbeeAPI.on("frame_object", function(frame) {
  console.log(">>", frame.data);
});