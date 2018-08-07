#!/bin/bash

aws cloudformation create-stack --stack-name Elysian-Proxied-Network-Stack --template-body file://templates/ElysianProxiedNetworkStack.yaml --profile trustlab.cli --region us-east-1
