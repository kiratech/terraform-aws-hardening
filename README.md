# terraform-aws-hardening

This repository contains a Terraform module providing a secure baseline for a newly created [Amazon Web Services](https://aws.amazon.com) account. AWS accounts default settings are more oriented towards easiness of use rather than applying the recommended secure best practices. `terraform-aws-hardening` is implemented as a set of Terraform configurations applying the best practices to all AWS regions.

**Make sure to use it only on accounts not containing any user-created resource (servers, databases, VPCs, etc.) as it has been tested only on newly created accounts**

The tool is heavily inspired by the [AWS Benchmarks - CIS Amazon Web Services Foundations v1.2.0](https://d0.awsstatic.com/whitepapers/compliance/AWS_CIS_Foundations_Benchmark.pdf) and by the automated tool [CloudSploit](https://cloudsploit.com/). However, this tool does not guarantee a full compliance for an existing account: it operates only on newly created accounts by providing saner defaults. Again: do not use it on accounts that are not brand new (i.e., not containing user-created objects or data).

As today, applying this tool gets you a 100% green score on CloudSploit for a newly created AWS account.

## Features
This is the list of features provided by this module. When applicable, the relevant CIS Benchmark section is provided. Some of the features are not included in the [AWS free tier](https://aws.amazon.com/free/).

* Identity and Access Management
    * Ensure credentials unused for 90 days or greater are disabled (`CIS 1.3`)
    * Ensure IAM password policy requires at least one uppercase letter (`CIS 1.5`)
    * Ensure IAM password policy require at least one lowercase letter (`CIS 1.6`)
    * Ensure IAM password policy require at least one symbol (`CIS 1.7`)
    * Ensure IAM password policy require at least one number (`CIS 1.8`)
    * Ensure IAM password policy requires minimum length of 14 or greater (`CIS 1.9`)
    * Ensure IAM password policy prevents password reuse (`CIS 1.10`)
    * Ensure IAM password policy expires passwords within 90 days or less (`CIS 1.11`)
* Logging
    * Ensure CloudTrail is enabled in all regions (`CIS 2.1`)
    * Ensure CloudTrail log file validation is enabled (`CIS 2.2`)
    * Ensure the S3 bucket CloudTrail logs to is not publicly accessible (`CIS 2.3`)
    * Ensure CloudTrail trails are integrated with CloudWatch Logs (`CIS 2.4`)
    * Ensure AWS Config is enabled in all regions (`CIS 2.5`)
    * Ensure S3 bucket access logging is enabled on the CloudTrail S3 bucket (`CIS 2.6`)
    * Ensure CloudTrail logs are encrypted at rest using KMS CMKs (`CIS 2.7`)
    * Ensure rotation for customer created CMKs is enabled (`CIS 2.8`)
    * Ensure VPC flow logging is enabled in all VPCs (`CIS 2.9`) *Only for the default VPC on each supported region*
* Networking
    * Ensure the default security group of every VPC restricts all traffic (`CIS 4.3`) *Only for the default VPC on each supported region*

## How it works

### Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 0.11

### Usage
Copy and paste into your Terraform configuration, and run `terraform init`:
```
module "aws-hardening" {
  source = "github.com/kiratech/terraform-aws-hardening"
}
```

## Contributing
Contributions are very welcome! Check out the [Guidelines](CONTRIBUTING.md) for instructions.

## License
This project is licensed under the terms of the **MIT** license. Check out the full license [here](LICENSE).
