#!/bin/bash -xe

SCRIPTS_DIR=`dirname $0`
source "$SCRIPTS_DIR/isolate-arguments.sh"

echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "STACK_SUFFIX: $STACK_SUFFIX"
echo "TARGET_REGION: $TARGET_REGION"

aws cloudformation create-stack --stack-name Elysian-Additional-Host-To-Network-Stack$STACK_SUFFIX --template-body file://templates/ElysianAdditionalHostToNetworkStack.yaml  --parameters file://parameters/ElysianAdditionalHostToNetworkStack.parameters.json --profile trustlab.cli --region $TARGET_REGION
