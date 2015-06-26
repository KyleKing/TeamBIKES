# server/publications/Books.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'BooksPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root', 'Mechanic'], group)
    Books.find()
  else
    # user not authorized. do not publish Books
    @stop()
    return