(function() {
  $(function() {
    return window.webcamRequest = function(position) {
      return $.get('http://api.webcams.travel/rest', {
        lat: position.lat(),
        lng: position.lng(),
        method: 'wct.webcams.list_nearby',
        devid: 'd2a3f882246031d44de64607d65981fd',
        format: 'json',
        radius: 10,
        unit: 'km'
      });
    };
  });

}).call(this);
