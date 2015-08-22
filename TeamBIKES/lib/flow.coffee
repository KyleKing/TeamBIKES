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
      Slide_In_Panel_Title: 'ManageMechanicNotes_Title'
      Slide_In_Panel_Content: 'ManageMechanicNotes_Form'
    }


FlowRouter.route '/ManageBikes',
  name: 'ManageBikes',
  action: ->
    BlazeLayout.render 'NavSide', body: 'ManageBikes'
FlowRouter.route '/ManageBike/:IDofSelectedRow',
  name: 'ManageBike',
  action: (params, queryParams) ->
    BlazeLayout.render 'UniversalLayout', body: 'ManageBike'


FlowRouter.route '/ManageMechanicNotes',
  name: 'ManageMechanicNotes',
  action: ->
    BlazeLayout.render 'NavSide', body: 'ManageMechanicNotes'
FlowRouter.route '/ManageMechanicNotes_Form/:IDofSelectedRow',
  name: 'ManageMechanicNotes_Form',
  action: (params, queryParams) ->
    BlazeLayout.render 'UniversalLayout', body: 'ManageMechanicNotes_Form'
    console.log 'Yeah! We are on the post:', params.IDofSelectedRow
FlowRouter.route '/ManageMechanicNotes_Insert',
  name: 'ManageMechanicNotes_Insert',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'ManageMechanicNotes_Insert'


FlowRouter.route '/ManageUsers',
  name: 'ManageUsers',
  action: ->
    BlazeLayout.render 'NavSide', body: 'ManageUsers'
FlowRouter.route '/ManageUsers_Form/:IDofSelectedRow',
  name: 'ManageUsers_Form',
  action: (params, queryParams) ->
    BlazeLayout.render 'UniversalLayout', body: 'ManageUsers_Form'

# Scroll to the top of every page
FlowRouter.triggers.enter () ->
  # Gotta love a mature programming language: http://stackoverflow.com/questions/9316415/the-same-old-issue-scrolltop0-not-working-in-chrome-safari
  # $(window).scrollTop 0
  # Not so fast: http://stackoverflow.com/a/5580456/3219667
  $('html,body').animate { scrollTop: 0 }, 'slow'



# In development
FlowRouter.route '/Slide_In_Panel',
  name: 'Slide_In_Panel',
  action: ->
    BlazeLayout.render 'NavSide', body: 'Slide_In_Panel'

FlowRouter.route '/Slide_In_Panel_UniversalLayoutBlank',
  name: 'Slide_In_Panel_UniversalLayoutBlank',
  action: ->
    BlazeLayout.render 'UniversalLayout', body: 'Slide_In_Panel'