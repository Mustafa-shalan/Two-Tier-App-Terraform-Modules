
#Creating a new vpc

resource "aws_vpc" "main-vpc" {
  cidr_block = var.vpc-cidr

  tags = {
    Name = var.tag_name
  }
}

#Creating a new public subnet that my web instance will be attached to

resource "aws_subnet" "main-subnet" {
  for_each = var.prefix
 
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.basename}-subnet-${each.key}"
  }
} 

#Creating two new private subnets that my db_instance will be attached to

resource "aws_subnet" "private-subnet"{
  for_each = var.prefix1
 
  availability_zone_id = each.value["az"]
  cidr_block = each.value["cidr"]
  vpc_id     = aws_vpc.main-vpc.id

  tags = {
    Name = "${var.basename}-subnet-${each.key}"
     }
}

# creating internet gateway 
resource "aws_internet_gateway" "igw" {
   vpc_id = aws_vpc.main-vpc.id

   tags = {
      name = "igw"
   }
}

# creating route table
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

# associate route table to the public subnet 
resource "aws_route_table_association" "public_rt1" {
  
for_each = aws_subnet.main-subnet 
   subnet_id      = each.value.id
   route_table_id = aws_route_table.rt.id
}

# associate route table to the private subnet 
resource "aws_route_table_association" "private_rt" {
for_each = aws_subnet.private-subnet 
   subnet_id      = each.value.id
   route_table_id = aws_route_table.rt.id
}