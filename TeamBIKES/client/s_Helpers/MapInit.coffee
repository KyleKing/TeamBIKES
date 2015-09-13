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

@MapInit = (MapInitSettings) ->
  # Just to call for the bike variables and not an entire init
  if MapInitSettings.MapName != false
    # Create the Leaflet Map
    L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
    window[MapInitSettings.MapName] = new (L.Map)( MapInitSettings.MapName, {
      center: MapInitSettings.Center
      fullscreenControl: MapInitSettings.FullScreenButton
      fullscreenControlOptions: {
        position: 'topleft'
      }
    })
    L.tileLayer.provider('OpenStreetMap.Mapnik').addTo window[MapInitSettings.MapName]
    window[MapInitSettings.MapName].spin false

    # Give user control over location
    window.LocateControl = L.control.locate(
      drawCircle: true
      follow: true
      setView: true
      keepCurrentZoomLevel: false
      remainActive: false
      markerClass: L.circleMarker).addTo window[MapInitSettings.MapName]

    # # Quickly load map (Doesn't seem to work reliably)
    # window[MapInitSettings.MapName].setView MapInitSettings.Center, 16

    # Automatically track user or center on UMD at arbitrary location
    if MapInitSettings.LocateUser
      # Start automatically
      window.LocateControl.start()
      window[MapInitSettings.MapName].on 'locationfound', (self) ->
        if MapInitSettings.PopupGuide
          console.log self
          # Create popup with user guide
          popup = L.popup()
          popup.setLatLng [self.latitude, self.longitude]
          popup.setContent MapInitSettings.PopupGuide
          popup.openOn window[MapInitSettings.MapName]
        Session.set "UserLocation": {lat: self.latitude, lng: self.longitude}
      window[MapInitSettings.MapName].on 'dragstart', window.LocateControl._stopFollowing, window.LocateControl
    else
      # Quickly load map
      window[MapInitSettings.MapName].setView MapInitSettings.Center, 16

    # Add toggle button if requested
    if MapInitSettings.ShowClosestBikes
      # Create toggle button to show lines to nearest bikes
      ShowClosestBikesToggle = L.easyButton(states: [
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
      ShowClosestBikesToggle.addTo window[MapInitSettings.MapName]

  # Create toggle button for displaying bike rack locations
  # Below button does the toggling anyway
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
  # ShowBikeRacksToggle.addTo window[MapInitSettings.MapName]

  # Create toggle button for markers - more of a dev feature
  if MapInitSettings.ShowBikeRacksMarkerToggle
    # Create toggle button for displaying bike rack locations
    ShowBikeRacksMarkerToggle = L.easyButton(states: [
      {
        stateName: 'show-markers'
        icon: 'fa-map-marker'
        onClick: (control) ->
          Session.set 'OptionalBikeRacksMarkers', true
          # Toggle Bike Racks to update subscription
          Session.set 'OptionalBikeRacks', 7
          console.log 'set OptionalBikeRacksMarkers true'
          control.state 'hide-markers'
        title: 'Show Bike Rack Markers'
      }
      {
        stateName: 'hide-markers'
        icon: 'fa-history'
        onClick: (control) ->
          Session.set 'OptionalBikeRacksMarkers', false
          # Toggle Bike Racks to update subscription
          Session.set 'OptionalBikeRacks', 7
          console.log 'set OptionalBikeRacksMarkers false'
          control.state 'show-markers'
        title: 'Hide Bike Rack Markers'
      }
    ])
    ShowBikeRacksMarkerToggle.addTo window[MapInitSettings.MapName]
  if isUndefined MapInitSettings.ShowBikeRacksMarkerToggle
    Session.set 'OptionalBikeRacksMarkers', true
  else
    Session.set 'OptionalBikeRacksMarkers', MapInitSettings.ShowBikeRacksMarkerToggle

  # Plot Bike Racks
  # Allow for user to toggle bike racks on and off
  if isUndefined Session.get 'OptionalBikeRacks'
    Session.set 'OptionalBikeRacks', false
  # Session.set 'OptionalBikeRacks', false
  Tracker.autorun ->
    if Session.equals 'OptionalBikeRacks', 7
      # Wait to unsubscribe
      if RackNames.find().count() is 0
        Session.set 'OptionalBikeRacks', true
    # Toggle Bike Racks to update subscription
    Meteor.subscribe 'RackNamesGet', Session.get 'OptionalBikeRacks'
  # Subscribe to rest of data
  Meteor.subscribe 'OuterLimitGet'
  Meteor.call 'QueryRackNames'
  # Init Vars
  RackPositionMarkers = []
  RackOutlinePolygons = []
  # Watch bike racks for change in availability (not built yet)
  RackNames.find().observe
    added: (EachRackData) ->
      BikeIcon = IconLogic('BikeRack')
      RackPositionMarkers[EachRackData._id] = L.marker(EachRackData.Coordinates, {
        icon: BikeIcon
        })
      if Session.get 'OptionalBikeRacksMarkers'
        RackPositionMarkers[EachRackData._id].addTo window[MapInitSettings.MapName]
      RackOutlinePolygons[EachRackData._id] = L.polygon(EachRackData.Details, {
        fill: true
        color: 'purple'
        smoothFactor: 0
        weight: 2
      }).addTo window[MapInitSettings.MapName]
      # _.each EachRackData.Details, (coord) ->
      #   L.marker(coord, {icon: BikeIcon}).addTo window[MapInitSettings.MapName]
    removed: (EachRackData) ->
      # Remove the marker from the map
      console.log RackPositionMarkers[EachRackData._id]._leaflet_id + ' removed on REMOVED event'
      window[MapInitSettings.MapName].removeLayer RackPositionMarkers[EachRackData._id]
      window[MapInitSettings.MapName].removeLayer RackOutlinePolygons[EachRackData._id]
      # Remove the reference to this marker instance
      delete RackPositionMarkers[EachRackData._id]
      delete RackOutlinePolygons[EachRackData._id]

    # Active area of bike map
    if MapInitSettings.DrawOutline
      CampusOutlinePolygons = []
      window.MapObserveOuterLineHandle = OuterLimit.find().observe
        added: (outerline) ->
          CampusOutlinePolygons[outerline._id] = L.polygon(outerline.Details, {
            fill: false
            color: 'purple'
            smoothFactor: 5
            weight: 7
          }).addTo(window[MapInitSettings.MapName])
        removed: (OldOuterline) ->
          # Remove the marker from the map
          console.log CampusOutlinePolygons[OldOuterline._id]._leaflet_id + ' removed on REMOVED event'
          window[MapInitSettings.MapName].removeLayer CampusOutlinePolygons[OldOuterline._id]
          # Remove the reference to this marker instance
          delete CampusOutlinePolygons[OldOuterline._id]
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
      # }).addTo(window[MapInitSettings.MapName])

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
  # Then clear  window[MapInitSettings.MapName] variable before loading a new map
  # console.log 'Deleting ' + window[MapInitSettings.MapName]
  # delete window[MapInitSettings.MapName]
  console.log 'Stopping LocateControl'
  # delete LocateControl
  window.LocateControl.stop()
