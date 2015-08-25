# Block all pages
FlowRouter.triggers.enter [AccountsTemplates.ensureSignedIn], { except: ["about", "map"] }

FlowRouter.route '/progress',
  name: 'progress',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'progress'
FlowRouter.route '/agency',
  name: 'agency',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'agency'



###   Public ###
FlowRouter.route '/',
  name: 'about',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'about'

### User ###
FlowRouter.route '/Profile',
  name: 'Profile',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'Profile'
FlowRouter.route '/map',
  name: 'map',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'map'


### Administrator ###
FlowRouter.route '/charts',
  name: 'chartsAdmin',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'chartsAdmin'
FlowRouter.route '/RFIDlayout',
  name: 'RFIDlayout',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'RFIDlayout'
FlowRouter.route '/mechanicView',
  name: 'mechanicView',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'mechanicView'
FlowRouter.route '/timeseries',
  name: 'timeseries',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'timeseries'


# DEV - TabularTables
FlowRouter.route '/AdminCompilation',
  name: 'AdminCompilation',
  action: ->
    BlazeLayout.render 'UniversalLayout_Admin', {
      body: 'AdminCompilation'
      Slide_In_Panel_Title: 'Slide_In_Panel_Placeholder_Title'
      Slide_In_Panel_Content: 'Slide_In_Panel_Placeholder'
    }

FlowRouter.route '/AdminCompilation/ManageBike/:IDofSelectedRow',
  name: 'AdminCompilation/ManageBike',
  action: (params, queryParams) ->
    BlazeLayout.render 'UniversalLayout_Admin', {
      body: 'AdminCompilation'
      Slide_In_Panel_Title: 'ManageMechanicNotes_Title'
      Slide_In_Panel_Content: 'ManageBike'
    }

FlowRouter.route '/AdminCompilation/ManageMechanicNotes_Insert/',
  name: 'AdminCompilation/ManageMechanicNotes_Insert',
  action: () ->
    BlazeLayout.render 'UniversalLayout_Admin_left', {
      body: 'AdminCompilation'
      Slide_In_Panel_Title: 'ManageMechanicNotes_Insert_Title'
      Slide_In_Panel_Content: 'ManageMechanicNotes_Insert'
    }

FlowRouter.route '/AdminCompilation/ManageMechanicNotes_Form/:IDofSelectedRow',
  name: 'AdminCompilation/ManageMechanicNotes_Form',
  action: (params, queryParams) ->
    BlazeLayout.render 'UniversalLayout_Admin', {
      body: 'AdminCompilation'
      Slide_In_Panel_Title: 'ManageMechanicNotes_Title'
      Slide_In_Panel_Content: 'ManageMechanicNotes_Form'
    }

FlowRouter.route '/AdminCompilation/ManageUsers_Form/:IDofSelectedRow',
  name: 'AdminCompilation/ManageUsers_Form',
  action: (params, queryParams) ->
    BlazeLayout.render 'UniversalLayout_Admin', {
      body: 'AdminCompilation'
      Slide_In_Panel_Title: 'ManageUsers_Form_Title'
      Slide_In_Panel_Content: 'ManageUsers_Form'
    }

# Scroll to the top of every page
ScrollToTop = ->
  # Gotta love a mature programming language: http://stackoverflow.com/questions/9316415/the-same-old-issue-scrolltop0-not-working-in-chrome-safari
  # $(window).scrollTop 0
  # Not so fast: http://stackoverflow.com/a/5580456/3219667
  $('html,body').animate { scrollTop: 0 }, 'slow'

FlowRouter.triggers.enter ScrollToTop, except: [
  'AdminCompilation'
  'AdminCompilation/ManageBike'
  'AdminCompilation/ManageMechanicNotes_Form'
  'AdminCompilation/ManageUsers_Form'
  'AdminCompilation/ManageUsers_Insert'
]

# In development