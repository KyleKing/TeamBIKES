/*******************************************/
/* GPS and String data test for non-RFID data passing */
/*******************************************/


// To test the ability to set the motor by the switch and then by meteor:

// Switch
int val;
int last;

// stringOutput
String stringOutput;


// Test Sending GPS Data
char *staticGPSData[] = { "1,38.99209793,-76.95336578",
                                "2,38.98859656,-76.94251287",
                                "3,38.98148741,-76.95128469",
                                "4,39.00284894,-76.93842238",
                                "5,39.00347762,-76.94101706",
                                "6,38.9907168,-76.94766338",
                                "7,38.99617971,-76.93356598",
                                "8,38.98346423,-76.93286501",
                                "9,38.98235019,-76.93982247",
                                "10,38.99419775,-76.93874252"};

// For Node.js/Meteor
// int counter = 0;

void setup()
{
   Serial.begin(115200);
}

void loop()
{
  for (int i = 0; i < 10; i++) {

    // stringOutput.concat(string, string2)
    stringOutput += staticGPSData[i];
    stringOutput += ",";
    // Serial.print(staticGPSData[i]);
    // Serial.print(","); // element break

    // Update Counter Variable
    // if (counter == 25) {
    //   counter = 0;
    // } else {
    //   counter = counter +1;
    // }
    // Serial.print(counter);
    // Serial.print(","); // element break

    // Read potentiometer
    val = analogRead(2);
    stringOutput += val;
    stringOutput += ";";
    // Serial.print(val);
    // Serial.print(";"); // data break

    Serial.print(stringOutput);
    delay(1000); // at < 100, data overlaps and is hard to parse
  }
}