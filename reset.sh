#!/usr/bin/env bash
docker compose stop
docker compose rm -f
rm -rf graphs elevation_cache logs vroom-conf/access.log