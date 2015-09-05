Template.ManageUsers.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  # FlowRouter.go('/ManageUsers_Form/' + rowData._id)
  FlowRouter.go('/AdminCompilation/ManageUsers_Form/' + rowData._id)
  $('.cd-panel').addClass 'is-visible'
  $('body').addClass 'noscroll'

Template.ManageUsers_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageUsers'

Template.ManageUsers_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }

Template.CurrentUser_Form.helpers
  UserFact: ->
    Meteor.users.find {_id: FlowRouter.getParam ("IDofSelectedRow") }



# Reactive Var Modulation example
# Source: https://github.com/aldeed/meteor-tabular/issues/79
Template.ManageUsers.created = ->
  TabularSelectorInit('ManageUsers')

Template.ManageUsers.rendered = ->
  TabularSelectorMain('ManageUsers')

Template.ManageUsers.helpers
  currentSelector: ->
    TabularSelectorHelper('ManageUsers')