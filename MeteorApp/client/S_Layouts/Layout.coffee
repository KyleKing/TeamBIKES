Template.layout.rendered = ->
  new WOW().init()
  $('nav.midnight-header').midnight()


closeSlideInPanel = () ->
  $('.cd-panel').removeClass 'is-visible'
  $('body').removeClass 'noscroll'
  event.preventDefault()
openSlideInPanel = () ->
  $('.cd-panel').addClass 'is-visible'
  $('body').addClass 'noscroll'
  event.preventDefault()

Template.layout.events
  'click .cd-btn': (event) ->
    openSlideInPanel()
  'click .cd-panel': (event) ->
    if $(event.target).is('.cd-panel') or $(event.target).is('.cd-panel-close')
      closeSlideInPanel()

Template.layout_left.events
  'click .cd-btn': (event) ->
    openSlideInPanel()
  'click .cd-panel': (event) ->
    if $(event.target).is('.cd-panel') or $(event.target).is('.cd-panel-close')
      closeSlideInPanel()

document.onkeydown = (evt) ->
  evt = evt or window.event
  if evt.keyCode == 27
    console.log 'Escape key was pressed'
    closeSlideInPanel()
    # Remove tool tip as well
    $('.cd-panel-tooltip').removeClass 'visible'
    $('.tooltip-arrow-right').removeClass 'visible'
