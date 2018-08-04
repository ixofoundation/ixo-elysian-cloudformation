#!/bin/bash

aws cloudformation create-stack --stack-name Simple-Web-Stack --template-body file://templates/Simple-Web-Stack.yaml --profile trustlab.cli --region us-east-1
