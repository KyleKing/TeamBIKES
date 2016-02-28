[today, now] = CurrentDay()

# ## \/ NOTE! CHANGED \/

# # MechanicNotes {
# #   CurrentTag: <see below>
# #   ...
# #   ...
# #   RepairHistory: [
#       # Mechanic: "Kyle King"
#       # Timestamp: "NUMBER"
# #     Notes: "string",
# #     Tag: <ToBeRedistributed, RepairToBeStarted,
# #     RepairInProgress, WaitingOnParts, Available>
# #     ]
# # }

# ## /\ Not THE SAME - CHANGED /\


if Meteor.users.find({'roles': "Mechanic"}).count() isnt 0
  # Create staff roles (for more info see roles package)
  if MechanicNotes.find({}).count() is 0
    # local variable to populate collection
    BikeNotes = [
      {
        MechanicID: Meteor.users.findOne({'roles': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: Fake.sentence()
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'roles': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 1
        Notes: Fake.word()
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'roles': "Mechanic"})._id
        Timestamp: now - (10000000 * Math.random())
        Bike: 3
        Notes: Fake.sentence()
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'roles': "Mechanic"})._id
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