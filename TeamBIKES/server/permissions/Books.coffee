Books.allow
  insert: (userId, doc) ->
    # the user must be logged in, and the document must be owned by the user
    # userId and doc.owner == userId
    userId
  update: (userId, doc, fields, modifier) ->
    # can only change your own documents
    # doc.owner == userId
    userId
  remove: (userId, doc) ->
    # can only remove your own documents
    # doc.owner == userId
    userId
    # fetch: [ 'owner' ]