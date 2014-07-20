$ ->
  do initialize = ->
    mapOptions =
      center: new google.maps.LatLng(35, 139)
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
    $.when(weatherRequest(position), webcamRequest(position))
      .done (weatherResponse, webcamResponse) ->
        window.webcamResponse = JSON.parse(webcamResponse[0])
        infowindow = new google.maps.InfoWindow
                      content: getWeatherInfo(weatherResponse) + getWebcamInfo(webcamResponse)
        infowindow.open(map, marker)
