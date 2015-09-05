Template.ManageUsers.events 'click tbody > tr': (event) ->
  # Store the id of the row clicked by the user
  dataTable = $(event.target).closest('table').DataTable()
  rowData = dataTable.row(event.currentTarget).data()
  # FlowRouter.go('/ManageUsers_Form/' + rowData._id)
  FlowRouter.go('/AdminCompilation/ManageUsers_Form/' + rowData._id)
  $('.cd-panel').addClass 'is-visible'
  $('body').addClass 'noscroll'
  # Session.set "IDofSelectedRowUsers", rowData._id
  # # Provide user feedback with a highlighted
  # $('.selected').removeClass 'selected'
  # $(event.currentTarget).toggleClass 'selected'

# Template.ManageUsers.helpers
#   # Return the id of selected row
#   SelectedRow: ->
#     Meteor.users.findOne {_id: Session.get "IDofSelectedRowUsers"}

Template.ManageUsers_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageUsers'

Template.ManageUsers_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    # current = FlowRouter.current()
    # Meteor.users.findOne {_id: current.params.IDofSelectedRow}
    Meteor.users.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }

Template.CurrentUser_Form.helpers
  UserFact: ->
    Meteor.users.find {_id: FlowRouter.getParam ("IDofSelectedRow") }
    # current = FlowRouter.current()
    # Meteor.users.find {_id: current.params.IDofSelectedRow}

# Reactive Var Modulation example
# Source: https://github.com/aldeed/meteor-tabular/issues/79
Template.ManageUsers.created = ->
  window.currentSelector = new ReactiveVar({})

Template.ManageUsers.rendered = ->
  $table = $('#ManageUsers')
  $input = $('<input name="my_col" type="text" />')
  $table.find('thead th.my_col').append $input
  # column class can be set in TabularTable definition
  $input.on 'keyup', (e) ->
    e.stopPropagation()
    sel = window.currentSelector.get()
    if @value
      sel.my_col =
        $regex: @value
        $options: 'ig'
      sel.value = @value
      console.log 'Value received on keyup: ' + @value
    else
      delete sel.my_col
    window.currentSelector.set sel

Template.ManageUsers.helpers
  currentSelector: ->
    console.log 'Printing selector returned to Tabular'
    name = window.currentSelector.get()
    console.log name.value
    {'profile.name': name.value}