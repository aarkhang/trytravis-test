#!/bin/bash
set -ev
export ROLE_AUTHOR=geerlingguy
export CWDIR="$(basename $PWD)"
if [ "$CWDIR" != "$ROLE_AUTHOR.$ROLE_NAME" ]; then
  cd ../
  mv ansible-role-$ROLE_NAME $ROLE_AUTHOR.$ROLE_NAME
  cd $ROLE_AUTHOR.$ROLE_NAME
  echo "Rename ansible-role-$ROLE_NAME to $ROLE_AUTHOR.$ROLE_NAME"
else
  echo "Already in $ROLE_AUTHOR.$ROLE_NAME"
fi
