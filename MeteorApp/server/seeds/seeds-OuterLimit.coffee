Meteor.methods 'Create_OuterLimit': ->
  if OuterLimit.find().count() is 0
    [today, now] = CurrentDay()
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
      console.log 'Create_OuterLimit: Imported campus boundary from UMD'.lightYellow
    catch error
      throw error
