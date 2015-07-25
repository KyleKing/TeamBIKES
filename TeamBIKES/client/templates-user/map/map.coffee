Template.map.rendered = ->
  Meteor.subscribe("AvailableBikeLocationsPub");
  # Create the Leaflet Map
  L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
  map = new (L.Map)('BikeMap', center: new (L.LatLng)(38.987701, -76.940989))
  L.tileLayer.provider('OpenStreetMap.Mapnik').addTo map
  map.spin false

  # Creates a red marker with the coffee icon
  redBike = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'red'
    iconColor: 'white')

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  markers = []
  # Notes for using included MarkCluster Package
  ClusterLayer = new (L.MarkerClusterGroup)
  ClusterLayer = L.markerClusterGroup(disableClusteringAtZoom: 16)
  AvailableBikeLocations.find({}).observe
    added: (bike) ->
      latlng = [
        bike.Lat
        bike.Lng
      ]
      marker = L.marker(latlng,
        title: '#' + bike.Bike + ' is ' + bike.Tag
        opacity: 0.8
        icon: redBike)
      marker = ClusterLayer.addLayer marker
      map.addLayer ClusterLayer
      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag);
      # Store this marker instance within the markers object.
      markers[bike._id] = marker
      # console.log bike._id + ' added to map on ADDED event'
    changed: (bike, oldDocument) ->
      latlng = [
        bike.Lat
        bike.Lng
      ]
      markers[bike._id].setLatLng(latlng).update()
      # console.log bike._id + ' changed on map on CHANGED event'
    removed: (oldBike) ->
      console.log oldBike
      # Remove the marker from the map
      map.removeLayer markers[oldBike._id]
      # Remove the reference to this marker instance
      delete markers[oldBike._id]
      # console.log oldBike._id + ' removed from map on REMOVED event'

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
  }

  ).addTo(map)

  # # // Zoom to user location
  # # Create marker
  # meMarker = L.AwesomeMarkers.icon(
  #   prefix: 'fa'
  #   icon: 'user'
  #   markerColor: 'blue'
  #   iconColor: 'white')
  # # Locate, zoom and plot
  # map.locate(setView: true).on 'locationfound', (e) ->
  #   marker = L.marker([
  #     e.latitude
  #     e.longitude
  #   ], icon: meMarker).addTo(map)
  # # map.locate({ setView: true })
  map.setView new (L.LatLng)(38.987701, -76.940989), 13

# Template.map.rendered = ->
#   return Meteor.subscribe('AvailableBikeLocationsPub', ->
#     if Meteor.isClient
#       console.log AvailableBikeLocations.find().count()
#       ###*******************************************###
#       ###   Configure Leaflet Map                   ###
#       ###******************************************###

#       # L.Icon.Default.imagePath = 'leaflet/images';
#       map = new (L.Map)('map',
#         center: new (L.LatLng)(38.987701, -76.940989)
#         maxZoom: 20
#         zoom: 16
#         zoomControl: false)
#       HERE_hybridDayMobile = L.tileLayer('http://{s}.{base}.maps.cit.api.here.com/maptile/2.1/maptile/{mapID}/hybrid.day.mobile/{z}/{x}/{y}/256/png8?app_id={app_id}&app_code={app_code}',
#         attribution: 'Map &copy; 1987-2014 <a href="http://developer.here.com">HERE</a>'
#         subdomains: '1234'
#         mapID: 'newest'
#         app_id: 'JIX0epTdHneK1hQlqfkr'
#         app_code: 'PchnUPPBcZ5VAuHmovac8g'
#         base: 'aerial'
#         minZoom: 0
#         maxZoom: 20).addTo(map)

#       zoomControl = L.control.zoom(position: 'bottomleft')
#       map.addControl zoomControl

#       ###*******************************************###
#       ###   Plot 'current' collection with available bike locations  ###
#       ###******************************************###

#       # Creates a red marker with the coffee icon
#       redBike = L.AwesomeMarkers.icon(
#         prefix: 'fa'
#         icon: 'bicycle'
#         markerColor: 'red'
#         iconColor: 'white')
#       # Use Leaflet markercluster group plugin
#       markers = new (L.MarkerClusterGroup)
#       map.addLayer markers

#       # Collect bike location data
#       bikesData = AvailableBikeLocations.find().fetch()
#       console.log bikesData

#       i = bikesData.length - 1
#       while i >= 1
#         if !isNaN(bikesData[i].Positions.Lat)
#           markers.addLayer new (L.Marker)(new (L.LatLng)(bikesData[i].Positions.Lat, bikesData[i].Positions.Lng), icon: redBike)
#           console.log(bikesData[i]);
#         else
#           console.log 'Bad Bike Location (NaN) - i.e. the current database is empty'
#           console.log bikesData[i]
#         i--
#       map.addLayer markers

#       ###*******************************************###

#       ###   Plot the user          ###

#       ###******************************************###

#       # Create marker
#       meMarker = L.AwesomeMarkers.icon(
#         prefix: 'fa'
#         icon: 'user'
#         markerColor: 'blue'
#         iconColor: 'white')
#       # Locate, zoom and plot
#       map.locate(setView: true).on 'locationfound', (e) ->
#         marker = L.marker([
#           e.latitude
#           e.longitude
#         ], icon: meMarker).addTo(map)
#         # console.log([e.latitude, e.longitude]);
#         return
#       return
#     )
#   return