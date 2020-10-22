# Pure Cloudformation Lambda deployment using S3 .zips and S3 triggers
 This allows you to deploy Lambda's via zip to an S3 bucket and use Cloudformation to control your resources. I ran into quite a lot of issues with circular dependencies while trying to deploy lambdas using pure cloudformation so I thought I'd share. 

AWS has recommended their own way of doing this [here](https://aws.amazon.com/blogs/mt/resolving-circular-dependency-in-provisioning-of-amazon-s3-buckets-with-aws-lambda-event-notifications/). Although this doesn't handle the bucket needing to be created initially and it's a bit more complicated than it needs to be.

## Usage
Initial creation of stack
```./create-stack.sh --stack-name lambda-deploy-demo --bucket-name lambda-deploy-demo-johara```

Update the existing stack
```./update-stack.sh --stack-name lambda-deploy-demo```