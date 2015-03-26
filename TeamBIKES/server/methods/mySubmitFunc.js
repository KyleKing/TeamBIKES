Meteor.methods({
  'mySubmitFunc': function (currentUserId) {
    // Prepare fields to udpate MongoDB
    var fields = {};
    fields.RFID = 'testRFIDsequence';

    var record = Meteor.users.findOne({_id: currentUserId});

    if (record.RFID !== undefined) {
      console.log(['RFID code already set for ', record._id]);
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
