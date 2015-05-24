// See roles
if (Meteor.users.find({}).count() === 0) {
  var users = [
      {name:"Normal User",email:"normal@example.com",roles:[]},
      {name:"Mechanic",email:"mechanic@example.com",roles:['mechanic']},
      {name:"Manage-Users User",email:"manage@example.com",roles:['SOMETHING']},
      {name:"Admin",email:"admin@example.com",roles:['admin']}
    ];

  _.each(users, function (user) {
    var id;

    id = Accounts.createUser({
      email: user.email,
      password: "password",
      profile: { name: user.name }
    });

    if (user.roles.length > 0) {
      // Need _id of existing user record so this call must come
      // after `Accounts.createUser` or `Accounts.onCreate`
      Roles.addUsersToRoles(id, user.roles);
    }

  });
}


// server/publish.js
// Give authorized users access to sensitive data by group
Meteor.publish('secrets', function (group) {
  if (Roles.userIsInRole(this.userId, ['admin'], group)) {

    return Meteor.secrets.find({group: group});

  } else {

    // user not authorized. do not publish secrets
    this.stop();
    return;

  }
});


Accounts.validateNewUser(function (user) {
  var loggedInUser = Meteor.user();

  if (Roles.userIsInRole(loggedInUser, ['admin','manage-users'])) {
    return true;
  }

  throw new Meteor.Error(403, "Not authorized to create new users");
});

// server/userMethods.js
Meteor.methods({
  /**
   * update a user's permissions
   *
   * @param {Object} targetUserId Id of user to update
   * @param {Array} roles User's new permissions
   * @param {String} group Company to update permissions for
   */
  updateRoles: function (targetUserId, roles, group) {
    var loggedInUser = Meteor.user()

    if (!loggedInUser ||
        !Roles.userIsInRole(loggedInUser,
                            ['manage-users','support-staff'], group)) {
      throw new Meteor.Error(403, "Access denied")
    }

    Roles.setUserRoles(targetUserId, roles, group)
  }
})







// // Seed users

// Meteor.startup(function() {

//   Factory.define('user', Meteor.users, {
//     username: function() { return Fake.word(); },
//     password: 'ada',
//     emails: [{
//       // This isn't working?
//       address: function() { return Fake.color(); },
//       // address: function() { return [Fake.color() + '@gmail.com']; },
//       // see above
//       verified: 'false',
//     }],
//     profile: {
//       // email: function() { return [Fake.color() + '@gmail.com']; },
//       name: function() { return Fake.word(); },
//       // role: 'Administrator',
//       UID: "112429874",
//       gender: "male",
//       handlebars: false,
//       snack: 'nn',
//       // avatar: '/packages/clinical_accounts-famous-dead-people/avatars/ada.lovelace.jpg'
//     }
//   });

//   if (Meteor.users.find({}).count() === 0) {

//     _(15).times(function(n) {
//       userId = Factory.create('user');
//       console.info('Account created: ' + userId._id);
//     });

//   }

// });
