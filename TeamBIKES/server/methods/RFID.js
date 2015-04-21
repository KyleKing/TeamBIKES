// Meteor.methods({
//   'RFIDStreamData': function (dataSet) {

//     // Update MongoDB data based on bike number
//     var record = RFIDdata.find().fetch()[0];
//     RFIDdata.insert({
//       RFIDCode: dataSet.RFIDCode,
//       time: dataSet.time
//     });

//     // Example Code:
//     // encrypted = CryptoJS.AES.encrypt(dataSet.RFIDCode.toString(), 'Dino');
//     // console.log(encrypted.toString());
//     key = 'Dino';
//     message = 'hi';
//     encrypted = CryptoJS.AES.encrypt(message, key);
//     console.log(encrypted.toString());
//     // 53616c7465645f5fe5b50dc580ac44b9be85d240abc5ff8b66ca327950f4ade5

//     decrypted = CryptoJS.AES.decrypt(encrypted, key);
//     console.log(decrypted.toString(CryptoJS.enc.Utf8));
//     // Message

//     return encrypted.toString();
//   }
// });


Meteor.methods({
  'RFIDStreamData': function (dataSet) {
    var incoming = dataSet.RFIDCode;
    console.log(incoming.trim());

    // Remove excess whitespace
    var code = incoming.trim();
    if ( RFIDdata.find({RFIDCode: code}).count() === 1 ) {
        // Correct RFID Code Found
        var record = RFIDdata.find({RFIDCode: code});
        return 'OPENSESAME*';
    } else if ( RFIDdata.find({RFIDCode: code}).count() === 0 ) {
        // No RFID Code Found
        return 'NO*';
    } else {
        // Too many RFID codes found
        console.log('Too many matching RFID codes....what the heck!?!?!');
        return 'MongoDB Error';
    }
  }
});