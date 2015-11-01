/**************************************************************************/
/*!
    This program is designed to operate with quite a bit of physical input
    to turn on a light when an RFID card is successfully read. Here's the
    electrical set up needed:
    pin 13 to anode of green LED, cathode of green led to resistor to ground
    pin 12 to anode of red LED, cathode of red led to resistor to ground
    pin 2 to left side of the switch, resistor from left side to ground
    5v to right side of switch
    After making these connections, the process is as follows:
    Depress switch to enter "READING" state
    Wave RFID tag over reader so that it will register.
    The uid read in will then be compared to the UID's in memory, and if
    a match is found, we move on to the next state the "OPEN" state,
    so to get to the "CLOSED" state, depress the switch quickly.
    If a match isn't found, the FSM automatically goes to the CLOSED state.
    This takes you to the "CLOSED" state for a little while again, and
    then goes back to "NOT READING".
*/
/**************************************************************************/
char foo;
#include <Arduino.h>
#include <EEPROM.h>
#include <Wire.h>
#include <PN532_I2C.h>
#include <PN532.h>
#include <Adafruit_GPS.h>
#include <SoftwareSerial.h>
PN532_I2C pn532i2c(Wire);
PN532 nfc(pn532i2c);
#include <Servo.h>
#define NOT_READING 0
#define READING 1
#define READ 2
#define OPEN 3
#define ERROR_CHECKING 4
#define CLOSED 5
//Software serial communication set up
SoftwareSerial mySerial(11,10);
//Indicator light wiring set up
int success_out = 13; //success LED connected to digital pin 13
int fail_out = 12; //fail LED connected to digital pin 12
//The button interrupt is triggered on a rising change on pin 2.
//Some serial stuff
char incoming;//for collecting Seral read data
//char code[10]={'O','P','E','N','S','E','S','A','M','E'};
int valid_uid[2][4] = {{101, 60, 71, 48}, {197 , 25, 79, 48}};
int val = 0;
int i = 0; //for counting
String string_out(13, HEX);
boolean success;
int currState = NOT_READING;
//Servo setup
Servo myservo;
int pos = 0;
//GPS setup stuff *******************************************
Adafruit_GPS GPS(&mySerial);
// Set GPSECHO to 'false' to turn off echoing the GPS data to the Serial console
// Set to 'true' if you want to debug and listen to the raw GPS sentences.
#define GPSECHO  false
// this keeps track of whether we're using the interrupt
// off by default!
boolean usingInterrupt = false;
void useInterrupt(boolean); // Func prototype keeps Arduino 0023 happy
//**************************************************************
void setup(void) {
//  Serial.begin(9600);
 //Set up for GPS... had to change Serial output for now
 // connect at 115200 so we can read the GPS fast enough and echo without dropping chars
  // also spit it out
  Serial.begin(115200);
  Serial.println("Adafruit GPS library basic test!");
  // 9600 NMEA is the default baud rate for Adafruit MTK GPS's- some use 4800
  GPS.begin(9600);

  // uncomment this line to turn on RMC (recommended minimum) and GGA (fix data) including altitude
  GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_RMCGGA);
  // uncomment this line to turn on only the "minimum recommended" data
  //GPS.sendCommand(PMTK_SET_NMEA_OUTPUT_RMCONLY);
  // For parsing data, we don't suggest using anything but either RMC only or RMC+GGA since
  // the parser doesn't care about other sentences at this time

  // Set the update rate
  GPS.sendCommand(PMTK_SET_NMEA_UPDATE_1HZ);   // 1 Hz update rate
  // For the parsing code to work nicely and have time to sort thru the data, and
  // print it out we don't suggest using anything higher than 1 Hz
  // Request updates on antenna status, comment out to keep quiet
  GPS.sendCommand(PGCMD_ANTENNA);
  // the nice thing about this code is you can have a timer0 interrupt go off
  // every 1 millisecond, and read data from the GPS for you. that makes the
  // loop code a heck of a lot easier!
  useInterrupt(false);
  delay(1000);
  // Ask for firmware version
  mySerial.println(PMTK_Q_RELEASE);
  myservo.attach(9);
  // Serial.println("Hello!");
  pinMode(success_out, OUTPUT);
  pinMode(fail_out, OUTPUT);
  //Attach an interrupt to pin 2
  attachInterrupt(0, startReading, RISING);
  nfc.begin();
  uint32_t versiondata = nfc.getFirmwareVersion();
  if (! versiondata) {
    digitalWrite(fail_out, HIGH);
    Serial.println("Cannot find reader,");
    while (!versiondata) {
      versiondata = nfc.getFirmwareVersion();
    } // halt
  }
  nfc.setPassiveActivationRetries(0xFFFF);
  nfc.SAMConfig();
  digitalWrite(fail_out, LOW);
  digitalWrite(success_out, HIGH);
  delay(500);
  digitalWrite(success_out, LOW);
  // Serial.println("Waiting for an ISO14443A card");
}
void useInterrupt(boolean v) {
  if (v) {
    // Timer0 is already used for millis() - we'll just interrupt somewhere
    // in the middle and call the "Compare A" function above
    OCR0A = 0xAF;
    TIMSK0 |= _BV(OCIE0A);
    usingInterrupt = true;
  } else {
    // do not call the interrupt function COMPA anymore
    TIMSK0 &= ~_BV(OCIE0A);
    usingInterrupt = false;
  }
}
void GPS_print(void){
  Serial.println("Entered GPS print!!");
  if (! usingInterrupt) {

    // read data from the GPS in the 'main loop'
    char c = GPS.read();
    // if you want to debug, this is a good time to do it!
    if (GPSECHO)
      if (c) Serial.print(c);
  }

  // if a sentence is received, we can check the checksum, parse it...
  if (GPS.newNMEAreceived()) {
    // a tricky thing here is if we print the NMEA sentence, or data
    // we end up not listening and catching other sentences!
    // so be very wary if using OUTPUT_ALLDATA and trytng to print out data
    //Serial.println(GPS.lastNMEA());   // this also sets the newNMEAreceived() flag to false
    Serial.println("New NMEA received");
    if (!GPS.parse(GPS.lastNMEA()))   // this also sets the newNMEAreceived() flag to false
      return;  // we can fail to parse a sentence in which case we should just wait for another

    //if (GPS.fix) {
     Serial.println("Got a fix!!");
      //Serial.print("Location: ");
      Serial.print(GPS.latitude, 4); Serial.print(GPS.lat);
      Serial.print(", ");
      Serial.print(GPS.longitude, 4); Serial.println(GPS.lon);

      return;

  //}
  }
}


