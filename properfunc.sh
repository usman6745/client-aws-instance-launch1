#!/bin/bash
INITIAL_ARGS="$*"
launch_ec2() {
   local AMI_ID="$1"
   local SUBNET="$2"
   local REGION="$3"
   local NAME="$4"
   local NAME_VALUE="$5"
   local Number_Of_Instances="$6"
   local SECURITY_GROUP_ID="$7"
   local KEYPAIR="$8"
   local INSTANCE_TYPE="$9"
   {
       echo """Your instance details is:-
       AMI_ID="${AMI_ID}"
       KEY_NAME="${NAME}"
       KEY_VALUE="${NAME_VALUE}"
       SUBNET_NAME="${SUBNET}"
       REGION_NAME="${REGION}"
       NUMBER_OF_INSTANCES="${Number_Of_Instances}"
       SECURITY_GROUP_ID="${SECURITY_GROUP_ID}"
       KEYPAIR="${KEYPAIR}"
       INSTANCE_TYPE="${INSTANCE_TYPE}"     
       """
   }
echo "aws ec2 run-instances --image-id ${AMI_ID} --count $Number_Of_Instances  --instance-type ${INSTANCE_TYPE} --key-name ${KEYPAIR} --security-group-ids ${SECURITY_GROUP_ID} --subnet-id ${SUBNET} --region ${REGION}"
aws ec2 run-instances --image-id ${AMI_ID} --count $Number_Of_Instances  --instance-type ${INSTANCE_TYPE} --key-name ${KEYPAIR} --security-group-ids ${SECURITY_GROUP_ID} --subnet-id ${SUBNET} --region ${REGION} > ec2.txt
grep InstanceId ec2.txt | tr -d '", "' > InstanceId
grep KeyName ec2.txt | tr -d '", "' > KeyName
sed -i 's/:/=/g' InstanceId
echo "aws ec2 create-tags --resources ""$"InstanceId" --tags Key=""$"NAME",Value=""$"NAME_VALUE" --region $REGION" >> InstanceId
chmod +x InstanceId
./InstanceId
id=`head -1 InstanceId`
id2=`head -1 KeyName`
echo "$id"
echo "$id2"
echo " Instance is launched"
}
#launch_ec2 $AMI_ID $KEYPAIR $SUBNET $REGION $TAG_KEY $TAG_VALUE $INSTANCE_TYPE $SECURITY_GROUP_ID
launch_ec2 $@
