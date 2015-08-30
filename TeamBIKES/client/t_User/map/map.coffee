Template.map.rendered = ->
  Meteor.subscribe("AvailableBikeLocationsPub")
  Meteor.subscribe("ReservedBike")

  # Call MapInit function from s_Helpers
  coords = [38.987701, -76.940989]
  MapInit
    MapName: 'BikeMap'
    LocateUser: true
    DrawOutline: true
    Center: coords
    ShowClosestBikes: true
    FullScreenButton: false

  # Reserve Bike Button, replaced by dblclick action
  # LeafletReserveButton = L.easyButton(states: [
  #   {
  #     stateName: 'Reserve'
  #     icon: 'fa-shopping-cart'
  #     onClick: (control) ->
  #       # Get selected bike, remove current icon, and update selected bike logic
  #       if Session.get 'selectedBike'
  #         Bike = Session.get 'selectedBike'
  #         [today, now] = CurrentDay()
  #         coords = DailyBikeData.findOne({Bike: Bike, Day: today}).Coordinates
  #         console.log coords
  #         window.map.panTo coords, 18
  #         Session.set "available": false
  #         if Meteor.userId()
  #           Meteor.call 'UserReserveBike', Meteor.userId(), Bike, (error, result) ->
  #             if error
  #               console.log error.reason
  #             else
  #               sAlert.success('Bike #' + Bike + ' successfully reserved!')
  #               if result == 1
  #                 sAlert.warning(result + ' previously reserved bike was re-listed as Available')
  #               else if result != 0
  #                 sAlert.warning(result + ' previously reserved bikes were re-listed as Available')
  #         else
  #           sAlert.warning('You must sign in to reserve a bike')
  #       else
  #         sAlert.error('Error: Choose a bike to reserve')
  #       return
  #     title: 'Reserve selected bike'
  #   }
  # ])
  # LeafletReserveButton.addTo window.map

  # Inspiration: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  MapMarkers = []
  Session.set
    "selectedBike": false
    "available": true

  [today, now] = CurrentDay()
  DailyBikeData.find({ Day: today, Tag: {$in: ['Available', Meteor.userId()] }}).observe
    added: (bike) ->
      latlng = bike.Coordinates
      BikeIcon = IconLogic(bike.Tag)
      MapMarkers[bike._id] = L.marker(latlng,
        title: bike.Bike
        opacity: 0.75
        # icon: BikeIcon).on("dblclick", (e) ->
        icon: BikeIcon).on("dblclick", (e) ->
          # Important Vars
          [today, now] = CurrentDay()
          SelectedBike = e.target.options.title
          Session.set
            'selectedBike': SelectedBike
            'available': false
          # Find bike info
          coords = DailyBikeData.findOne({Bike: SelectedBike, Day: today}).Coordinates
          window.map.panTo coords, 18
          # Reserve bike
          if Meteor.userId()
            Meteor.call 'UserReserveBike', Meteor.userId(), SelectedBike, (error, result) ->
              # Inform user of results
              if error
                console.log error.reason
              else
                sAlert.success('Bike #' + SelectedBike + ' successfully reserved!')
                if result == 1
                  sAlert.warning('1 previously reserved bike was re-listed as Available')
                else if result != 0
                  sAlert.warning(result + ' previously reserved bikes were re-listed as Available')
          else
            sAlert.warning('You must sign in to reserve a bike')
          ).addTo(window.map)

    changed: (bike, oldBike) ->
      if oldBike.Tag == bike.Tag
        latlng = bike.Coordinates
        MapMarkers[bike._id].setLatLng(latlng).update()
        console.log MapMarkers[bike._id]._leaflet_id + ' changed on window.map on CHANGED event'
      else if bike.Tag == Meteor.userId()
        MapMarkers[bike._id].setIcon window.Reserved
        console.log 'Changed to green icon color for # ' + bike.Bike
      else if bike.Tag == "Available"
        MapMarkers[bike._id].setIcon window.Available
        console.log 'Changed to gray icon color for # ' + bike.Bike
      else
        console.log "changed, but not with this logic"

    removed: (oldBike) ->
      if oldBike.Tag != Meteor.userId() && Session.get 'available'
        # If removed bike is currently selected bike...
        if Session.get("selectedBike") == oldBike.Bike
          # Updated reserve bike text
          Session.set "available": false
          # And alert user
          sAlert.error('Bike reserved by different user. Select new bike')
      # Remove the marker from the map
      console.log MapMarkers[oldBike._id]._leaflet_id + ' removed from window.map on REMOVED event and...'
      window.map.removeLayer MapMarkers[oldBike._id]
      # Remove the reference to this marker instance
      delete MapMarkers[oldBike._id]


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


# DrawClosestBikes = () ->
Tracker.autorun ->
  console.log 'Autorun is auto-running!'
  # Remove old polylines
  if !isUndefined(window.LineToNearestBike) && !isUndefined(window.LineToNearestBike[0])
    console.log 'removing old polylines'
    Num = 0
    while Num < window.LineToNearestBike.length
      # console.log window.LineToNearestBike[Num]._leaflet_id + ' removed from window.map on REMOVED event and...'
      window.map.removeLayer window.LineToNearestBike[Num]
      # # Remove the reference to this marker instance
      delete window.LineToNearestBike[Num]
      Num++

  console.log "UserLocation = " + Session.get "UserLocation"
  console.log "ShowClosestBikes = " + Session.get "ShowClosestBikes"
  # If true, then plot lines to nearest bikes
  if Session.get "ShowClosestBikes"
    # COnsider case of user without a GPS location
    if isUndefined Session.get "UserLocation"
      sAlert.warning('Your GPS location could not be found, using map center instead')
      center = window.map.getCenter()
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
    if closest.length == 0
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
          opacity: 1/(Num+1)
        }).addTo(window.map)
        Num++
      return

Template.map.events
  'click #ClosestBikes': (e) ->
    # Toggle reactive data source
    if Session.get "ShowClosestBikes"
      Session.set "ShowClosestBikes": false
    else
      Session.set "ShowClosestBikes": true


    # then change view to only show revered bike and timer