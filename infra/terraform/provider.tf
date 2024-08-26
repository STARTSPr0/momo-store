terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.97.0"
       # source = "terraform-registry.storage.yandexcloud.net/yandex-cloud/yandex" # Alternate link
    }
  }
  required_version = ">= 0.75.0"
}

provider "yandex" {
  #token     = var.yc_token
  cloud_id  = var.cloud_id # Set your cloud ID
  folder_id = var.folder_id # Set your cloud folder ID
  zone      = var.zone # Availability zone by default, one of ru-central1-a, ru-central1-b, ru-central1-c
}
