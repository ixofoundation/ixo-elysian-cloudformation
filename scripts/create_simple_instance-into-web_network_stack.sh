#!/bin/bash

aws cloudformation create-stack --stack-name Simple-Web-Instance-Stack --template-body file://templates/Simple-Instance-into-Web-Network-Stack.yaml --profile trustlab.cli --region us-east-1
