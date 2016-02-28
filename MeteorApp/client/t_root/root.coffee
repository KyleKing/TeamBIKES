Template.root.onCreated ->
  Meteor.subscribe('ManageUsers')
  Meteor.subscribe('DailyBikeDataPub')
  # Racknames
  # Outline

Template.root.events
  "click button.action": (e) ->
    # console.log e.currentTarget
    id = e.currentTarget.id
    Meteor.call(id)
  "click button.clear": (e) ->
    id = e.currentTarget.id
    Meteor.call(id)

Template.root.helpers
  listOfCollections: ->
    return [
      {
        name: 'Meteor.users'
        count: Meteor.users.find().count()
        action: 'Create_Users'
        clear: 'Delete_Users'
      }
      {
        name: 'DailyBikeData'
        count: DailyBikeData.find().count()
        action: 'CreateDailyBikeData'
        clear: 'Delete_DailyBikeData'
      }
      {
        name: 'RackNames'
        count: RackNames.find().count()
        action: 'Create_RackNames'
        clear: 'Delete_RackNames'
      }
      {
        name: 'OuterLimit'
        count: OuterLimit.find().count()
        action: 'Create_OuterLimit'
        clear: 'Delete_RackNames'
      }
      {
        name: 'RFIDdata'
        count: RFIDdata.find().count()
        action: 'Create_RFIDdata'
        clear: 'Delete_RFIDdata'
      }
      {
        name: 'MechanicNotes'
        count: MechanicNotes.find().count()
        action: 'Create_MechanicNotes'
        clear: 'Delete_MechanicNotes'
      }
    ]
