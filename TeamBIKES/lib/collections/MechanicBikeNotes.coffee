@MechanicBikeNotes = new Mongo.Collection 'mechanicBikeNotes'

# MechanicBikeNotes.helpers {}

# MechanicBikeNotes.before.insert (userId, doc) ->
#   doc.createdAt = moment().toDate()
#   return