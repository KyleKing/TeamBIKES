

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
  window.ManageUsers = new ReactiveVar({})
  window.ManageUsers.get().titles = []

Template.ManageUsers.rendered = ->
  $('#ManageUsers thead th').each ->
    title = $('#ManageUsers thead th').eq($(this).index()).text()
    # Collect list of titles to allow multi-column filter
    sel = window.ManageUsers.get()
    if isUndefined _.findWhere(sel, title)
      sel.titles.push(title)
    # Get specific data as set in Tabular Tables definition (i.e. class = 'profile.name')
    ThisClass = $('#ManageUsers thead th').eq($(this).index()).attr('class')
    # Remove excess sorting, sorting_asc class etc.
    ThisClass = ThisClass.replace(/(sortin)\w+/gi, '').trim()
    # console.log ThisClass
    unless isUndefined(ThisClass) or ThisClass is ''
      # Create input text input
      # $input = $('<br><input type="text" placeholder="Search ' + title + '"' + 'class="' + ThisClass + '"/>')
      $input = $('<input type="text" placeholder="Search ' + title + '"' + 'class="' + ThisClass + '"/>')
      # $(this).append $input
      $(this).html $input
      # Prevent sorting on click of input box
      $input.on 'click', (e) ->
        e.stopPropagation()
      # Capture events on typing
      $input.on 'keyup', (e) ->
        console.log 'searching: ' + title + ' and ThisClass: ' + ThisClass
        sel = window.ManageUsers.get()
        sel[title] = {}
        sel[title].search = ThisClass
        if @value
          # sel['profile.name'] =
          sel[title].value =
            $regex: @value
            $options: 'i'
        else
          delete sel[title]
          # delete sel['profile.name']
        console.log sel
        window.ManageUsers.set sel

Template.ManageUsers.helpers
  currentSelector: ->
    # console.log 'Current Selector'
    sel = window.ManageUsers.get()

    ReactiveTest = {}
    _.each sel.titles, (title) ->
      unless isUndefined sel[title]
        ReactiveTest[sel[title].search] = sel[title].value
    ReactiveTest