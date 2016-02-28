@TabularTables = {}
Meteor.isClient and Template.registerHelper('TabularTables', TabularTables)

allRoles = ['User', 'Mechanic', 'Employee', 'Redistribution', 'Admin', 'Root' ]
SecureTabular = (userId, fields, allowedRoles) ->
  if Roles.userIsInRole(userId, allowedRoles)
    return true
  else
    return false

# ManageBikes
TabularTables.ManageBikes = new (Tabular.Table)(
  name: 'ManageBikes'
  collection: DailyBikeData
  autoWidth: false
  allowFields: (userId, fields) ->
    SecureTabular(userId, fields, ['Admin', 'Root'])
  columns: [
    { data: 'Bike', title: 'Bike' }
    # { data: 'Day', title: 'Day' }
    { data: 'Tag', title: 'Tag', class: 'Tag', class: 'Tag' }
    # { data: 'Timestamp()', title: 'Last Timestamp' }
    { data: 'Positions.0.Coordinates.0', title: 'Lat', class: 'Positions.0.Coordinates.0' }
    { data: 'Positions.0.Coordinates.1', title: 'Lng', class: 'Positions.0.Coordinates.1' }
  ]
  # extraFields: ['Positions.0.Timestamp']
)

# # FIXME Proving difficult with Astronomy...?
# DailyBikeData.helpers
#   Timestamp: ->
#     DateFormats =
#       shortest: 'hh:mm:ss a'
#       short: 'hh:mm:ss a M-D-YY'
#       long: 'dddd DD.MM.YYYY hh:mm:ss a'
#     # UI.registerHelper 'formatDate', (@Positions[0].Timestamp, format) ->
#     if moment
#       format = 'shortest'
#       # can use other formats like 'lll' too
#       format = DateFormats[format] or format
#       moment(@Positions[0].Timestamp).format format
#     else
#       @Positions[0].Timestamp


# ManageMechanicNotes
TabularTables.ManageMechanicNotes = new (Tabular.Table)(
  name: 'ManageMechanicNotes'
  collection: MechanicNotes
  autoWidth: false
  allowFields: (userId, fields) ->
    SecureTabular(userId, fields, ['Admin', 'Root', 'Mechanic'])
  columns: [
    { data: 'MechanicID', title: 'MechanicID', class: 'MechanicID' }
    { data: 'Timestamp', title: 'Timestamp' }
    { data: 'Bike', title: 'Bike' }
    { data: 'Notes', title: 'Notes', class: 'Notes' }
    { data: 'Tag', title: 'Tag', class: 'Tag' }
  ])


# ManageUsers
TabularTables.ManageUsers = new (Tabular.Table)(
  name: 'ManageUsers'
  collection: Meteor.users
  autoWidth: false
  allowFields: (userId, fields) ->
    SecureTabular(userId, fields, ['Admin', 'Root'])
  columns: [
    { data: 'profile.name', title: 'Name', class: "profile.name" }
    # { data: 'createdAt', title: 'Created At' }
    { data: 'emails.0.address', title: 'Email', class: "emails.0.address" }
    { data: 'emails.0.verified', title: 'Verified?'} # should be overlaid with a color?
    { data: 'roles', title: 'Roles', class: 'roles'  }
    # { tmpl: Meteor.isClient && Template.LinkToSpecificUser, title: 'Link' }
  ])
