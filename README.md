## vroom-frontend

The frontend is using the default profile for cars. But when using ORS the default is 'car' which doesn't exist.
Requests need to set cars to profile 'driving-car'. I haven't found any place to configure this but I found a workaround
by changing the [solution_handler.js](vroom-frontend/src/utils/solution_handler.js):

```javascript
var vehicles = JSON.parse(JSON.stringify(dataHandler.getVehicles()));
for (let i = 0; i < vehicles.length; i++) {
    vehicles[i].profile = 'driving-car';
}
var input = {
    jobs: JSON.parse(JSON.stringify(dataHandler.getJobs())),
    shipments: JSON.parse(JSON.stringify(dataHandler.getShipments())),
    vehicles: vehicles,
    "options": {
        "g": true
    }
};
```

The variable `input` is used for sending data to vroom api but has no profile set. The loop introduces that param.

You can also change the initial location when opening the frontend
in [leaflet_setup.js](vroom-frontend/src/config/leaflet_setup.js) at `initCenter`.