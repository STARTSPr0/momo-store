resource "yandex_kubernetes_node_group" "k8s-node-group" {
  description = "Node group for Managed Service for Kubernetes cluster"
  name        = "${var.cluster_name}-node-group"
  cluster_id  = yandex_kubernetes_cluster.k8s-cluster.id
  version     = var.k8s_version

  scale_policy {
    auto_scale {
      initial = var.node_auto_scale_initial
      min     = var.node_auto_scale_min
      max     = var.node_auto_scale_max
    }
  }

  allocation_policy {
    location {
      zone = var.zone
    }
  }

  instance_template {
    platform_id = var.node_platform_id

    network_interface {
      nat                = true
      subnet_ids         = [yandex_vpc_subnet.momo_subnet.id]
      security_group_ids = [
        yandex_vpc_security_group.k8s-public-services.id
      ]
    }

    resources {
      memory = var.node_memory # RAM quantity in GB
      cores  = var.node_core # Number of CPU cores
    }

    boot_disk {
      type = var.node_disk_type
      size = var.node_disk_size # Disk size in GB
    }
  }
}