#!/bin/bash
CURRENT_DIR=$(pwd)

sudo rkt run \
	--insecure-options=all \
	--port=www:7000 \
        --volume conf,kind=host,source=$CURRENT_DIR/ \
        --volume data,kind=host,source=$CURRENT_DIR/ \
        ../nginx.aci

	#--net=host \
