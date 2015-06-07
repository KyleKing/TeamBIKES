/*********************************************/
/*   Remove Below content for Production          */
/********************************************/

Meteor.publish("RFIDdataInfo", function() {
  return RFIDdata.find();
});