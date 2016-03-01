# if RackNames.find().count() is 0 or OuterLimit.find().count() is 0
#   console.log 'Found zero racknames in db'
#   Meteor.call 'QueryRackNames'

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
          output = proj4('GOOGLE', 'WGS84', coordinate)
          # Convert coordinate order back
          BikeRackShapeData.push(output.reverse())
      doc =
        attributes: OuterLine.attributes
        Details: BikeRackShapeData
        Optional: true
      InsertedID = OuterLimit.insert doc
  catch error
    console.log error

