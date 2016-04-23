Meteor.methods
  # update a user's permissions
  updateRoles: (targetUserId, roles) ->
    console.log 'Updating roles'
    console.log roles
    usrID = Meteor.user()._id
    # Control the addition/removal of the root role
    if usrID and Roles.userIsInRole(usrID, ['Root'])
      unless usrID is targetUserId
        unless roles.root.length is 0
          if roles.root[0] is true
            Roles.addUsersToRoles(targetUserId, ['Root'])
          if roles.root[0] is false
            console.log 'WARNING DELETING ONLY ROOT ACCESS'
            Roles.removeUsersFromRoles(targetUserId, ['Root'])
    # Approval for the other roles
    if usrID and Roles.userIsInRole(usrID, ['Admin', 'Root'])
      Roles.addUsersToRoles(targetUserId, roles.added)
      Roles.removeUsersFromRoles(targetUserId, roles.removed)
      console.log 'setUserRoles was called!'
    else
      throw new Meteor.Error(403, "Access denied")

# See additional methods in seeds/methods-user.coffee
