DailyBikeData.allow
  insert: (userId, doc) ->
    #A safer alternative would be :
    #return (userId && doc.owner === userId);
    true
  update: (userId, doc, fields, modifier) ->
    #A safer alternative would be :
    #return doc.owner === userId;
    true
  fetch: [ 'owner' ]