Template.ManageMechanicNotes.events
  'click tbody > tr': (event) ->
    # Store the id of the row clicked by the user
    dataTable = $(event.target).closest('table').DataTable()
    rowData = dataTable.row(event.currentTarget).data()
    FlowRouter.go('/Dashboard/ManageMechanicNotes_Form/' + rowData._id)
    $('.cd-panel').addClass 'is-visible'
    $('body').addClass 'noscroll'

  'click .ManageMechanicNotes_Insert': ->
    FlowRouter.go('/Dashboard/ManageMechanicNotes_Insert/')
    $('.cd-panel').addClass 'is-visible'
    $('body').addClass 'noscroll'

# Reactive Var Modulation example
# Source: https://github.com/aldeed/meteor-tabular/issues/79
Template.ManageMechanicNotes.created = ->
  TCS.Created('ManageMechanicNotes')

Template.ManageMechanicNotes.rendered = ->
  TCS.Rendered('ManageMechanicNotes', 'ManageMechanicNotes')

Template.ManageMechanicNotes.helpers
  currentSelector: ->
    TCS.Helper('ManageMechanicNotes')
