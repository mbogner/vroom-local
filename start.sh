#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "${DIR}" || exit 1
cd pbf || exit 2

./download-austria.sh

cd "${DIR}" || exit 1
echo "starting docker instances"
docker compose up -d

cd vroom-frontend || exit 3
npm install
npm run serve