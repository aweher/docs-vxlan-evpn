#!/bin/bash
# ASW
PROYECTO="reg.dc.celp.red/lacnog/doc-lab-vxlan-evpn"
NOW=$(date +%Y%m%d%H%M%S)
docker build --no-cache -t $PROYECTO:$NOW -t $PROYECTO:latest .
docker push $PROYECTO:$NOW
docker push $PROYECTO:latest
