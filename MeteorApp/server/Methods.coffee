Meteor.methods 'UserReserveBike': (currentUserId, Bike) ->
  # Check if other reserved bikes and remove reservations
  count = Meteor.call('RemoveReservation', currentUserId)

  # Find and reserve requested bike
  [today, now] = CurrentDay()
  record = DailyBikeData.findOne({Bike: Bike, Day: today})
  if record
    record.set({Tag: currentUserId})
    record.save()
    console.log 'Reserved bike #' + Bike
  else
    errMessage = 'No Bike Record Found in Method: UserReserveBike'
    throw errMessage
  # Create cron task to delete reservation at set time interval
  Meteor.call('StartReservationCountdown', currentUserId, Bike)

# Meteor.methods 'DeleteRacks': ->
#   RackNames.remove( { "attributes.OBJECTID": { $lt:  100000} } )
#   'ok'


# Meteor.methods 'loop': (dataSet, schema) ->
#   # Print out schema of received data]
#   # for (var key in dataSet) {
#   #   if (dataSet.hasOwnProperty(key)) {
#   #     console.log(key + " -> " + dataSet[key]);
#   #   }
#   # }
#   # Prepare fields to udpate MongoDB
#   fields = {}
#   root = [ 'Time.' + dataSet.timeHH + '.' + dataSet.timemm ]
#   fields[root + '.user'] = dataSet.User
#   fields[root + '.lat'] = dataSet.Lat
#   fields[root + '.lng'] = dataSet.Long
#   # Update MongoDB data based on bike number
#   record = TimeSeries.findOne(
#     Bike: dataSet.BikeNumber
#     YYYY: dataSet.timeYYYY
#     MM: dataSet.timeMM
#     DD: dataSet.timeDD)
#   TimeSeries.update record, $set: fields
#   'ok'
# Meteor.methods 'current': (dataSet, schema) ->
#   # Print out schema of received data]
#   for key of dataSet
#     if dataSet.hasOwnProperty(key)
#       console.log key + ' -> ' + dataSet[key]
#   # Prepare fields to udpate MongoDB
#   fields = {}
#   fields.lat = dataSet.lat
#   fields.lng = dataSet.lng
#   # Update MongoDB data based on bike number
#   record = Current.findOne(Bike: dataSet.BikeNumber)
#   Current.update record, $set: fields
#   'ok'
# Meteor.methods 'chart': (dataSet) ->
#   # Prepare fields to udpate MongoDB
#   fields = {}
#   fields['data.' + dataSet.BikeNumber] = dataSet.Potentiometer
#   fields.x = dataSet.x
#   console.log dataSet.Potentiometer
#   # Update MongoDB data based on bike number
#   record = AdminAreaChart.findOne()
#   AdminAreaChart.update record, $set: fields
#   'ok'




# # ###*******************************************###

# # ###  Meteor Methods (server side code called from client)  ###

# # ###******************************************###

# # # Testing sorting of array of documents
# # if Meteor.isServer
# #   Meteor.methods sortTime: ->
# #     pipeline = [
# #       { $match: bike: 4 }
# #       { $unwind: '$positions' }
# #       { $sort: 'positions.timestamp': -1 }
# #       { $group:
# #         _id: '$bike'
# #         positions: $push: '$positions' }
# #     ]
# #     Bike = TimeSeries.aggregate(pipeline)
# #     # var pipeline = [
# #     #   { $group : { _id : "$positions.timestamp", positions: { $push: "$positions.Lat" } } }
# #     #   // { $match: { bike: num} },
# #     #   // { $unwind: '$positions' },
# #     #   // { $sort: {'positions.timestamp': -1} }
# #     #   // { $out: "sortedTime" } // Not yet supported in Meteor
# #     # ];
# #     # var Bike = TimeSeries.aggregate(pipeline);
# #     SortTime.insert
# #       email: 'Kyle@email.com'
# #       meal: Bike[0]._id
# #       data: 4
# #       lunch: 12
# #     return
# #   # Called by Admin 3
# #   Meteor.methods eachBike: ->
# #     # For each bike (10), match and unwind into usable format
# #     BikeNum = 1
# #     while BikeNum <= 10
# #       Bikes = TimeSeries.aggregate([
# #         { $match: bike: BikeNum }
# #         { $unwind: '$positions' }
# #         { $sort: 'positions.timestamp': 1 }
# #         { $group:
# #           _id: '$positions.user'
# #           positions: $push: '$positions' }
# #       ])

# #       ###*******************************************###

# #       ###   This should be including every bike with the same bike number regardless of day value, but it isn't ###

# #       ### Possibly due to the _id ###

# #       ###******************************************###

# #       # console.log(Bikes);
# #       # for each bike (scalable), ...
# #       _(Bikes).each (Bike) ->
# #         if Bike._id
# #           # Ignore blank strings (i.e. no user)
# #           record = TestUsers.findOne(User: Bike._id)
# #           positionsData = []
# #           rides = 0
# #           _(Bike.positions).each (position) ->
# #             positionsData.push
# #               bike: BikeNum
# #               timestamp: position.timestamp
# #               user: position.user
# #               lat: position.lat
# #               lng: position.lng
# #             rides = rides + 1
# #             return
# #           if !record
# #             TestUsers.insert
# #               user: Bike._id
# #               rides: rides
# #               positions: positionsData
# #           else
# #             _(Bike.positions).each (position) ->
# #               if !TestUsers.findOne('positions.timestamp': position.timestamp)
# #                 positionsData =
# #                   bike: BikeNum
# #                   timestamp: position.timestamp
# #                   user: position.user
# #                   lat: position.lat
# #                   lng: position.lng
# #                 TestUsers.update record,
# #                   $addToSet: positions: positionsData
# #                   $inc: rides: 1
# #               return
# #         return
# #       BikeNum++
# #     return
# # # end Meteor.isServer
