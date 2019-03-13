#!/bin/bash

INITIAL_ARGS="$*"

launch_ec2() {
   local AMI_ID="$1"
   local KEYPAIR="$2"
   local SUBNET="$3"
   local REGION="$4"
   local TAG_KEY="$5"
   local TAG_VALUE="$6"
   local INSTANCE_TYPE="$7"
   local SECURITY_GROUP_ID="$8"
   
   {
       echo """Your instance details is:-
       AMI_ID="${AMI_ID}"
       KEYPAIR_NAME="${KEYPAIR}"
       SUBNET_NAME="${SUBNET}"
       REGION_NAME="${REGION}"
       TAG_KEY="${TAG_KEY}"
       TAG_VALUE="${TAG_VALUE}"
       """
   }
echo "aws ec2 run-instances --image-id "${AMI_ID}" --count 1 --instance-type "${INSTANCE_TYPE}" --key-name "${KEYPAIR}" --security-group-ids "${SECURITY_GROUP_ID}" --subnet-id "${SUBNET}" --region "${REGION}""

   aws ec2 run-instances --image-id ${AMI_ID} --count 1 --instance-type ${INSTANCE_TYPE} --key-name ${KEYPAIR} --security-group-ids ${SECURITY_GROUP_ID} --subnet-id ${SUBNET} --region ${REGION}
}

launch_ec2 "$@"
