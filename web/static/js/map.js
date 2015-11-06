$(() => {
  let mapboxId = $('#mapbox-id').attr('data-value')
  let mapboxAccessToken = $('#mapbox-access-token').attr('data-value')

  let map = L.map('map').setView([50.12, 8.68], 5);

  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 10,
      id: mapboxId,
      accessToken: mapboxAccessToken
  }).addTo(map);
});
