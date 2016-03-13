Template.admin.helpers
  infoTxt: ->
    if Roles.userIsInRole(Meteor.userId(), ['Admin', 'Root'])
      return "Try clicking on any row to see the interactive functionality"
    else
      if Meteor.user().roles.length = 1
        rolesList = ' as a ' + Meteor.user().roles[0]
        if Meteor.user().roles.length > 1
          rolesList = rolesList + ' or ' + Meteor.user().roles[1]
      else
        rolesList = ''
      phrase = "Don't see any data? That is because you don't" +
        ' have permission"' +
        rolesList +
        '." Try signing in under a different account and see how the view changes.'
      return phrase
