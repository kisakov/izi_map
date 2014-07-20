$ ->
  window.weatherRequest = (position) ->
    $.get 'http://api.openweathermap.org/data/2.5/weather',
      lat: position.lat()
      lon: position.lng()
      APPID: 'c9aedb4a466406c8ad44321c774fc6d3'

  window.getWeatherInfo = (response) ->
    data   = response[0]
    result = if response[1] == 'success'
               "
                #{data.name}, #{data.sys.country}<br>
                #{data.weather[0].main}<br>
                #{data.weather[0].description}<br>
                #{Math.round(data.main.temp - 273.15)} C&deg<br>
                Humidity: #{data.main.humidity}%<br>
                Wind: #{data.wind.speed}m/s<br>
               "
             else
               '<p>No wheater forecast for this location</p>'
    "<h3>Wheater forecast</h3>#{result}"

