# Architecture
This network architecture has Route53,cloudfront and S3 set in presentation layer, API Gateway and lambda in Application Layer and RDS in Database layer.

1.Route 53 receives the initial request and routes it to the appropriate CloudFront distribution.
####2.CloudFront acts as a CDN and forwards the request to API Gateway.
####3.API Gateway receives the request and can perform authentication, authorization, and request/response transformations.
####4.API Gateway triggers a Lambda function associated with the endpoint.
####5.Lambda executes the code logic defined in the function, which may include interacting with the RDS database.
6.Lambda returns the response to API Gateway.
7.API Gateway returns the response to CloudFront.
8.CloudFront caches and delivers the response to the client.

This flow allows you to build scalable, serverless architectures in AWS, where incoming requests are routed through multiple services for handling and processing before reaching the desired backend data store, in this case, an RDS database.

<img src="https://user-images.githubusercontent.com/83971386/127896132-06db5721-51ec-4c5f-81ee-6e39d14fa803.png" width="90%"></img>
# Prerequisites
* An AWS Account with an IAM user capable of creating resources – `AdminstratorAccess`
* A locally configured AWS profile for the above IAM user
* Terraform installation - [steps](https://learn.hashicorp.com/tutorials/terraform/install-cli)
* AWS EC2 key pair - [steps](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
* Environment Variables for AWS CLI - [steps](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)
* tfupdate installation - [steps](https://github.com/antonbabenko/pre-commit-terraform#how-to-install)
* tfsec installation - [steps](https://github.com/antonbabenko/pre-commit-terraform#how-to-install)

# How to Apply/Destroy
This section details the deployment and teardown of the three-tier-architecture. **Warning: this will create AWS resources that costs money**

## Deployment Steps

#### 1.	Clone the repo
    git clone https://github.com/BJWRD/three-tier-architecture && cd three-tier-architecture
    
#### 2. Update the s3 bucket name to your own - `versions.tf`

    backend "s3" {
      bucket = "ENTER HERE"
      key    = "terraform.tfstate"
      region = "eu-west-2"
    }
    

#### 3. Update `versions.tf`
    tfupdate terraform versions.tf && tfupdate provider aws versions.tf
    
#### 4. Access the relevant environment 
    cd dev
    
**NOTE:** The environment you choose is dependent on whether you plan to provision resources which are adequate for a `dev/stage/prod` environment.

#### 5.	Initialise the TF directory
    terraform init

#### 5. Ensure the terraform code is formatted and validated 
    terraform fmt && terraform validate

#### 6. `tfsec` - vulnerability check
    tfsec
    
#### 7. Create an execution plan
    terraform plan

#### 8. Execute terraform configuration 
    terraform apply --auto-approve
    
<img width="348" alt="image" src="https://user-images.githubusercontent.com/83971386/218799991-3bd9f750-5984-496a-9c11-2f145622339d.png">


## Verification Steps 

#### 1. Check AWS Infrastructure
Check the infrastructure deployment status, by enter the following terraform command -

     terraform show

<img width="426" alt="image" src="https://user-images.githubusercontent.com/83971386/218800177-9b4fde90-80ca-41ab-aa20-d8a199e104a3.png">

**NOTE:** You may want to ouput `terraform show` to a .txt file for easier viewing i.e. terraform show > tf_infrastructure.txt

Alternatively, log into the AWS Console and verify your AWS infrastructure deployment from there.

#### VPC Verification

<img width="673" alt="image" src="https://user-images.githubusercontent.com/83971386/218800769-18a359e8-78d9-45d7-bdaf-f1a96226a7eb.png">

#### EC2 Verification

<img width="653" alt="image" src="https://user-images.githubusercontent.com/83971386/219601104-31139fe9-2f47-4ad8-8607-77c72126bbe1.png">

####  RDS Verification

<img width="652" alt="image" src="https://user-images.githubusercontent.com/83971386/218801322-bd18927c-e7de-4aa9-bf96-7aa460f13f67.png">

#### 2. Verify bjwrd/app.py webapp is running via Docker 
SSH onto one of the EC2 hosts and verify that the bjwrd/app.py docker container is running -

    docker ps
    
<img width="513" alt="image" src="https://user-images.githubusercontent.com/83971386/219605219-28d1478f-ebcd-4cc5-af4e-5693aea96725.png">

Alternatively, you can retrieve the ALB DNS address and search within your browser.

## Teardown Steps

####  1. Destroy the deployed AWS Infrastructure 
`terraform destroy --auto-approve`

<img width="381" alt="image" src="https://user-images.githubusercontent.com/83971386/219432782-46a8ae1c-6f03-4a7f-89bd-7dac1f79d23e.png">

## Requirements
| Name          | Version       |
| ------------- |:-------------:|
| terraform     | ~>1.3.9       |
| aws           | ~>3.50.0      |

## Providers
| Name          | Version       |
| ------------- |:-------------:|
| aws           | ~>3.50.0      |

## Modules
| Name | Source |
|------|--------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | three-tier-architecture/modules/vpc |
| <a name="module_ec2"></a> [ec2](#module\_ec2) | three-tier-architecture/modules/ec2 |
| <a name="module_rds"></a> [rds](#module\_rds) | three-tier-architecture/modules/rds |

## Resources
| Name          | Type       |
| ------------- |:-------------:|
| [aws_launch_template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_launch_template) | resource |
| [aws_db_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_db_instance) | resource |
| [aws_vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_vpc) | resource |
| [aws_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_subnet) | resource |
| [aws_internet_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_internet_gateway) | resource |
| [aws_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_route_table) | resource |
| [aws_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_route_table_association) | resource |
| [aws_lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_lb) | resource |
| [aws_lb_listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_lb_listener) | resource |
| [aws_lb_target_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_lb_target_group) | resource |
| [aws_autoscaling_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_autoscaling_group) | resource |
| [aws_db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_db_subnet_group) | resource |
| [aws_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_security_group) | resource |
