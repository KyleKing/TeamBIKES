Meteor.startup ->
  sAlert.config
    effect: 'stackslide'
    position: 'top-right'
    timeout: 3000
    html: false
    onRouteClose: true
    stack: true
    offset: 10