Template.root.onCreated ->
  Meteor.subscribe('ManageUsers')
  Meteor.subscribe('DailyBikeDataPub')
  # RackNames
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
    collections = [
      'Meteor.users'
      'DailyBikeData'
      'RackNames'
      'OuterLimit'
      'RFIDdata'
      'MechanicNotes'
      'XbeeData'
    ]
    tableValues = []
    _.each collections, (collection) ->
      tableValues.push({
        name: collection
        count: eval( collection + '.find().count()' )
        action: 'Create_' + collection
        clear: 'Delete_' + collection
      })
    console.log tableValues
    return tableValues
