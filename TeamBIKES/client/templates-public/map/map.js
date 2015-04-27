Template.map.rendered = function() {
  // return Meteor.subscribe("currentData", function() {

    if (Meteor.isClient) {

      // L.Icon.Default.imagePath = 'leaflet/images';

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

      // var OpenCycleMap = L.tileLayer("http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png", {
      //   attribution: "&copy; <a href=\"http://www.opencyclemap.org\">OpenCycleMap</a>, &copy; <a href=\"http://openstreetmap.org\">OpenStreetMap</a> contributors, <a href=\"http://creativecommons.org/licenses/by-sa/2.0/\">CC-BY-SA</a>"
      // }).addTo(map);

      var zoomControl = L.control.zoom({
        position: 'bottomleft'
      });

      map.addControl(zoomControl);

      // // Use Leaflet cluster group plugin
      // var markers = new L.MarkerClusterGroup();
      // bikesData = Current.find().fetch();

      // var bikeIconGR = L.icon({
      //     iconUrl: 'leaflet/bikes/marker-icon.png',
      //     shadowUrl: 'leaflet/bikes/marker-icon.png',

      //     iconSize:     [50, 50], // size of the icon
      //     shadowSize:   [0, 0], // size of the shadow
      //     iconAnchor:   [22, 94], // point of the icon which will correspond to marker's location
      //     shadowAnchor: [0, 0],  // the same for the shadow
      //     popupAnchor:  [-3, -76] // point from which the popup should open relative to the iconAnchor
      // });

      // map.addLayer(markers);

      // // New serial port connection:
      // var i = bikesData.length - 1;
      // while (i >= 1) {
      //   if (!isNaN(bikesData[i].Lat)) {
      //     markers.addLayer( new L.Marker(new L.LatLng(bikesData[i].Lat, bikesData[i].Long), {icon: bikeIconGR} ) );
      //     console.log(bikesData[i]);
      //   } else {
      //     console.log("Bad Bike Location (NaN) - i.e. the current database is empty");
      //   }
      //   i--;
      // }
      // map.addLayer(markers);



      // Creates a red marker with the coffee icon
      var redMarker = L.AwesomeMarkers.icon({
        prefix: 'fa',
        icon: 'bicycle',
        // prefix: 'ion',
        // icon: 'coffee',
        markerColor: 'red',
        iconColor: 'white'
      });
      var marker = L.marker([38.9820409, -76.94257429999999], {icon: redMarker}).addTo(map);
      // console.log(marker);



      map.locate({
        setView: true
      }).on("locationfound", function(e) {
        var marker = L.marker([e.latitude, e.longitude], {icon: redMarker}).addTo(map);
        // console.log(markerGPS);
        console.log([e.latitude, e.longitude]);
      });

    }
  // });
};