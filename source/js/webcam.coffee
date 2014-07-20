$ ->
  window.webcamRequest = (position) ->
    $.get 'http://api.webcams.travel/rest',
      lat: position.lat()
      lng: position.lng()
      method: 'wct.webcams.list_nearby'
      devid: 'd2a3f882246031d44de64607d65981fd'
      format: 'json'
      radius: 10
      unit: 'km'

  window.getWebcamInfo = (response) ->
    data   = JSON.parse(response[0])
    result = if response[1] == 'success' && data.status == 'ok' && data.webcams.count
        webcams = for webcam in data.webcams.webcam
          "
           <p>
             Title: #{webcam.title}<br>
             View count: #{webcam.view_count}<br>
             <a href='#{webcam.url}'><img src='#{webcam.thumbnail_url}'></a>
           </p>
          "
        webcams.join('')
      else
        '<p>No webcams for this location</p>'
    "<h3>Webcams</h3>#{result}"