resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "allow inbound traffic"
  vpc_id      = aws_vpc.main-vpc.id
  ingress {
     from_port       = 80
     to_port         = 80
     protocol        = "tcp"
     cidr_blocks = ["0.0.0.0/0"]    
     }
  ingress {
     from_port       = 443
     to_port         = 443
     protocol        = "tcp"
     cidr_blocks = ["0.0.0.0/0"]    
  }

  egress {
     from_port = "0"
     to_port   = "0"
     protocol  = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     name = "webserver_sg"
  }
}

resource "aws_security_group" "database_sg" {
  name        = "database_sg"
  description = "allow inbound traffic from ALB"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
     from_port   = 3306
     to_port     = 3306
     protocol    = "tcp"
  }

  egress {
     from_port = "0"
     to_port   = "0"
     protocol  = "-1"
     cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
     name = "database_sg"
  }
}