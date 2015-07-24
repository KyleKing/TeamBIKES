if (Movies.find().count() === 0) {
  Movies.insert({title: 'The Shawshank Redemption', year: 1994, rating: 9.2});
  Movies.insert({title: 'The Godfather', year: 1972, rating: 9.2});
  Movies.insert({title: 'Forrest Gump', year: 1994, rating: 8.7});
  Movies.insert({title: 'The Matrix', year: 1999, rating: 8.7});
}

Meteor.publish("crud", function () {
  return Movies.find();
});

Meteor.startup(function () {
  if (Books.find().count() === 0) {
    var books = [
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}},
      {title: "Discover Meteor", author: "Tom Coleman and Sacha Grief", info: { url: "https://www.discovermeteor.com/"}},
      {title: "Your First Meteor Application", author: "David Turnbull", info: { url: "http://meteortips.com/first-meteor-tutorial/"}},
      {title: "Meteor Tutorial", author: "Matthew Platts", info: { url: "http://www.meteor-tutorial.org/"}},
      {title: "Meteor in Action", author: "Stephen Hochaus and Manuel Schoebel", info: { url: "http://www.meteorinaction.com/"}},
      {title: "Meteor Cookbook", author: "Abigail Watson", info: { url: "https://github.com/awatson1978/meteor-cookbook/blob/master/table-of-contents.md"}}
      ];
    _.each(books, function (book) {
      Books.insert(book);
    });
  }
});

Meteor.publish("Datatable", function () {
  return Books.find();
});

// more movie data: http://www.imdb.com/xml/find?json=1&tt=on&q=meteor


// more movie data: http://www.imdb.com/xml/find?json=1&tt=on&q=meteor
