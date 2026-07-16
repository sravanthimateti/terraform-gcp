## Terraform Resource Block
### Example: Terraform resource blocks for VPC and subnet creation

**vpc.tf**

```hcl
# Cretae VPC resource
resource "google_compute_network" "vpc1" {
  # arguments
  name = "flipkart10-vpc"
  # auto or custom vpc
  auto_create_subnetworks = false 
}

#Create subnet
resource "google_compute_subnetwork" "subnet1" {
  # implicit dependency
  name = "flipkart10-subnet1"
  network =  google_compute_network.vpc1.id
  ip_cidr_range = "10.5.0.0/16"
  region = "us-central1"   
}

```
provider.tf

```hcl
provider "google" {
  project = "flipkart10-prod"
  region = "us-central1"
  credentials = file("key.json")
  
}
```

