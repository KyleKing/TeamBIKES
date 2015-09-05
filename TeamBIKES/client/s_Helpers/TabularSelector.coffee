@TabularSelectorInit = (template) ->
  if isUndefined window.TabularSelector
    window.TabularSelector = new ReactiveVar({})
  sel = window.TabularSelector.get()
  sel[template] = {}
  sel[template].titles = []
  window.TabularSelector.set sel

@TabularSelectorMain = (template) ->
  SelectedTable = '#' + template + ' thead th'
  $(SelectedTable).each ->
    title = $(SelectedTable).eq($(this).index()).text()
    # Collect list of titles to allow multi-column filter
    sel = window.TabularSelector.get()
    # console.log 'Overall sel - line 15'
    # console.log sel
    sel = sel[template]

    if isUndefined _.findWhere(sel, title)
      sel.titles.push(title)
    # Get specific data as set in Tabular Tables definition (i.e. class = 'profile.name')
    ThisClass = $(SelectedTable).eq($(this).index()).attr('class')
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
        sel = window.TabularSelector.get()
        # rename sel to template object
        sel = sel[template]
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
        # need new variable to encompass to template-level object
        overall = window.TabularSelector.get()
        overall[template] = sel
        # console.log 'OVERALL:'
        # console.log overall
        window.TabularSelector.set overall

@TabularSelectorHelper = (template) ->
  # console.log 'Current Selector'
  sel = window.TabularSelector.get()
  sel = sel[template]
  # console.log 'Template sel - line 62'
  # console.log sel

  ReactiveTest = {}
  _.each sel.titles, (title) ->
    unless isUndefined sel[title]
      ReactiveTest[sel[title].search] = sel[title].value
  ReactiveTest