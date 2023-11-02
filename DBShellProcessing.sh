#!/bin/sh
echo "Starting the run"
export secret_id=arn:aws:secretsmanager:us-east-1:929556976395:secret:CdkCreateDbStackdavidDBSecr-MdO86qUN97v4-puZdZu


export theUser="$(aws secretsmanager get-secret-value --secret-id $secret_id | jq -r .SecretString | jq -r .username)"
export password="$(aws secretsmanager get-secret-value --secret-id $secret_id | jq -r .SecretString | jq -r .password)"
export hostName="$(aws secretsmanager get-secret-value --secret-id $secret_id | jq -r .SecretString | jq -r .host)"
export port="$(aws secretsmanager get-secret-value --secret-id $secret_id | jq -r .SecretString | jq -r .port)"

PGPASSWORD=$password psql --host=$hostName --port=$port --username=$theUser --dbname=postgres -c 'CREATE DATABASE "webfocus-eda";'

echo "ending the run"
