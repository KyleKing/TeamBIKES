/*********/
/* Static Code to send data to demo RPi in replacement of an XBee module */
/*********/

String stringOutput;

// Test Sending GPS Data
char *staticGPSData[] = {
    "1,38.99209793,-76.95336578",
    "2,38.98859656,-76.94251287",
    "3,38.98148741,-76.95128469",
    "4,39.00284894,-76.93842238",
    "5,39.00347762,-76.94101706",
    "6,38.9907168,-76.94766338",
    "7,38.99617971,-76.93356598",
    "8,38.98346423,-76.93286501",
    "9,38.98235019,-76.93982247",
    "10,38.99419775,-76.93874252"
};

// From Coffee script function:
//    # Parse incoming CVS data into array
//    array = data.split(',')
//    dataSet =
//        USER_ID: array[0]
//        LATITUDE: array[1]
//        LONGITUDE: array[2]
//        LOCKSTATEE: array[3]
//        Module_ID: array[4]

void setup() {
    Serial.begin(9600);
}

void loop() {
    // Random number from 0 to 300
    stringOutput += random(301);
    stringOutput += ",";
    stringOutput += staticGPSData[ random(10) ];
    stringOutput += ",true,";
    stringOutput += "ABCDEFGHIJK;";
    Serial.println(stringOutput);

    // Clear string:
    stringOutput = "";
    delay(3000);
}