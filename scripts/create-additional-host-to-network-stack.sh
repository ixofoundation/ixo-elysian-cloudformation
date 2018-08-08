#!/bin/bash -xe

STACK_SUFFIX="-$1"
if [ "$#" -ne 1 ]; then
    STACK_SUFFIX=""
fi

aws cloudformation create-stack --stack-name Elysian-Additional-Host-To-Network-Stack$STACK_SUFFIX --template-body file://templates/ElysianAdditionalHostToNetworkStack.yaml  --parameters file://parameters/ElysianAdditionalHostToNetworkStack.parameters.json --profile trustlab.cli --region us-east-1
