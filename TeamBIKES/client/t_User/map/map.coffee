Template.map.rendered = ->
  Meteor.subscribe("AvailableBikeLocationsPub")
  Meteor.subscribe("ReservedBike")

  # Call MapInit function from s_Helpers
  coords = [38.987701, -76.940989]
  [window.map, GreyBike, RedBike, GreenBike] = MapInit('BikeMap', true, true, coords)

  # Inspiration: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  markers = []
  Session.set
    "selectedBike": false
    "available": true

  [today, now] = CurrentDay()
  DailyBikeData.find({Day: today}).observe
    added: (bike) ->
      latlng = bike.Coordinates
      if bike.Tag == 'Available'
        BikeIcon = GreyBike
      else
        BikeIcon = GreenBike
        console.log 'bike.Tag = ' + bike.Tag
        console.log 'bike.Bike = ' + bike.Bike
      markers[bike._id] = L.marker(latlng,
        title: bike.Bike
        opacity: 0.75
        icon: BikeIcon).on("click", (e) ->
          # Remove previously selected bike
          if Session.get('selectedBike')
            last = Session.get 'selectedBike'
            lastBike = DailyBikeData.findOne({Bike: last})
            if lastBike.Tag == 'Available'
              BikeIcon = GreyBike
            else
              BikeIcon = GreenBike
            markers[lastBike._id].setIcon BikeIcon
            # console.log lastBike._id
            # console.log markers[lastBike._id]._icon.title

          # Highlight new bike
          @setIcon RedBike
          Session.set
            "selectedBike": e.target.options.title
            "available": true
          # console.log e.target.options.title
          ).addTo(window.map)

      # marker.bindPopup("#" + bike.Bike + " is " + bike.Tag)

    changed: (bike, oldBike) ->
      if oldBike.Tag == bike.Tag
        latlng = bike.Coordinates
        markers[bike._id].setLatLng(latlng).update()
        console.log markers[bike._id]._leaflet_id + ' changed on window.map on CHANGED event'
      else if bike.Tag == Meteor.userId()
        markers[bike._id].setIcon GreenBike
        console.log 'Changed to green icon color for # ' + bike.Bike
      else if bike.Tag == "Available"
        markers[bike._id].setIcon GreyBike
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
      window.map.removeLayer markers[oldBike._id]
      console.log markers[oldBike._id]._leaflet_id + ' removed from window.map on REMOVED event and...'
      # Remove the reference to this marker instance
      delete markers[oldBike._id]


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
      coords = DailyBikeData.findOne({Bike: Bike}).Coordinates
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
    center = window.map.getCenter()
    closest = DailyBikeData.find(
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


    # then change view to only show revered bike and timer