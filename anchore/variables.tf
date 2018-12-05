variable "instance_type" {
    type = "string"
    default = "t2.large"
}

variable "key_pair_name" {
    type = "string"
}

variable "security_group_name" {
    type = "string"
    default = "launch-wizard-15"
}
