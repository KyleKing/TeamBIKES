# Block all pages
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

# %%%%%%%%%%%%%%%%%%%%%%%%%%
ScrollToTop = ->
  # Gotta love a mature programming language: http://stackoverflow.com/questions/9316415/the-same-old-issue-scrolltop0-not-working-in-chrome-safari
  $(window).scrollTop 0
FlowRouter.triggers.enter ScrollToTop