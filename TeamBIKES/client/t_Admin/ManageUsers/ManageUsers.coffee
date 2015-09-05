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
  $('#ManageUsers thead th').each ->
    title = $('#ManageUsers thead th').eq($(this).index()).text()
    # Get specific data as set in Tabular Tables definition (i.e. class = 'profile.name')
    ThisClass = $('#ManageUsers thead th').eq($(this).index()).attr('class')
    # Remove excess sorting, sorting_asc class etc.
    ThisClass = ThisClass.replace /( sortin)\w+/g, ''
    # Create input text input
    $input = $('<input type="text" placeholder="Search ' + title + '"' + 'class="' + ThisClass + '"/>')
    $(this).prepend $input
    # Prevent sorting on lick of input box
    $input.on 'click', (e) ->
      e.stopPropagation()
    # Capture events on typing
    $input.on 'keyup', (e) ->
      console.log 'searching: ' + title + ' and ThisClass: ' + ThisClass
      sel = window.currentSelector.get()
      sel.search = ThisClass
      if @value
        # sel['profile.name'] =
        sel.value =
          $regex: @value
          $options: 'i'
      else
        delete sel.value
        # delete sel['profile.name']
      window.currentSelector.set sel

Template.ManageUsers.helpers
  currentSelector: ->
    # console.log 'Current Selector'
    sel = window.currentSelector.get()
    # console.log sel
    # sel
    search = sel.search
    ReactiveTest = {}
    ReactiveTest[search] = sel.value
    ReactiveTest