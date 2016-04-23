Meteor.methods 'completeAccountRecord': (currentUserId, RFID) ->
  record = Meteor.users.findOne( currentUserId )
  if record.RFID is undefined
    Meteor.users.update(record, $set: { 'profile.RFID': RFID } )
  else
    throw new Error('addRFIDToNewAccount: Existing RFID code')

  # Add user to User role
  if Meteor.users.findOne( currentUserId ).roles is undefined
    Roles.addUsersToRoles currentUserId, ['User']
  return 'ok'
