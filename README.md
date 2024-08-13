# E-Commerce Flash Sale Platform

## Introduction
This project sets up an e-commerce flash sale platform using AWS services. It includes a microservices architecture for user management, order processing, inventory management, and product cataloguing.

## Instructions

### Prerequisites
- Terraform installed.
- AWS CLI installed and configured with appropriate permissions.
- S3 bucket (in this case, "ecommerce-flash-sale-platform-terraform-state-bucket") and DynamoDB table (in this case, named "terraform-locks" with "LockID" as a string for the partition key) defined for Terraform state.

### Setup and Deployment
1. Clone the repository.
2. Navigate to the project directory.
3. Initialize Terraform:
terraform init
4. Apply the Terraform configuration:
terraform apply
5. When deployment is successful, tear down the stack:
terraform destroy

### Dependencies
- AWS provider
- Terraform 1.0 or higher

### Other Relevant Information
Architectural decisions:
- Lambdas are used extensively here. This design pattern has a higher AWS cost, but with such a small team, it reduces labor costs required to manage the infrastructure and shifts responsibility for patching/security updates over to AWS.

Known issues:
- Currently still has monolithic characteristics due to Lambdas bein dependent on other microservices, if one goes down, the service as a whole is interrupted. Implementing retries and circuit-breakers in the Lambdas, or using services such as EventBridge or SQS can be implemented to mitigate this.

Future Enhancements:
- Microservices should live in separate accounts and communicate via API Gateway
- Centralized monitoring account
- Centralized deployment account and each microservice is put into a stack set
- Switching to Aurora over RDS to not need to worry about reads/writes or auto-scaling configuration, at a higher cost
- Putting StepFunctions in front of the Lambdas to add resilience and manage coordination across multiple microservices
- API Gateway throttling and caching can be implemented to further reduce the burden of sudden usage spikes on the infrastructure
- AWS Organizations, SCPs, and VPC peering can be implemented after migrating microservices to separate accounts


## AWS Certification
Michael Cheung
AWS Certification: [Verification link](https://cp.certmetrics.com/amazon/en/public/verify/credential/M1GMGM72HMEEQRS1)  