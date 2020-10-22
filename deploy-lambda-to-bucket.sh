#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -l|--location)
    LOCATION="$2"
    shift
    shift
    ;;
    -b|--bucket-name)
    BUCKET_NAME="$2"
    shift
    shift
    ;;
    -n|--name)
    NAME="$2"
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

cd $LOCATION
rm -rf node_modules
npm install --only=prod
zip -r function.zip .
aws s3 cp function.zip s3://$BUCKET_NAME/functions/$NAME/function.zip
rm function.zip
