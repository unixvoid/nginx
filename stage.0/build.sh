#!/bin/bash

sudo docker build -t stage.0 .
sudo docker run --name tmpstage -v $(pwd):/stage:rw stage.0
strip nginx
sudo docker rm tmpstage
sudo docker rmi stage.0
cp nginx ../stage.1/aci/
mv nginx ../stage.1/docker/
echo "------------------------------------------------------"
echo " nginx binary moved to stage.1/aci and stage.1/docker"
echo "------------------------------------------------------"
