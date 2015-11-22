# Useful function from lib/CurrentDay.coffee for current date and time
[today, now] = CurrentDay()

# To help with load order, make sure there is DailyBikeData available
# Called in cron demo
@PopulateDailyBikeData = () ->
  if DailyBikeData.find({Day: today}).count() is 0
    # If collection is empty
    if RedistributionCollection.find().count() is 0
      console.log 'Starting PopulateDailyBikeData to create Redistribution Collection'
      # Find all bikes
      BikeData = DailyBikeData.find({Day: today}).fetch()
      # Then strip out PII for redistribution access
      _.each BikeData, (BikeDatum) ->
        RedistributionCollection.insert
          Bike: BikeDatum.Bike
          Day: BikeDatum.Day
          Tag: BikeDatum.Tag
          # Make sure to strip out rider name
          Positions:
            Timestamp: BikeDatum.Positions[1].Timestamp
            Lat: BikeDatum.Positions[1].Lat
            Lng: BikeDatum.Positions[1].Lng
      console.log 'Created RedistributionCollection data schema'

# Re-factor into methods that can be run asynchronously
# Meteor.methods longMethod: ->
#   @unblock()
#   Meteor._sleepForMs 1000 * 60 * 60
#   return

Meteor.methods
  CreateDailyBikeData: (NumBikes, NumDays) ->
    # @CreateDailyBikeData = (NumBikes, NumDays) ->
    # allow to run asynchronously
    @unblock()

    # DailyBikeData {
    #   Bike: <number>,
    #   Day: <number out of 365>,
    #   Tag: <ToBeRedistributed, RepairToBeStarted, RepairInProgress, WaitingOnParts, Available>
    #   Positions: [{
    #     TS: <timestamp>,
    #     Rider: <None, User ID, or Employee ID>,
    #     Lat: 38.991403,
    #     Lng: -76.941449
    #   }, ...]
    # }

    randNames = [
      'Anastasia Romanoff'
      'Marie Antoinette'
      'Chuff Chuffington'
      'Kate Middleton'
      'Harry Potter'
      'Snow White'
      'Lake Likesscooters'
      'Pippa Middleton'
      'Napoleon Bonapart'
      'Britany Bartsch'
      'Roselee Sabourin'
      'Chelsie Vantassel'
      'Chaya Daley'
      'Luella Cordon'
      'Jamel Brekke'
      'Jonie Schoemaker'
      'Susannah Highfield'
      'Mitzi Brouwer'
      'Forrest Lazarus'
      'Dortha Dacanay'
      'Delinda Brouse'
      'Alyssa Castenada'
      'Carlo Poehler'
      'Cicely Rudder'
      'Lorraine Galban'
      'Trang Lenart'
      'Patrica Quirk'
      'Zackary Dedios'
      'Ursula Kennerly'
      'Shameka Flick'
      'President Loh'
      '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''
    ]
    AllRandNames = [
      'Anastasia Romanoff'
      'Marie Antoinette'
      'Chuff Chuffington'
      'Kate Middleton'
      'Harry Potter'
      'Snow White'
      'Lake Likesscooters'
      'Pippa Middleton'
      'Napoleon Bonapart'
      'Britany Bartsch'
      'Roselee Sabourin'
      'Chelsie Vantassel'
      'Chaya Daley'
      'Luella Cordon'
      'Jamel Brekke'
      'Jonie Schoemaker'
      'Susannah Highfield'
      'Mitzi Brouwer'
      'Forrest Lazarus'
      'Dortha Dacanay'
      'Delinda Brouse'
      'Alyssa Castenada'
      'Carlo Poehler'
      'Cicely Rudder'
      'Lorraine Galban'
      'Trang Lenart'
      'Patrica Quirk'
      'Zackary Dedios'
      'Ursula Kennerly'
      'Shameka Flick'
      'President Loh'
    ]

    # Bottom Right: Latitude : 38.980296 | Longitude : -76.933479
    # Bottom Left: Latitude : 38.982297 | Longitude : -76.957941
    # Top Left: Latitude : 38.999109 | Longitude : -76.956053
    # Top Right: Latitude : 39.003778 | Longitude : -76.932278
    randGPS = (max) ->

      # Calculate random GPS coordinates within campus
      leftLat = 38.994052
      rightLat = 38.981376
      bottomLng = -76.936569
      topLng = -76.950603
      skew = 1000000
      randLat = []
      randLng = []
      _.times max, ->
        randLat.push _.random(leftLat * skew, rightLat * skew) / skew
      _.times max, ->
        randLng.push _.random(bottomLng * skew, topLng * skew) / skew

      #   Save an array to return
      randCoordinates = [Number(randLat), Number(randLng)]
      # # Save in object to return
      # randCoordinates =
      #   Lat: Number(randLat)
      #   Lng: Number(randLng)
      randCoordinates
    # randGPS = () ->
    #   # RandID = _.random(1, RackNames.find().count())
    #   # RackNames.findOne({'attributes.OBJECTID': RandID}).Coordinates
    #   # console.log RackDocs[1].Coordinates
    #   # RackDocs[_.random(1, RackDocs.length())].Coordinates
    #   RackDocs[_.random(0, 284)].Coordinates


    # Insert database of bikes if no data for today
    # if DailyBikeData.find({Day: today}).count() is 0
    # if DailyBikeData.find({Day: today}).count() is 0 and RackNames.find().count() isnt 0
    console.log 'Started creating DailyBikeData data schema'
    j = 0
    while j < NumDays
      if DailyBikeData.find({Day: (today - j) }).count() is 0
        i = 1
        while i <= NumBikes
          # create template for each DailyBikeData data stored
          Position = []
          randomNow = NaN
          blank = {}
          countTime = 0
          while countTime < 30
            # For 60 minutes in an hour
            randomNow = now - (10000000 * Math.random())
            namePoint = Math.round((randNames.length - 1) * Math.random())
            # console.log('randNames = ' + randNames);
            if Math.round(0.75 * Math.random()) is 0
              if Math.round(1.1 * Math.random()) is 0
                RandTag = 'asdfahdfghsdlkfjsad'
              else
                RandTag = 'Available'
            else
              RandTag = 'RepairInProgress'
            blank =
              Tag: RandTag
              Rider: if RandTag is 'asdfahdfghsdlkfjsad' then AllRandNames[namePoint] else ''
              Timestamp: randomNow
              Coordinates: randGPS(1)
            # console.log('name = ' + blank.User);
            Position.push blank
            countTime++
          TotalBikes = DailyBikeData.find().count()
          if TotalBikes is 0
            BikeCount = i
          else
            BikeCount = TotalBikes + 1
          DailyBikeData.insert
            Bike: BikeCount
            Day: today - j
            # simplified version
            Tag: RandTag
            Coordinates: randGPS(1)
            Positions: Position
          i++
        console.log 'Created DailyBikeData data schema for ' + j + ' days behind today'
      j++
    console.log 'Done creating DailyBikeData data schema'
    # PopulateDailyBikeData()

    # ALERT KYLE
    info = 'PopulateDailyBikeData is in progress. Currently ' + DailyBikeData.find({Day: today}).count() + ' were found.'
    Meteor.call 'sendEmail', 'kmking72@gmail.com', 'kmking72@gmail.com', 'Hello from Meteor!', info

    'ok'

