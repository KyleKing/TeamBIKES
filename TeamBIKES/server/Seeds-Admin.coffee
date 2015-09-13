if RackNames.find().count() is 0 or OuterLimit.find().count() is 0
  console.log 'Found zero racknames in db'
  Meteor.call 'QueryRackNames'


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
AllRandNames = [
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
]

# Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
# Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
# Top Left: Latitude : 38.999109 | Longitude : -76.956053
# Top Right: Latitude : 39.003778 | Longitude : -76.932278
# randGPS = (max) ->
  # # Calculate random GPS coordinates within campus
  # leftLat = 38.994052
  # rightLat = 38.981376
  # bottomLng = -76.936569
  # topLng = -76.950603
  # skew = 1000000
  # randLat = []
  # randLng = []
  # _.times max, ->
  #   randLat.push _.random(leftLat * skew, rightLat * skew) / skew
  #   return
  # _.times max, ->
  #   randLng.push _.random(bottomLng * skew, topLng * skew) / skew
  #   return
  # # Save in object to return
  # randCoordinates =
  #   Lat: randLat
  #   Lng: randLng
  # randCoordinates
randGPS = () ->
  RandID = _.random(1, RackNames.find().count())
  RackNames.findOne({'attributes.OBJECTID': RandID}).Coordinates


# Useful function from lib/CurrentDay.coffee for current date and time
[today, now] = CurrentDay()
# Insert database of bikes if no data for today
if DailyBikeData.find({Day: today}).count() is 0 and RackNames.find().count() isnt 0
  console.log 'Started creating DailyBikeData data schema'
  j = 0
  while j < 4
    if DailyBikeData.find({Day: (today-j) }).count() is 0
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
          if Math.round(0.75 * Math.random()) is 0
            if Math.round(1.1 * Math.random()) is 0
              RandTag = 'asdfahdfghsdlkfjsad'
            else
              RandTag = 'Available'
          else
            RandTag = 'RepairInProgress'
          blank =
            Tag: RandTag
            Rider: if RandTag is 'asdfahdfghsdlkfjsad' then AllRandNames[namePoint] else ''
            Timestamp: randomNow
            Coordinates: randGPS()
          # console.log('name = ' + blank.User);
          Position.push blank
          countTime++
        DailyBikeData.insert
          Bike: i
          Day: today - j
          # simplified version
          Tag: RandTag
          Coordinates: randGPS()
          Positions: Position
        i++
      console.log 'Created DailyBikeData data schema for ' + j + ' days behind today'
    j++
  console.log 'Done creating DailyBikeData data schema'


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
if Meteor.users.find({'profile.name': "Mechanic"}).count() isnt 0
  # Create staff roles (for more info see roles package)
  if MechanicNotes.find({}).count() is 0
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
if Meteor.users.find({}).count() is 0
  # local variable with sample user profiles
  users = [
    {
      FullName: 'Normal'
      Email: 'normal@example.com'
      Roles: []
    }
    {
      FullName: 'Mechanic'
      Email: 'mechanic@example.com'
      Roles: ['Mechanic', 'Employee']
    }
    {
      FullName: 'Redistribution'
      Email: 'redistribution@example.com'
      Roles: ['Redistribution', 'Employee']
    }
    {
      FullName: 'Admin'
      Email: 'admin@example.com'
      Roles: ['Admin']
    }
    # {
    #   FullName: 'Root'
    #   Email: 'root@example.com'
    #   Roles: ['Root']
    # }
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
      # Roles.addUsersToRoles id, user.Roles, 'Professional'
      # Roles.GLOBAL_GROUP
  console.log 'Created basic set of users with roles!'



[today, now] = CurrentDay()
# seeds/RedistributionCollection.coffee

# To help with load order, make sure there is DailyBikeData available
@PopulateDailyBikeData = () ->
  console.log 'Checking DailyBikeData Collection'
  if DailyBikeData.find({Day: today}).count() isnt 0
    # If collection is empty
    if RedistributionCollection.find().count() is 0
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

PopulateDailyBikeData()