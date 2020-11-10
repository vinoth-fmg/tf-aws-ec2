variable "region" {
  default     = "REGION"
  description = "AWS region"
}

variable "imageid" {
  default     = "IMGID"
  description = "AMI ID"
}

variable "instancetype" {
  default     = "INSTANCETYPE"
  description = "Instance Type"
}

variable "instancecount" {
  default     = "CNT"
  description = "No of Instances to be spinned up"
}
