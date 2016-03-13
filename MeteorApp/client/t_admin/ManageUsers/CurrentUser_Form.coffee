Template.CurrentUser_Form.helpers
  mailToUser: ->
    selectedUser = Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }
    if selectedUser
      console.log selectedUser.emails[0].address
      return 'mailto:' + selectedUser.emails[0].address
    else
      return ''
  UserFact: ->
    Meteor.users.find {_id: FlowRouter.getParam ("IDofSelectedRow") }

  isChecked: (value) ->
    SelectedUser = Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow")}
    if SelectedUser
      roles = SelectedUser.roles
    else
      roles = []

    # Probably a better way to write this, but it isn't too bad..
    if value is 'UserVar'
      if roles.indexOf('User')
        return 'checked'
      else
        return false

    if value is 'MechanicVar'
      if roles.indexOf('Mechanic')
        return 'checked'
      else
        return false

    if value is 'RedistributionVar'
      if roles.indexOf('Redistribution')
        return 'checked'
      else
        return false

    if value is 'EmployeeVar'
      if roles.indexOf('Employee')
        return 'checked'
      else
        return false

    if value is 'AdminVar'
      if roles.indexOf('Admin')
        return 'checked'
      else
        return false

    return false
