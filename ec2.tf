resource "aws_instance" "aws_instance_devops" {
  instance_type = "t2.micro"
 // ami           = "ami-0083662ba17882949"
  ami           = "IMGID" 

  # This will create 4 instances
  count = 2
}
