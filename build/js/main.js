(function() {
  $(function() {
    var initialize, placeInfoWindow, placeMarker;
    (initialize = function() {
      var map, mapOptions;
      mapOptions = {
        center: new google.maps.LatLng(35, 139),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
      return google.maps.event.addListener(map, 'click', function(e) {
        return placeMarker(e.latLng, map);
      });
    })();
    placeMarker = function(position, map) {
      var marker;
      marker = new google.maps.Marker({
        position: position,
        map: map,
        title: 'Wheater and webcams'
      });
      placeInfoWindow(position, map, marker);
      return map.panTo(position);
    };
    return placeInfoWindow = function(position, map, marker) {
      return $.when(weatherRequest(position), webcamRequest(position)).done(function(weatherResponse, webcamResponse) {
        var infowindow;
        window.webcamResponse = JSON.parse(webcamResponse[0]);
        infowindow = new google.maps.InfoWindow({
          content: getWeatherInfo(weatherResponse) + getWebcamInfo(webcamResponse)
        });
        return infowindow.open(map, marker);
      });
    };
  });

}).call(this);
