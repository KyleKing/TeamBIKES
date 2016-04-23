# Raspberry Pi Parser (Central Node for Redbars Bikeshare)

1. Connects to a serial device (Arduino or XBee/ZIgbee) automatically
2. Then reacts to incoming serial data in a csv format with ';' or XBee frames respectively
3. Collected data is parsed into a specific array that is then sent over a DDP connection to a locally hosted meteor application by calling the RFIDStream method

See arduino_node.ino for a sample Arduino device

# Coordinator_Raspberry Pi

> The Node.js application that runs on the coordinator device for remote communication to the web application

To run the Node application, enter the folder `cd Coordinator_Raspberry%20Pi` and install the necessary Node packages: `npm install`. If you don't have Node.js or NPM installed, visit https://docs.npmjs.com/getting-started/installing-node. To run this code on a Raspberry Pi, you will need to install Node (TODO: link a guide and my other notes).

Once the NPM packages are installed, try connecting an Arduino or XBee module to your computer/Raspberry Pi via a USB cable. Start the Node application with `node init.js`. The application should recognize the USB device and will wait for incoming data. The anticipated format is:

(TODO: Add sample code for Arduino manual testing and circuit diagram for soldered Raspberry Pi)

```
TODO: Add CSV Format
```