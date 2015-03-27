Meteor.publish("webixMovies", function() {
  return Movies.find();
});