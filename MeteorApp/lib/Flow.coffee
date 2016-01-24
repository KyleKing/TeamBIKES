FlowRouter.notFound = action: ->
  BlazeLayout.render 'NotFound'


FlowRouter.route '/content',
    name: 'content',
    action: ->
      BlazeLayout.render 'content'


FlowRouter.route '/',
    name: 'About',
    action: ->
      BlazeLayout.render 'Layout', {
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
        BlazeLayout.render 'Layout', {
          Full: Template
        }

# %%%%%%%%%%%%%%%%%%%%%%%%%%
ScrollToTop = ->
  # Gotta love a mature programming language: http://stackoverflow.com/questions/9316415/the-same-old-issue-scrolltop0-not-working-in-chrome-safari
  $(window).scrollTop 0
FlowRouter.triggers.enter ScrollToTop
