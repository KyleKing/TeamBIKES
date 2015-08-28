Template.map.rendered = ->
  Meteor.subscribe("AvailableBikeLocationsPub")
  Meteor.subscribe("ReservedBike")

  # Call MapInit function from s_Helpers
  coords = [38.987701, -76.940989]
  # MapInit(MapName, LocateUser, DrawOutline, Center)
  # MapInit('BikeMap', false, true, coords)
  MapInit('BikeMap', true, true, coords)

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
        icon: BikeIcon).on("click", (e) ->
          # Remove previously selected bike
          if Session.get('selectedBike')
            last = Session.get 'selectedBike'
            lastBike = DailyBikeData.findOne({Bike: last, Day: today})
            MapMarkers[lastBike._id].setIcon IconLogic(lastBike.Tag)
            # console.log lastBike._id
            # console.log MapMarkers[lastBike._id]._icon.title

          # Highlight new bike
          @setIcon window.Selected
          Session.set
            "selectedBike": e.target.options.title
            "available": true
          # console.log e.target.options.title
          ).addTo(window.map)

      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag)

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
          Session.set
            "available": false
          # And alert user
          sAlert.error('Bike reserved by different user. Select new bike')
      # Remove the marker from the map
      window.map.removeLayer MapMarkers[oldBike._id]
      console.log MapMarkers[oldBike._id]._leaflet_id + ' removed from window.map on REMOVED event and...'
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

Template.map.events
  'click #ReserveBtn': (e) ->
    # Get selected bike, remove current icon, and update selected bike logic
    if Session.get 'selectedBike'
      Bike = Session.get 'selectedBike'
      [today, now] = CurrentDay()
      coords = DailyBikeData.findOne({Bike: Bike, Day: today}).Coordinates
      console.log coords
      window.map.panTo coords, 18
      Session.set "available": false
      if Meteor.userId()
        Meteor.call 'UserReserveBike', Meteor.userId(), Bike, (error, result) ->
          if error
            console.log error.reason
          else
            sAlert.success('Bike #' + Bike + ' successfully reserved!')
            if result == 1
              sAlert.warning(result + ' previously reserved bike was re-listed as Available')
            else if result != 0
              sAlert.warning(result + ' previously reserved bikes were re-listed as Available')
      else
        sAlert.warning('You must sign in to reserve a bike')
    else
      sAlert.error('Error: Choose a bike to reserve')

  'click #ClosestBikes': (e) ->
    console.log Session.get "UserLocation"
    if isUndefined Session.get "UserLocation"
      console.log 'Undefined...'
    else
      center = Session.get "UserLocation"
      console.log center

      [today, now] = CurrentDay()
      closest = DailyBikeData.find(
        Day: today
        Tag: {$in: ['Available', Meteor.userId()]}
        Coordinates:
          $near: center
        ).fetch()

      console.log closest

      polygon = L.polyline([
        center
        closest[0].Coordinates
      ], {
        color: 'blue'
        opacity: 1
        title: 'Closest'
      }).addTo(window.map)

      polygon = L.polyline([
        center
        closest[1].Coordinates
      ], {
        color: 'blue'
        opacity: 0.4
        title: 'Closest'
      }).addTo(window.map)

      polygon = L.polyline([
        center
        closest[2].Coordinates
      ], {
        color: 'blue'
        opacity: 0.2
        title: 'Closest'
      }).addTo(window.map)
      Session.set "AlooPolylineComplete": true

    # Session.set "AlooPolylineComplete": false
    # onLocationFound = (pos) ->
    #   console.log 'Location FOUND!'
    #   if !Session.get "AlooPolylineComplete"
    #     radius = pos.accuracy / 2
    #     # console.log pos
    #     # console.log pos.latlng
    #     # L.marker(pos.latlng).addTo(map).bindPopup('You are within ' + radius + ' meters from this point').openPopup()
    #     # L.circle(pos.latlng, radius).addTo map
    #     center = pos.latlng
    #     console.log center

    #     [today, now] = CurrentDay()
    #     closest = DailyBikeData.find(
    #       Day: today
    #       Tag: {$in: ['Available', Meteor.userId()]}
    #       Coordinates:
    #         $near: center
    #       ).fetch()

    #     console.log closest

    #     polygon = L.polyline([
    #       center
    #       closest[0].Coordinates
    #     ], {
    #       color: 'blue'
    #       opacity: 1
    #       title: 'Closest'
    #     }).addTo(window.map)

    #     polygon = L.polyline([
    #       center
    #       closest[1].Coordinates
    #     ], {
    #       color: 'blue'
    #       opacity: 0.4
    #       title: 'Closest'
    #     }).addTo(window.map)

    #     polygon = L.polyline([
    #       center
    #       closest[2].Coordinates
    #     ], {
    #       color: 'blue'
    #       opacity: 0.2
    #       title: 'Closest'
    #     }).addTo(window.map)
    #     Session.set "AlooPolylineComplete": true

    # map.on 'locationfound', onLocationFound
    # map.locate {setView: true, maxZoom: 18}
    # console.log 'Pressed the button!'


    # center = window.map.getCenter()
    # console.log 'Get changes'
    # console.log center


    # then change view to only show revered bike and timer