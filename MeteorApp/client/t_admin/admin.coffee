Template.admin.helpers
  infoTxt: ->
    if Meteor.userId()
      if Roles.userIsInRole(Meteor.userId(), ['Admin', 'Root'])
        return "Try clicking on any row to see the interactive functionality"
      else
        if Meteor.user()
          if Meteor.user().roles
            if Meteor.user().roles.length = 1
              rolesList = ' with the ' + Meteor.user().roles[0] + ' role.'
            if Meteor.user().roles.length > 1
              rolesList = ' with the ' + Meteor.user().roles[0] + ' and ' +
                Meteor.user().roles[1] + ' roles.'
        if isUndefined(rolesList)
          rolesList = '.'
    phrase = "Don't see any data? That is because you don't have permission" +
      rolesList +
      ' Try signing in under a different account and see how the view changes.'
    return phrase
