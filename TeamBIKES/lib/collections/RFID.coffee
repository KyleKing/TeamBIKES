@RFIDdata = new Mongo.Collection 'RFIDdata'

# RFIDdata.helpers {}

# RFIDdata.before.insert (userId, doc) ->
#   doc.createdAt = moment().toDate()
#   return