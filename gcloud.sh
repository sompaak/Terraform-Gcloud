#!/bin/bash



#Uses image to run terraform
gcloud builds submit --config terraform.yaml

# Executes a kubectl command from kubectl builder
gcloud builds submit --config kubectl.yaml

# Executes a bash script
gcloud builds submit --config bash.yaml

