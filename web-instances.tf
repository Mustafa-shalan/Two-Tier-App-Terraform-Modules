resource "aws_instance" "ec2_1" {
for_each = aws_subnet.main-subnet 
   subnet_id      = each.value.id
   ami                     = var.ec2_instance_ami
   instance_type           = var.ec2_instance_type
   availability_zone       = each.value.availability_zone
   vpc_security_group_ids  = [aws_security_group.webserver_sg.id] 
   user_data               = <<EOF
       #!/bin/bash
       yum update -y
       yum install -y httpd
       systemctl start httpd
       systemctl enable httpd
       echo -e '<html>\n<html>\n\t<body>\n\t\t<h1>Welcome To My Website!</h1>\n\t</body>\n</html>' > /var/www/html/index.html
       EOF

   tags = {
      Name = "mustafa_instance"
  }
}

resource  "aws_eip" "my-eip"{
    vpc = true
}
resource "aws_eip_association" "associate"{
for_each = aws_instance.ec2_1
    instance_id=each.value.id
    allocation_id=aws_eip.my-eip.id
} 