if RackNames.find().count() is 0
  # Fetch the data and parse into JSON
  console.log 'Starting Query RackNames'
  # format pjson is a formatted version
  url = 'http://maps.umd.edu/arcgis/rest/services/Layers/CampusBikeRacks/MapServer/4/query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry=%7B%22xmin%22%3A0%2C%22ymin%22%3A0%2C%22xmax%22%3A-900000000%2C%22ymax%22%3A900000000%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100'

  # parameters = {
  #   query?f=json&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry=%7B%22xmin%22%3A0%2C%22ymin%22%3A0%2C%22xmax%22%3A-900000000%2C%22ymax%22%3A900000000%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100
  # }
  # params:{
  #   "format": "json",
  #   "access_token": Meteor.settings.bitly,
  #   "longUrl": url
  # }
  # response = Meteor.http.get url, {timeout:30000, params: parameters}
  response = Meteor.http.get url, {timeout:30000}
  RackNamesInfo = JSON.parse(response.content)

  # And the whole shape of each bike rack
  urlDetails = 'http://maps.umd.edu/arcgis/rest/services/Layers/CampusBikeRacks/MapServer/0/query?f=pjson&returnGeometry=true&spatialRel=esriSpatialRelIntersects&geometry=%7B%22xmin%22%3A0%2C%22ymin%22%3A0%2C%22xmax%22%3A-900000000%2C%22ymax%22%3A900000000%2C%22spatialReference%22%3A%7B%22wkid%22%3A102100%7D%7D&geometryType=esriGeometryEnvelope&inSR=102100&outFields=*&outSR=102100'
  responseDetails = Meteor.http.get urlDetails, {timeout:30000}
  RackNamesDetails = JSON.parse(responseDetails.content)
  # console.log RackNamesDetails


  RackDocs = []
  # Don't overflow a single document and place each in own doc
  _.each RackNamesInfo.features, (RackData) ->
    # Convert to decimal from projection
    proj4('GOOGLE', 'WGS84', RackData.geometry)
    # Now convert ring data
    CurrentID = RackData.attributes.OBJECTID - 1
    BikeRackShapeData = []
    # console.log '--- One Iteration ---'
    # console.log CurrentID
    # console.log RackData.geometry.x + ' and ' + RackData.geometry.y
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
      Optional: 7
      Availability: RackData.attributes.Rack_Capac
    InsertedID = RackNames.insert doc
    RackDocs.push doc


# Create DailyBikeData
if DailyBikeData.find({Day: today}).count() is 0
  Meteor.call 'CreateDailyBikeData', 50, 2, (error, result) ->
    console.log result
  # CreateDailyBikeData(50, 2)
  # CreateDailyBikeData(RackDocs)

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
          # console.log '--- Originally ---'
          # console.log coordinate
          output = proj4('GOOGLE', 'WGS84', coordinate)
          # Account for weirdly flipped coordinates...
          BikeRackShapeData.push(output.reverse())
          # console.log '--- Output ---'
          # console.log output
      doc =
        attributes: OuterLine.attributes
        Details: BikeRackShapeData
        Optional: true
      InsertedID = OuterLimit.insert doc
  catch error
    console.log error