#!/bin/bash

aws cloudformation create-stack --stack-name Elysian-ALB-Stack --template-body file://templates/Elysian-ALB-Stack.yaml --profile trustlab.cli --region us-east-1
