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
  token     = "y0_AgAAAAAD-maZAATuwQAAAAEOg8F6AACsDJXS6pVDBrgWh8wbRpsAD63FJQ"
  cloud_id  = "b1gi8vdh7kmlf42g1mcd" # Set your cloud ID
  folder_id = "b1gauj5l1sg0oprjjcat" # Set your cloud folder ID
  zone      = "ru-central1-a" # Availability zone by default, one of ru-central1-a, ru-central1-b, ru-central1-c
}
