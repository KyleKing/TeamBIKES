Template.ManageMechanicNotes.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  FlowRouter.go('/AdminCompilation/ManageMechanicNotes_Form/' + rowData._id)
  $('.cd-panel').addClass('is-visible')
  # Session.set "IDofSelectedRowNotes", rowData._id
  # # Provide user feedback with a highlighted
  # $('.selected').removeClass 'selected'
  # $(event.currentTarget).toggleClass 'selected'

# Template.ManageMechanicNotes.helpers
#   # Return the id of selected row
#   SelectedRow: ->
#     MechanicNotes.findOne {_id: Session.get "IDofSelectedRowNotes"}

# Template.LinkToSpecific.events 'click .FLOWGO': ->
#   FlowRouter.go('/ManageMechanicNotes_Form/' + Session.get "IDofSelectedRowNotes")


Template.ManageMechanicNotes_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageMechanicNotes'

Template.ManageMechanicNotes_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    MechanicNotes.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }
    # current = FlowRouter.current()
    # MechanicNotes.findOne {_id: current.params.IDofSelectedRow}