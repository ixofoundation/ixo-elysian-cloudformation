#!/bin/bash

aws cloudformation create-stack --stack-name Elysian-Networking-Stack --template-body file://templates/Elysian-Networking-Stack.yaml --profile trustlab.cli --region us-east-1
