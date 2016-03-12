Template.profile.rendered = ->
  L.Icon.Default.imagePath = 'packages/bevanhunt_leaflet/images'
  KyleMap = new L.map('kyle').setView([49.25044, -123.137], 13)
  L.tileLayer.provider('OpenStreetMap.Mapnik').addTo(KyleMap)

  KyleMapbutton = L.easyButton('fa-globe fa-lg', (btn, map) ->
    console.log map
    alert('Map center is at: ' + map.getCenter().toString())
  ).addTo(KyleMap)
