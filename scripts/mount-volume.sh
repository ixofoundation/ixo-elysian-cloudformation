#!/bin/bash

if [ $# -eq 3 ]
then
  DEVICE_NAME=$1
  MOUNT_POINT=$2
  USER=$3

  X="$(sudo file -s ${DEVICE_NAME})"

  if [ "$X" = "${DEVICE_NAME}: data" ]
  then
    echo "0"
    sudo mkfs -t ext4 ${DEVICE_NAME}
  fi

  sudo mkdir $MOUNT_POINT
  sudo mount $DEVICE_NAME $MOUNT_POINT
  sudo chown -R $USER:$USER $MOUNT_POINT
else
  echo "expected 2 arguments: device name (eg. /dev/xvdf) and mount point (eg. /home/ec2-user/persistent-volume)"
fi
