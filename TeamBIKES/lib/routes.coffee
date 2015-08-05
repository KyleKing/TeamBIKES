# # Global Route Configuration
# Router.configure
#   loadingTemplate: 'Loading'
#   notFoundTemplate: 'NotFound'
#   layoutTemplate: 'UniversalLayout'

# # Plugins
# Router.plugin 'dataNotFound', dataNotFoundTemplate: 'notFound'
# Router.plugin 'ensureSignedIn', except: [
#   'about'
#   'atSignIn'
#   'atSignUp'
#   'atForgotPassword'
#   'progress'
# ]

# # Sign out and go to home page with route control, from:
# # http://stackoverflow.com/a/27744765/3219667
# Router.route '/sign-out', (->
#   #here you put things you wanna render, it's empty since you just want to logout and redirect
#   return
# ),
#   name: 'signOut'
#   onBeforeAction: ->
#     if Meteor.userId()
#       Meteor.logout()
#     @next()
#     return
#   onAfterAction: ->
#     Router.go '/'
#     return


# # The real routes
# Router.route '/progress'
# Router.route '/agency'

# ###   Public ###
# # Router.route '/', name: 'about'

# ### User ###
# Router.route '/Profile'
# Router.route '/map'

# ### Administrator ###
# Router.route '/charts', name: 'chartsAdmin'
# Router.route '/RFIDlayout'
# Router.route '/mechanicView'
# Router.route '/timeseries'


# # DEV - TabularTables
# Router.route '/ManageBikes', layoutTemplate: 'NavSide'
# Router.route '/ManageMechanicNotes', layoutTemplate: 'NavSide'
# Router.route '/ManageUsers', layoutTemplate: 'NavSide'