# Architecture
This network architecture has Route53,cloudfront and S3 set in presentation layer, API Gateway and lambda in Application Layer and RDS in Database layer.



# Summary of Flow

* Route 53 receives the initial request and routes it to the appropriate CloudFront distribution.
* CloudFront acts as a CDN and forwards the request to API Gateway.
* API Gateway receives the request and can perform authentication, authorization, and request/response transformations.
* API Gateway triggers a Lambda function associated with the endpoint.
* Lambda executes the code logic defined in the function, which may include interacting with the RDS database.
* Lambda returns the response to API Gateway.
* API Gateway returns the response to CloudFront.
* CloudFront caches and delivers the response to the client.

This flow allows you to build scalable, serverless architectures in AWS, where incoming requests are routed through multiple services for handling and processing before reaching the desired backend data store, in this case, an RDS database.

<img src="https://user-images.githubusercontent.com/83971386/127896132-06db5721-51ec-4c5f-81ee-6e39d14fa803.png" width="90%"></img>

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
| <a name="api_gateway"></a> [vpc](#module\_api_gateway) | 3-tier-application/api_gateway |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | 3-tier-application/cloudfront |
| <a name="module_rds"></a> [rds](#module\_rds) | 3-tier-application/rds |
| <a name="module_rds"></a> [rds](#module\_rds) | 3-tier-application/rds |

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
