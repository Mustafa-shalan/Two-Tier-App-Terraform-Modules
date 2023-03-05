resource "aws_vpc" "custom_vpc" {
   cidr_block       = var.vpc_cidr

   tags = {
      name = "custom_vpc"
   }
}


resource "aws_subnet" "public_subnet1" {   
   vpc_id            = aws_vpc.custom_vpc.id
   cidr_block        = var.public_subnet1
   availability_zone = var.az1

   tags = {
      name = "public_subnet1"
   }
}

resource "aws_subnet" "private_subnet1" {   
   vpc_id            = aws_vpc.custom_vpc.id
   cidr_block        = var.private_subnet1
   availability_zone = var.az1

   tags = {
      name = "private_subnet1"
   }
}


resource "aws_subnet" "private_subnet2" {   
   vpc_id            = aws_vpc.custom_vpc.id
   cidr_block        = var.private_subnet2
   availability_zone = var.az2

   tags = {
      name = "private_subnet2"
   }
}


resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.custom_vpc.id

   tags = {
      name = "igw"
   }
}


resource "aws_route_table" "rt" {
   vpc_id = aws_vpc.custom_vpc.id
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      name = "rt"
  }
}

resource "aws_route_table_association" "public_rt1" {
   subnet_id      = aws_subnet.public_subnet1.id
   route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "private_rt1" {
   subnet_id      = aws_subnet.private_subnet1.id
   route_table_id = aws_route_table.rt.id
}


resource "aws_route_table_association" "private_rt2" {
   subnet_id      = aws_subnet.private_subnet2.id
   route_table_id = aws_route_table.rt.id
}

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = var.tag_name
  }
}


resource "aws_subnet" "main-subnet" {
  for_each = var.prefix
 
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.basename}-subnet-${each.key}"
  }
} 


resource "aws_subnet" "private-subnet"{
  for_each = var.prefix1
 
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.basename}-subnet-${each.key}"
     }
}

resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main-vpc.id

   tags = {
      name = "igw"
   }
}

resource "aws_route_table" "rt" {
   vpc_id = aws_vpc.main-vpc.id
   route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      name = "rt"
  }
}

resource "aws_route_table_association" "public_rt1" {
  
for_each = aws_subnet.main-subnet 
   subnet_id      = each.value.id
   route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "private_rt" {
for_each = aws_subnet.private-subnet 
   subnet_id      = each.value.id
   route_table_id = aws_route_table.rt.id
}