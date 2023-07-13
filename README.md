# 3-Tier-Architecture
This network architecture has Route53,cloudfront and S3 set in PRESENTATION LAYER, API Gateway and lambda in APPLICATION LAYER and RDS in DATABASE LAYER.

![3-tierenv](https://github.com/Aparna-Rath/3-TierApplication/assets/139382097/e62a244a-fd81-4829-ae3f-8a4b11e07947)


# Walk through the flow of request

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
| <a name="api_gateway"></a> [api_gateway](#module\_api_gateway) | 3-tier-application/api_gateway |
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | 3-tier-application/cloudfront |
| <a name="module_rds"></a> [rds](#module\_rds) | 3-tier-application/rds |
| <a name="module_lambdas"></a> [lambdas](#module\_lambdas) | 3-tier-application/lambdas |
| <a name="module_route53"></a> [route53](#module\_route53) | 3-tier-application/route53 |

