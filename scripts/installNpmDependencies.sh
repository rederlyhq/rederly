#!/usr/bin/env bash

./scripts/discoverPackageJson.sh | xargs dirname | xargs -I '{}' sh -c "echo 'Installing {}'; npm install --prefix '{}'"