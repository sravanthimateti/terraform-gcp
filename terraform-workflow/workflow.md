## Terraform Workflow
### Create a custom VPC


**main.tf**
```hcl
provider "google" {
  project = "flipkart10-prod"
  region = "us-central1"
  credentials = file("key.json")
}

# create a vpc
resource "google_compute_network" "vpc1" {
    name = "my-terraform-vpc"
    auto_create_subnetworks = false
   
}

```

### Create a VM


**gce.tf**
```hcl
# terraform code for vm creation

# This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "demovm-1" {
  boot_disk {
    auto_delete = true
    device_name = "demovm-1"

    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-minimal-2604-resolute-amd64-v20260714"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-micro"
  name         = "demovm-1"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    queue_count = 0
    stack_type  = "IPV4_ONLY"
    subnetwork  = "projects/flipkart10-prod/regions/us-central1/subnetworks/default"
  }

  reservation_affinity {
    type = "ANY_RESERVATION"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "1024575660133-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  zone = "us-central1-a"
}

```
