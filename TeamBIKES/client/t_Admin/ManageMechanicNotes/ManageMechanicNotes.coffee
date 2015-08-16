Template.ManageMechanicNotes.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  Session.set "IDofSelectedRow", rowData._id
  # Provide user feedback with a highlighted
  $('.selected').removeClass 'selected'
  $(event.currentTarget).toggleClass 'selected'

# Template.ManageMechanicNotes.helpers
#   # Return the id of selected row
#   SelectedRow: ->
#     MechanicNotes.findOne {_id: Session.get "IDofSelectedRow"}

Template.LinkToSpecific.events 'click .FLOWGO': ->
  FlowRouter.go('/ManageMechanicNotes_Form/' + Session.get "IDofSelectedRow")


Template.ManageMechanicNotes_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageMechanicNotes'

Template.ManageMechanicNotes_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    current = FlowRouter.current()
    MechanicNotes.findOne {_id: current.params.IDofSelectedRow}