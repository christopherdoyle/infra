#!/bin/sh

# Script used to prepare the minio instance that runs as part of the development
# Docker compose cluster.

while ! mc config host add h0 http://ente_minio:3200 test testtest
do
   echo "waiting for ente_minio..."
   sleep 0.5
done

cd /data

mc mb -p b2-eu-cen
mc mb -p wasabi-eu-central-2-v3
mc mb -p scw-eu-fr-v3
