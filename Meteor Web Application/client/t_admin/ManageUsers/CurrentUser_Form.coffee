# Create useful:form
Forms.mixin(Template.CurrentUser_Form)

Template.CurrentUser_Form.events
  'documentSubmit': (event, tmpl, doc) ->
    # Capture any event on form submit
    targetUserId = FlowRouter.getParam ("IDofSelectedRow")
    roles = Object.keys(doc)
    if roles.length is 0
      console.log 'No changed roles, ignoring attempt to submit form.'
    else
      # Determine actions necessary on server
      changedRoles = {added: [], removed: [], root: []}
      _.each(roles, (role) ->
        if role is 'Root'
          changedRoles.root.push(doc[role])
        else
          if doc[role] is true
            changedRoles.added.push(role)
          else if doc[role] is false
            changedRoles.removed.push(role)
          else
            throw new Error('Change in ' + role + ' role is not know')

      )
      Meteor.call('updateRoles', targetUserId, changedRoles)
      console.log changedRoles

Template.CurrentUser_Form.helpers
  mailToUser: ->
    # Make an active hyper link to open an email application
    selectedUser = Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }
    if selectedUser
      return 'mailto:' + selectedUser.emails[0].address
    else
      return ''
  UserFact: ->
    Meteor.users.find {_id: FlowRouter.getParam ("IDofSelectedRow") }

  isChecked: (value) ->
    # Check boxes in accordance with the user document
    SelectedUser = Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow")}
    if SelectedUser
      roles = SelectedUser.roles
    else
      roles = []

    # Probably a better way to write this, but it isn't too bad..
    if value is 'UserVar'
      if roles.indexOf('User') >= 0
        return 'checked'
      else
        return false

    if value is 'MechanicVar'
      if roles.indexOf('Mechanic') >= 0
        return 'checked'
      else
        return false

    if value is 'RedistributionVar'
      if roles.indexOf('Redistribution') >= 0
        return 'checked'
      else
        return false

    if value is 'EmployeeVar'
      if roles.indexOf('Employee') >= 0
        return 'checked'
      else
        return false

    if value is 'AdminVar'
      if roles.indexOf('Admin') >= 0
        return 'checked'
      else
        return false

    if value is 'RootVar'
      if roles.indexOf('Root') >= 0
        return 'checked'
      else
        return false

    return false
