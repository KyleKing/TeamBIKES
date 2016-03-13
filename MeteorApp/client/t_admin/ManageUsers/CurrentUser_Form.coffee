Forms.mixin(Template.CurrentUser_Form)

# # Template.CurrentUser_Form.rendered = ->
# #   @autorun( ->
# #     form = Forms.instance()
# #     if Meteor.user()
# #       RFIDCode = Meteor.user().profile.RFID
# #       if RFIDCode is 'signUp'
# #         RFIDCode = ''
# #       re = /^deactivated/i
# #       if RFIDCode.match(re)
# #         console.log RFIDCode
# #         RFIDCode = ''
# #       form.doc({
# #         fullName: Meteor.user().profile.name
# #         RFIDCode: RFIDCode
# #       })
# #   )

# Template.CurrentUser_Form.events
#   'documentSubmit': (event, tmpl, doc) ->
#     # console.log doc
#     Meteor.users.update(
#       {_id: Meteor.userId()},
#       {$set: { 'profile.RFID': doc.RFIDCode }}
#     )

Template.CurrentUser_Form.helpers
  mailToUser: ->
    selectedUser = Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }
    if selectedUser
      return 'mailto:' + selectedUser.emails[0].address
    else
      return ''
  UserFact: ->
    Meteor.users.find {_id: FlowRouter.getParam ("IDofSelectedRow") }

  isChecked: (value) ->
    SelectedUser = Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow")}
    if SelectedUser
      # console.log '______'
      # console.log SelectedUser.profile.name
      roles = SelectedUser.roles
      # console.log roles
      # console.log value
      # console.log roles.indexOf('User')
      # console.log roles.indexOf('Mechanic')
      # console.log roles.indexOf('Redistribution')
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
