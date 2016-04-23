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

MechanicApproval = (userId) ->
  approvedRoles = ['Root', 'Admin', 'Mechanic']
  return Roles.userIsInRole(userId, approvedRoles)

MechanicNotes.allow
  insert: (userId, doc) ->
    return MechanicApproval(userId)
  update: (userId, doc, fields, modifier) ->
    return MechanicApproval(userId)
  remove: (userId, doc) ->
    return MechanicApproval(userId)

  fetch: [ 'owner' ]
