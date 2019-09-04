import mapboxgl from 'mapbox-gl';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const addMarkersToMap = (map, marker) => {
  const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

  new mapboxgl.Marker({color: 'red'})
  .setLngLat([ marker.lng, marker.lat ])
  .setPopup(popup)
  .addTo(map);


};

const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    var markersUser = JSON.parse(mapElement.dataset.markersUser);
    if (Array.isArray(markersUser) && markersUser.length) {
      drawCircles(map, markersUser);
      fitMapToMarkers(map, markersUser);
    }

    const markerLocal = JSON.parse(mapElement.dataset.markerLocal);
    if (markerLocal) {
      addMarkersToMap(map, markerLocal);
      markersUser.push(markerLocal);
      fitMapToMarkers(map, markersUser);
    }
  }
};

const drawCircles = (map, markers) => {
  map.on('load', function () {
    console.log(markers)

    markers.forEach(function(marker, index) {
      if (marker.user != marker.current_user) {
        map.addSource("polygon" + index, createGeoJSONCircle([marker.lng, marker.lat], 0.5));
        map.addLayer({
          "id": "polygon" + index,
          "type": "fill",
          "source": "polygon" + index,
          "layout": {},
          "paint": {
            "fill-color": "blue",
            "fill-opacity": 0.4
          }
        });
      console.log(marker)

      map.on('click', 'polygon' + index, function (e) {
        new mapboxgl.Popup()
          .setLngLat(e.lngLat)
          .setHTML(marker.infoWindow)
          .addTo(map);
      });

      // Change the cursor to a pointer when the mouse is over the states layer.
      map.on('mouseenter', 'polygon' + index, function () {
      map.getCanvas().style.cursor = 'pointer';
      });

      // Change it back to a pointer when it leaves.
      map.on('mouseleave', 'polygon' + index, function () {
      map.getCanvas().style.cursor = '';
      });
    };
  });
  });
}

var createGeoJSONCircle = function(center, radiusInKm, points) {
  if(!points) points = 64;

  var coords = {
    latitude: center[1],
    longitude: center[0]
  };

  var km = radiusInKm;

  var ret = [];
  var distanceX = km/(111.320*Math.cos(coords.latitude*Math.PI/180));
  var distanceY = km/110.574;

  var theta, x, y;
  for(var i=0; i<points; i++) {
    theta = (i/points)*(2*Math.PI);
    x = distanceX*Math.cos(theta);
    y = distanceY*Math.sin(theta);

    ret.push([coords.longitude+x, coords.latitude+y]);
  }
  ret.push(ret[0]);

  return {
    "type": "geojson",
    "data": {
      "type": "FeatureCollection",
      "features": [{
        "type": "Feature",
        "geometry": {
          "type": "Polygon",
          "coordinates": [ret]
        }
      }]
    }
  };
};
function updateScale(map, container, options) {
    // A horizontal scale is imagined to be present at center of the map
    // container with maximum length (Default) as 100px.
    // Using spherical law of cosines approximation, the real distance is
    // found between the two coordinates.
    const maxWidth = options && options.maxWidth || 100;

    const y = map._container.clientHeight / 2;
    const maxMeters = getDistance(map.unproject([0, y]), map.unproject([maxWidth, y]));
    // The real distance corresponding to 100px scale length is rounded off to
    // near pretty number and the scale length for the same is found out.
    // Default unit of the scale is based on User's locale.
    if (options && options.unit === 'imperial') {
        const maxFeet = 3.2808 * maxMeters;
        if (maxFeet > 5280) {
            const maxMiles = maxFeet / 5280;
            setScale(container, maxWidth, maxMiles, 'mi');
        } else {
            setScale(container, maxWidth, maxFeet, 'ft');
        }
    } else if (options && options.unit === 'nautical') {
        const maxNauticals = maxMeters / 1852;
        setScale(container, maxWidth, maxNauticals, 'nm');
    } else {
        setScale(container, maxWidth, maxMeters, 'm');
    }
}

function setScale(container, maxWidth, maxDistance, unit) {
    let distance = getRoundNum(maxDistance);
    const ratio = distance / maxDistance;

    if (unit === 'm' && distance >= 1000) {
        distance = distance / 1000;
        unit = 'km';
    }

    container.style.width = `${maxWidth * ratio}px`;
    container.innerHTML = distance + unit;
}

function getDistance(latlng1, latlng2) {
    // Uses spherical law of cosines approximation.
    const R = 6371000;

    const rad = Math.PI / 180,
        lat1 = latlng1.lat * rad,
        lat2 = latlng2.lat * rad,
        a = Math.sin(lat1) * Math.sin(lat2) +
          Math.cos(lat1) * Math.cos(lat2) * Math.cos((latlng2.lng - latlng1.lng) * rad);

    const maxMeters = R * Math.acos(Math.min(a, 1));
    return maxMeters;

}

function getRoundNum(num) {
    const pow10 = Math.pow(10, (`${Math.floor(num)}`).length - 1);
    let d = num / pow10;

    d = d >= 10 ? 10 :
        d >= 5 ? 5 :
        d >= 3 ? 3 :
        d >= 2 ? 2 : 1;

    return pow10 * d;
}

export { initMapbox };
