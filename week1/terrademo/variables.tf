variable "credentials" {
  description = "My Credentials"
  default     = "./key/my-creds.json"
}

variable "project" {
  description = "Project"
  default     = "pivotal-bonbon-411719"
}

variable "location" {
  description = "Project Location"
  default     = "EU"
}

variable "region" {
  description = "Project Region"
  default     = "europe-southwest1-a"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  default     = "demo_dataset"
}

variable "gcs_bucket" {
  description = "My Storage Bucket Name"
  default     = "pivotal-bonbon-411719-terra-bucket"
}


variable "gcs_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}