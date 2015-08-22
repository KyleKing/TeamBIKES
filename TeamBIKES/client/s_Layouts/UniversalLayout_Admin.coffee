Template.UniversalLayout_Admin.events
  #open the lateral panel
  'click .cd-btn': (event) ->
    event.preventDefault()
    $('.cd-panel').addClass 'is-visible'
    return
  #close the lateral panel
  'click .cd-panel': (event) ->
    if $(event.target).is('.cd-panel') or $(event.target).is('.cd-panel-close')
      $('.cd-panel').removeClass 'is-visible'
      event.preventDefault()