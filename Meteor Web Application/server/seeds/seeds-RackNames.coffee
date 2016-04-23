Meteor.methods 'Create_RackNames': ->
  if RackNames.find().count() is 0
    [today, now] = CurrentDay()
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
    _.each RackNamesInfo.features, (rackData) ->
      # Convert to decimal from projection
      proj4('GOOGLE', 'WGS84', rackData.geometry)
      # Now convert ring data
      CurrentID = rackData.attributes.OBJECTID - 1
      BikeRackShapeData = []
      # console.log '--- One Iteration ---'
      # console.log CurrentID
      # console.log rackData.geometry.x + ' and ' + rackData.geometry.y
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
        attributes: rackData.attributes
        Coordinates: [rackData.geometry.y, rackData.geometry.x]
        Details: BikeRackShapeData
        Optional: 7
        Availability: rackData.attributes.Rack_Capac
      InsertedID = RackNames.insert doc
      RackDocs.push doc
    console.log 'Create_RackNames: Imported UMD data'.lightYellow
