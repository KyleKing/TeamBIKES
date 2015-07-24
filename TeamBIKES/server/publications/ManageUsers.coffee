Meteor.publish 'ManageUsers', () ->
  Meteor.users.find()