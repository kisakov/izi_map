$ ->
  do initialize = ->
    mapOptions =
      center: new google.maps.LatLng(-34.397, 150.644)
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)
    google.maps.event.addListener map, 'click', (e) ->
      placeMarker(e.latLng, map)

  placeMarker = (position, map) ->
    marker = new google.maps.Marker
      position: position
      map: map
      title: 'Wheater and webcams'

    placeInfoWindow(position, map, marker)
    map.panTo(position)

  placeInfoWindow = (position, map, marker) ->
    infowindow = new google.maps.InfoWindow(content: position.lat().toString())
    infowindow.open(map, marker)

