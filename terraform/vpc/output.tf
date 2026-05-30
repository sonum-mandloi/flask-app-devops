output "vpc_out" {
     value = aws_vpc.devops_vpc.id  
}

output "public_out_1" {
  value = aws_subnet.public_subnet_1.id
}

output "public_out_2" {
  value = aws_subnet.public_subnet_2.id
}