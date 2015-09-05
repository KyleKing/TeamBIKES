Template.ManageMechanicNotes.events
  'click tbody > tr': (event) ->
    # Store the id of the row clicked by the user
    dataTable = $(event.target).closest('table').DataTable()
    rowData = dataTable.row(event.currentTarget).data()
    FlowRouter.go('/AdminCompilation/ManageMechanicNotes_Form/' + rowData._id)
    $('.cd-panel').addClass 'is-visible'
    $('body').addClass 'noscroll'

  'click .ManageMechanicNotes_Insert': () ->
    FlowRouter.go('/AdminCompilation/ManageMechanicNotes_Insert/')
    $('.cd-panel').addClass 'is-visible'
    $('body').addClass 'noscroll'
    console.log 'no scroll'

Template.ManageMechanicNotes_Form.onCreated ->
  # Use this.subscribe inside onCreated callback
  @subscribe 'ManageMechanicNotes'

Template.ManageMechanicNotes_Form.helpers
  # Return the id of selected row
  SelectedRow: ->
    MechanicNotes.findOne {_id: FlowRouter.getParam ("IDofSelectedRow") }


# Reactive Var Modulation example
# Source: https://github.com/aldeed/meteor-tabular/issues/79
Template.ManageMechanicNotes.created = ->
  window.ManageMechanicNotes = new ReactiveVar({})
  window.ManageMechanicNotes.get().titles = []

Template.ManageMechanicNotes.rendered = ->
  $('#ManageMechanicNotes thead th').each ->
    title = $('#ManageMechanicNotes thead th').eq($(this).index()).text()
    console.log title
    # Collect list of titles to allow multi-column filter
    sel = window.ManageMechanicNotes.get()
    if isUndefined _.findWhere(sel, title)
      sel.titles.push(title)
    # Get specific data as set in Tabular Tables definition (i.e. class = 'profile.name')
    ThisClass = $('#ManageMechanicNotes thead th').eq($(this).index()).attr('class')
    console.log ThisClass
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
        sel = window.ManageMechanicNotes.get()
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
        window.ManageMechanicNotes.set sel

Template.ManageMechanicNotes.helpers
  currentSelector: ->
    # console.log 'Current Selector'
    sel = window.ManageMechanicNotes.get()

    ReactiveTest = {}
    _.each sel.titles, (title) ->
      unless isUndefined sel[title]
        ReactiveTest[sel[title].search] = sel[title].value
    ReactiveTest