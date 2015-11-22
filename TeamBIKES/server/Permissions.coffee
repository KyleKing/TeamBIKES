RFIDdata.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

RackNames.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

DailyBikeData.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fields, modifier) ->
    true
  remove: (userId, doc) ->
    true
  fetch: [ 'owner' ]

Meteor.users.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc, fields, modifier) ->
    true
  fetch: [ 'owner' ]

MechanicNotes.allow
  insert: (userId, doc) ->
    # A safer alternative would be :
    # return (userId && doc.owner === userId);
    true
  update: (userId, doc, fields, modifier) ->
    # A safer alternative would be :
    # return doc.owner === userId;
    true
  remove: (userId, doc) ->
    # A safer alternative would be :
    # return doc.owner === userId;
    true
  fetch: [ 'owner' ]