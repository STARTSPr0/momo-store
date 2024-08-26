variable "cloud_id" {
  type        = string
  description = "ID of the cloud"
}

variable "folder_id" {
  type        = string
  description = "ID of the folder"
}

variable "zone" {
  type        = string
  description = "ID of the availability zone"
}

variable "yc_token" {
  type        = string
  default = "ru-central1-a"
  description = "ID of the cloud"
}