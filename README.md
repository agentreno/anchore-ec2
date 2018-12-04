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
