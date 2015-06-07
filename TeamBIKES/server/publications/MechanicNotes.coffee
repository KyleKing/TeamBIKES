# server/publications/MechanicNotes.coffee

# Give authorized users access to sensitive data by group
# Published as null so no subscription call unnecessary, for now
Meteor.publish null, (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root', 'Mechanic'], group)
    MechanicNotes.find()
  else
    # user not authorized. do not publish MechanicNotes
    @stop()
    return