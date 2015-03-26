Meteor.methods({
  'mySubmitFunc': function (currentUserId) {
    // Prepare fields to udpate MongoDB
    var fields = {};
    fields.RFID = 'testRFIDsequence';

    // Less secure method using hidden sign up template:
        // fields['profile.RFIDtemp'] = '';
    // var record = Meteor.users.findOne({'profile.RFIDtemp': 'xkgj'});

    var record = Meteor.users.findOne({_id: currentUserId});
    console.log(record);

    if (record.RFID !== undefined) {
      console.log('RFID already set');
    } else {
      Meteor.users.update(
        record,
        { $set: fields }
      );
      console.log(['Set RFID code for ', record._id]);
    }

    return "ok";
  }
});

/*********************************************/
/*   TODO: Check for accounts without an RFID field          */
/********************************************/
