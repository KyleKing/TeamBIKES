Meteor.methods({
  'loop': function (dataSet, schema) {
    // Print out schema of received data]
    // for (var key in dataSet) {
    //   if (dataSet.hasOwnProperty(key)) {
    //     console.log(key + " -> " + dataSet[key]);
    //   }
    // }

    // Prepare fields to udpate MongoDB
    var fields = {};
    var root = ["Time." + dataSet.timeHH + '.' + dataSet.timemm];
    fields[root + ".user"] = dataSet.User;
    fields[root + ".lat"] = dataSet.Lat;
    fields[root + ".lng"] = dataSet.Long;

    // Update MongoDB data based on bike number
    var record = TimeSeries.findOne({Bike: dataSet.BikeNumber, YYYY: dataSet.timeYYYY, MM: dataSet.timeMM, DD: dataSet.timeDD});
    TimeSeries.update(
      record,
      { $set: fields }
    );

    return "ok";
  }
});

Meteor.methods({
  'current': function (dataSet, schema) {
    // Print out schema of received data]
    for (var key in dataSet) {
      if (dataSet.hasOwnProperty(key)) {
        console.log(key + " -> " + dataSet[key]);
      }
    }

    // Prepare fields to udpate MongoDB
    var fields = {};
    fields.lat = dataSet.lat;
    fields.lng = dataSet.lng;

    // Update MongoDB data based on bike number
    var record = Current.findOne({Bike: dataSet.BikeNumber});
    Current.update(
      record,
      { $set: fields }
    );

    return "ok";
  }
});

Meteor.methods({
  'chart': function (dataSet) {
    // Prepare fields to udpate MongoDB
    var fields = {};
    fields["data." + dataSet.BikeNumber] = dataSet.Potentiometer;
    fields.x = dataSet.x;
    console.log(dataSet.Potentiometer);

    // Update MongoDB data based on bike number
    var record = AdminAreaChart.findOne();
    AdminAreaChart.update(
      record,
      { $set: fields }
    );

    return "ok";
  }
});