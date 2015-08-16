Template.ManageUsers.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  Session.set "IDofSelectedRow", rowData._id
  # Provide user feedback with a highlighted
  $('.selected').removeClass 'selected'
  $(event.currentTarget).toggleClass 'selected'

# Template.ManageUsers.helpers
#   # Return the id of selected row
#   SelectedRow: ->
#     Meteor.users.findOne {_id: Session.get "IDofSelectedRow"}

Template.LinkToSpecificUser.events 'click .FLOWGO': ->
  if Session.get "IDofSelectedRow"
    FlowRouter.go('/ManageUsers_Form/' + Session.get "IDofSelectedRow")
  else
    console.log Session.get "IDofSelectedRow"

Template.ManageUsers_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageUsers'

Template.ManageUsers_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    current = FlowRouter.current()
    Meteor.users.findOne {_id: current.params.IDofSelectedRow}

Template.CurrentUser_Form.helpers
  UserFact: ->
    current = FlowRouter.current()
    console.log Meteor.users.findOne {_id: current.params.IDofSelectedRow}
    Meteor.users.find {_id: current.params.IDofSelectedRow}