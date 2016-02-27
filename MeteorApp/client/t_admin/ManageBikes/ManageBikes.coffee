Template.ManageBikes.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  Session.set "IDofSelectedRowBikes", rowData._id
  # FlowRouter.go('/ManageBike/' + rowData._id)
  FlowRouter.go('/Dashboard/ManageBike/' + rowData._id)
  $('.cd-panel').addClass 'is-visible'
  $('body').addClass 'noscroll'

  # # Provide user feedback with a highlighted
  # $('.selected').removeClass 'selected'
  # $(event.currentTarget).toggleClass 'selected'

Template.ManageBikes.helpers
  selector: ->
    [today, now] = CurrentDay()
    { Day: today }


# Reactive Var Modulation example
# Source: https://github.com/aldeed/meteor-tabular/issues/79
Template.ManageBikes.created = ->
  TabularSelectorInit('ManageBikes')

Template.ManageBikes.rendered = ->
  TabularSelectorMain('ManageBikes')

Template.ManageBikes.helpers
  currentSelector: ->
    TabularSelectorHelper('ManageBikes')