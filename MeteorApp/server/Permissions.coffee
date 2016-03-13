# RFIDdata.allow
#   insert: ->
#     true
#   remove: ->
#     true
#   update: ->
#     true

# RackNames.allow
#   insert: ->
#     true
#   remove: ->
#     true
#   update: ->
#     true

# DailyBikeData.allow
#   insert: (userId, doc) ->
#     true
#   update: (userId, doc, fields, modifier) ->
#     true
#   remove: (userId, doc) ->
#     true
#   fetch: [ 'owner' ]

# Meteor.users.allow
#   insert: (userId, doc) ->
#     true
#   update: (userId, doc, fields, modifier) ->
#     true
#   fetch: [ 'owner' ]

MechanicNotes.allow
  insert: (userId, doc) ->
    # return (userId and doc.owner is userId)
    false
  update: (userId, doc, fields, modifier) ->
    # return (userId and doc.owner is userId)
    true
  remove: (userId, doc) ->
    # return (userId and doc.owner is userId)
    true
  fetch: [ 'owner' ]
