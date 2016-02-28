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


# DEV - TabularTables
FlowRouter.route '/Dashboard',
  name: 'Dashboard',
  action: ->
    BlazeLayout.render 'layout', {
      Full: 'admin'
      Slide_In_Panel_Title: 'Slide_In_Panel_Placeholder_Title'
      Slide_In_Panel_Content: 'Slide_In_Panel_Placeholder'
    }

FlowRouter.route '/Dashboard/ManageBike/:IDofSelectedRow',
  name: 'Dashboard/ManageBike',
  action: (params, queryParams) ->
    BlazeLayout.render 'layout', {
      Full: 'admin'
      Slide_In_Panel_Title: 'ManageBike_Title'
      Slide_In_Panel_Content: 'ManageBike'
    }

FlowRouter.route '/Dashboard/ManageMechanicNotes_Insert/',
  name: 'Dashboard/ManageMechanicNotes_Insert',
  action: () ->
    BlazeLayout.render 'layout_Left', {
      Full: 'admin'
      Slide_In_Panel_Title_Left: 'ManageMechanicNotes_Insert_Title'
      Slide_In_Panel_Content_Left: 'ManageMechanicNotes_Insert'
    }

FlowRouter.route '/Dashboard/ManageMechanicNotes_Form/:IDofSelectedRow',
  name: 'Dashboard/ManageMechanicNotes_Form',
  action: (params, queryParams) ->
    BlazeLayout.render 'layout', {
      Full: 'admin'
      Slide_In_Panel_Title: 'ManageMechanicNotes_Title'
      Slide_In_Panel_Content: 'ManageMechanicNotes_Form'
    }

FlowRouter.route '/Dashboard/ManageUsers_Form/:IDofSelectedRow',
  name: 'Dashboard/ManageUsers_Form',
  action: (params, queryParams) ->
    BlazeLayout.render 'layout', {
      Full: 'admin'
      Slide_In_Panel_Title: 'ManageUsers_Form_Title'
      Slide_In_Panel_Content: 'ManageUsers_Form'
    }