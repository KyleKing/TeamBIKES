@IconLogic = (Tag) ->
  if Tag == 'Available'
    BikeIcon = window.Available
  else if Tag == 'RepairInProgress'
    BikeIcon = window.Damaged
  else
    BikeIcon = window.Reserved
  BikeIcon

@MapInit = (MapName, LocateUser, DrawOutline, Center) ->
  # Just to call for the bike variables and not an entire init
  if MapName != false
    # Create the Leaflet Map
    L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
    window.map = new (L.Map)( MapName, center: Center )
    L.tileLayer.provider('OpenStreetMap.Mapnik').addTo window.map
    window.map.spin false

    # Give user control over location
    LocateControl = L.control.locate(
      drawCircle: true
      follow: true
      setView: true
      keepCurrentZoomLevel: false
      remainActive: false
      markerClass: L.circleMarker).addTo window.map

    # # Quickly load map (Doesn't seem to work reliably)
    # window.map.setView Center, 16

    # Automatically track user or center on UMD at arbitrary location
    if LocateUser
      # Start automatically
      LocateControl.start()
      window.map.on 'dragstart', LocateControl._stopFollowing, LocateControl
    else
      # Quickly load map
      window.map.setView Center, 16

    # Active area of bike map
    # Manually drawn from: http://www.latlong.net/
    if DrawOutline
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
      }).addTo(window.map)

  # Bike icons
  # Color choices: 'red', 'darkred', 'orange', 'green'
  # 'darkgreen', 'blue', 'purple', 'darkpuple', 'cadetblue'

  # Unselected, but available
  window.Available = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'cadetblue'
    iconColor: 'white')
  # Damaged (InRepair) bike
  window.Damaged = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'darkred'
    iconColor: 'white')
  # Reserved
  window.Reserved = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'orange'
    iconColor: 'white')
  # Selected
  window.Selected = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'green'
    iconColor: 'white')
  # Redistributed
  window.Redistributed = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'bicycle'
    markerColor: 'purple'
    iconColor: 'white')