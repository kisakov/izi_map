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
        var infoWindow, marker, position;
        position = e.latLng;
        marker = placeMarker(position, map);
        infoWindow = placeInfoWindow(position, map, marker);
        $.when(weatherRequest(position), webcamRequest(position)).done(function(weatherResponse, webcamResponse) {
          return infoWindow.setContent(getWeatherInfo(weatherResponse) + getWebcamInfo(webcamResponse));
        });
        return map.panTo(position);
      });
    })();
    placeMarker = function(position, map) {
      return new google.maps.Marker({
        position: position,
        map: map,
        title: 'Wheater and webcams'
      });
    };
    return placeInfoWindow = function(position, map, marker) {
      var infoWindow;
      infoWindow = new google.maps.InfoWindow({
        content: '<img src="img/ajax-loader.gif" title="loading...">'
      });
      infoWindow.open(map, marker);
      return infoWindow;
    };
  });

}).call(this);
