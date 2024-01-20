terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.6.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = "./key/my-creds.json"
  project     = "pivotal-bonbon-411719"
  region      = "europe-southwest1-a"
}

resource "google_storage_bucket" "demo-bucket" {
  name          = "pivotal-bonbon-411719-terra-bucket"
  location      = "EU"
  force_destroy = true

  lifecycle_rule {
    condition {
      age = 1
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
}