resource "aws_instance" "aws_instance_devops" {
  instance_type = var.instancetype
  ami           = var.imageid 
  count = var.instancecount
  subnet_id = var.subnetid
  
  tags = {
    Name = "DEVOPS-DEMO-EC2-count.index"
  }
}
