#!/bin/bash
set -ev
export ROLE_DIR=geerlingguy.$ROLE_NAME
export REPO_DIR="$(basename $PWD)"
if [ "$REPO_DIR" != "$ROLE_DIR" ]; then
  cd ../
  mv $REPO_DIR $ROLE_DIR
  cd $ROLE_DIR
fi
