# vroom-local

Easy way to get vroom up and running locally.

## Usage

Simply run the `start.sh` script included in the root folder. This starts

### ORS

ORS instance at `localhost:8080`. This takes quite some time to download Austria map data and update the database.

You will see a text like the following in `ors` container log when it finished importing data:

```text
========================================================================
====> Recycling garbage...
Before:  Total - 1.81 GB, Free - 580.30 MB, Max: 2 GB, Used - 1.24 GB
After:  Total - 2 GB, Free - 792.11 MB, Max: 2 GB, Used - 1.23 GB
========================================================================
====> Memory usage by profiles:
[1] 573.04 MB (45.6%)
Total: 573.04 MB (45.6%)
========================================================================
```

Before you can't send any queries.

### Vroom API

At localhost:3000. There is also a test.http file with a sample request for the api. In case you're wondering what the
`geometry` value is in the response: This is a encoded polyline which needs to be decoded. There is a tool from google
which you can use for this online: https://developers.google.com/maps/documentation/utilities/polylineutility

### Vroom Frontend

Further the start script installs and starts a local instance of vroom frontend at http://127.0.0.1:9966. But this needs
some changes for OSR:

#### vroom-frontend issue

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

You can see the same profile setting in the `test.http` file. Without that profile you get 400 from the API telling you
that there is no 'car' profile.

You can also change the initial location when opening the frontend
in [leaflet_setup.js](vroom-frontend/src/config/leaflet_setup.js) at `initCenter`.