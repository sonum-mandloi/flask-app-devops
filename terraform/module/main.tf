module "module1" {
    source = "../vpc"
    vpc_cidr = "10.0.0.0/16"
    public_sub_1 = "10.0.1.0/24"
    public_sub_2 = "10.0.2.0/24"
}

module "module2" {
    source = "../securitygroup"
    vpc_id = module.module1.vpc_out

}

module "module3" {
    source = "../instance"
    i_type = "m7i-flex.large"
    i_image = "ami-0150847fe1b89b004"
    key_name = "sydney"
    i_name = "Jenkins-Server"
    sg_id = module.module2.sg_out
    public_subnet_1 = module.module1.public_out_1
    user_data = file("${path.module}/../instance/userdata_jenkins.sh")
}

module "module4" {
    source = "../instance"
    i_type = "m7i-flex.large"
    i_image = "ami-0150847fe1b89b004"
    key_name = "sydney"
    i_name = "sonarqube_server"
    sg_id = module.module2.sg_out
    public_subnet_1 = module.module1.public_out_1
    user_data = file("${path.module}/../instance/userdata_sonar.sh")

}