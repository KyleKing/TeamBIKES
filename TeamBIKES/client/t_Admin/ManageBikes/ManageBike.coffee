Meteor.startup ->
  sAlert.config
    effect: 'stackslide'
    position: 'top-right'
    timeout: 3000
    html: false
    onRouteClose: true
    stack: true
    offset: 10

Template.ManageBike.rendered = ->
  Meteor.subscribe("DailyBikeDataPub")

  # Call MapInit function from s_Helpers to create the Leaflet Map
  coords = [38.987701, -76.940989]
  [window.map, GreyBike, RedBike, GreenBike] = MapInit('ManageBikeMap', false, false, coords)

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  markers = []
  Session.set
    "selectedBike": false
    "available": true

  # current = FlowRouter.current()
  # DailyBikeData.find({_id: current.params.IDofSelectedRow}).observe
  DailyBikeData.find({_id: FlowRouter.getParam ("IDofSelectedRow")}).observe
  # DailyBikeData.find({_id: Session.get("IDofSelectedRowBikes")}).observe
    added: (bike) ->
      polyline = L.polyline([bike.Positions[0].Coordinates, bike.Positions[1].Coordinates], color: 'blue').addTo(map)
      _.each bike.Positions, (BikeRecord) ->
        latlng = BikeRecord.Coordinates
        polyline.addLatLng(latlng) # extend polyline with new location
        if BikeRecord.Rider == ''
          BikeIcon = GreyBike
        else
          BikeIcon = GreenBike
        markers[BikeRecord._id] = L.marker(latlng,
          title: BikeRecord.Bike
          opacity: 0.75
          icon: BikeIcon
          # ).on("click", (e) ->
          #   # Remove previously selected bike
          #   if Session.get('selectedBike') && Session.get('available')
          #     if BikeRecord.Tag == 'Available'
          #       BikeIcon = GreyBike
          #     else
          #       BikeIcon = GreenBike
          #     last = Session.get 'selectedBike'
          #     last_id = DailyBikeData.findOne({Bike: last})._id
          #     markers[last_id].setIcon BikeIcon

          #   # Highlight new bike
          #   @setIcon RedBike
          #   Session.set
          #     "selectedBike": e.target.options.title
          #     "available": true
          #   # console.log e.target
          #   # console.log e.target._leaflet_id
          #   # console.log e.target.options.title
            ).addTo(window.map)

      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag)
      # console.log "Added: " + markers[bike._id]._leaflet_id

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
    #   if oldBike.Tag != Meteor.userId() && Session.get 'available'
    #     # If removed bike is currently selected bike...
    #     if Session.get("selectedBike") == oldBike.Bike
    #       # Updated reserve bike text
    #       Session.set
    #         "available": false
    #       # And alert user
    #       sAlert.error('Bike reserved by different user. Select new bike')
    #   # Remove the marker from the map
    #   window.map.removeLayer markers[oldBike._id]
    #   console.log markers[oldBike._id]._leaflet_id + ' removed from window.map on REMOVED event and...'
    #   # Remove the reference to this marker instance
    #   delete markers[oldBike._id]