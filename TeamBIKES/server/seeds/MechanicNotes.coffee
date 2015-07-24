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


if Meteor.users.find().count() != 0
  # Create staff roles (for more info see roles package)
  if MechanicNotes.find({}).count() == 0
    # local variable to populate collection
    BikeNotes = [
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: "NUMBER"
        Bike: 1
        Notes: 'Only a string'
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: "NUMBER"
        Bike: 1
        Notes: "string of something information"
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: "NUMBER"
        Bike: 3
        Notes: "I am Groot"
        Tag: "ToBeRedistributed"
      }
      {
        MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
        Timestamp: "NUMBER"
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