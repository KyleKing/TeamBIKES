# DailyBikeData {
#   Bike: <number>,
#   Day: <number out of 365>,
#   Tag: <ToBeRedistributed, RepairToBeStarted, RepairInProgress, WaitingOnParts, Available>
#   Positions: [{
#     TS: <timestamp>,
#     Rider: <None, User ID, or Employee ID>,
#     Lat: 38.991403,
#     Lng: -76.941449
#   }, ...]
# }

randNames = [
  'Anastasia Romanoff'
  'Marie Antoinette'
  'Chuff Chuffington'
  'Kate Middleton'
  'Harry Potter'
  'Snow White'
  'Lake Likesscooters'
  'Pippa Middleton'
  'Napoleon Bonapart'
  'Britany Bartsch'
  'Roselee Sabourin'
  'Chelsie Vantassel'
  'Chaya Daley'
  'Luella Cordon'
  'Jamel Brekke'
  'Jonie Schoemaker'
  'Susannah Highfield'
  'Mitzi Brouwer'
  'Forrest Lazarus'
  'Dortha Dacanay'
  'Delinda Brouse'
  'Alyssa Castenada'
  'Carlo Poehler'
  'Cicely Rudder'
  'Lorraine Galban'
  'Trang Lenart'
  'Patrica Quirk'
  'Zackary Dedios'
  'Ursula Kennerly'
  'Shameka Flick'
  'President Loh'
  '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
]

# Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
# Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
# Top Left: Latitude : 38.999109 | Longitude : -76.956053
# Top Right: Latitude : 39.003778 | Longitude : -76.932278
randGPS = (max) ->
  # Calculate random GPS coordinates within campus
  leftLat = 38.994052
  rightLat = 38.981376
  bottomLng = -76.936569
  topLng = -76.950603
  skew = 1000000
  randLat = []
  randLng = []
  _.times max, ->
    randLat.push _.random(leftLat * skew, rightLat * skew) / skew
    return
  _.times max, ->
    randLng.push _.random(bottomLng * skew, topLng * skew) / skew
    return
  # Save in object to return
  randCoordinates =
    Lat: randLat
    Lng: randLng
  randCoordinates


# Useful function from lib/CurrentDay.coffee for current date and time
[today, now] = CurrentDay()
# Insert database of bikes if no data for today
if DailyBikeData.find({Day: today}).count() == 0
  i = 1
  while i <= 100
    # create template for each DailyBikeData data stored
    Position = []
    randomNow = NaN
    blank = {}
    countTime = 0
    while countTime < 30
      # For 60 minutes in an hour
      randomNow = now - (10000000 * Math.random())
      namePoint = Math.round((randNames.length - 1) * Math.random())
      # console.log('randNames = ' + randNames);
      randGPSPoint = Math.round(1 * Math.random())
      blank =
        Rider: randNames[namePoint]
        Timestamp: randomNow
        Coordinates: [randGPS(2).Lat[randGPSPoint], randGPS(2).Lng[randGPSPoint]]
      # console.log('name = ' + blank.User);
      Position.push blank
      countTime++
    DailyBikeData.insert
      Bike: i
      Day: today
      # simplified version
      Tag: if Math.round(0.65 * Math.random()) == 0 then 'Available' else 'RepairInProgress'
      Coordinates: [randGPS(2).Lat[randGPSPoint], randGPS(2).Lng[randGPSPoint]]
      Positions: Position
    i++
  console.log 'Created DailyBikeData data schema'


## \/ NOTE! CHANGED \/

# MechanicNotes {
#   CurrentTag: <see below>
#   ...
#   ...
#   RepairHistory: [
      # Mechanic: "Kyle King"
      # Timestamp: "NUMBER"
#     Notes: "string",
#     Tag: <ToBeRedistributed, RepairToBeStarted,
#     RepairInProgress, WaitingOnParts, Available>
#     ]
# }

## /\ Not THE SAME - CHANGED /\


