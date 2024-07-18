provider "aws" {
    region = var.region

}

resource "aws_instance" "example-3" {

    ami = var.ami_id
    instance_type = var.instance_type

    tags = {
        Name = "QA-Instance"
    }
  
}