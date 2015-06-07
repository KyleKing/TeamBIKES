# server/publications/MechanicNotes.coffee

# Give authorized users access to sensitive data by group
Meteor.publish 'MechanicNotesPub', (group) ->
  if Roles.userIsInRole(@userId, ['Admin', 'Root', 'Mechanic'], group)
    MechanicNotes.find()
  else
    # user not authorized. do not publish MechanicNotes
    @stop()
    return