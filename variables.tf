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

variable "count" {
  default     = "COUNT"
  description = "No of Instances to be spinned up"
}
