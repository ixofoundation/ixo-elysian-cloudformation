#!/bin/bash

aws cloudformation create-stack --stack-name Elysian-Dockerhost-Instance --template-body file://templates/Elysian_Dockerhost_CrossStack.yaml  --parameters file://parameters/Elysian_Dockerhost_CrossStack.parameters.json --profile trustlab.cli --region us-east-1
