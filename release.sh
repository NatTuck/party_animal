#!/bin/bash

. ~/prod-env.sh

mix deps.get --only prod
mix compile
(cd assets && pnpm install)
mix assets.deploy
mix release --overwrite

# Genenerate a tar archive to copy to another machine.
#(cd _build/prod/rel && tar czvf /tmp/party-animal-release.tar.gz party_animal)
