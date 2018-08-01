#!/bin/bash -xe
#
# See: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html
#
# Make sure both volumes have been created AND attached to this instance !
#
# We do not need a loop counter in the "until" statements below because
# there is a 5 minute limit on the CreationPolicy for this EC2 instance already.

EC2_INSTANCE_ID=$(curl -s http://instance-data/latest/meta-data/instance-id)

######################################################################
# Volume /dev/sdh (which will get created as /dev/xvdh on Amazon Linux)

DATA_STATE="unknown"
until [ "${!DATA_STATE}" == "attached" ]; do
  DATA_STATE=$(aws ec2 describe-volumes \
    --region ${AWS::Region} \
    --filters \
        Name=attachment.instance-id,Values=${!EC2_INSTANCE_ID} \
        Name=attachment.device,Values=/dev/sdh \
    --query Volumes[].Attachments[].State \
    --output text)

  sleep 5
done

# Format /dev/xvdh if it does not contain a partition yet
if [ "$(file -b -s /dev/xvdh)" == "data" ]; then
  mkfs -t ext4 /dev/xvdh
fi

mkdir -p /data
mount /dev/xvdh /data

# Persist the volume in /etc/fstab so it gets mounted again
echo '/dev/xvdh /data ext4 defaults,nofail 0 2' >> /etc/fstab
