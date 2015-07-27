TabularTables = {}

# ManageBikes
Meteor.isClient and Template.registerHelper('ManageBikesTable', TabularTables)
TabularTables.ManageBikes = new (Tabular.Table)(
  name: 'ManageBikes'
  collection: DailyBikeData
  autoWidth: false
  columns: [
    { data: 'Bike', title: 'Bike' }
    { data: 'Day', title: 'Day' }
    { data: 'Tag', title: 'Tag' }
  ])

# ManageMechanicNotes
Meteor.isClient and Template.registerHelper('ManageMechanicNotesTable', TabularTables)
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
Meteor.isClient and Template.registerHelper('ManageUsersTable', TabularTables)
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