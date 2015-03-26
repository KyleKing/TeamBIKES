
Meteor.startup(function() {

  Factory.define('user', Meteor.users, {
    username: function() { return Fake.word(); },
    password: 'ada',
    emails: [{
      // This isn't working?
      address: function() { return Fake.color(); },
      // address: function() { return [Fake.color() + '@gmail.com']; },
      // see above
      verified: 'false',
    }],
    profile: {
      // email: function() { return [Fake.color() + '@gmail.com']; },
      name: function() { return Fake.word(); },
      // role: 'Administrator',
      UID: "112429874",
      gender: "male",
      handlebars: false,
      snack: 'nn',
      // avatar: '/packages/clinical_accounts-famous-dead-people/avatars/ada.lovelace.jpg'
    }
  });

  if (Meteor.users.find({}).count() === 0) {

    _(15).times(function(n) {
      userId = Factory.create('user');
      console.info('Account created: ' + userId._id);
    });

  }

});
