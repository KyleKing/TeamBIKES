Meteor.startup ->
  sAlert.config
    effect: 'stackslide'
    position: 'bottom'
    timeout: 3000
    html: false
    onRouteClose: true
    stack: true
    offset: 0

Template.map.rendered = ->
  Meteor.subscribe("AvailableBikeLocationsPub")
  Meteor.subscribe("ReservedBike")

  # Create the Leaflet Map
  L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
  map = new (L.Map)('BikeMap', center: new (L.LatLng)(38.987701, -76.940989))
  L.tileLayer.provider('OpenStreetMap.Mapnik').addTo map
  map.spin false

  # Give user control over location
  LocateControl = L.control.locate(
    drawCircle: true
    follow: true
    setView: true
    keepCurrentZoomLevel: false
    remainActive: false
    markerClass: L.circleMarker).addTo map
  # # Start automatically
  # LocateControl.start()

  # Otherwise center on UMD
  map.setView new (L.LatLng)(38.987701, -76.940989), 16

  # Bike icons
  # Unselected, but available
  GreyBike = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'cadetblue'
    iconColor: 'white')
  # Selected bike
  RedBike = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'red'
    iconColor: 'white')
  # Reserved
  GreenBike = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'green'
    iconColor: 'white')

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  markers = []
  Session.set
    "selectedBike": false
    "available": true

  DailyBikeData.find({}).observe
    added: (bike) ->
      latlng = bike.Location.coordinates
      if bike.Tag == 'Available'
        BikeIcon = GreyBike
      else
        BikeIcon = GreenBike
      markers[bike._id] = L.marker(latlng,
        title: bike.Bike
        opacity: 0.75
        icon: BikeIcon).on("click", (e) ->
          # Remove previously selected bike
          if Session.get('selectedBike') && Session.get('available')
            if bike.Tag == 'Available'
              BikeIcon = GreyBike
            else
              BikeIcon = GreenBike
            last = Session.get 'selectedBike'
            last_id = DailyBikeData.findOne({Bike: last})._id
            markers[last_id].setIcon BikeIcon

          # Highlight new bike
          @setIcon RedBike
          Session.set
            "selectedBike": e.target.options.title
            "available": true
          # console.log e.target
          # console.log e.target._leaflet_id
          # console.log e.target.options.title
          ).addTo(map)

      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag)
      console.log "Added: " + markers[bike._id]._leaflet_id

      home = [38.987701, -76.940989]
      closest = DailyBikeData.find({Location:{$near:{$geometry:{type:"point",coordinates:home},$maxDistance:99999}}}).fetch()
      console.log closest[0]
      console.log closest[0].Location.coordinates

      polygon = L.polyline([
        home
        closest[0].Location.coordinates
      ], {color: 'red'}).addTo(map)

      polygon = L.polyline([
        home
        closest[1].Location.coordinates
      ], {color: 'blue'}).addTo(map)

      polygon = L.polyline([
        home
        closest[2].Location.coordinates
      ], {color: 'purple'}).addTo(map)

    changed: (bike, oldBike) ->
      if oldBike.Tag == bike.Tag
        latlng = bike.Location.coordinates.coordinates
        markers[bike._id].setLatLng(latlng).update()
        console.log markers[bike._id]._leaflet_id + ' changed on map on CHANGED event'
      else if bike.Tag == Meteor.userId()
        markers[bike._id].setIcon GreenBike
        console.log 'Changed to green icon color for # ' + bike.Bike
      else if bike.Tag == "Available"
        markers[bike._id].setIcon GreyBike
        console.log 'Changed to gray icon color for # ' + bike.Bike
      else
        console.log "changed, but not with this logic"

    removed: (oldBike) ->
      if oldBike.Tag != Meteor.userId() && Session.get 'available'
        # If removed bike is currently selected bike...
        if Session.get("selectedBike") == oldBike.Bike
          # Updated reserve bike text
          Session.set
            "available": false
          # And alert user
          sAlert.warning('Bike reserved by different user. Select new bike')
      # Remove the marker from the map
      map.removeLayer markers[oldBike._id]
      console.log markers[oldBike._id]._leaflet_id + ' removed from map on REMOVED event and...'
      # Remove the reference to this marker instance
      delete markers[oldBike._id]



  # Active area of bike map
  # Manually drawn from: http://www.latlong.net/
  polygon = L.polygon([
    [ 39.000276, -76.943264 ]
    [ 38.998642, -76.946397 ]
    [ 38.992438, -76.951632 ]
    [ 38.986300, -76.956096 ]
    [ 38.985433, -76.955495 ]
    [ 38.984733, -76.952019 ]
    [ 38.983765, -76.952190 ]
    [ 38.983532, -76.948543 ]
    [ 38.981330, -76.946354 ]
    [ 38.977527, -76.937985 ]
    [ 38.983065, -76.937771 ]
    [ 38.983131, -76.934423 ]
    [ 38.983832, -76.933479 ]
    [ 38.984833, -76.934423 ]
    [ 38.984799, -76.937299 ]
    [ 38.992671, -76.933093 ]
    [ 38.993105, -76.935153 ]
    [ 38.996074, -76.935325 ]
    [ 38.996174, -76.937728 ]
    [ 39.000243, -76.942277 ]
    [ 39.001777, -76.940989 ]
    [ 39.003244, -76.940818 ]
    [ 39.003711, -76.942706 ]
    [ 39.001210, -76.943436 ]
  ], {
    fill: false
    color: 'blue'
    smoothFactor: 7
    weight: 10
  }).addTo(map)

# Provide context for user
Template.map.helpers
  selectedBike: ->
    if Session.get 'selectedBike'
      if Session.get 'available'
        "Bike #" + Session.get 'selectedBike'
      else
        "Select a new bike"
    else
      "Click marker to reserve bike"

Template.map.events
  'click #ReserveBtn': (e) ->
    # Get selected bike, remove current icon, and update selected bike logic
    Bike = Session.get 'selectedBike'
    Session.set "available": false
    Meteor.call 'UserReserveBike', Meteor.userId(), Bike, (error, result) ->
      if error
        console.log error.reason
      else
        sAlert.success('Bike #' + Bike + ' successfully reserved!')
        if result != 0
          sAlert.warning(result + ' previously reserved bikes were re-listed as Available')

    # then change view to only show revered bike and timer