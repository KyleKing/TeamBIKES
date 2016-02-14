@IconLogic = (Tag) ->
  # Determine color of bike marker based on bike tag
  if Tag == 'Available'
    BikeIcon = window.Available
  else if Tag == 'RepairInProgress'
    BikeIcon = window.Damaged
  else if Tag == 'BikeRack'
    BikeIcon = window.BikeRack
  else
    BikeIcon = window.Reserved
  BikeIcon

@MapInit = (mapInitSettings) ->
  # Just to call for the bike variables and not an entire init
  if mapInitSettings.MapName != false
    # Create the Leaflet Map
    L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
    window[mapInitSettings.MapName] = new (L.Map)( mapInitSettings.MapName, {
      center: mapInitSettings.Center
      fullscreenControl: mapInitSettings.FullScreenButton
      fullscreenControlOptions: {
        position: 'topleft'
      }
    })
    L.tileLayer.provider('OpenStreetMap.Mapnik').addTo window[mapInitSettings.MapName]
    window[mapInitSettings.MapName].spin false

    # Give user control over location
    window.LocateControl = L.control.locate(
      drawCircle: true
      follow: true
      setView: true
      keepCurrentZoomLevel: false
      remainActive: false
      markerClass: L.circleMarker).addTo window[mapInitSettings.MapName]

    # # Quickly load map (Doesn't seem to work reliably)
    # window[mapInitSettings.MapName].setView mapInitSettings.Center, 16

    # Automatically track user or center on UMD at arbitrary location
    if mapInitSettings.LocateUser
      # Start automatically
      window.LocateControl.start()
      window[mapInitSettings.MapName].on 'locationfound', (self) ->
        if mapInitSettings.PopupGuide
          console.log self
          # Create popup with user guide
          popup = L.popup()
          popup.setLatLng [self.latitude, self.longitude]
          popup.setContent mapInitSettings.PopupGuide
          popup.openOn window[mapInitSettings.MapName]
        Session.set "UserLocation": {lat: self.latitude, lng: self.longitude}
      window[mapInitSettings.MapName].on 'dragstart', window.LocateControl._stopFollowing, window.LocateControl
    else
      # Quickly load map
      window[mapInitSettings.MapName].setView mapInitSettings.Center, 16

    # Add toggle button if requested
    if mapInitSettings.ShowClosestBikes
      # Create toggle button to show lines to nearest bikes
      window.ShowClosestBikesToggle = L.easyButton(states: [
        {
          stateName: 'adding-markers'
          icon: 'fa-compass'
          onClick: (control) ->
            Session.set "ShowClosestBikes": true
            console.log 'set ShowClosestBikes true'
            control.state 'removing-markers'
            return
          title: 'Show nearest bikes'
        }
        {
          stateName: 'removing-markers'
          icon: 'fa-undo'
          onClick: (control) ->
            Session.set "ShowClosestBikes": false
            console.log 'set ShowClosestBikes false'
            control.state 'adding-markers'
            return
          title: 'Undo'
        }
      ])
      window.ShowClosestBikesToggle.addTo window[mapInitSettings.MapName]
      if Session.get 'ShowClosestBikes'
        window.ShowClosestBikesToggle.state 'removing-markers'

  # # Create toggle button for displaying bike rack locations
  # # Below button does the toggling anyway
  # ShowBikeRacksToggle = L.easyButton(states: [
  #   {
  #     stateName: 'show'
  #     icon: 'fa-archive'
  #     onClick: (control) ->
  #       Session.set 'OptionalBikeRacks', true
  #       console.log 'set OptionalBikeRacks true'
  #       control.state 'hide'
  #     title: 'Show Bike Rack Locations'
  #   }
  #   {
  #     stateName: 'hide'
  #     icon: 'fa-history'
  #     onClick: (control) ->
  #       Session.set 'OptionalBikeRacks', false
  #       console.log 'set OptionalBikeRacks false'
  #       control.state 'show'
  #     title: 'Hide Bike Rack Locations'
  #   }
  # ])
  # ShowBikeRacksToggle.addTo window[mapInitSettings.MapName]

  # Create toggle button for markers - more of a dev feature
  if mapInitSettings.ShowBikeRacksMarkerToggle
    # Create toggle button for displaying bike rack locations
    window.ShowBikeRacksMarkerToggle = L.easyButton(states: [
      {
        stateName: 'show-markers'
        # icon: 'fa-map-marker'
        icon: 'fa-archive'
        onClick: (control) ->
          Session.set 'OptionalBikeRacksMarkers', true
          # Toggle Bike Racks to update subscription
          Session.set 'OptionalBikeRacks', 7
          console.log 'set OptionalBikeRacksMarkers to 7'
          control.state 'hide-markers'
        title: 'Show Bike Rack Markers'
      }
      {
        stateName: 'hide-markers'
        icon: 'fa-history'
        onClick: (control) ->
          Session.set 'OptionalBikeRacksMarkers', false
          # Toggle Bike Racks to update subscription
          Session.set 'OptionalBikeRacks', 0
          console.log 'set OptionalBikeRacksMarkers false'
          control.state 'show-markers'
        title: 'Hide Bike Rack Markers'
      }
    ])
    window.ShowBikeRacksMarkerToggle.addTo window[mapInitSettings.MapName]
    if Session.get 'OptionalBikeRacksMarkers'
      window.ShowBikeRacksMarkerToggle.state('hide-markers')

  # Determine to show markers or not as standard
  if isUndefined mapInitSettings.ShowBikeRacksMarkerToggle
    Session.set 'OptionalBikeRacksMarkers', true
  # Set to the inverse (i.e. for user ('Bike Map') who wants to see bike racks vs. admin who only wants outlines)
  else if mapInitSettings.MapName is 'BikeMap'
    Session.set 'OptionalBikeRacksMarkers', mapInitSettings.ShowBikeRacksMarkerToggle
  else
    Session.set 'OptionalBikeRacksMarkers', !mapInitSettings.ShowBikeRacksMarkerToggle

  # Plot Bike Racks
  # Allow for user to toggle bike racks on and off
  if isUndefined Session.get 'OptionalBikeRacks'
    Session.set('OptionalBikeRacks', 0)

  # Tracker.autorun ->
  #   if Session.equals 'OptionalBikeRacks', 7
  #     console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
  #     Meteor.subscribe 'RackNamesGet', Session.get 'OptionalBikeRacks'
  #     # # Wait to unsubscribe
  #     # if RackNames.find().count() is 0
  #     #   Session.set 'OptionalBikeRacks', true
  #     # # Toggle Bike Racks to update subscription
  #   if Session.equals 'OptionalBikeRacks', false
  #     console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
  #     Meteor.subscribe 'RackNamesGet', 7
  Meteor.subscribe 'RackNamesGet', 7
  console.log "Session.get 'OptionalBikeRacks' is " + Session.get('OptionalBikeRacks')


  # Subscribe to rest of data
  Meteor.subscribe 'OuterLimitGet'
  # Init Vars
  rackPositionMarkers = []
  rackOutlinePolygons = []
  # Watch bike racks for change in availability (not built yet)
  Tracker.autorun ->
    RackNames.find().observe
      added: (eachRackData) ->
        BikeIcon = IconLogic('BikeRack')
        rackPositionMarkers[eachRackData._id] = L.marker(eachRackData.Coordinates, {
          icon: BikeIcon
          })
        # if Session.get 'OptionalBikeRacksMarkers'
        if Session.equals 'OptionalBikeRacks', 7
          console.log Session.get 'OptionalBikeRacks'
          rackPositionMarkers[eachRackData._id].addTo window[mapInitSettings.MapName]

        # Force re-run
        if Session.equals 'OptionalBikeRacks', 0
          console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
        # if Session.equals 'OptionalBikeRacks', 7
        #   console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
        rackOutlinePolygons[eachRackData._id] = L.polygon(eachRackData.Details, {
          fill: true
          color: 'purple'
          smoothFactor: 0
          weight: 2
        }).addTo window[mapInitSettings.MapName]
        # _.each eachRackData.Details, (coord) ->
        #   L.marker(coord, {icon: BikeIcon}).addTo window[mapInitSettings.MapName]
      removed: (eachRackData) ->
        # Remove the marker from the map
        console.log rackPositionMarkers[eachRackData._id]._leaflet_id + ' removed on REMOVED event'
        window[mapInitSettings.MapName].removeLayer rackPositionMarkers[eachRackData._id]
        window[mapInitSettings.MapName].removeLayer rackOutlinePolygons[eachRackData._id]
        # Remove the reference to this marker instance
        delete rackPositionMarkers[eachRackData._id]
        delete rackOutlinePolygons[eachRackData._id]

    # Active area of bike map
    if mapInitSettings.DrawOutline
      campusOutlinePolygons = []
      window.MapObserveOuterLineHandle = OuterLimit.find().observe
        added: (outerline) ->
          campusOutlinePolygons[outerline._id] = L.polygon(outerline.Details, {
            fill: false
            color: 'purple'
            smoothFactor: 5
            weight: 7
          }).addTo(window[mapInitSettings.MapName])
        removed: (oldOuterline) ->
          # Remove the marker from the map
          console.log campusOutlinePolygons[oldOuterline._id]._leaflet_id +
            ' removed on REMOVED event'
          window[mapInitSettings.MapName].removeLayer campusOutlinePolygons[oldOuterline._id]
          # Remove the reference to this marker instance
          delete campusOutlinePolygons[oldOuterline._id]
        # Manually drawn from: http://www.latlong.net/
        # polygon = L.polygon([
        #   [ 39.000276, -76.943264 ]
        #   [ 38.998642, -76.946397 ]
        #   [ 38.992438, -76.951632 ]
        #   [ 38.986300, -76.956096 ]
        #   [ 38.985433, -76.955495 ]
        #   [ 38.984733, -76.952019 ]
        #   [ 38.983765, -76.952190 ]
        #   [ 38.983532, -76.948543 ]
        #   [ 38.981330, -76.946354 ]
        #   [ 38.977527, -76.937985 ]
        #   [ 38.983065, -76.937771 ]
        #   [ 38.983131, -76.934423 ]
        #   [ 38.983832, -76.933479 ]
        #   [ 38.984833, -76.934423 ]
        #   [ 38.984799, -76.937299 ]
        #   [ 38.992671, -76.933093 ]
        #   [ 38.993105, -76.935153 ]
        #   [ 38.996074, -76.935325 ]
        #   [ 38.996174, -76.937728 ]
        #   [ 39.000243, -76.942277 ]
        #   [ 39.001777, -76.940989 ]
        #   [ 39.003244, -76.940818 ]
        #   [ 39.003711, -76.942706 ]
        #   [ 39.001210, -76.943436 ]
        # ], {
        #   fill: false
        #   color: 'blue'
        #   smoothFactor: 7
        #   weight: 10
        # }).addTo(window[mapInitSettings.MapName])

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
  # BikeRack
  window.BikeRack = L.AwesomeMarkers.icon(
    prefix: 'fa'
    icon: 'archive'
    markerColor: 'purple'
    iconColor: 'white')

@MapInitDestroyedFunction = ->
  window.MapObserveOuterLineHandle.stop()
  # Then clear  window[mapInitSettings.MapName] variable before loading a new map
  # console.log 'Deleting ' + window[mapInitSettings.MapName]
  # delete window[mapInitSettings.MapName]
  console.log 'Stopping LocateControl'
  # delete LocateControl
  window.LocateControl.stop()
