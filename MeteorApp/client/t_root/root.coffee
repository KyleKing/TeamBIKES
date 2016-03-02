Template.root.onCreated ->
  Meteor.subscribe('Pub_Users')
  Meteor.subscribe('Pub_DailyBikeData')
  Meteor.subscribe('Pub_RackNames')
  Meteor.subscribe('Pub_OuterLimit')
  Meteor.subscribe('Pub_RFIDtags')
  Meteor.subscribe('Pub_MechanicNotes')
  Meteor.subscribe('Pub_XbeeData')
  # TestProject:
  Meteor.subscribe('Pub_RandMechanicNames')
  Meteor.subscribe('Pub_BarChart')
  Meteor.subscribe('Pub_AdminBarChart')
  Meteor.subscribe('Pub_AdminAreaChart')
  Meteor.subscribe('Pub_TestProject')

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
      'TestProject'
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
