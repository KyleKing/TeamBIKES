@TabularTables = {}
Meteor.isClient and Template.registerHelper('TabularTables', TabularTables)

# # Example Tabular Datatable
# Meteor.isClient and Template.registerHelper('TabularTables', TabularTables)
# TabularTables.Books = new (Tabular.Table)(
#   name: 'BookList'
#   collection: Books
#   autoWidth: false
#   columns: [
#     { data: 'title', title: 'Title' }
#     { data: 'author', title: 'Author' }
#     { data: 'info.url', title: 'Web address' }
#   ])

# # ManageBikes
# TabularTables.ManageBikes = new (Tabular.Table)(
#   name: 'ManageBikes'
#   collection: DailyBikeData
#   pub: "DailyBikeDataPub"
#   autoWidth: false
#   columns: [
#     { data: 'Bike', title: 'Bike' }
#     # { data: 'Day', title: 'Day' }
#     { data: 'Tag', title: 'Tag', class: 'Tag', class: 'Tag' }
#     { data: 'Timestamp()', title: 'Last Timestamp' }
#     { data: 'Positions.0.Coordinates.0', title: 'Lat', class: 'Positions.0.Coordinates.0' }
#     { data: 'Positions.0.Coordinates.1', title: 'Lng', class: 'Positions.0.Coordinates.1' }
#   ]
#   # extraFields: ['Positions.0.Timestamp']
# )

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



# # ManageMechanicNotes
# TabularTables.ManageMechanicNotes = new (Tabular.Table)(
#   name: 'ManageMechanicNotes'
#   collection: MechanicNotes
#   autoWidth: false
#   columns: [
#     { data: 'MechanicID', title: 'MechanicID', class: 'MechanicID' }
#     { data: 'Timestamp', title: 'Timestamp' }
#     { data: 'Bike', title: 'Bike' }
#     { data: 'Notes', title: 'Notes', class: 'Notes' }
#     { data: 'Tag', title: 'Tag', class: 'Tag' }
#   ])

# ManageUsers
TabularTables.ManageUsers = new (Tabular.Table)(
  name: 'ManageUsers'
  collection: Meteor.users
  autoWidth: false
  columns: [
    { data: 'profile.name', title: 'Name', class: "profile.name" }
    # { data: 'createdAt', title: 'Created At' }
    { data: 'emails.0.address', title: 'Email', class: "emails.0.address" }
    { data: 'emails.0.verified', title: 'Verified?'} # should be overlaid with a color?
    { data: 'roles', title: 'Roles', class: 'roles'  }
    # { tmpl: Meteor.isClient && Template.LinkToSpecificUser, title: 'Link' }
  ])