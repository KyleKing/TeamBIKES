Template.ManageBike.helpers
  'SelectedBike': ->
    # Access position in array based on bike icon clicked on
    bikeNum = Session.get('SelectedBike_Position')
    if bikeNum is false
      return false
    else
      bike = DailyBikeData.findOne(FlowRouter.getParam("IDofSelectedRow"))
      console.log bike.Positions[bikeNum]
      return bike.Positions[bikeNum]

Template.ManageBike.rendered = ->
  Meteor.subscribe("DailyBikeDataPub")

  # Call MapInit function from s_Helpers to create the Leaflet Map
  MapInit
    MapName: 'ManageBikeMap'
    LocateUser: false
    DrawOutline: false
    Center: [38.987701, -76.940989]
    ShowClosestBikes: false
    FullScreenButton: true
    PopupGuide: 'Click a bike to learn more'
    ShowBikeRacksMarkerToggle: true
    # OptionalBikeRacksMarkers: 7

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  Session.set
    "SelectedBike_Position": false
    "available": true

  @autorun ->
    console.log 'THIS AUTORUN IS RUNNING'
    # FlowRouter.watchPathChange()
    RouteID = FlowRouter.getParam("IDofSelectedRow")
    # Wait for data to be available
    if DailyBikeData.findOne({_id: RouteID})
      if isUndefined(window.markers)
        console.log 'Creating layer group for markers'
        window.markers = new L.FeatureGroup()
      PlotAdminBikes(RouteID)


PlotAdminBikes = (RouteID) ->
  if window.markers.getLayers()
    console.log 'Removing old markers'
    window.markers.clearLayers()

  window.MapObserveHandle = DailyBikeData.find({_id: RouteID}).observe
    added: (bike) ->
      # polyline = L.polyline([
      #   bike.Positions[0].Coordinates
      #   bike.Positions[1].Coordinates
      # ], {
      #   color: 'blue'
      #   opacity: 0.4
      #   title: 'Next'
      # })

      PositionCount = 0
      NumDataPoints = bike.Positions.length
      _.each bike.Positions, (BikeRecord) ->
        latlng = BikeRecord.Coordinates
        # polyline.addLatLng(latlng) # extend polyline with new location

        BikeIcon = IconLogic(BikeRecord.Tag)
        markers[PositionCount] = L.marker(latlng,
          title: PositionCount
          opacity: PositionCount / NumDataPoints
          icon: BikeIcon).on("click", (e) ->
            # Highlight new bike
            @setIcon window.Selected
            # On previously selected bike, change icon back to proper icon
            if Session.get('SelectedBike_Position') || Session.get('SelectedBike_Position') == 0
              ArrayPosition = Session.get 'SelectedBike_Position'
              console.log ArrayPosition
              ThisBike = DailyBikeData.findOne({_id: FlowRouter.getParam("IDofSelectedRow")})
              console.log ThisBike
              BikeTag =  ThisBike.Positions[ArrayPosition].Tag
              console.log BikeTag
              markers[ArrayPosition].setIcon IconLogic(BikeTag)
              console.log IconLogic(BikeTag)
              console.log '-----break------'

            # Store info for later use
            Session.set
              "SelectedBike_Position": e.target.options.title
              "available": true
            console.log e.target.options.title
            ) # .addTo(window.ManageBikeMap)
        window.markers.addLayer(markers[PositionCount])
        PositionCount++
      # Confirm that one loop has been run and add layers to map
      console.log 'bike.Bike = ' + bike.Bike
      # window.markers.addLayer(polyline)
      window.ManageBikeMap.addLayer(window.markers)

    # changed: (bike, oldBike) ->
    #   if oldBike.Tag == bike.Tag
    #     latlng = bike.Coordinates
    #     markers[bike._id].setLatLng(latlng).update()
    #     console.log markers[bike._id]._leaflet_id + ' changed on window.ManageBikeMap on CHANGED event'
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
    #   window.ManageBikeMap.removeLayer markers[Math.floor(oldBike.Positions.Timestamp)]
    #   console.log markers[Math.floor(oldBike.Positions.Timestamp)]._leaflet_id + ' removed from window.ManageBikeMap on REMOVED event and...'
    #   # Remove the reference to this marker instance
    #   delete markers[Math.floor(oldBike.Positions.Timestamp)]

Template.ManageBike.destroyed = ->
  # stop observing DailyBikeData
  window.MapObserveHandle.stop()
