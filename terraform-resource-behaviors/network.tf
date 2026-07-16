# create VPC
resource "google_compute_network" "vpc-1" { 
  name = "flipkart10-terraform-vpc"
  auto_create_subnetworks = false
}

# Create subnet
resource "google_compute_subnetwork" "subnet-1" {
  name = "flipkart10-subnet"
  region = "us-central1"
  ip_cidr_range = "10.5.0.0/16"
  network =  google_compute_network.vpc-1.id  
}

# create ssh firewall rule
resource "google_compute_firewall" "ssh-firewall" {
    # name,direction,source ,port,network,priority,allow
  name = "flipkart10-allow-ssh"
  network = google_compute_network.vpc-1.id 
  allow {
    protocol = "tcp"
    ports = ["22"]
  }  
  direction = "INGRESS"
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["flipkart10-ssh-tag-1", "flipkart10-ssh-tag-2"] 
}

# create http firewall rule
resource "google_compute_firewall" "http-firewall" {
    # name,direction,source ,port,network,priority,allow
  name = "flipkart10-allow-http"
  network = google_compute_network.vpc-1.id 
  allow {
    protocol = "tcp"
    ports = ["80"]
  }  
  direction = "INGRESS"
  priority = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["flipkart10-ssh-tag-3"] 
}
