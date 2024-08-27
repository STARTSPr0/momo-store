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

variable "k8s_version" {
  type        = number
  default = "1.27"
  description = "Version of k8s"
}

variable "node_memory" {
  type        = number
  default = "2"
  description = "Node RAM quantity in GB"
}

variable "node_core" {
  type        = number
  default = "2"
  description = "Node number of CPU cores"
}

variable "node_disk_size" {
  type        = number
  default = "64"
  description = "Node Disk size in GB"
}

variable "node_auto_scale_initial" {
  type        = number
  default = "1"
  description = "Node initial count"
}

variable "node_auto_scale_min" {
  type        = number
  default = "1"
  description = "Node min count"
}

variable "node_auto_scale_max" {
  type        = number
  default = "3"
  description = "Node max count"
}

variable "node_disk_type" {
  type        = string
  default = "network-hdd"
  description = "Disk type"
}

variable "node_platform_id" {
  type        = string
  default = "standard-v2"
  description = "Platform id"
}