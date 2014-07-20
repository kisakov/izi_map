(function() {
  $(function() {
    window.weatherRequest = function(position) {
      return $.get('http://api.openweathermap.org/data/2.5/weather', {
        lat: position.lat(),
        lon: position.lng(),
        APPID: 'c9aedb4a466406c8ad44321c774fc6d3'
      });
    };
    return window.getWeatherInfo = function(response) {
      var data, result;
      data = response[0];
      result = response[1] === 'success' ? "" + data.weather[0].main + "<br> " + data.weather[0].description + "<br> " + (Math.round(data.main.temp - 273.15)) + " C&deg<br> Humidity: " + data.main.humidity + "%<br> Wind: " + data.wind.speed + "m/s<br>" : '<p>No wheater forecast for this location</p>';
      return "<h3>Wheater</h3>" + result;
    };
  });

}).call(this);
