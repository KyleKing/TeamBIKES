Meteor.startup ->
  sAlert.config
    effect: 'stackslide'
    position: 'top-right'
    timeout: 3000
    html: false
    onRouteClose: true
    stack: true
    offset: 10

Template.ManageBike.rendered = ->
  Meteor.subscribe("DailyBikeDataPub")

  # Call MapInit function from s_Helpers to create the Leaflet Map
  coords = [38.987701, -76.940989]
  [window.map, GreyBike, RedBike, GreenBike] = MapInit('ManageBikeMap', false, false, coords)

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  markers = []
  Session.set
    "selectedBike": false
    "available": true

  DailyBikeData.find({_id: FlowRouter.getParam ("IDofSelectedRow")}).observe
    added: (bike) ->
      polyline = L.polyline([bike.Positions[0].Coordinates, bike.Positions[1].Coordinates], color: 'blue').addTo(map)
      _.each bike.Positions, (BikeRecord) ->
        latlng = BikeRecord.Coordinates
        polyline.addLatLng(latlng) # extend polyline with new location
        if BikeRecord.Rider
          BikeIcon = GreenBike
        else
          BikeIcon = GreyBike
        markers[BikeRecord._id] = L.marker(latlng,
          title: BikeRecord.Bike
          opacity: 0.75
          icon: BikeIcon
          # ).on("click", (e) ->
          #   # Remove previously selected bike
          #   if Session.get('selectedBike') && Session.get('available')
          #     if BikeRecord.Tag == 'Available'
          #       BikeIcon = GreyBike
          #     else
          #       BikeIcon = GreenBike
          #     last = Session.get 'selectedBike'
          #     last_id = DailyBikeData.findOne({Bike: last})._id
          #     markers[last_id].setIcon BikeIcon

          #   # Highlight new bike
          #   @setIcon RedBike
          #   Session.set
          #     "selectedBike": e.target.options.title
          #     "available": true
          #   # console.log e.target
          #   # console.log e.target._leaflet_id
          #   # console.log e.target.options.title
            ).addTo(window.map)