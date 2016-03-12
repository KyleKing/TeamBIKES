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

  # Create Map
  ################################################

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
      # Create popup with user guide
      popup = L.popup()
      popup.setLatLng mapInitSettings.Center
      popup.setContent mapInitSettings.PopupGuide
      popup.openOn window[mapInitSettings.MapName]

    # TODO - mostly done
    # Only for the user-map, see the bulk of the code there
    ################################################

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
          title: 'Show nearest bikes'
        }
        {
          stateName: 'removing-markers'
          icon: 'fa-undo'
          onClick: (control) ->
            Session.set "ShowClosestBikes": false
            console.log 'set ShowClosestBikes false'
            control.state 'adding-markers'
          title: 'Undo'
        }
      ])
      window.ShowClosestBikesToggle.addTo window[mapInitSettings.MapName]
      if Session.get 'ShowClosestBikes'
        window.ShowClosestBikesToggle.state 'removing-markers'


  # Bike Rack Locations - toggle icon or polyline
  ################################################

  # Removed in favor of a simpler system to display the bike racks as polygons

  # # Create toggle button for markers - more of a dev feature
  # if mapInitSettings.ShowBikeRacksMarkerToggle
  #   # Create toggle button for displaying bike rack locations
  #   window.ShowBikeRacksMarkerToggle = L.easyButton(states: [
  #     {
  #       stateName: 'show-markers'
  #       # icon: 'fa-map-marker'
  #       icon: 'fa-archive'
  #       onClick: (control) ->
  #         Session.set 'OptionalBikeRacksMarkers', true
  #         # Toggle Bike Racks to update subscription
  #         # Make sure to initially set to = 0
  #         Session.set 'OptionalBikeRacks', 7
  #         console.log 'set OptionalBikeRacksMarkers to 7'
  #         control.state 'hide-markers'
  #       title: 'Show Bike Rack Markers'
  #     }
  #     {
  #       stateName: 'hide-markers'
  #       icon: 'fa-history'
  #       onClick: (control) ->
  #         Session.set 'OptionalBikeRacksMarkers', false
  #         console.log 'set OptionalBikeRacksMarkers false'
  #         # Toggle Bike Racks to update subscription
  #         Session.set 'OptionalBikeRacks', 0
  #         control.state 'show-markers'
  #       title: 'Hide Bike Rack Markers'
  #     }
  #   ])
  #   window.ShowBikeRacksMarkerToggle.addTo window[mapInitSettings.MapName]
  #   if Session.get 'OptionalBikeRacksMarkers'
  #     window.ShowBikeRacksMarkerToggle.state('hide-markers')

  # # Allow for user to toggle bike racks on and off
  # # if isUndefined(mapInitSettings.OptionalBikeRacksMarkers) is false
  # #   Session.set('OptionalBikeRacks', mapInitSettings.OptionalBikeRacksMarkers)
  # if isUndefined Session.get 'OptionalBikeRacks'
  #   Session.set('OptionalBikeRacks', 0)
  #   Meteor.subscribe('RackNamesGet', 7)

  # Tracker.autorun ->
  #   if Session.equals 'OptionalBikeRacks', 7
  #     console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
  #     Meteor.subscribe 'RackNamesGet', Session.get 'OptionalBikeRacks'
  #   if Session.equals 'OptionalBikeRacks', 0
  #     console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
  #     Meteor.subscribe 'RackNamesGet', false
  # # console.log "Session.get 'OptionalBikeRacks' is " + Session.get('OptionalBikeRacks')

  # # More complex if/else below, but this is easier:
  # Session.set 'OptionalBikeRacksMarkers', mapInitSettings.ShowBikeRacksMarkerToggle
  # # # Bike rack markers decision flags
  # # if isUndefined mapInitSettings.ShowBikeRacksMarkerToggle
  # #   Session.set 'OptionalBikeRacksMarkers', true
  # # # Set to the inverse (i.e. for user ('Bike Map') who wants to see bike racks vs. admin who only wants outlines)
  # # else if mapInitSettings.MapName is 'BikeMap'
  # #   Session.set 'OptionalBikeRacksMarkers', mapInitSettings.ShowBikeRacksMarkerToggle
  # # else
  # #   Session.set 'OptionalBikeRacksMarkers', !mapInitSettings.ShowBikeRacksMarkerToggle

  # rackPositionMarkers = []
  # Tracker.autorun ->
  #   # Watch bike racks for change in availability (not built yet)
  #   RackNames.find().observe
  #     added: (eachRackData) ->
  #       if Session.equals 'OptionalBikeRacks', 7
  #         BikeIcon = IconLogic('BikeRack')
  #         rackPositionMarkers[eachRackData._id] = L.marker(eachRackData.Coordinates, {
  #           icon: BikeIcon
  #         })
  #         console.log Session.get 'OptionalBikeRacks'
  #         rackPositionMarkers[eachRackData._id].addTo window[mapInitSettings.MapName]

  #       # Force re-run
  #       if Session.equals 'OptionalBikeRacks', 0
  #         console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
  #       # if Session.equals 'OptionalBikeRacks', 7
  #       #   console.log "Session.get 'OptionalBikeRacks' = " + Session.get 'OptionalBikeRacks'
  #       rackOutlinePolygons[eachRackData._id] = L.polygon(eachRackData.Details, {
  #         fill: true
  #         color: 'purple'
  #         smoothFactor: 0
  #         weight: 2
  #       }).addTo window[mapInitSettings.MapName]
  #       # _.each eachRackData.Details, (coord) ->
  #       #   L.marker(coord, {icon: BikeIcon}).addTo window[mapInitSettings.MapName]
  #     removed: (eachRackData) ->
  #       # Remove the marker from the map
  #       console.log rackPositionMarkers[eachRackData._id]._leaflet_id + ' removed on REMOVED event'
  #       window[mapInitSettings.MapName].removeLayer rackPositionMarkers[eachRackData._id]
  #       window[mapInitSettings.MapName].removeLayer rackOutlinePolygons[eachRackData._id]
  #       # Remove the reference to this marker instance
  #       delete rackPositionMarkers[eachRackData._id]
  #       delete rackOutlinePolygons[eachRackData._id]

  Meteor.subscribe('RackNamesGet', 7)
  rackPositionMarkers = []
  RackNames.find().observe
    added: (eachRackData) ->
      rackOutlinePolygons[eachRackData._id] = L.polygon(eachRackData.Details, {
        fill: true
        color: 'purple'
        smoothFactor: 0
        weight: 2
      }).addTo window[mapInitSettings.MapName]
    removed: (eachRackData) ->
      # Remove the marker from the map
      console.log rackPositionMarkers[eachRackData._id]._leaflet_id + ' removed on REMOVED event'
      window[mapInitSettings.MapName].removeLayer rackOutlinePolygons[eachRackData._id]
      delete rackOutlinePolygons[eachRackData._id]


  # Create polyline of edge of supported range
  ################################################

  Meteor.subscribe 'OuterLimitGet'
  rackOutlinePolygons = []
  Tracker.autorun ->
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

  # Bike icons
  ################################################
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
