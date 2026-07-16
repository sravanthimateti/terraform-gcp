provider "google" {
  project = "flipkart10-prod"
  region = "us-central1"
  credentials = file("key.json")
}
