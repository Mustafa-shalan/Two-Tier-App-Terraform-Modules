variable "tag_name" {
   default = "mustafa-vpc"
}

variable "vpc-cidr" {
   default = "192.168.0.0/16"
}

variable "basename" {
   description = "Prefix used for all resources names"
   default = "mustafa"
}

variable "prefix" {
   type = map
   default = {
      pub-1 = {
         az = "usw2-az1"
         cidr = "192.168.1.0/24"
      }
      
      }
   }
variable "prefix1" {
   type = map
   default = {
    priv-1 = {
         az = "usw2-az2"
         cidr = "192.168.2.0/24"
      }
    priv-2 = {
         az = "usw2-az3"
         cidr = "192.168.3.0/24"
        }
      
      }
   }
variable "ec2_instance_ami" {
  description = "ec2 instance image id"
  type        = string
  default     = "ami-0b029b1931b347543"
}


variable "ec2_instance_type" {
  description = "ec2 instance type"
  type        = string
  default     = "t2.micro"
}


variable "db_engine" {
  description = "db engine"
  type        = string
  default     = "mysql"
}


variable "db_engine_version" {
  description = "db engine version"
  type        = string
  default     = "5.7"
}


variable "db_name" {
  description = "db name"
  type        = string
  default     = "my_db"
}


variable "db_instance_class" {
  description = "db instance class"
  type        = string
  default     = "db.t2.micro"
}


variable "db_username" {
  description = "database admin username"
  type        = string
  sensitive   = true
  default = "mustafa"
}


variable "db_password" {
  description = "database admin password"
  type        = string
  sensitive   = true
  default = "mushalan1"
}
