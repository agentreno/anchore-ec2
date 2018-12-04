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

# AWS instance
resource "aws_instance" "anchore_instance" {
    ami = "${data.aws_ami.ubuntu.id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_pair_name}"

    tags {
        Name = "anchore_instance"
    }
}
