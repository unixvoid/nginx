#!/bin/bash

sudo docker build -t stage.0 .
sudo docker run --name tmpstage -v $(pwd):/stage:rw stage.0
strip nginx
sudo docker rm tmpstage
sudo docker rmi stage.0
