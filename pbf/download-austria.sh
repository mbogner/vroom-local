#!/usr/bin/env bash
PBF=austria-latest.osm.pbf

echo "pbf: $PBF"

if [[ -f "$PBF" ]]; then
  echo "pbf file already exists"
else
  echo "download pbf file"
  wget https://download.geofabrik.de/europe/${PBF}
fi