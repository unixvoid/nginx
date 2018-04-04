#!/bin/bash
# script to sign an aci and produce a key
# this script takes 2 arguments, the name of the
#   aci to be signed, and the security password
#   for the key. example:
#   ./sign.sh nginx-latest-amd64 supersecretpass
NAME=$(ls *.aci)

echo "===================================="
ls -alh
echo "===================================="

echo $1 | gpg \
	--passphrase-fd 0 \
	--batch --yes \
	--no-default-keyring --armor \
	--secret-keyring ./unixvoid.sec --keyring ./unixvoid.pub \
  --output $NAME.asc \
  --detach-sig $NAME
