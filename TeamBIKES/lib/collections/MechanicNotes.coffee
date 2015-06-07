@MechanicNotes = new Mongo.Collection 'mechanicNotes'

# MechanicNotes.helpers {}

# MechanicNotes.before.insert (userId, doc) ->
#   doc.createdAt = moment().toDate()
#   return