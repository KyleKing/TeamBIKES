Template.map.rendered = ->
  # Create the Leaflet Map
  L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
  map = new (L.Map)('BikeMap', center: new (L.LatLng)(38.987701, -76.940989))
  L.tileLayer.provider('OpenStreetMap.Mapnik').addTo map
  map.spin false
  # // Receive data from server and display on map and rerun on server updates
  # Meteor.autorun(function() {
  #   var bikesData = AvailableBikeLocations.find().fetch();
  #   bikesData.forEach(function(bike) {
  #     var latlng = [bike.Positions.lat, bike.Positions.lng];
  #     var marker = L.marker(latlng).addTo(map);
  #     marker.bindPopup("#" + bike.Bike + " is " + bike.Tag);
  #   });
  # });
  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  markers = []
  AvailableBikeLocations.find({}).observe
    added: (bike) ->
      latlng = [
        bike.Lat
        bike.Lng
      ]
      marker = L.marker(latlng,
        title: '#' + bike.Bike + ' is ' + bike.Tag
        opacity: 0.5).addTo(map)
      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag);
      # Store this marker instance within the markers object.
      markers[bike._id] = marker
      console.log markers[bike._id] + ' added to map on ADDED event'
    changed: (bike, oldDocument) ->
      latlng = [
        bike.Lat
        bike.Lng
      ]
      markers[bike._id].setLatLng(latlng).update()
      console.log markers[bike._id] + ' changed on map on CHANGED event'
    removed: (oldBike) ->
      console.log oldBike
      # Remove the marker from the map
      map.removeLayer markers[oldBike._id]
      # Remove the reference to this marker instance
      delete markers[oldBike._id]
      console.log markers[oldBike._id] + ' removed from map on REMOVED event'

  bottomLng = -76.936569
  topLng = -76.950603
  leftLat = 38.994052
  rightLat = 38.981376
  polygon = L.polygon([
    [ rightLat, bottomLng ]
    [ rightLat, topLng ]
    [ leftLat, topLng ]
    [ leftLat, bottomLng ]
  ]).addTo(map)
  # // Zoom to user location
  # map.locate({ setView: true })
  map.setView new (L.LatLng)(38.987701, -76.940989), 13
  # Notes for using included MarkCluster Package
  # var markers = new L.MarkerClusterGroup();
  # markers.addLayer(new L.Marker([51.5, -0.09]));
  # map.addLayer(markers);

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