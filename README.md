# karl-anchore

## Description

Example project to set up Anchore container vulnerability scanner on an EC2
instance as part of the CISO PSO Hackathon

## Building

Ensure you have an EC2 key pair set up in advance, and a valid AWS credentials
file with default profile.

First time only run `terraform init`.

Run `terraform plan` and `terraform apply`, supplying any variables (like key
pair name) as needed.

## Using Anchore

Anchore have some great documentation at:
https://anchore.freshdesk.com/support/solutions

Particularly the policy gates that can be used to assess containers:
https://anchore.freshdesk.com/support/solutions/articles/36000073896-anchore-policy-checks

Interact with the Anchore service once it is running, by opening up port 8228
and using anchore-cli. The vulnerability databases take an hour or two to
populate. It is often easier to use the CLI container like so:

```
docker run -it -e ANCHORE_CLI_URL=http://<EC2 public IP>:8228/v1/ anchore/engine-cli anchore-cli system feeds list
```

TODO: Show how to integrate with a CI/CD pipeline.
