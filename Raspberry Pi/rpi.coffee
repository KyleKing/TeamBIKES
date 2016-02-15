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
    console.log h1('Connected to Meteor!')
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


  # Figure out active Serial Port

  # # Manual Method
  # # Using terminal, identify with:
  # # ls /dev/cu.*
  # # ls /dev/tty.usbserial-* # for zigbee
  # # ls /dev/cu.usbmodem* # for arduino
  # currentPort = '/dev/tty.usbserial-AH016D5G' # Direct left Zigbee
  # createSerial(currentPort)

  # Automatic Method
  serialport.list (err, ports) ->
    ports.forEach (port) ->
      console.log port
      console.log port.comName
      # // console.log(port.pnpId);
      # // console.log(port.manufacturer);
      # console.log(port.locationId);
      # console.log(port.vendorId);
      # console.log(port.productId);

      # Check if desired port:
      console.log port.comName.match(/\/dev\/cu.usbmodem*/)
      if port.comName.match(/\/dev\/cu.usbmodem*/)
        console.log port.comName
        # createSerial port.comName


createSerial = (currentPort) ->
  # Configure serial port
  serialPort = new SerialPort(currentPort,
    baudrate: 9600
    parser: xbeeAPI.rawParser())

  # SerialPort events - trigger specific functions upon specific events
  serialPort.on 'open', ->
    console.log info('SerialPort is open with rate of ' +
      serialPort.options.baudRate)
    return

  # All frames parsed by the XBee will be emitted here
  xbeeAPI.on 'frame_object', (frame) ->
    console.log 'Received Frame:'
    console.log frame
    console.log h1('----------*----------')

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
      console.log '>> Serial: ' + data
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

      # if dataSet.USER_ID isnt lastID
      if true is true and false is false
        lastID = dataSet.USER_ID
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

          if result isnt undefined
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
            serialPort.write xbeeAPI.buildFrame(frame_obj)
            console.log h1('Frame sent to specific xbee: ' + result.Address)
            console.log h1(xbeeAPI.buildFrame(frame_obj))
          console.log '----------!----------'
          console.log ''
      else
        console.log 'Received a duplicate frame'
        # console.log 'Ignoring an incoming frame'

  serialPort.on 'close', ->
    console.log warn('port closed.')

  serialPort.on 'error', (error) ->
    console.log warn('Serial port error: ' + error)
