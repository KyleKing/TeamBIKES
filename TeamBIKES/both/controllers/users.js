UsersController = AppController.extend({
  waitOn: function() {
    return this.subscribe('usersInfo');
  },
  data: {
    users: Meteor.users.find({})
  },
  onAfterAction: function () {
    Meta.setTitle('Users');
  }
});

// UsersController.events({
//   'click [data-action=doSomething]': function (event, template) {
//     event.preventDefault();
//   }
// });