# # Potential method for single reset and load:
# Meteor.users.find().observeChanges
#   added: () ->
if Meteor.users.find().count() != 0
  # Create staff roles (for more info see roles package)
  if MechanicNotes.find({}).count() == 0
    # local variable to populate collection
    BikeNotes = [
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: 'Only a string'
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: "string of something information"
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 3
        Notes: "I am Groot"
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: 'Only a string'
        Tag: "ToBeRedistributed"
      }
    ]
    # Populate Accounts db
    _.each BikeNotes, (BikeNote) ->
      MechanicNotes.insert
        MechanicID: BikeNote.MechanicID
        Timestamp: BikeNote.Timestamp
        Bike: BikeNote.Bike
        Notes: BikeNote.Notes
        Tag: BikeNote.Tag
    console.log 'MechanicNotes Created'


# Create staff roles (for more info see roles package)
if Meteor.users.find({}).count() == 0
  # local variable with sample user profiles
  users = [
    {
      FullName: 'Kyle'
      Email: 'normal@example.com'
      Roles: []
    }
    {
      FullName: 'Mechanic'
      Email: 'mechanic@example.com'
      Roles: ['Mechanic']
    }
    {
      FullName: 'Redistribution'
      Email: 'redistribution@example.com'
      Roles: ['Redistribution']
    }
    {
      FullName: 'Num1Employee'
      Email: 'Num1Employee@example.com'
      Roles: ['Mechanic', 'Redistribution']
    }
    {
      FullName: 'Admin'
      Email: 'admin@example.com'
      Roles: ['Admin']
    }
    {
      FullName: 'Root'
      Email: 'root@example.com'
      Roles: ['Root']
    }
  ]

  # Populate Accounts db
  _.each users, (user) ->
    id = undefined
    id = Accounts.createUser(
      email: user.Email
      password: 'password'
      profile: name: user.FullName)
    if user.Roles.length > 0
      # Need _id of existing user record so this call must come
      # after `Accounts.createUser` or `Accounts.onCreate`
      Roles.addUsersToRoles id, user.Roles
    return



[today, now] = CurrentDay()
# seeds/RedistributionCollection.coffee

# To help with load order, make sure there is DailyBikeData available
if DailyBikeData.find({Day: today}).count() != 0
  # If collection is empty
  if RedistributionCollection.find().count() == 0
    # Find all bikes
    BikeData = DailyBikeData.find({Day: today}).fetch()
    # Then strip out PII for redistribution access
    _.each BikeData, (BikeDatum) ->
      RedistributionCollection.insert
        Bike: BikeDatum.Bike
        Day: BikeDatum.Day
        Tag: BikeDatum.Tag
        # Make sure to strip out rider name
        Positions:
          Timestamp: BikeDatum.Positions[1].Timestamp
          Lat: BikeDatum.Positions[1].Lat
          Lng: BikeDatum.Positions[1].Lng
    console.log 'Created RedistributionCollection data schema'


# See roles
if Meteor.users.find({}).count() == 0
  users = [
    {
      name: 'Normal User'
      email: 'normal@example.com'
      roles: []
    }
    {
      name: 'Mechanic'
      email: 'mechanic@example.com'
      roles: [ 'mechanic' ]
    }
    {
      name: 'Manage-Users User'
      email: 'manage@example.com'
      roles: [ 'SOMETHING' ]
    }
    {
      name: 'Admin'
      email: 'admin@example.com'
      roles: [ 'admin' ]
    }
  ]
  _.each users, (user) ->
    id = undefined
    id = Accounts.createUser(
      email: user.email
      password: 'password'
      profile: name: user.name)
    if user.roles.length > 0
      # Need _id of existing user record so this call must come
      # after `Accounts.createUser` or `Accounts.onCreate`
      Roles.addUsersToRoles id, user.roles


# server/publish.js
# Give authorized users access to sensitive data by group
Meteor.publish 'secrets', (group) ->
  if Roles.userIsInRole(@userId, [ 'admin' ], group)
    Meteor.secrets.find group: group
  else
    # user not authorized. do not publish secrets
    @stop()

Accounts.validateNewUser (user) ->
  loggedInUser = Meteor.user()
  if Roles.userIsInRole(loggedInUser, [
      'admin'
      'manage-users'
    ])
    return true
  throw new (Meteor.Error)(403, 'Not authorized to create new users')

# server/userMethods.js
Meteor.methods updateRoles: (targetUserId, roles, group) ->
  loggedInUser = Meteor.user()
  if !loggedInUser or !Roles.userIsInRole(loggedInUser, [
      'manage-users'
      'support-staff'
    ], group)
    throw new (Meteor.Error)(403, 'Access denied')
  Roles.setUserRoles targetUserId, roles, group