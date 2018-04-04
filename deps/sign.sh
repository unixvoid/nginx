#!/bin/bash
# script to sign an aci and produce a key
# this script takes 2 arguments, the name of the
#   aci to be signed, and the security password
#   for the key. example:
#   ./sign.sh nginx-latest-amd64 supersecretpass

echo "===================================="
ls -alh
echo "===================================="

echo $2 | gpg \
	--passphrase-fd 0 \
	--batch --yes \
	--no-default-keyring --armor \
	--secret-keyring ./unixvoid.sec --keyring ./unixvoid.pub \
	--output $1.aci.asc \
	--detach-sig $1.aci
