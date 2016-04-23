//
//
//

// // // Boot on Startup

// // $ cd /etc/init.d/
// // $ sudo nano CoordinatorBootSequence
// // Add: cd ~/Documents/TeamBikes/Raspberry_Pi_Node/; node init.js
// // Close and Save
// // $ sudo chmod 755 CoordinatorBootSequence
// // $ sudo update-rc.d CoordinatorBootSequence defaults
// // Check the script
// // $ bash /etc/init.d/CoordinatorBootSequence

// // More reliable version:
// // Instead of: "// Add: cd ~/Documents/TeamBikes/Raspberry_Pi_Node/; node init.js"
// // Add:
// #!/bin/sh
// ### BEGIN INIT INFO
// # Provides:          CoordinatorBootSequence
// # Required-Start:    $remote_fs $syslog
// # Required-Stop:     $remote_fs $syslog
// # Default-Start:     5
// # Default-Stop:      6
// # Short-Description: Will this work?
// # Description:       This file should be used to construct scripts to be
// #                    placed in /etc/init.d.
// ### END INIT INFO
// cd ~/Documents/TeamBikes/Raspberry_Pi_Node/; node init.js

//
//
//

// Actual JavaScript Code (Both Arduino/XBee controllers):

// Connects to a serial device (Arduino or XBee/ZIgbee) automatically
// Then reacts to incoming serial data in a csv format with ';' or
//    XBee frames respectively
// Collected data is parsed into a specific array that is then sent over a
//    DDP connection to a locally hosted meteor application by calling the
//    RFIDStream method

// TODO Setup Login for DDP Connection

// TODO Figure out if these are needed for XBee
// var lastID = '',
//   lastModule_ID = '';

// FIXME: Ignore first line of input because not formatted correctly

var util = require('util');
var clc = require('cli-color'),
  info = clc.blue,
  h1 = info.bold,
  warn = clc.yellow;

var PythonShell = require('python-shell'),
  pyshell = new PythonShell('lcd.py');
pyshell.send('Coordinator     Initialized');
// pyshell.on('message', function (message) {
//   // console.log('Received from pyshell: ' + message);
// });

var moment = require('moment');
moment().format();

var xbee_api = require('xbee-api'),
  C = xbee_api.constants;
xbeeAPI = new xbee_api.XBeeAPI({
  api_mode: 2
});


// var currentHost = ['localhost', 3000];
var currentHost = ['redbarbikes.com', 80];
var serialport = require('serialport'),
  SerialPort = serialport.SerialPort,
  DDPClient = require('ddp');
var ddpclient = new DDPClient({
  host: currentHost[0],
  port: currentHost[1],
});

// Called by both Arduino and Xbee functions

function parseInput(dataa) {
  data = dataa.toString();
  data = data.trim();
  // console.log('*  Converted To: ' + data);
  array = data.split(',');
  var dataSet = {
    USER_ID: array[0],
    LATITUDE: array[1],
    LONGITUDE: array[2],
    LOCKSTATE: array[3],
    Module_ID: array[4],
    TIMESTAMP: (new Date).getTime()
  };
  pyshell.send('UID:' + dataSet.USER_ID + ' LS:' + dataSet.LOCKSTATE+ ' M_ID:' +
    dataSet.Module_ID);
  console.log('>> Sending to Meteor:');
  console.log(dataSet);
  return dataSet
}

// Meteor DDP Connection

ddpclient.connect(function(error) {
  if (error) {
    pyshell.send(error);
    throw error;
  } else {
    console.log(info('Connected to Meteor!'));
  }
  serialport.list(function(err, ports) {
    return ports.forEach(function(port) {
      console.log(port);
      console.log(port.comName + '\n');

      // See rpi.coffee in Raspberry_Pi_Meteor for example Crypto.js script

      // Figure out active Serial Port - Automatic Method
      // Using terminal, identify with:
      // ls /dev/cu.*
      if (port.comName.match(/\/dev\/tty.usbserial-*/)) {
        xbee_createSerial(port.comName);
      }
      if (port.comName.match(/\/dev\/cu.usbmodem*/)) {
        arduino_createSerial(port.comName);
      }
      if (port.serialNumber != undefined) {
        // On the Raspberry Pi the ports appear differently
        if (port.serialNumber.match(/arduino/gi)) {
          arduino_createSerial(port.comName);
        }
        if (port.comName.match(/\/dev\/ttyUSB*/)) {
          xbee_createSerial(port.comName);
        }
      }
    });
  });
});

// Arduino Test Connection

