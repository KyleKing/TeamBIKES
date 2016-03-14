closeSlideInPanel = (event) ->
  $('.cd-panel').removeClass 'is-visible'
  $('body').removeClass 'noscroll'
  unless event is false
    event.preventDefault()
  # Remove tool tip as well
  $('.cd-panel-tooltip').removeClass 'visible'
  $('.tooltip-arrow-right').removeClass 'visible'

openSlideInPanel = (event) ->
  $('.cd-panel').addClass 'is-visible'
  $('body').addClass 'noscroll'
  unless event is false
    event.preventDefault()

# Make sure panel is open when go to specific link (i.e. someone shares a link)
Template.layout.rendered = ->
  # console.log 'Template.layout.rendered ->'
  # console.log FlowRouter.getParam ("IDofSelectedRow")
  if FlowRouter.getParam ("IDofSelectedRow")
    openSlideInPanel(false)
FlowRouter.triggers.exit ->
  closeSlideInPanel(false)

Template.layout.events
  'click .cd-btn': (event) ->
    openSlideInPanel(event)
  'click .cd-panel': (event) ->
    if $(event.target).is('.cd-panel') or $(event.target).is('.cd-panel-close')
      closeSlideInPanel(event)

Template.layout_left.events
  'click .cd-btn': (event) ->
    openSlideInPanel()
  'click .cd-panel': (event) ->
    if $(event.target).is('.cd-panel') or $(event.target).is('.cd-panel-close')
      closeSlideInPanel(event)

document.onkeydown = (evt) ->
  evt = evt or window.event
  if evt.keyCode == 27
    console.log 'Escape key was pressed'
    closeSlideInPanel(evt)
