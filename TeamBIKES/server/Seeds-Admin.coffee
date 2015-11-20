# if RackNames.find().count() is 0 or OuterLimit.find().count() is 0
#   console.log 'Found zero racknames in db'
#   Meteor.call 'QueryRackNames'

# This is used by a few things
# Useful function from lib/CurrentDay.coffee for current date and time
[today, now] = CurrentDay()


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
        Notes: Fake.sentence()
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: Fake.word()
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 3
        Notes: Fake.sentence()
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: Fake.sentence()
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
      RFID: 'THIS IS NOT THE KYLE YOU ARE LOOKING FOR'
      Roles: []
    }
    {
      FullName: 'Mechanic'
      Email: 'mechanic@example.com'
      RFID: 'NotKyle'
      Roles: ['Mechanic', 'Employee']
    }
    {
      FullName: 'Redistribution'
      Email: 'redistribution@example.com'
      RFID: 'c5194f30'
      Roles: ['Redistribution', 'Employee']
    }
    {
      FullName: 'Admin'
      Email: 'admin@example.com'
      RFID: 'NOT 653c4730'
      Roles: ['Admin']
    }
    {
      FullName: 'Root'
      Email: 'root@example.com'
      RFID: 'THISISKyle'
      Roles: ['Root']
    }
  ]

  # Populate Accounts db
  _.each users, (user) ->
    id = undefined
    id = Accounts.createUser(
      email: user.Email
      password: 'password'
      profile:
        RFID: user.RFID
        name: user.FullName)
    if user.Roles.length > 0
      # Need _id of existing user record so this call must come
      # after `Accounts.createUser` or `Accounts.onCreate`
      Roles.addUsersToRoles id, user.Roles
      # Roles.addUsersToRoles id, user.Roles, 'Professional'
      # Roles.GLOBAL_GROUP
  console.log 'Created basic set of users with roles!'