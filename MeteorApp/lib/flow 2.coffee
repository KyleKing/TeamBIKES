# # Block all pages
# FlowRouter.triggers.enter [AccountsTemplates.ensureSignedIn], { except: ["about", 'agency', "map", "RFIDlayout"] }

# FlowRouter.route '/progress',
#   name: 'progress',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'progress'


# # FlowRouter.route '/',
# #   name: 'about',
# #   action: ->
# #     BlazeLayout.render 'UniversalLayout', full: 'agency'
# FlowRouter.notFound = action: ->
#   BlazeLayout.render 'MacawLayout', full: 'aboutmacaw'

# FlowRouter.route '/',
#   name: 'about',
#   action: ->
#     BlazeLayout.render 'MacawLayout', full: 'aboutmacaw'



# ###   Public ###
# FlowRouter.route '/about_ideas',
#   name: 'ideas',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'about'

# ### User ###
# FlowRouter.route '/Profile',
#   name: 'Profile',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'Profile'
# FlowRouter.route '/map',
#   name: 'map',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'map'
# FlowRouter.route '/MechMap',
#   name: 'MechMap',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'MechMap'


# ### Administrator ###
# FlowRouter.route '/charts',
#   name: 'chartsAdmin',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'chartsAdmin'
# FlowRouter.route '/RFIDlayout',
#   name: 'RFIDlayout',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'RFIDlayout'
# FlowRouter.route '/DevPanel',
#   name: 'DevPanel',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'DevPanel'
# FlowRouter.route '/RackPanel',
#   name: 'RackPanel',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'RackPanel'

# FlowRouter.route '/mechanicView',
#   name: 'mechanicView',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'mechanicView'
# FlowRouter.route '/timeseries',
#   name: 'timeseries',
#   action: ->
#     BlazeLayout.render 'MacawLayout', body: 'timeseries'


# # DEV - TabularTables
# FlowRouter.route '/Dashboard',
#   name: 'Dashboard',
#   action: ->
#     BlazeLayout.render 'MacawLayout', {
#       body: 'AdminCompilation'
#       Slide_In_Panel_Title: 'Slide_In_Panel_Placeholder_Title'
#       Slide_In_Panel_Content: 'Slide_In_Panel_Placeholder'
#     }

# FlowRouter.route '/Dashboard/ManageBike/:IDofSelectedRow',
#   name: 'Dashboard/ManageBike',
#   action: (params, queryParams) ->
#     BlazeLayout.render 'MacawLayout', {
#       body: 'AdminCompilation'
#       Slide_In_Panel_Title: 'ManageBike_Title'
#       Slide_In_Panel_Content: 'ManageBike'
#     }

# FlowRouter.route '/Dashboard/ManageMechanicNotes_Insert/',
#   name: 'Dashboard/ManageMechanicNotes_Insert',
#   action: () ->
#     BlazeLayout.render 'MacawLayout_Left', {
#       body: 'AdminCompilation'
#       Slide_In_Panel_Title_Left: 'ManageMechanicNotes_Insert_Title'
#       Slide_In_Panel_Content_Left: 'ManageMechanicNotes_Insert'
#     }

# FlowRouter.route '/Dashboard/ManageMechanicNotes_Form/:IDofSelectedRow',
#   name: 'Dashboard/ManageMechanicNotes_Form',
#   action: (params, queryParams) ->
#     BlazeLayout.render 'MacawLayout', {
#       body: 'AdminCompilation'
#       Slide_In_Panel_Title: 'ManageMechanicNotes_Title'
#       Slide_In_Panel_Content: 'ManageMechanicNotes_Form'
#     }

# FlowRouter.route '/Dashboard/ManageUsers_Form/:IDofSelectedRow',
#   name: 'Dashboard/ManageUsers_Form',
#   action: (params, queryParams) ->
#     BlazeLayout.render 'MacawLayout', {
#       body: 'AdminCompilation'
#       Slide_In_Panel_Title: 'ManageUsers_Form_Title'
#       Slide_In_Panel_Content: 'ManageUsers_Form'
#     }

# # Quick Dev Route
# FlowRouter.route '/dev/kyle',
#   name: 'Dev',
#   action: () ->
#     BlazeLayout.render 'UniversalLayout_Basic', {
#       body: 'LoginFormCD'
#     }

# # Scroll to the top of every page
# ScrollToTop = ->
#   # Gotta love a mature programming language: http://stackoverflow.com/questions/9316415/the-same-old-issue-scrolltop0-not-working-in-chrome-safari
#   # $(window).scrollTop 0
#   # Not so fast: http://stackoverflow.com/a/5580456/3219667
#   $('html,body').animate { scrollTop: 0 }, 'slow'

# FlowRouter.triggers.enter ScrollToTop, except: [
# #   'Dashboard/ManageBike'
# #   'Dashboard/ManageMechanicNotes_Form'
# #   'Dashboard/ManageUsers_Form'
# #   'Dashboard/ManageUsers_Insert'
#   'Dashboard'
#   'Dashboard/ManageBike'
#   'Dashboard/ManageMechanicNotes_Form'
#   'Dashboard/ManageUsers_Form'
# ]

# # 'Dashboard/ManageMechanicNotes_Insert' -> doesn't work on left...but may be due to a different layout

# # In development