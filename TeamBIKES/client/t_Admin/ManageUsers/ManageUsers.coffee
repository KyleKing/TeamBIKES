Template.ManageUsers.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  FlowRouter.go('/ManageUsers_Form/' + rowData._id)
  # Session.set "IDofSelectedRowUsers", rowData._id
  # # Provide user feedback with a highlighted
  # $('.selected').removeClass 'selected'
  # $(event.currentTarget).toggleClass 'selected'

# Template.ManageUsers.helpers
#   # Return the id of selected row
#   SelectedRow: ->
#     Meteor.users.findOne {_id: Session.get "IDofSelectedRowUsers"}

# Template.LinkToSpecificUser.events 'click tbody tr .FLOWGO': ->
#   if Session.get "IDofSelectedRowUsers"
#     FlowRouter.go('/ManageUsers_Form/' + Session.get "IDofSelectedRowUsers")
#   else
#     console.log Session.get "IDofSelectedRowUsers"

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
    Meteor.users.find {_id: current.params.IDofSelectedRow}