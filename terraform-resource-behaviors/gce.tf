resource "google_compute_instance" "vm-1" {
  name= "flipkart10-vm"
  zone = "us-central1-a"
  machine_type ="e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }  

  network_interface {
    subnetwork = google_compute_subnetwork.subnet-1.id
    access_config {
      # empty
      #public ip
    }  
  }
  metadata_startup_script = file("${path.module}/startup.sh")
  # adding vm tags
  tags = [
    tolist(google_compute_firewall.ssh-firewall.target_tags)[0],
    tolist(google_compute_firewall.ssh-firewall.target_tags)[1],
    tolist(google_compute_firewall.http-firewall.target_tags)[0],
    "flipkart10-extra-tag"
  ]
}
