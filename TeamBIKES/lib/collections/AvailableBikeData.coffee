@AvailableBikeData = new Mongo.Collection 'availableBikeData'

# AvailableBikeData.helpers {}

# AvailableBikeData.before.insert (userId, doc) ->
#   doc.createdAt = moment().toDate()
#   return