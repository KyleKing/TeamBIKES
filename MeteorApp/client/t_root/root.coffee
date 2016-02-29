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
      'RFIDtags'
      'MechanicNotes'
      'XbeeData'
    ]
    tableValues = []
    _.each collections, (collection) ->
      cln = if collection is 'Meteor.users' then 'Users' else collection
      tableValues.push({
        name: collection
        count: eval( collection + '.find().count()' )
        action: 'Create_' + cln
        clear: 'Delete_' + cln
      })
    return tableValues
