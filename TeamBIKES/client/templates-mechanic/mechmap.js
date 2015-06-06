Template.mechmap.created = function() {
  return Meteor.subscribe("bikesData", function() {

    if (Meteor.isClient) {

      L.Icon.Default.imagePath = 'leaflet/images';

      var map = new L.Map('map', {
        center: new L.LatLng(38.987701, -76.940989),
        maxZoom: 20,
        zoom: 16,
        zoomControl: false
      });

      var HERE_hybridDayMobile = L.tileLayer('http://{s}.{base}.maps.cit.api.here.com/maptile/2.1/maptile/{mapID}/hybrid.day.mobile/{z}/{x}/{y}/256/png8?app_id={app_id}&app_code={app_code}', {
        attribution: 'Map &copy; 1987-2014 <a href="http://developer.here.com">HERE</a>',
        subdomains: '1234',
        mapID: 'newest',
        app_id: 'JIX0epTdHneK1hQlqfkr',
        app_code: 'PchnUPPBcZ5VAuHmovac8g',
        base: 'aerial',
        minZoom: 0,
        maxZoom: 20
      }).addTo(map);

      var zoomControl = L.control.zoom({
        position: 'bottomleft'
      });

      map.addControl(zoomControl);

      // var bikeIconGR = L.icon({
      //     iconUrl: 'leaflet/bikes/marker-icon.png',
      //     shadowUrl: 'leaflet/bikes/marker-icon.png',

      //     iconSize:     [50, 50], // size of the icon
      //     shadowSize:   [0, 0], // size of the shadow
      //     iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
      //     shadowAnchor: [0, 0],  // the same for the shadow
      //     popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
      // });

      var bikeIconRE = L.icon({
          iconUrl: 'leaflet/bikesRE/marker-icon.png',
          shadowUrl: 'leaflet/bikesRE/marker-icon.png',

          iconSize:     [50, 50], // size of the icon
          shadowSize:   [0, 0], // size of the shadow
          iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
          shadowAnchor: [0, 0],  // the same for the shadow
          popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
      });

      // Use Leaflet cluster group plugin
      var markers = new L.MarkerClusterGroup();
      // var bikesData = Bikes.findOne({bike: 1}).updates;

      for (var i = 0; i <= 10; i++) {
        if (Bikes.findOne({bike: 1}).updates[i].status === "Fixed") {
          console.log('Fixed Bike');
          // markers.addLayer( new L.Marker(new L.LatLng(bikesData[i].latitude, bikesData[i].longitude), {icon: bikeIconGR} ) );
        } else {
          markers.addLayer( new L.Marker(new L.LatLng(Bikes.findOne({bike: 1}).updates[i].lat, Bikes.findOne({bike: 1}).updates[i].lng), {icon: bikeIconRE} ) );
        }
      }

      map.addLayer(markers);

    map.locate({
      setView: true
    }).on("locationfound", function(e) {

    var marker;
      marker = L.marker([e.latitude, e.longitude]).addTo(map);
    });
  }
});
};