serialport = Meteor.npmRequire('serialport')
SerialPort = serialport.SerialPort
util = Meteor.npmRequire('util')
moment = Meteor.npmRequire('moment')
moment().format()

clc = Meteor.npmRequire('cli-color')
info = clc.blue
h1 = info.bold
warn = clc.yellow

DDPClient = Meteor.npmRequire('ddp')
xbee_api = Meteor.npmRequire('xbee-api')
C = xbee_api.constants
xbeeAPI = new (xbee_api.XBeeAPI)(api_mode: 2)

lastID = ''
lastModule_ID = ''

# Configure Meteor-Connection
ddpclient = new DDPClient(
  host: 'localhost'
  port: 3000
  auto_reconnect: true
  auto_reconnect_timer: 500
  use_ejson: true
  use_ssl: false
  use_ssl_strict: true
  maintain_collections: true
)

# Connect to Meteor
ddpclient.connect (error) ->
  # Error Checking
  if error
    throw error
  else
    console.log info('Connected to Meteor!')

  # Login - Note may not work?
  # login(ddpclient,
  #   {  // Options below are the defaults
  #      env: 'METEOR_TOKEN',  // Name of an environment variable to check for a
  #                            // token. If a token is found and is good,
  #                            // authentication will require no user interaction.
  #      method: 'email',    // Login method: account, email, username or token
  #      account: 'admin@example.com',        // Prompt for account info by default
  #      pass: 'password',           // Prompt for password by default
  #      retry: 2,             // Number of login attempts to make
  #      plaintext: false      // Do not fallback to plaintext password compatibility
  #                            // for older non-bcrypt accounts
  #   },
  #   function (error, userInfo) {
  #     if (error) {
  #       // Something went wrong...
  #       console.log('error');
  #     } else {
  #       // We are now logged in, with userInfo.token as our session auth token.
  #       token = userInfo.token;
  #     }
  #   }
  # );

  # Figure out active Serial Port - Automatic Method
  # Using terminal, identify with:
  # ls /dev/cu.*
  serialport.list (err, ports) ->
    ports.forEach (port) ->
      console.log port
      console.log port.comName + '\n'

      # For Zigbee
      if port.comName.match(/\/dev\/tty.usbserial-*/)
        xbee_createSerial port.comName

      # For Arduino:
      if port.comName.match(/\/dev\/cu.usbmodem*/)
        arduino_createSerial port.comName



arduino_createSerial = (currentPort) ->
  console.log warn('Created New Serial Port Connection to ' + currentPort)
  # Configure serial port
  arduino_serialPort = new SerialPort(currentPort,
    baudrate: 9600
    parser: serialport.parsers.readline("\n")
  )

  # SerialPort events - trigger specific functions upon specific events
  arduino_serialPort.on 'open', ->
    console.log 'SerialPort is open with rate of ' +
      arduino_serialPort.options.baudRate

  arduino_serialPort.on 'data', (frame) ->
    console.log h1('----------*----------')
    console.log '* Received Frame:'
    console.log frame

    data = frame.toString()
    console.log '* Converted To: ' + data

    # Parse incoming CVS data into array
    array = data.split(',')
    dataSet =
      USER_ID: array[0]
      LATITUDE: array[1]
      LONGITUDE: array[2]
      LOCKSTATEE: array[3]
      Module_ID: array[4]
      TIMESTAMP: (new Date).getTime()

    # Call Meteor actions with "dataSet"
    ddpclient.call 'RFIDStreamData', [ dataSet ], (err, result) ->
      console.log '>> Sent to Meteor: ' + array

      # // P-J's Suggestion
      # var CryptoJS = require("crypto-js");
      # var info = { message: "This is my message !", key: "Dino" };
      # var encrypted = CryptoJS.AES.encrypt(info.message, info.key, {
      #     mode: CryptoJS.mode.CBC,
      #     padding: CryptoJS.pad.Pkcs7
      # });
      # var decrypted = CryptoJS.AES.decrypt(result, info.key, {
      #     mode: CryptoJS.mode.CBC,
      #     padding: CryptoJS.pad.Pkcs7
      # });
      # // console.log(encrypted.toString());
      # console.log('Decrypted result: '+ decrypted.toString(CryptoJS.enc.Utf8));

      if result isnt undefined and result.data isnt undefined
        if result.Address is undefined
          console.log warn("Warning: BROADCASTING TO ALL XBEE's, " +
            "I hope you know what you are doing.")
        console.log '>> Writing ' + result.data
        arduino_serialPort.write result.data

  arduino_serialPort.on 'close', ->
    console.log warn('port closed.')

  arduino_serialPort.on 'error', (error) ->
    console.log warn('Serial port error: ' + error)



xbee_createSerial = (currentPort) ->
  console.log warn('Created New Serial Port Connection to ' + currentPort)
  # Configure serial port
  xbee_serialPort = new SerialPort(currentPort,
    baudrate: 9600
    parser: xbeeAPI.rawParser()
  )

  # SerialPort events - trigger specific functions upon specific events
  xbee_serialPort.on 'open', ->
    console.log 'SerialPort is open with rate of ' +
      xbee_serialPort.options.baudRate

  # All frames parsed by the XBee will be emitted here
  xbeeAPI.on 'frame_object', (frame) ->
    console.log h1('----------*----------')
    console.log '* Received Frame:'
    console.log frame

    if frame.data is undefined
      if frame.deliveryStatus == 0
        console.log info('>> Data was delivered!')
        console.log info(frame + '\n')
      else
        console.log warn('>> No data in frame received')
        console.log warn('   Data was not received')
        console.log warn('   ' + frame + '\n')
    else
      data = frame.data.toString()
      console.log '* Converted To: ' + data
      # console.log("OBJ> " + util.inspect(frame));

      # Parse incoming CVS data into array
      array = data.split(',')
      dataSet =
        USER_ID: array[0]
        LATITUDE: array[1]
        LONGITUDE: array[2]
        LOCKSTATEE: array[3]
        Module_ID: array[4]
        TIMESTAMP: (new Date).getTime()

      # Not sure if this is necessary:
      # if dataSet.USER_ID isnt lastID
      if true is true and false is false
        lastID = dataSet.USER_ID
        # Call Meteor actions with "dataSet"
        ddpclient.call 'RFIDStreamData', [ dataSet ], (err, result) ->
          console.log '>> Sent to Meteor: ' + array
          if result isnt undefined and result.data isnt undefined
            if result.Address is undefined
              console.log warn("Warning: BROADCASTING TO ALL XBEE's, " +
                "I hope you know what you are doing.")
            frame_obj =
              type: 0x10
              id: 0x01
              destination64: result.Address
              destination16: 'fffe'
              broadcastRadius: 0x00
              options: 0x00
              data: result.data
            xbee_serialPort.write xbeeAPI.buildFrame(frame_obj)
            console.log h1('Frame sent to specific xbee: ' + result.Address)
            console.log h1(xbeeAPI.buildFrame(frame_obj))
          console.log '----------!----------'
          console.log ''
      else
        console.log 'Received a duplicate frame'
        # console.log 'Ignoring an incoming frame'

  xbee_serialPort.on 'close', ->
    console.log warn('port closed.')

  xbee_serialPort.on 'error', (error) ->
    console.log warn('Serial port error: ' + error)
