// Name serial port - there should be a smarter way to do this, but this seems easiest
// Using terminal, identify with:
// ls /dev/cu.*
// ls /dev/cu.usbserial-* # for zigbee
// ls /dev/cu.usbmodem* # for arduino

var currentPort = "/dev/tty.usbserial-AH016D5G"; // Direct left Zigbee

var DDPClient = require("ddp");
var moment = require('moment');
moment().format();

var xbee = require("xbee");

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
  }

  // Error Checking
  function showPortClose() {
    console.log('port closed.');
  }
  function showError(error) {
    console.log('Serial port error: ' + error);
  }

  // Node events - trigger specific functions upon specific events
  serialPort.on('open', showPortOpen);
  serialPort.on('data', saveLatestData);
  serialPort.on('close', showPortClose);
  serialPort.on('error', showError);
});