Template.menu.events 'click #menu-toggle': (e) ->
  e.preventDefault()
  $('#wrapper').toggleClass 'toggled'
  $('.container').toggleClass 'toggled'
  $('#menu-toggle').toggleClass 'toggled'

Template.menu.helpers activeIfTemplateIs: (template) ->
  currentRoute = Router.current()
  if currentRoute and template == currentRoute.lookupTemplate() then 'active' else ''
# Source: http://robertdickert.com/blog/2014/05/09/set-up-navigation-with-iron-router-and-bootstrap/