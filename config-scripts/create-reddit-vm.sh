#!/bin/sh

IMAGE=`gcloud compute images list --format="value(name)"  --filter="name:reddit-full"  --sort-by="~name" --limit=1`

echo Using last image: $IMAGE

gcloud compute instances create reddit-app-1 \
  --image $IMAGE \
  --machine-type=g1-small \
  --tags "puma-server" \
  --zone "europe-west1-b"
