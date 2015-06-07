@RedistributionCollection = new Mongo.Collection 'redistributionCollection'

# RedistributionCollection.helpers {}

# RedistributionCollection.before.insert (userId, doc) ->
#   doc.createdAt = moment().toDate()
#   return