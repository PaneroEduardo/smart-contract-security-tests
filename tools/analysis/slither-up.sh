#! /bin/bash

#Download securify from GitHub
git clone https://github.com/crytic/slither.git
#
cd slither

sed -e 's/RUN solc-select install .*/RUN solc-select install 0.8.17 \&\& solc-select use 0.8.17/' Dockerfile > DockerfileCustom

docker build -t slither -f DockerfileCustom .