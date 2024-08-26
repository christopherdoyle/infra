terraform {
  required_version = ">= 1.0.0"
  required_providers {
    b2 = {
      source  = "Backblaze/b2"
      version = "0.8.12"
    }
  }
}

variable "b2_application_key" {
  description = "Backblaze B2 API key"
  type        = string
  sensitive   = true
}

variable "b2_application_key_id" {
  description = "Backblaze B2 API key id"
  type        = string
  sensitive   = true
}

provider "b2" {
  application_key    = var.b2_application_key
  application_key_id = var.b2_application_key_id
}

data "b2_account_info" "main" {
}

resource "random_string" "ente_bucket_stub" {
  length           = 32
  special          = true
  override_special = "-"
  upper            = true
  lower            = true
  numeric          = true
}

resource "b2_bucket" "ente" {
  bucket_name = "ente-${random_string.ente_bucket_stub.result}"
  bucket_type = "allPrivate"
}

resource "b2_application_key" "ente" {
  key_name     = "ente-key"
  capabilities = ["deleteFiles", "listBuckets", "listFiles", "readBuckets", "readFiles", "shareFiles", "writeFiles"]
  bucket_id    = b2_bucket.ente.bucket_id
}

output "ente_url" {
  value = "${data.b2_account_info.main.s3_api_url}/${b2_bucket.ente.bucket_name}"
}

output "ente_application_key_id" {
  value = b2_application_key.ente.application_key_id
}

output "ente_application_key" {
  value     = b2_application_key.ente.application_key
  sensitive = true
}
