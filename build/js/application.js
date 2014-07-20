(function() {
  window.initialize = function() {
    var map, mapOptions, placeInfoWindow, placeMarker;
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
    placeInfoWindow = function(position, map, marker) {
      var infowindow;
      infowindow = new google.maps.InfoWindow({
        content: position.lat().toString()
      });
      return infowindow.open(map, marker);
    };
    mapOptions = {
      center: new google.maps.LatLng(-34.397, 150.644),
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
    return google.maps.event.addListener(map, 'click', function(e) {
      return placeMarker(e.latLng, map);
    });
  };

}).call(this);
