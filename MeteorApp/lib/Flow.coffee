# Block all pages, unless logged in
FlowRouter.triggers.enter [AccountsTemplates.ensureSignedIn], { except: ['about', 'faq'] }


# Inconsistently works?
FlowRouter.notFound = action: ->
  BlazeLayout.render 'notFound'

# General Templates
flowTemplates = [
  'about'
  'faq'
  'map'
  'profile'
  'root'
]
_.each flowTemplates, (tmpl) ->
  route = '/' + if tmpl is 'about' then '' else tmpl
  FlowRouter.route route,
      name: tmpl
      action: ->
        BlazeLayout.render 'layout', {
          full: tmpl
        }

# Admin Dashboard
scrollExceptions = []
dashboardTemplates = [
  'Slide_In_Panel_Placeholder'
  'ManageBike'
  'ManageMechanicNotes_Form'
  'ManageUsers_Form'
]
_.each dashboardTemplates, (tmpl) ->
  scrollExceptions.push(tmpl)
  if tmpl is 'Slide_In_Panel_Placeholder'
    route = ''
  else
    route = tmpl + '/:IDofSelectedRow'
  # Create Routes
  FlowRouter.route '/Dashboard/' + route,
    name: '/dash/' + tmpl,
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
  scrollExceptions.push(tmpl)
  if tmpl is 'Slide_In_Panel_Placeholder'
    route = ''
  else
    route = tmpl
  # Create Routes
  FlowRouter.route '/Dashboard/' + route,
    name: tmpl,
    action: (params, queryParams) ->
      BlazeLayout.render 'layout_left', {
        full: 'admin'
        slideInPanelTitle_Left: tmpl + '_Title'
        slideInPanelContent_Left: tmpl
      }

# Scroll to the top of every page
ScrollToTop = ->
  # $(window).scrollTop 0
  $('html,body').animate { scrollTop: 0 }, 'slow'

FlowRouter.triggers.enter ScrollToTop, except: scrollExceptions

@TransitionerTemplateOrder = [
  'about'
  'faq'
  'map'
  'profile'
  '/dash/' + 'Slide_In_Panel_Placeholder'
  'root'
]
