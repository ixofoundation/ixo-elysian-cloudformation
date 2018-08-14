# [ixo Elysian][website-url] :heavy_plus_sign: [AWS CloudFormation](https://aws.amazon.com/cloudformation/)

[Foundation][website-url]
|
[Elysian Source](https://github.com/ixofoundation/ixo-pds)
|
[White Paper](https://medium.com/ixo-blog/elysian-release-7279ee9c49bc)
|
[Blog](https://medium.com/ixo-blog)

[![][ixo-logo]][website-url]

These CloudFormation templates help you model and set up Elysian's
resources in AWS easily.

## Quickstart

###  [AWS CloudFormation Designer](https://console.aws.amazon.com/cloudformation/designer/home)

In order to host a Elysian instance at least a single Elysian Personal Data Store fronted by a proxy is required.

This can be accomplished using the <B>ElysianProxiedNetworkStack.yaml</B> CFN template.

| Region            | HVM AMIs                                                                                 |
| ----------------: | ---------------------------------------------------------------------------------------- |
| `us-east-1`       | [![ixo Elysian Stack launch][stack-badge]][us-east-1-CREATE-ElysianProxiedNetworkStack-with-S3-url]      |

The resulting stack:
![][ElysianProxiedNetworkStack-diagram-S3-url]

Note: If additional Elysian Personal Data Store instances are desired use the <B>ElysianAdditionalHostToNetworkStack.yaml</B> CFN template.
NB: Attempting to use this template without first creating a stack by means of the <B>ElysianProxiedNetworkStack.yaml</B> CFN template and referencing it by means of the NetworkStackName parameter will result in FAILURE.

| Region            | HVM AMIs                                                                                 |
| ----------------: | ---------------------------------------------------------------------------------------- |
| `us-east-1`       | [![Elysian-Dockerhost-Instance Stack launch][stack-badge]][us-east-1-CREATE-ElysianAdditionalHostToNetworkStack-WITH-S3-url]      |

The resulting stack (will re-use infrastructure from previously created stack):
![][ElysianAdditionalHostToNetworkStack-diagram-S3-url]


###  [AWS CLI](https://aws.amazon.com/cli)

Alternatively the AWS cli can be used to create stacks with the provided templates. For insight into how this can be accomplished refer to the contents of the scripts directory.

```bash
aws cloudformation create-stack --stack-name Elysian-Proxied-Network-Stack --template-body file://templates/ElysianProxiedNetworkStack.yaml  --parameters file://parameters/ElysianProxiedNetworkStack.parameters.json --profile your.previously-configured-cli-profile --region us-east-1
```

[ixo-logo]: https://ixo.foundation/wp-content/uploads/2018/01/ixo-Cyan@2x.png

[website-url]: https://ixo.foundation

[ElysianProxiedNetworkStack-diagram-S3-url]: https://s3.amazonaws.com/ixo-elysian-cfn-templates/ElysianProxiedNetworkStack-diagram.png

[us-east-1-CREATE-ElysianProxiedNetworkStack-with-S3-url]: https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=Elysian-Proxied-Network-Stack&templateURL=https://s3.amazonaws.com/ixo-elysian-cfn-templates/ElysianProxiedNetworkStack.yaml

[ElysianAdditionalHostToNetworkStack-diagram-S3-url]: https://s3.amazonaws.com/ixo-elysian-cfn-templates/Additional-Host-To-Network-Stack-diagram.png

[us-east-1-CREATE-ElysianAdditionalHostToNetworkStack-WITH-S3-url]: https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=Elysian-Additional-Host-To-Network-Stack&templateURL=https://s3.amazonaws.com/ixo-elysian-cfn-templates/ElysianAdditionalHostToNetworkStack.yaml

[stack-badge]: https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png
