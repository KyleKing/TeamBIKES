Template.map.rendered = ->
  @subscribe("AvailableBikeLocationsPub")
  @subscribe("ReservedBike")

  # Call MapInit function from s_Helpers
  coords = [38.987701, -76.940989]
  MapInit
    MapName: 'BikeMap'
    LocateUser: false
    DrawOutline: true
    Center: coords
    ShowClosestBikes: true
    FullScreenButton: true
    PopupGuide: 'Click any bike icon to reserve a bike for 5 minutes'
    ShowBikeRacksMarkerToggle: false

  # Inspiration: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  MapMarkers = []
  Session.set
    "selectedBike": false
    "available": true

  [today, now] = CurrentDay()
  window.MapObserveHandle = DailyBikeData.find({ Day: today, Tag: {$in: ['Available', Meteor.userId()] }}).observe
    added: (bike) ->
      latlng = bike.Coordinates
      BikeIcon = IconLogic(bike.Tag)
      MapMarkers[bike._id] = L.marker(latlng,
        title: bike.Bike
        opacity: 0.75
        icon: BikeIcon).on("click", (e) ->
          # Important Vars
          [today, now] = CurrentDay()
          SelectedBike = e.target.options.title
          Session.set
            'selectedBike': SelectedBike
            'available': false
          # Find bike info
          coords = DailyBikeData.findOne({Bike: SelectedBike, Day: today}).Coordinates
          window.BikeMap.panTo coords, 18
          # Reserve bike
          if Meteor.userId()
            Meteor.call 'UserReserveBike', Meteor.userId(), SelectedBike, (error, result) ->
              # Inform user of results
              if error
                console.log error.reason
              else
                sAlert.success('Bike #' + SelectedBike + ' successfully reserved for the next FIVE minutes!')
                if result is 1
                  sAlert.warning('1 previously reserved bike was re-listed as Available')
                else if result isnt 0
                  sAlert.warning(result + ' previously reserved bikes were re-listed as Available')
          else
            sAlert.warning('You must sign in to reserve a bike')
          ).addTo(window.BikeMap)

    changed: (bike, oldBike) ->
      if oldBike.Tag is bike.Tag
        latlng = bike.Coordinates
        MapMarkers[bike._id].setLatLng(latlng).update()
        console.log MapMarkers[bike._id]._leaflet_id + ' changed on window.BikeMap on CHANGED event'
      else if bike.Tag is Meteor.userId()
        MapMarkers[bike._id].setIcon window.Reserved
        console.log 'Changed to green icon color for # ' + bike.Bike
      else if bike.Tag is "Available"
        MapMarkers[bike._id].setIcon window.Available
        console.log 'Changed to gray icon color for # ' + bike.Bike
      else
        console.log "changed, but not with this logic"

    removed: (oldBike) ->
      if oldBike.Tag isnt Meteor.userId() and Session.get 'available'
        # If removed bike is currently selected bike...
        if Session.get("selectedBike") is oldBike.Bike
          # Updated reserve bike text
          Session.set "available": false
          # And alert user
          sAlert.error('Bike reserved by different user. Select new bike')
      # Remove the marker from the map
      console.log MapMarkers[oldBike._id]._leaflet_id + ' removed from window.BikeMap on REMOVED event'
      window.BikeMap.removeLayer MapMarkers[oldBike._id]
      # Remove the reference to this marker instance
      delete MapMarkers[oldBike._id]

# WIP:
################################################

# Run autorun function on only map template
Template.map.created = ->
  Session.set 'MapTemplate', true

Template.map.destroyed = ->
  # Call this function to properly remove any functions called in Map Init Function
  MapInitDestroyedFunction()
  Session.set 'MapTemplate', false
  window.MapObserveHandle.stop() # also stop observing DailyBikeData

# DrawClosestBikes = () ->
Tracker.autorun ->
  # Run on only map template
  if Session.equals 'MapTemplate', true
    # console.log 'Autorun is auto-running!'
    # Remove old polylines
    unless isUndefined(window.LineToNearestBike) or isUndefined(window.LineToNearestBike[0])
      console.log 'removing old polylines'
      Num = 0
      while Num < window.LineToNearestBike.length
        # console.log window.LineToNearestBike[Num]._leaflet_id + ' removed from window.BikeMap on REMOVED event and...'
        window.BikeMap.removeLayer window.LineToNearestBike[Num]
        # # Remove the reference to this marker instance
        delete window.LineToNearestBike[Num]
        Num++

    console.log "UserLocation = " + Session.get "UserLocation"
    console.log "ShowClosestBikes = " + Session.get "ShowClosestBikes"
    # If true, then plot lines to nearest bikes
    if Session.get "ShowClosestBikes"
      # Consider case of user without a GPS location
      if isUndefined Session.get "UserLocation"
        sAlert.warning('Your GPS location could not be found, using map center instead')
        center = window.BikeMap.getCenter()
      else
        center = Session.get "UserLocation"

      # Use MongoDB to find nearest bikes
      [today, now] = CurrentDay()
      closest = DailyBikeData.find(
        Day: today
        Tag: {$in: ['Available', Meteor.userId()]}
        Coordinates:
          $near: center
        ).fetch()

      # Check error case and draw
      if closest.length is 0
        console.log 'No close bikes found'
      else
        # Init Vars
        console.log closest
        window.LineToNearestBike = []
        Num = 0
        while Num < 4
          window.LineToNearestBike[Num] = L.polyline([
            center
            closest[Num].Coordinates
          ], {
            color: 'blue'
            opacity: 1 / (Num + 1)
          }).addTo(window.BikeMap)
          Num++
        return

Template.map.events
  'click #ClosestBikes': (e) ->
    # Toggle reactive data source
    if Session.get "ShowClosestBikes"
      Session.set "ShowClosestBikes": false
    else
      Session.set "ShowClosestBikes": true

# # then change view to only show revered bike and timer. Possibly only show bike rack locations as well??
