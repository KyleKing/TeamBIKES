plot = (RouteID, OldRouteID) ->
  [GreyBike, RedBike, GreenBike] = MapInit(false, false, false, false)

  console.log 'OldRouteID = ' + OldRouteID
  console.log 'RouteID = ' + RouteID
  console.log OldRouteID != RouteID
  console.log OldRouteID != false

  # if OldRouteID == false
  #   console.log 'Creating layer group for markers'
  #   window.markers = new L.FeatureGroup()

  console.log 'Removing old markers'
  window.markers.clearLayers()

  DailyBikeData.find({_id: RouteID}).observe
    added: (bike) ->
      polyline = L.polyline([
        bike.Positions[0].Coordinates
        bike.Positions[1].Coordinates
      ], {
        color: 'blue'
        opacity: 0.4
        title: 'Next'
      })
      # .addTo(window.map)
      _.each bike.Positions, (BikeRecord) ->
        latlng = BikeRecord.Coordinates
        polyline.addLatLng(latlng) # extend polyline with new location
        if BikeRecord.Tag == 'Available'
          BikeIcon = GreyBike
        else if BikeRecord.Tag == 'RepairInProgress'
          BikeIcon = RedBike
        else
          BikeIcon = GreenBike
        marker = L.marker(latlng,
          title: BikeRecord.Bike
          opacity: 0.75
          icon: BikeIcon)
        # .addTo(window.map)
        window.markers.addLayer(marker)
      console.log 'bike.Bike = ' + bike.Bike
      window.markers.addLayer(polyline)
      window.map.addLayer(window.markers)

    # changed: (bike, oldBike) ->
    #   if oldBike.Tag == bike.Tag
    #     latlng = bike.Coordinates
    #     markers[bike._id].setLatLng(latlng).update()
    #     console.log markers[bike._id]._leaflet_id + ' changed on window.map on CHANGED event'
    #   else if bike.Tag == Meteor.userId()
    #     markers[bike._id].setIcon GreenBike
    #     console.log 'Changed to green icon color for # ' + bike.Bike
    #   else if bike.Tag == "Available"
    #     markers[bike._id].setIcon GreyBike
    #     console.log 'Changed to gray icon color for # ' + bike.Bike
    #   else
    #     console.log "changed, but not with this logic"

    # removed: (oldBike) ->
    #   # Remove the marker from the map
    #   window.map.removeLayer markers[Math.floor(oldBike.Positions.Timestamp)]
    #   console.log markers[Math.floor(oldBike.Positions.Timestamp)]._leaflet_id + ' removed from window.map on REMOVED event and...'
    #   # Remove the reference to this marker instance
    #   delete markers[Math.floor(oldBike.Positions.Timestamp)]




# REMOVE BIKE BETWEEN ROUTES? Do it without recreating the map?
# No ._id value for each element of the array


Template.ManageBike.rendered = ->
  Meteor.subscribe("DailyBikeDataPub")

  # Call MapInit function from s_Helpers to create the Leaflet Map
  coords = [38.987701, -76.940989]
  [GreyBike, RedBike, GreenBike] = MapInit('ManageBikeMap', false, false, coords)

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  Session.set
    "selectedBike": false
    "available": true

  @autorun ->
    # FlowRouter.watchPathChange()
    RouteID = FlowRouter.getParam("IDofSelectedRow")
    # Wait for data to be available
    if DailyBikeData.findOne({_id: RouteID})
      if isUndefined(Session.get("OldRouteID"))
        console.log 'OldRouteID was undefined, so reset session var'
        Session.set "OldRouteID": false
      if isUndefined(window.markers)
        console.log 'Creating layer group for markers'
        window.markers = new L.FeatureGroup()
      plot(RouteID, Session.get("OldRouteID"))
      Session.set "OldRouteID": RouteID