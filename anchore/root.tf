# Data inputs
data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}

# Instance role with ECR permissions
resource "aws_iam_role" "anchore_ecr_role" {
    name = "anchore_ecr_role"

    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "anchore_ecr_policy" {
    name = "anchore_ecr_policy"
    role = "${aws_iam_role.anchore_ecr_role.id}"

    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ecr:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "anchore_instance_profile" {
    name = "anchore_instance_profile"
    role = "${aws_iam_role.anchore_ecr_role.name}"
}

# AWS instance
resource "aws_instance" "anchore_instance" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_pair_name}"

    user_data = "${file("anchore/user_data.sh")}"

    # Give Anchore access to ECR via EC2 instance profile
    iam_instance_profile = "${aws_iam_instance_profile.anchore_instance_profile.name}"

    security_groups = ["${var.security_group_name}"]

    tags {
        Name = "anchore_instance"
    }
}

output "anchore_instance_public_ip" {
    value = "${aws_instance.anchore_instance.public_ip}"
}
