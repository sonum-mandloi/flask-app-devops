resource "aws_instance" "jenkins_server" {
  ami           = var.i_image
  instance_type = var.i_type
  key_name      = var.key_name

  subnet_id              = var.public_subnet_1
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = var.i_name
  }

user_data = var.user_data
}