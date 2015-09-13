# Fetch Bike Rack Locations from UMD API
Meteor.methods 'QueryRackNames': ->
  if RackNames.find().count() is 0
    try
      # Fetch the data and parse into JSON
      console.log 'Starting Query RackNames'
      # format pjson is a formatted version
      url = 'http://maps.umd.edu/arcgis/rest/services/Layers/CampusBikeRacks/MapServer/4/query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry=%7B%22xmin%22%3A0%2C%22ymin%22%3A0%2C%22xmax%22%3A-900000000%2C%22ymax%22%3A900000000%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100'
      response = Meteor.http.get url, {timeout:30000}
      RackNamesInfo = JSON.parse(response.content)
      # And the whole shape of each bike rack
      urlDetails = 'http://maps.umd.edu/arcgis/rest/services/Layers/CampusBikeRacks/MapServer/0/query?f=pjson&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry=%7B%22xmin%22%3A0%2C%22ymin%22%3A0%2C%22xmax%22%3A-900000000%2C%22ymax%22%3A900000000%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100'
      responseDetails = Meteor.http.get urlDetails, {timeout:30000}
      RackNamesDetails = JSON.parse(responseDetails.content)

      # Don't overflow a single document and place each in own doc
      _.each RackNamesInfo.features, (RackData) ->
        # Convert to decimal from projection
        proj4('GOOGLE', 'WGS84', RackData.geometry)
        # Now convert ring data
        CurrentID = RackData.attributes.OBJECTID - 1
        BikeRackShapeData = []
        _.each RackNamesDetails.features[CurrentID].geometry.rings, (coord) ->
          _.each coord, (coordinate) ->
            # _.each coordinate, (coord) ->
            # console.log '--- Originally ---'
            # console.log coordinate
            output = proj4('GOOGLE', 'WGS84', coordinate)
            # Account for weirdly flipped coordinates...
            BikeRackShapeData.push(output.reverse())
            # console.log '--- One Iteration ---'
            # console.log CurrentID
            # console.log output
            # console.log BikeRackShapeData
        doc =
          attributes: RackData.attributes
          Coordinates: [RackData.geometry.y, RackData.geometry.x]
          Details: BikeRackShapeData
          Optional: true
          Availablility: RackData.attributes.Rack_Capac
        InsertedID = RackNames.insert doc

  # console.log 'OuterLimit = ' + OuterLimit.find().count()
  if OuterLimit.find().count() is 0
    try
      console.log 'Running OuterLimit'
      urlOuterLimit = 'http://maps.umd.edu/arcgis/rest/services/Layers/CampusBoundary/MapServer/0/query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&maxAllowableOffset=1&geometry=%7B%22xmin%22%3A0%2C%22ymin%22%3A0%2C%22xmax%22%3A-900000000%2C%22ymax%22%3A900000000%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100'
      responseOuterLimit = Meteor.http.get urlOuterLimit, {timeout:30000}
      CampusOuterLimit = JSON.parse(responseOuterLimit.content)
      _.each CampusOuterLimit.features, (OuterLine) ->
        BikeRackShapeData = []
        _.each OuterLine.geometry.paths, (CoordinateRing) ->
          _.each CoordinateRing, (coordinate) ->
            console.log '--- Originally ---'
            console.log coordinate
            output = proj4('GOOGLE', 'WGS84', coordinate)
            # Account for weirdly flipped coordinates...
            BikeRackShapeData.push(output.reverse())
            console.log '--- Output ---'
            console.log output
        doc =
          attributes: OuterLine.attributes
          Details: BikeRackShapeData
          Optional: true
        InsertedID = OuterLimit.insert doc
    catch error
      console.log error


Meteor.methods 'UserReserveBike': (currentUserId, Bike) ->
  # Check if other reserved bikes and remove reservations
  count = RemoveReservation(currentUserId)

  # Find and reserve requested bike
  [today, now] = CurrentDay()
  record = DailyBikeData.findOne({Bike: Bike, Day: today})
  if record
    DailyBikeData.update record, {$set: {Tag: currentUserId} }
    console.log 'Reserved bike #' + Bike
  # Create cron task to delete reservation at set time interval
  StartReservationCountdown(currentUserId, Bike)
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