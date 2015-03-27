WebixController = AppController.extend({
  waitOn: function() {
    return this.subscribe('webixMovies');
  },
  data: {
    movies: Movies.find({})
  },
  onAfterAction: function () {
    Meta.setTitle('Webix');
  }
});