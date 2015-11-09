import channel from './socket'

$(() => {
  let mapboxId = $('#mapbox-id').attr('data-value')
  let mapboxAccessToken = $('#mapbox-access-token').attr('data-value')

  let map = L.map('map').setView([35.12, 8.68], 3);

  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://mapbox.com">Mapbox</a>',
      maxZoom: 10,
      id: mapboxId,
      accessToken: mapboxAccessToken
  }).addTo(map);

  channel.on("new_tweet", payload => {
    let tweet = payload['body'];

    let coords = tweet['geo']['coordinates'];
    console.log(coords);

    let marker = L.marker(coords).addTo(map);
    marker.bindPopup(tweet['text']).openPopup();
  });
});
