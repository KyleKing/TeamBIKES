Meteor.startup ->
  sAlert.config
    effect: 'stackslide'
    position: 'bottom'
    timeout: 2000
    html: false
    onRouteClose: true
    stack: true
    offset: 0

Meteor.subscribe("AvailableBikeLocationsPub");

Template.map.rendered = ->
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
  # Notes for using included MarkCluster Package
  ClusterLayer = new (L.MarkerClusterGroup)
  ClusterLayer = L.markerClusterGroup(disableClusteringAtZoom: 16)
  DailyBikeData.find({}).observe
    added: (bike) ->
      latlng = [ bike.Lat, bike.Lng ]
      markers[bike._id] = L.marker(latlng,
        title: bike.Bike
        opacity: 0.8
        icon: GreyBike).on("click", (e) ->
          # Remove previously selected bike
          if Session.get 'selectedBike'
            last = Session.get 'selectedBike'
            last_id = DailyBikeData.findOne({Bike: last})._id
            markers[last_id].setIcon GreyBike

          # Highlight new bike
          @setIcon RedBike
          Session.set
            "selectedBike": e.target.options.title
            "available": true
          # console.log e.target
          # console.log e.target._leaflet_id
          # console.log e.target.options.title
        )
      ClusterLayer.addLayer markers[bike._id]
      map.addLayer ClusterLayer
      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag);
    changed: (bike, oldDocument) ->
      latlng = [ bike.Lat, bike.Lng ]
      markers[bike._id].setLatLng(latlng).update()
      # console.log bike._id + ' changed on map on CHANGED event'
    removed: (oldBike) ->
      # If removed bike is currently selected bike...
      if Session.get("selectedBike") == oldBike.Bike
        # Updated reserve bike text
        Session.set
          "available": false
        # And alert user
        sAlert.warning('Bike reserved by different user. Select new bike')
      # Remove the marker from the map
      map.removeLayer markers[oldBike._id]
      # Remove the reference to this marker instance
      delete markers[oldBike._id]
      # console.log oldBike._id + ' removed from map on REMOVED event'


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
    Bike = Session.get 'selectedBike'
    result = Meteor.call('UserReserveBike', Meteor.userId(), Bike)
    sAlert.success('Bike #' + Bike + ' successfully reserved!')
    # then change view to only show revered bike and timer