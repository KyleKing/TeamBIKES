Meteor.subscribe("RFIDdataPublication");

Template.RFIDlayout.helpers({
  RFIDlayout: function () {
    return RFIDdata.find().fetch();
  }
});