arduino_createSerial = function(currentPort) {
  console.log(warn('Created New Serial Port Connection to ' +
    currentPort));
  var arduino_serialPort = new SerialPort(currentPort, {
    baudrate: 9600,
    parser: serialport.parsers.readline("\n")
  });
  arduino_serialPort.on('open', function() {
    return console.log('SerialPort is open with rate of ' +
      arduino_serialPort.options.baudRate);
  });
  arduino_serialPort.on('data', function(raw) {
    var array, dataSet;
    console.log(h1('----------*----------'));
    console.log('* Received Frame: ' + raw);
    dataSet = parseInput(raw);
    return ddpclient.call('RFIDStreamData', [dataSet], function(err, res) {
      if (res !== undefined && res.data !== undefined) {
        if (res.Address === undefined) {
          console.log(warn("Warning: BROADCASTING TO ALL XBEE's, " +
            "I hope you know what you are doing."));
        }
        console.log('>> Writing ' + res.data);
        arduino_serialPort.write(res.data);
      }
    });
  });
  arduino_serialPort.on('close', function() {
    return console.log(warn('port closed.'));
  });
  return arduino_serialPort.on('error', function(error) {
    pyshell.send(error);
    return console.log(warn('Serial port error: ' + error));
  });
};


// Hex -> Ascii
// Source: http://stackoverflow.com/a/3745677/3219667

function hex2a(hexx) {
  if (hexx === undefined) {
    // pyshell.send('Empty data field');
    // console.log(warn('Empty data field, no hex term received in hex2a'));
    return;
  } else {
    var hex = hexx.toString('hex'); // ensure conversion
    var str = '';
    for (var i = 0; i < hex.length; i += 2) {
      str += String.fromCharCode(parseInt(hex.substr(i, 2), 16));
    }
    return str;
  }
}

// Xbee Coordinator

xbee_createSerial = function(currentPort) {
  pyshell.send('Connected to    ' + currentPort);
  console.log(warn('Created New Serial Port Connection to ' +
    currentPort));
  var xbee_serialPort = new SerialPort(currentPort, {
    baudrate: 9600,
    parser: xbeeAPI.rawParser()
  });
  xbee_serialPort.on('open', function() {
    return console.log('SerialPort is open with rate of ' +
      xbee_serialPort.options.baudRate);
  });
  xbeeAPI.on('frame_object', function(frame) {
    var array, data, dataSet;
    console.log(h1('----------*----------'));
    data = hex2a(frame.data);
    if (data === undefined) {
      if (frame.deliveryStatus === 0) {
        console.log(info('>> Received Response: Data was delivered!'));
        console.log(frame);
      } else {
        console.log(warn('>> Received Response: Previous Data'));
        console.log(warn('   was not received.'));
        console.log(frame);
      }
    } else {
      console.log('>> ' + data);
      dataSet = parseInput(data);
      // Not sure if this is necessary:
      // if dataSet.USER_ID isnt lastID
      // Check that USER_ID is defined
      if (dataSet.USER_ID != undefined) {
        // lastID = dataSet.USER_ID;
        return ddpclient.call('RFIDStreamData', [dataSet], function(err, res) {
          if (res !== undefined && res.data !== undefined) {
            var Address = res.Address;
            if (Address === undefined) {
              pyshell.send("Warning: BROADCASTING TO ALL XBEE's");
              console.log(warn("Warning: BROADCASTING TO ALL XBEE's, " +
                "I hope you know what you are doing."));
            }
            var frame_obj = {
              type: 0x10,
              id: 0x01,
              destination64: Address,
              destination16: 'fffe',
              broadcastRadius: 0x00,
              options: 0x00,
              data: res.data
            };
            xbee_serialPort.write(xbeeAPI.buildFrame(frame_obj));
            // Tell the Raspberry Pi the good news!
            strAddress = Address.toString();
            if (res.data === 'y') {
              pyshell.send('ACCESS APPROVED for: ' + strAddress.substr(-4));
            } else if (res.data === 'n') {
              pyshell.send('ACCESS DENIED for: ' + strAddress.substr(-4));
            } else {
              pyshell.send('Meteor Error: stay locked');
            }
            console.log(info('Frame sent to specific XBee: ' + Address));
          }
          console.log(info('----------!---------- \n'));
        });
      } else {
        pyshell.send("Warning: Dataset is undefined");
        return console.log(warn('Dataset is undefined'));
      }
    }
    console.log(warn('----------!---------- \n'));
  });
  xbee_serialPort.on('close', function() {
    pyshell.send('Port closed.');
    return console.log(warn('port closed.'));
  });
  return xbee_serialPort.on('error', function(error) {
    pyshell.send(error);
    return console.log(warn('Serial port error: ' + error));
  });
};
