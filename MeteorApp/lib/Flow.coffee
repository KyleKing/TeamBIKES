# Block all pages, unless logged in
FlowRouter.triggers.enter [AccountsTemplates.ensureSignedIn], { except: ['About'] }

FlowRouter.notFound = action: ->
  BlazeLayout.render 'NotFound'

FlowRouter.route '/',
    name: 'About',
    action: ->
      BlazeLayout.render 'layout', {
        Full: 'About'
      }

Templates = [
  'FAQ'
  'Map'
]

_.each Templates, (Template) ->
  route = '/' + Template
  FlowRouter.route route,
      name: Template,
      action: ->
        BlazeLayout.render 'layout', {
          Full: Template
        }

ScrollToTop = ->
  $(window).scrollTop 0
FlowRouter.triggers.enter ScrollToTop
