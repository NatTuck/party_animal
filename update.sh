#!/bin/bash

# Update runs on the server to update to latest git main branch code.

. $HOME/.asdf/asdf.sh

cd ~/party_animal
git pull
mix deps.get
mix ecto.migrate

