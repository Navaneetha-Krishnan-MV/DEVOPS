#!/bin/bash


#################
# Author: Navaneethakrishnan
# Date: 24th-Dec
#
# versio: v1
#
# This script will report AWS resource usage
#################

set -x

# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM Users

# list s3 buckets
echo "List of s3 Buckets"
aws s3 ls > ResourceTracker

# list EC2 Instances
echo "List of EC2"
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' >> ResourceTracker

# list lambda
echo "List of Lambda-function"
aws lambda list-functions 

# list IAM users
echo "List of iam users "
aws iam list-users

