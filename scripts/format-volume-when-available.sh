#!/bin/bash -xe
#
# See: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html
#
# Make sure volume has been created AND attached to this instance !
#
# We do not need a loop counter in the "until" statements below because
# there is a 5 minute limit on the CreationPolicy for this EC2 instance already.


######################################################################
# Volume /dev/sdf (which will get created as /dev/xvdf on Amazon Linux)

while [ ! -e /dev/sdf ];
do
  echo waiting for /dev/sdf to attach
  sleep 5
done

# Format /dev/xvdf if it does not contain a partition yet
if [ "$(file -b -s /dev/xvdf)" == "data" ]; then
  mkfs -t ext4 /dev/xvdf
fi

mkdir -p /persistent-volume
mount /dev/xvdf /persistent-volume

mkdir /persistent-volume/backup
mkdir /persistent-volume/data
chmod -R ugo+r+w+x persistent-volume

# Persist the volume in /etc/fstab so it gets mounted again
echo '/dev/xvdf /persistent-volume ext4 defaults,nofail 0 2' >> /etc/fstab

lsblk
