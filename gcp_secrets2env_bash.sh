#!/bin/bash

ENV_FILEPATH=".env"

# Clean .env file
rm $ENV_FILEPATH

gcloud secrets list | sed 1d | awk '{print $1}' | while read VAR_NAME
do
    VAR_VALUE=$(gcloud secrets versions access latest --secret="$VAR_NAME")
    if [ $VAR_VALUE ]
    then
        echo "$VAR_NAME=$VAR_VALUE" >> $ENV_FILEPATH
    fi
done