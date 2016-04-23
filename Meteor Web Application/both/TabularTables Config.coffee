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
    { data: 'Tag', title: 'Tag', class: 'Tag' }
    {
      data: 'Positions.0.Timestamp'
      title: 'Timestamp'
      render: (val, type, doc) ->
        DateFormats =
          shortest: 'hh:mm:ss a'
          short: 'M-D-YY hh:mm a'
          long: 'dddd DD.MM.YYYY hh:mm a'
        if moment
          format = DateFormats['short']
          moment(val).format format
        else
          val
    }
    { data: 'Positions.0.Coordinates.0', title: 'Lat', class: 'Positions.0.Coordinates.0' }
    { data: 'Positions.0.Coordinates.1', title: 'Lng', class: 'Positions.0.Coordinates.1' }
  ]
)

# ManageMechanicNotes
TabularTables.ManageMechanicNotes = new (Tabular.Table)(
  name: 'ManageMechanicNotes'
  collection: MechanicNotes
  autoWidth: false
  allowFields: (userId, fields) ->
    SecureTabular(userId, fields, ['Admin', 'Root', 'Mechanic'])
  columns: [
    { data: 'MechanicID', title: 'MechanicID', class: 'MechanicID' }
    {
      data: 'Timestamp'
      title: 'Timestamp'
      render: (val, type, doc) ->
        DateFormats =
          shortest: 'hh:mm:ss a'
          short: 'M-D-YY hh:mm a'
          long: 'dddd DD.MM.YYYY hh:mm a'
        if moment
          format = DateFormats['short']
          moment(val).format format
        else
          val
    }
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

# For User Profile
################################################
# RecentRides
TabularTables.RecentRides = new (Tabular.Table)(
  name: 'RecentRides'
  collection: DailyBikeData
  autoWidth: false
  allowFields: (userId, fields) ->
    SecureTabular(userId, fields, ['User', 'Admin', 'Root'])
  columns: [
    { data: 'Bike', title: 'Bike' }
    { data: 'Tag', title: 'Tag', class: 'Tag' }
    {
      data: 'Positions.0.Timestamp'
      title: 'Timestamp'
      render: (val, type, doc) ->
        DateFormats =
          shortest: 'hh:mm:ss a'
          short: 'M-D-YY hh:mm a'
          long: 'dddd DD.MM.YYYY hh:mm a'
        if moment
          format = DateFormats['short']
          moment(val).format format
        else
          val
    }
    { data: 'Positions.0.Coordinates.0', title: 'Lat', class: 'Positions.0.Coordinates.0' }
    { data: 'Positions.0.Coordinates.1', title: 'Lng', class: 'Positions.0.Coordinates.1' }
  ]
)