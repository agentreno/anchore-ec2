module "anchore" {
    source = "anchore"
}

output "anchore_instance_public_ip" {
    value = "${module.anchore.anchore_instance_public_ip}"
}
