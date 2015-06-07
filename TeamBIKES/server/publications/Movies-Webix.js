Meteor.publish('MoviesPub', function () {
  return Movies.find();
});