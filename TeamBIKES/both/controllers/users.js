// Meteor.call('mySubmitFunc');

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