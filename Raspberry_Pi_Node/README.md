# Raspberry Pi Parser (Central Node for Redbars Bikeshare)

1. Connects to a serial device (Arduino or XBee/ZIgbee) automatically
2. Then reacts to incoming serial data in a csv format with ';' or XBee frames respectively
3. Collected data is parsed into a specific array that is then sent over a DDP connection to a locally hosted meteor application by calling the RFIDStream method

See arduino_node.ino for a sample Arduino device
