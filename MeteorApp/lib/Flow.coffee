# Block all pages, unless logged in
FlowRouter.triggers.enter [AccountsTemplates.ensureSignedIn], { except: ['about'] }

FlowRouter.notFound = action: ->
  BlazeLayout.render 'notFound'

@FlowTemplates = [
  'about'
  'faq'
  'map'
  'profile'
]

_.each FlowTemplates, (tmpl) ->
  route = '/' + if tmpl is 'about' then '' else tmpl
  FlowRouter.route route,
      name: tmpl
      action: ->
        BlazeLayout.render 'layout', {
          full: tmpl
        }

# Scroll to the top of every page
ScrollToTop = ->
  $(window).scrollTop 0
  # $('html,body').animate { scrollTop: 0 }, 'slow'

FlowRouter.triggers.enter ScrollToTop, except: [
  'Dashboard'
  'Dashboard/ManageBike'
  'Dashboard/ManageMechanicNotes_Form'
  'Dashboard/ManageUsers_Form'
]

# Admin Dashboard
dashboardTemplates = [
  'Slide_In_Panel_Placeholder'
  'ManageBike'
  'ManageMechanicNotes_Form'
  'ManageUsers_Form'
]
_.each dashboardTemplates, (tmpl) ->
  if tmpl is 'Slide_In_Panel_Placeholder'
    route = ''
  else
    route = tmpl + '/:IDofSelectedRow'
  # Create Routes
  FlowRouter.route '/Dashboard/' + route,
    name: 'Dashboard/' + route,
    action: (params, queryParams) ->
      BlazeLayout.render 'layout', {
        full: 'admin'
        slideInPanelTitle: tmpl + '_Title'
        slideInPanelContent: tmpl
      }

dashboardTemplatesLeft = [
  'ManageMechanicNotes_Insert'
]
_.each dashboardTemplatesLeft, (tmpl) ->
  if tmpl is 'Slide_In_Panel_Placeholder'
    route = ''
  else
    route = tmpl
  # Create Routes
  FlowRouter.route '/Dashboard/' + route,
    name: 'Dashboard/' + route,
    action: (params, queryParams) ->
      BlazeLayout.render 'layout_left', {
        full: 'admin'
        slideInPanelTitle_Left: tmpl + '_Title'
        slideInPanelContent_Left: tmpl
      }


