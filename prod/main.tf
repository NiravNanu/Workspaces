provider "aws" {
    region = var.region

}

resource "aws_instance" "example-2" {

    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "Prod-Instance"
    }
  
}