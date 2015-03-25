Meteor.startup(function() {

  Factory.define('item', Items, {
    // name: function() { return Fake.paragraph([5]); },
    name: function() { return Fake.color(); },
    rating: function() { return _.random(1, 5); }
  });

  if (Items.find({}).count() === 0) {

    _(15).times(function(n) {
      Factory.create('item');
    });

  }

});
