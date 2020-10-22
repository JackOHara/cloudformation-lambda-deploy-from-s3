#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -s|--stack-name)
    STACK_NAME="$2"
    shift
    shift
    ;;
    -b|--bucket-name)
    BUCKET_NAME="$2"
    shift
    shift
    ;;
    *)
    POSITIONAL+=("$1")
    shift
    ;;
esac
done
set -- "${POSITIONAL[@]}"

aws cloudformation create-stack --stack-name $STACK_NAME --template-body file://bucket.yaml  --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=BucketName,ParameterValue=$BUCKET_NAME
aws cloudformation wait stack-create-complete --stack-name $STACK_NAME

./deploy-lambda-to-bucket.sh  --name ExampleFunction --location example-lambda --bucket-name $BUCKET_NAME

aws cloudformation update-stack --stack-name $STACK_NAME --template-body file://lambda.yaml  --capabilities CAPABILITY_IAM \
    --parameters ParameterKey=BucketName,ParameterValue=$BUCKET_NAME
aws cloudformation wait stack-update-complete --stack-name $STACK_NAME
