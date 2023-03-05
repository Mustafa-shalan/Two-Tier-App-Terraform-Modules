resource "aws_db_subnet_group" "default" {
  name       = "db_sub_grp"
  subnet_ids = [aws_subnet.private-subnet["priv-1"].id, aws_subnet.private-subnet["priv-2"].id]
  tags = { 
     Name = "rds_subnet_group"
  }
}

resource "aws_db_instance" "my_db" {
  allocated_storage      = 10
  db_subnet_group_name   = "db_sub_grp"
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  instance_class         = var.db_instance_class
  multi_az               = false
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database_sg.id]
}