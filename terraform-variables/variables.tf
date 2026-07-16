variable "region" {
  description = "this is region in gcp"
  type = string
  default = "us-central1"  
}

variable "project_id" {
  description = "project id of gcp"
  type = string
  default = "flipkart10-prod"  
}

variable "zone" {
  description = "zone in which VM should be created"
  type = string
  default = "us-central1-a"  
}

variable "machine_type" {
  description = "machine type of VM"
  type = string
  default = "e2-small"  
}
