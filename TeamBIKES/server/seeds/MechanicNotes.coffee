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
if Meteor.users.find().count() != 0
  # Create staff roles (for more info see roles package)
  if MechanicNotes.find({}).count() == 0
    # local variable to populate collection
    BikeNotes = [
      {
        CurrentTag: "ToBeRedistributed"
        RepairHistory:
          MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
          Timestamp: "NUMBER"
          Notes: "string of useless information"
          Tag: "ToBeRedistributed"
      }
      {
        CurrentTag: "Available"
        RepairHistory:
          [{
            MechanicID: Meteor.users.findOne({'profile.name': "Root"})._id
            Timestamp: "NUMBER"
            Notes: "I am Groot"
            Tag: "Available"
          }
          {
            MechanicID: Meteor.users.findOne({'profile.name': "Mechanic"})._id
            Timestamp: "NUMBER"
            Notes: "string of useless information"
            Tag: "ToBeRedistributed"
          }]
      }
    ]
    # Populate Accounts db
    _.each BikeNotes, (BikeNote) ->
      MechanicNotes.insert
        CurrentTag: BikeNote.CurrentTag
        RepairHistory: [BikeNote.RepairHistory]
    console.log 'MechanicNotes Created'