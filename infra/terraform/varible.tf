variable "cloud_id" {
  type        = string
  default = "none"
  description = "ID of the cloud"
}

variable "folder_id" {
  type        = string
  default = "none"
  description = "ID of the folder"
}

variable "zone" {
  type        = string
  default = "ru-central1-a"
  description = "ID of the availability zone"
}

variable "cluster_name" {
  type        = string
  default = "k8s-cluster-momo"
  description = "Name of cluster"
}