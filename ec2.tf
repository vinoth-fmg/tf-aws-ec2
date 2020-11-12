# Our default security group to access
# the instances over HTTP
resource "aws_security_group" "aws_sg_devops" {
  name        = "aws-sg-devopsdemo"
  description = "Http access Globally"
  vpc_id      = "vpc-0eeac674"

 # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "aws_instance_devops" {
  instance_type = var.instancetype
  ami           = var.imageid 
  count = var.instancecount
  subnet_id = var.subnetid
  
  #Keyname
  key_name = "jenkins-devops"
  
  # Our Security group to allow HTTP access
  vpc_security_group_ids = [aws_security_group.aws_sg_devops.id]
  
  # User data which installs and Configures nginx webserver
  user_data = file("userdata.sh")
  
  tags = {
    Name = "DEVOPS-DEMO-EC2-${count.index}"
  }
}