void loop(void) {
  uint8_t uid[] = { 0, 0, 0, 0};  // Buffer to store the returned UID
  uint8_t uidLength;                        // Length of the UID (4 or 7 bytes depending on ISO14443A card type)
  digitalWrite(success_out, LOW);
  digitalWrite(fail_out, LOW);
  //read button pin by waiting for interrupt
  delay(200);
  if (currState == READING)
  { Serial.println("READING");
    digitalWrite(success_out, HIGH);
    delay(500);
    digitalWrite(success_out, LOW);
    success = nfc.readPassiveTargetID(PN532_MIFARE_ISO14443A, &uid[0], &uidLength);
    // Serial.print(success, DEC);
    if (success) {
      currState = READ;
    }
    else {
      currState = ERROR_CHECKING;
    }
  }
  if (currState == READ) {
    string_out = "";
    // string_out="Front";
    if (uid[1]) {
       Serial.println("READ");
      for (uint8_t i = 0; i < 4; i++)
      { //Serial.println(uid[i]);
        if (uid[i] < 16) {
          string_out += "0";
        }
        string_out += String(uid[i], HEX);
      }
      string_out += ",";
      int j = 0;
      boolean flag = 0;
      for (j = 0; j < 2; j++)
      {
        for (i = 0; i < 4; i++)
        { if (uid[i] != valid_uid[j][i])
            break;
        }
        if (i == 4)
        { flag = 1;
          break;
        }
      }
      string_out += "38.990,-76.936,";
      if (!flag)
      { //Serial.println("Invalid card");
        string_out += "still locked";
        currState = CLOSED;
      }
      else
      { //Serial.println("Valid card!");
        string_out += "unlocked!";
        currState = OPEN;
      }
      Serial.println(string_out);
    }
  }
  if (currState == NOT_READING)
  { Serial.println("NOT READING");
    digitalWrite(fail_out, HIGH);
    digitalWrite(success_out, LOW);
    delay(500);
  }
  if (currState == OPEN)
  { GPS_print();

    for (pos = 0; pos <= 180; pos += 1) { // goes from 0 degrees to 180 degrees
      // in steps of 1 degree
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);                       // waits 15ms for the servo to reach the position
    }Serial.println("OPEN");
    for (i = 0; i < 5; i++) {
      digitalWrite(success_out, HIGH);
      delay(300);
      digitalWrite(success_out, LOW);
      delay(300);
    }
  }
  if (currState == ERROR_CHECKING) {
     Serial.println("ERROR CHECKING");
    delay(500);
    nfc.begin();
    val = nfc.getFirmwareVersion();
    i = 0;
    while (!val) {
      nfc.begin();
      val = nfc.getFirmwareVersion();
      delay(300);
      i++;
      if (i == 20) {
        Serial.println("Check connection");
      }
    }
    nfc.setPassiveActivationRetries(0xFFFF);
    nfc.SAMConfig();
    currState = READING;
  }
  if (currState == CLOSED)
  { for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);                       // waits 15ms for the servo to reach the position
    }
    Serial.println("CLOSED");
    for (i = 0; i < 5; i = i + 1) {
      digitalWrite(fail_out, HIGH);
      delay(200);
      digitalWrite(success_out, HIGH);
      delay(300);
      digitalWrite(fail_out, LOW);
      delay(200);
      digitalWrite(success_out, HIGH);
      digitalWrite(success_out, LOW);
    }
    currState = NOT_READING;
  }
}
void startReading()
{ Serial.println("Interrupt entered");
  if (currState == NOT_READING) {
    currState = READING;
  }
  if (currState == OPEN) {
    currState = CLOSED;
  }
}
void serialEvent() {
  Serial.println("Entered serial event");
  int i = 0;
  int flag = 0;
  if (currState == READ) {
    //   Serial.println("Inside serial & read");
    //while (Serial.available()) {
    //incoming=(char)Serial.read();
    // if(incoming=='*'&& i>9) {flag=0; break;}
    //if(incoming=='*'){flag=1;break;}
    //if(incoming!=code[i]){flag=1;break;}
    //i=i+1;}
    if (!flag) {
      currState = OPEN;
    }
    else {
      currState = NOT_READING;
    }
  }
}