# Reserve a bike
Meteor.methods 'UserReserveBike': (currentUserId, Bike) ->
  # Check if other reserved bikes and remove reservations
  count = DailyBikeData.find({Tag: currentUserId}).count()
  DailyBikeData.update { Tag: currentUserId}, {$set: Tag: 'Available' }, multi: true

  # Find and reserve requested bike
  record = DailyBikeData.findOne({Bike: Bike})
  if record
    DailyBikeData.update record, {$set: {Tag: currentUserId} }
    console.log 'Set tag for bike # ' + Bike
  count

Meteor.methods 'mySubmitFunc': (currentUserId) ->
  # Prepare fields to udpate MongoDB
  fields = {}
  fields.RFID = Fake.word()
  record = Meteor.users.findOne(_id: currentUserId)
  if record.RFID != undefined
    console.log [
      'RFID code already set for '
      record._id
    ]
  else
    Meteor.users.update record, $set: fields
    console.log [
      'Set RFID code for '
      record._id
    ]
  'ok'

###*******************************************###

###   TODO: Check for accounts without an RFID field and call this function          ###

# Use: http://docs.mongodb.org/manual/reference/operator/query/exists/
# $exists: false

###******************************************###



# Meteor.methods 'RFIDStreamData': (dataSet) ->
#   # Update MongoDB data based on bike number
#   record = RFIDdata.find().fetch()[0]
#   RFIDdata.insert
#     RFIDCode: dataSet.RFIDCode
#     time: dataSet.time
#   # Example Code:
#   # encrypted = CryptoJS.AES.encrypt(dataSet.RFIDCode.toString(), 'Dino');
#   # console.log(encrypted.toString());
#   key = 'Dino'
#   message = 'hi'
#   encrypted = CryptoJS.AES.encrypt(message, key)
#   console.log encrypted.toString()
#   # 53616c7465645f5fe5b50dc580ac44b9be85d240abc5ff8b66ca327950f4ade5
#   decrypted = CryptoJS.AES.decrypt(encrypted, key)
#   console.log decrypted.toString(CryptoJS.enc.Utf8)
#   # Message
#   encrypted.toString()

Meteor.methods 'RFIDStreamData': (dataSet) ->
  incoming = dataSet.RFIDCode
  console.log incoming.trim()
  # Remove excess whitespace
  code = incoming.trim()
  if RFIDdata.find(RFIDCode: code).count() == 1
    # Correct RFID Code Found
    record = RFIDdata.find(RFIDCode: code)
    'OPENSESAME*'
  else if RFIDdata.find(RFIDCode: code).count() == 0
    # No RFID Code Found
    'NO*'
  else
    # Too many RFID codes found
    console.log 'Too many matching RFID codes....what the heck!?!?!'
    'MongoDB Error'


Meteor.methods 'loop': (dataSet, schema) ->
  # Print out schema of received data]
  # for (var key in dataSet) {
  #   if (dataSet.hasOwnProperty(key)) {
  #     console.log(key + " -> " + dataSet[key]);
  #   }
  # }
  # Prepare fields to udpate MongoDB
  fields = {}
  root = [ 'Time.' + dataSet.timeHH + '.' + dataSet.timemm ]
  fields[root + '.user'] = dataSet.User
  fields[root + '.lat'] = dataSet.Lat
  fields[root + '.lng'] = dataSet.Long
  # Update MongoDB data based on bike number
  record = TimeSeries.findOne(
    Bike: dataSet.BikeNumber
    YYYY: dataSet.timeYYYY
    MM: dataSet.timeMM
    DD: dataSet.timeDD)
  TimeSeries.update record, $set: fields
  'ok'
Meteor.methods 'current': (dataSet, schema) ->
  # Print out schema of received data]
  for key of dataSet
    if dataSet.hasOwnProperty(key)
      console.log key + ' -> ' + dataSet[key]
  # Prepare fields to udpate MongoDB
  fields = {}
  fields.lat = dataSet.lat
  fields.lng = dataSet.lng
  # Update MongoDB data based on bike number
  record = Current.findOne(Bike: dataSet.BikeNumber)
  Current.update record, $set: fields
  'ok'
Meteor.methods 'chart': (dataSet) ->
  # Prepare fields to udpate MongoDB
  fields = {}
  fields['data.' + dataSet.BikeNumber] = dataSet.Potentiometer
  fields.x = dataSet.x
  console.log dataSet.Potentiometer
  # Update MongoDB data based on bike number
  record = AdminAreaChart.findOne()
  AdminAreaChart.update record, $set: fields
  'ok'




# ###*******************************************###

# ###  Meteor Methods (server side code called from client)  ###

# ###******************************************###

# # Testing sorting of array of documents
# if Meteor.isServer
#   Meteor.methods sortTime: ->
#     pipeline = [
#       { $match: bike: 4 }
#       { $unwind: '$positions' }
#       { $sort: 'positions.timestamp': -1 }
#       { $group:
#         _id: '$bike'
#         positions: $push: '$positions' }
#     ]
#     Bike = TimeSeries.aggregate(pipeline)
#     # var pipeline = [
#     #   { $group : { _id : "$positions.timestamp", positions: { $push: "$positions.Lat" } } }
#     #   // { $match: { bike: num} },
#     #   // { $unwind: '$positions' },
#     #   // { $sort: {'positions.timestamp': -1} }
#     #   // { $out: "sortedTime" } // Not yet supported in Meteor
#     # ];
#     # var Bike = TimeSeries.aggregate(pipeline);
#     SortTime.insert
#       email: 'Kyle@email.com'
#       meal: Bike[0]._id
#       data: 4
#       lunch: 12
#     return
#   # Called by Admin 3
#   Meteor.methods eachBike: ->
#     # For each bike (10), match and unwind into usable format
#     BikeNum = 1
#     while BikeNum <= 10
#       Bikes = TimeSeries.aggregate([
#         { $match: bike: BikeNum }
#         { $unwind: '$positions' }
#         { $sort: 'positions.timestamp': 1 }
#         { $group:
#           _id: '$positions.user'
#           positions: $push: '$positions' }
#       ])

#       ###*******************************************###

#       ###   This should be including every bike with the same bike number regardless of day value, but it isn't ###

#       ### Possibly due to the _id ###

#       ###******************************************###

#       # console.log(Bikes);
#       # for each bike (scalable), ...
#       _(Bikes).each (Bike) ->
#         if Bike._id
#           # Ignore blank strings (i.e. no user)
#           record = TestUsers.findOne(User: Bike._id)
#           positionsData = []
#           rides = 0
#           _(Bike.positions).each (position) ->
#             positionsData.push
#               bike: BikeNum
#               timestamp: position.timestamp
#               user: position.user
#               lat: position.lat
#               lng: position.lng
#             rides = rides + 1
#             return
#           if !record
#             TestUsers.insert
#               user: Bike._id
#               rides: rides
#               positions: positionsData
#           else
#             _(Bike.positions).each (position) ->
#               if !TestUsers.findOne('positions.timestamp': position.timestamp)
#                 positionsData =
#                   bike: BikeNum
#                   timestamp: position.timestamp
#                   user: position.user
#                   lat: position.lat
#                   lng: position.lng
#                 TestUsers.update record,
#                   $addToSet: positions: positionsData
#                   $inc: rides: 1
#               return
#         return
#       BikeNum++
#     return
# # end Meteor.isServer