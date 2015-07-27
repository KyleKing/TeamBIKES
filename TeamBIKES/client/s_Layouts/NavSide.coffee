Template.NavSide.events 'click #NavSide-toggle': (e) ->
  e.preventDefault()
  $('#wrapper').toggleClass 'toggled'
  $('#NavSide-Container').toggleClass 'toggled'
  $('#NavSide-toggle').toggleClass 'toggled'

Template.NavSide.helpers activeIfTemplateIs: (template) ->
  currentRoute = Router.current()
  if currentRoute and template == currentRoute.lookupTemplate() then 'active' else ''
# Source: http://robertdickert.com/blog/2014/05/09/set-up-navigation-with-iron-router-and-bootstrap/