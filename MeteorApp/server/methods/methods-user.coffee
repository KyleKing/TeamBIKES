Meteor.methods
  # update a user's permissions
  updateRoles: (targetUserId, roles) ->
    console.log 'Updating roles'
    console.log roles
    usrID = Meteor.user()
    if usrID and Roles.userIsInRole(usrID, ['Admin', 'Root'])
      Roles.addUsersToRoles usrID, roles.added
      Roles.removeUsersFromRoles usrID, roles.removed
      console.log 'setUserRoles was called!'
    else
      throw new Meteor.Error(403, "Access denied")

# See additional methods in seeds/methods-user.coffee
