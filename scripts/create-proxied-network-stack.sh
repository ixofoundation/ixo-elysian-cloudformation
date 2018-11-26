#!/bin/sh

SCRIPTS_DIR=`dirname $0`
source "$SCRIPTS_DIR/isolate-arguments.sh"

echo "SCRIPTS_DIR: $SCRIPTS_DIR"
echo "STACK_SUFFIX: $STACK_SUFFIX"
echo "TARGET_ENVIRONMENT: $TARGET_ENVIRONMENT"
echo "IMAGE_TAG: $IMAGE_TAG"
echo "TARGET_REGION: $TARGET_REGION"
echo "CERT_ARN: $CERT_ARN"

sed -i '' "s|%%TargetEnvironment%%|$TARGET_ENVIRONMENT|" "$SCRIPTS_DIR/../parameters/ElysianProxiedNetworkStack.parameters.json"
sed -i '' "s|%%ImageTag%%|$IMAGE_TAG|" "$SCRIPTS_DIR/../parameters/ElysianProxiedNetworkStack.parameters.json"
sed -i '' "s|%%CertARN%%|$CERT_ARN|" "$SCRIPTS_DIR/../parameters/ElysianProxiedNetworkStack.parameters.json"

aws cloudformation create-stack --stack-name Elysian-ELB-Proxy-Network-Stack$STACK_SUFFIX --template-body file://templates/ElysianProxiedNetworkStack.yaml  --parameters file://parameters/ElysianProxiedNetworkStack.parameters.json --profile default --region $TARGET_REGION

git checkout "$SCRIPTS_DIR/../parameters/ElysianProxiedNetworkStack.parameters.json"
