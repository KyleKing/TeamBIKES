# Block all pages, unless logged in
FlowRouter.triggers.enter [AccountsTemplates.ensureSignedIn], { except: ['about'] }

FlowRouter.notFound = action: ->
  BlazeLayout.render 'notFound'

@FlowTemplates = [
  'about'
  'faq'
  'map'
  'profile'
  'admin'
]

_.each FlowTemplates, (tmpl) ->
  route = '/' + if tmpl is 'about' then '' else tmpl
  FlowRouter.route route,
      name: tmpl
      action: ->
        BlazeLayout.render 'layout', {
          Full: tmpl
        }

# Scroll to the top of every page
ScrollToTop = ->
  $(window).scrollTop 0
FlowRouter.triggers.enter ScrollToTop
#   $('html,body').animate { scrollTop: 0 }, 'slow'

# FlowRouter.triggers.enter ScrollToTop, except: [
#   'Dashboard'
#   'Dashboard/ManageBike'
#   'Dashboard/ManageMechanicNotes_Form'
#   'Dashboard/ManageUsers_Form'
# ]
