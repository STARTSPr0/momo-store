resource "yandex_kubernetes_cluster" "k8s-cluster" {
  name = var.cluster_name
  network_id = yandex_vpc_network.momo_network.id
  master {
    version   = "1.27"
    public_ip = true
    zonal {
      zone      = var.zone_id
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
