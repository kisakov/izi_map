$ ->
  do initialize = ->
    mapOptions =
      center: new google.maps.LatLng(35, 139)
      zoom: 8
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)
    google.maps.event.addListener map, 'click', (e) ->
      position   = e.latLng
      marker     = placeMarker(position, map)
      infoWindow = placeInfoWindow(position, map, marker)
      $.when(weatherRequest(position), webcamRequest(position)).done (weatherResponse, webcamResponse) ->
        infoWindow.setContent getWeatherInfo(weatherResponse) + getWebcamInfo(webcamResponse)
      map.panTo(position)

  placeMarker = (position, map) ->
    new google.maps.Marker
      position: position
      map: map
      title: 'Wheater and webcams'

  placeInfoWindow = (position, map, marker) ->
    infoWindow = new google.maps.InfoWindow content: '<img src="img/ajax-loader.gif" title="loading...">'
    infoWindow.open(map, marker)
    infoWindow

