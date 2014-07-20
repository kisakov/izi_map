(function() {
  $(function() {
    window.webcamRequest = function(position) {
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
    return window.getWebcamInfo = function(response) {
      var data, result, webcam, webcams;
      data = JSON.parse(response[0]);
      result = response[1] === 'success' && data.status === 'ok' && data.webcams.count ? (webcams = (function() {
        var _i, _len, _ref, _results;
        _ref = data.webcams.webcam;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          webcam = _ref[_i];
          _results.push("<p> Title: " + webcam.title + "<br> View count: " + webcam.view_count + "<br> <a href='" + webcam.url + "'><img src='" + webcam.thumbnail_url + "'></a> </p>");
        }
        return _results;
      })(), webcams.join('')) : '<p>No webcams for this location</p>';
      return "<h3>Webcams</h3>" + result;
    };
  });

}).call(this);
