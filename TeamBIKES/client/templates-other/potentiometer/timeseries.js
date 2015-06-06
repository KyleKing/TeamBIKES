// Return data for the html template
Template.timeseries.rendered = function() {
  return Meteor.subscribe("timeseriesData");
};

Template.timeseries.helpers({
  timeseries: function () {
    Session.set("currentBike", 4);
    Session.set("currentTime", 18);
    if (TimeSeries.find({Bike: Session.get("currentBike"), YYYY: 2015, MM: 2, DD: 8}).count() === 1) {
      return TimeSeries.findOne({Bike: Session.get("currentBike"), YYYY: 2015, MM: 2, DD: 8});
    }
    console.log("uhoh");
  }
});