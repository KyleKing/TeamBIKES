foo = (RouteID, OldRouteID) ->
  console.log Session.get('OldRouteID')
  markers = []
  [window.map, GreyBike, RedBike, GreenBike] = MapInit(false, false, false, false)

  DailyBikeData.find({_id: RouteID}).observe
    added: (bike) ->
      polyline = L.polyline([bike.Positions[0].Coordinates, bike.Positions[1].Coordinates], color: 'blue').addTo(window.map)
      _.each bike.Positions, (BikeRecord) ->
        latlng = BikeRecord.Coordinates
        polyline.addLatLng(latlng) # extend polyline with new location
        if BikeRecord.Tag = 'Available'
          BikeIcon = GreyBike
        else if BikeRecord.Tag = 'RepairInProgress'
          BikeIcon = RedBike
        else
          BikeIcon = GreenBike
        markers[BikeRecord._id] = L.marker(latlng,
          title: BikeRecord.Bike
          opacity: 0.75
          icon: BikeIcon).addTo(window.map)


Tracker.autorun ->
  FlowRouter.watchPathChange()
  RouteID = FlowRouter.getParam("IDofSelectedRow")
  if DailyBikeData.findOne({_id: RouteID})
    if isUndefined(Session.get("OldRouteID"))
      Session.set "OldRouteID": false
    foo(RouteID, Session.get("OldRouteID"))
    Session.set "OldRouteID": RouteID

Template.ManageBike.rendered = ->
  Meteor.subscribe("DailyBikeDataPub")

  # Call MapInit function from s_Helpers to create the Leaflet Map
  coords = [38.987701, -76.940989]
  [window.map, GreyBike, RedBike, GreenBike] = MapInit('ManageBikeMap', false, false, coords)

  # Source: http://meteorcapture.com/how-to-create-a-reactive-google-map/
  # and leaflet specific: http://asynchrotron.com/blog/2013/12/28/realtime-maps-with-meteor-and-leaflet-part-2/
  Session.set
    "selectedBike": false
    "available": true