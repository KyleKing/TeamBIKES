TabularTables = {}
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

# ManageBikes
TabularTables.ManageBikes = new (Tabular.Table)(
  name: 'ManageBikes'
  collection: DailyBikeData
  pub: "DailyBikeDataPub"
  autoWidth: false
  columns: [
    { data: 'Bike', title: 'Bike' }
    { data: 'Day', title: 'Day' }
    { data: 'Tag', title: 'Tag' }
  ])


# Define helper with dburles:collection-helpers package
# We'll reference this in our table columns with "positions(value)"
DailyBikeData.helpers
  Positions: (Value) ->
    something = DailyBikeData.findOne().Positions
    console.log "Positions helper called!"
    something[0].Timestamp

# ManageBike
TabularTables.ManageBike = new (Tabular.Table)(
  name: 'ManageBike'
  collection: DailyBikeData
  pub: "DailyBikeDataPub"
  autoWidth: false
  columns: [
    { data: 'Bike', title: 'Rider' }
    { data: 'Positions.0.Timestamp', title: 'Timestamp' }
    { data: 'Positions(Coordinates)', title: 'Lat' }
    { data: 'Positions(Coordinates)', title: 'Lng' }
  ])

# ManageMechanicNotes
TabularTables.ManageMechanicNotes = new (Tabular.Table)(
  name: 'ManageMechanicNotes'
  collection: MechanicNotes
  autoWidth: false
  columns: [
    { data: 'MechanicID', title: 'MechanicID' }
    { data: 'Timestamp', title: 'Timestamp' }
    { data: 'Bike', title: 'Bike' }
    { data: 'Notes', title: 'Notes' }
    { data: 'Tag', title: 'Tag' }
  ])

# ManageUsers
TabularTables.ManageUsers = new (Tabular.Table)(
  name: 'ManageUsers'
  collection: Meteor.users
  autoWidth: false
  columns: [
    { data: 'profile.name', title: 'profile.name' }
    { data: 'createdAt', title: 'createdAt' }
    { data: 'emails.0.address', title: 'emails.0.address' }
    { data: 'emails.0.verified', title: 'ver?' }
    { data: 'roles', title: 'roles' }
  ])