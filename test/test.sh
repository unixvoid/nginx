#!/bin/bash
CURRENT_DIR=$(pwd)

sudo docker run \
		-d \
		-p 7000:7000 \
		--name nginxtest \
		-v $CURRENT_DIR/nginx.conf:/cryo/conf/nginx.conf:ro \
		-v $CURRENT_DIR/index.html:/cryo/data/index.html:ro \
		mfaltys/nginx

sudo docker logs -f nginxtest
