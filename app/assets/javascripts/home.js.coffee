# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$.ajax({
  type: 'POST',
  url: 'oauth/token.json',
  # url: 'http://api.geonames.org/citiesJSON',
  dataType: 'JSON',
  data: {
    # north: 44.1,
    # south: -9.9,
    # east: 22.4,
    # west: 55.2,
    # lang: 'de',
    # username: 'demo'
    grant_type: 'client_credentials',
    client_id: '99c650ac7bf80b41b2330b7081e89746b20681298109fc17503cc626b61c1c57',
    client_secret: '87d4a1b10e0cc14eeb110a8d00397b3a049d11371cfef503c2e068ea6f9852c1'
  },
  success: (d, textStatus, jqXHR) ->
    console.debug d, textStatus
  error: (jqXHR, textStatus, errorThrown) ->
    console.debug jqXHR, textStatus, errorThrown
})