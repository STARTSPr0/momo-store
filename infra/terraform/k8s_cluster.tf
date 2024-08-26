resource "yandex_kubernetes_cluster" "k8s-cluster" {
  name = var.cluster_name
  network_id = yandex_vpc_network.momo_network.id
  master {
    version   = var.k8s_version
    public_ip = true
    zonal {
      zone      = var.zone
      subnet_id = yandex_vpc_subnet.momo_subnet.id
    }
  }
  
  service_account_id      = yandex_iam_service_account.k8s_cluster_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_cluster_sa.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
}

######NODES Start

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

######NODES Enmd

resource "yandex_vpc_network" "momo_network" {
  name        = "${var.cluster_name}-network"
  description = "Shared network for momo-app"
}

resource "yandex_vpc_subnet" "momo_subnet" {
  name           = "${var.cluster_name}-subnet"
  description    = "Subnet for momo-app"
  zone           = var.zone
  network_id     = yandex_vpc_network.momo_network.id
  v4_cidr_blocks = ["10.0.0.0/16"]
}

resource "yandex_iam_service_account" "k8s_cluster_sa" {
  name        = "${var.cluster_name}-k8s-account"
  description = "K8S ${var.cluster_name} service account"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
  folder_id = var.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_cluster_sa.id}"
}
