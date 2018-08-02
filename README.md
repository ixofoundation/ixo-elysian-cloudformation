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

Note: A prerequisite for the <B>Elysian_Dockerhost_CrossStack</B> template to be
used in the creation of a stack is for a VPC & Subnet to exist with a set of predefined
outputs as done from the <B>Elysian_VPC_Subnet_CrossStack</B> CFN template.

Subsequent to the basic networking <B>Resources</B> being created by the <B>Elysian_VPC_Subnet_CrossStack</B> CFN template
the following <B>Outputs</B> are provided for cross-stack consumption:

```yaml
Outputs:
  VPCId:
    Description: VPC ID
    Value: !Ref VPC
    Export:
      Name: !Sub '${AWS::StackName}-VPCID'
  PublicSubnet:
    Description: The subnet ID to use for public web servers
    Value: !Ref PublicSubnet
    Export:
      Name: !Sub '${AWS::StackName}-SubnetID'
  InstanceSecurityGroup:
    Description: The security group ID to use for public servers
    Value: !GetAtt
      - InstanceSecurityGroup
      - GroupId
    Export:
      Name: !Sub '${AWS::StackName}-SecurityGroupID'
  AvailabilityZone:
    Description: The availability zone to use for volumes
    Value: !GetAtt
      - PublicSubnet
      - AvailabilityZone
    Export:
      Name: !Sub '${AWS::StackName}-AvailabilityZone'
```

## Summary

First create the cross-stack Network stack by means of <B>templates/Elysian_VPC_Subnet_CrossStack.yaml</B>
and then create a Elysian ixo PDS Docker host by means of <B>templates/Elysian_Dockerhost_CrossStack.yaml</B>

This is accomplished by using the <B>templates/Elysian_VPC_Subnet_CrossStack.yaml</B> CFN tempate,
and can happen either by means of the
[AWS CLI](https://aws.amazon.com/cli) or the
[AWS CloudFormation Designer](https://console.aws.amazon.com/cloudformation/designer/home?region=us-east-1)

###  1) Create the cross-stack Network stack

#### [AWS CLI](https://aws.amazon.com/cli)

```bash
$ aws cloudformation create-stack --stack-name Elysian-VPC-Subnet-Stack --template-body file://templates/Elysian_VPC_Subnet_CrossStack.yaml --profile trustlab.cli --region us-east-1
```

#### [AWS CloudFormation Designer](https://console.aws.amazon.com/cloudformation/designer/home?region=us-east-1)


| Region            | HVM AMIs                                                                 |
| ----------------: | ------------------------------------------------------------------------ |
| `us-east-1`       | [![ixo Elysian Stack launch][stack-badge]][us-east-1-hvm-stack-url]      |
| `us-west-1`       | [![ixo Elysian Stack launch][stack-badge]][us-west-1-hvm-stack-url]      |
| `us-west-2`       | [![ixo Elysian Stack launch][stack-badge]][us-west-2-hvm-stack-url]      |
| `eu-west-1`       | [![ixo Elysian Stack launch][stack-badge]][eu-west-1-hvm-stack-url]      |
| `eu-central-1`    | [![ixo Elysian Stack launch][stack-badge]][eu-central-1-hvm-stack-url]   |
| `ap-northeast-1   | [![ixo Elysian Stack launch][stack-badge]][ap-southeast-1-hvm-stack-url] |
| `ap-northeast-2`  | [![ixo Elysian Stack launch][stack-badge]][ap-southeast-2-hvm-stack-url] |
| `ap-southeast-1`  | [![ixo Elysian Stack launch][stack-badge]][sa-east-1-hvm-stack-url]      |
| `ap-southeast-2`  | [![ixo Elysian Stack launch][stack-badge]][ap-southeast-2-hvm-stack-url] |
| `sa-east-1`       | [![ixo Elysian Stack launch][stack-badge]][sa-east-1-hvm-stack-url]      |
| `cn-north-1`      | [![ixo Elysian Stack launch][stack-badge]][cn-north-1-hvm-stack-url]      |

### Parameters

<B>Recommended usage: use these parameters or replace with your own.</B>

#### Elysian-Dockerhost-Instance

| Parameter                   | Default                     | Description                                                                          |
| --------------------------: | --------------------------- | ------------------------------------------------------------------------------------ |
| `NetworkStackName`          | `Elysian-VPC-Subnet-Stack`  | Name of an active CloudFormation stack that contains the networking resources, such as the subnet and security group, that will be used in this stack. |
| `KeyName`                   | `ixoworld.xyz`              | Name of an existing EC2 KeyPair to enable SSH access to the instance.                |
| `InstanceType`              | `t2.small`                  | TWebServer EC2 instance type.                                                        |


### Instructions:

1. **Initial Setup**:

    Create the required key pair to access Elysium instance. If you providing your own DB instances, make sure its accessible by Kong instances.
    If you want to create instances in existing VPC, VPC need to have two public subnet and all required ports open to allow access to Kong Load balancer.

    *Continue to next step if you want to use an existing key pair*

3. **Choose a Region & VM Type**:

    Choose the region closest to your API servers, and pick the virtualization type you'd like from the list of available [templates](#templates) above.

    You should land on AWS Cloud Formation *"Select Template"* page

4. **Parameters**:

    Fill in all the parameters details. If you chose to launch Kong with Cassandra/Postgres you would be asked to fill in extra parameters to create a Cassandra cluster or Postgres RDS instance.
    check the description of each field and provide appropriate values.

    **Note**: *consult the [parameters table](#parameters) for detailed description of parameters*

5. **Option page**:

    Add Tags and other fields according to your requirements.  

    **Note:** *The template is configured to add a "Name" tag to each relevant resource*

6. **Grab a Coffee!**:

    It will take several minutes *(~20 minutes)* to create the stack. Once the stack has a status of `CREATE_COMPLETE`, click on *"Output"* tab to get the proxy and Admin URL, it may take *60 seconds* more for links to become active.

    **Note**: *To monitor the progress go to AWS CloudFormation console, select the stack in the list. In the stack details pane, click the "Events" tab to see the progress.*

7. **Use ixo Elysian:**

    Quickly learn how to use Kong with the [5-minute Quickstart](https://getkong.org/docs/latest/getting-started/quickstart/).

#### Important Note

1. The security configuration on the templates opens up all externally accessible ports to incoming traffic from any IP address if default is chosen *(`0.0.0.0/0`)*
2. The security risk is high. If you desire a more secure configuration, please update
3. The template installs many resources on AWS. You will be billed just for the AWS resources used
4. Some of the instance types may not be supported in all the AWS Regions or Availablity Zones, so choose next best available option


[ixo-logo]: https://ixo.foundation/wp-content/uploads/2018/01/ixo-Cyan@2x.png
[website-url]: https://ixo.foundation

[us-east-1-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[us-west-1-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=us-west-1#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[us-west-2-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[eu-west-1-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[ap-northeast-1-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=ap-northeast-1#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[ap-southeast-1-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-1#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[ap-southeast-2-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-2#/stacks/new?stackName=kong-elb-hvm&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template
[sa-east-1-hvm-stack-url]: https://console.aws.amazon.com/cloudformation/home?region=sa-east-1#/stacks/new?stackName=kong-elb-pv&templateURL=https:%2F%2Fs3.amazonaws.com%2Fkong-cf-templates%2Flatest%2Fkong-elb-cassandra-user-vpc-optional-hvm.template

[stack-badge]: https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png
