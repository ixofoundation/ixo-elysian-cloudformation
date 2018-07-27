#!/bin/bash

aws cloudformation create-stack --stack-name Elysian-VPC-Subnet-Stack --template-body file://templates/Elysian_VPC_Subnet_CrossStack.yaml --profile trustlab.cli --region us-east-1
