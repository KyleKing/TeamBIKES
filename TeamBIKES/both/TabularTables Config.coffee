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
    { tmpl: Meteor.isClient && Template.LinkToSpecific, title: 'Link' }
  ])

# ManageUsers
TabularTables.ManageUsers = new (Tabular.Table)(
  name: 'ManageUsers'
  collection: Meteor.users
  autoWidth: false
  columns: [
    { data: 'profile.name', title: 'Name' }
    # { data: 'createdAt', title: 'Created At' }
    { data: 'emails.0.address', title: 'Email' }
    { data: 'emails.0.verified', title: 'Verified?' } # should be overlaid with a color?
    { data: 'roles', title: 'Roles' }
    # { tmpl: Meteor.isClient && Template.LinkToSpecificUser, title: 'Link' }
  ])