# Login Demo - Publish login information for test purposes
Meteor.publish 'MeteorUsers', ->
  Meteor.users.find()