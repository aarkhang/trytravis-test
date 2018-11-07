#!/bin/sh
set -e

IMAGE=`gcloud compute images list --format="value(name)"  --filter="name:reddit-base"  --sort-by="~name" --limit=1`

echo Using last base image: $IMAGE

packer validate -var-file=variables-immutable.json -var "source_image=$IMAGE" immutable.json
packer build -var-file=variables-immutable.json -var "source_image=$IMAGE" immutable.json
