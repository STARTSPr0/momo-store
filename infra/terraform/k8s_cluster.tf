locals {
  folder_id   = "b1gauj5l1sg0oprjjcat"
}

resource "yandex_kubernetes_cluster" "k8s-regional" {
  name = "k8s-regional"
  network_id = yandex_vpc_network.momo_network.id
  master {
    version   = "1.27"
    public_ip = true
    zonal {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.momo_subnet.id
    }
  }
  
  service_account_id      = yandex_iam_service_account.my-regional-account.id
  node_service_account_id = yandex_iam_service_account.my-regional-account.id
  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller,
    yandex_resourcemanager_folder_iam_member.encrypterDecrypter
  ]
}

resource "yandex_vpc_network" "momo_network" {
  name        = "network"
  description = "Shared network for momo-app"
}

resource "yandex_vpc_subnet" "momo_subnet" {
  name           = "subnet"
  description    = "Subnet for momo-app"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.momo_network.id
  v4_cidr_blocks = ["10.0.0.0/16"]
}

resource "yandex_iam_service_account" "my-regional-account" {
  name        = "regional-k8s-account"
  description = "K8S regional service account"
}

resource "yandex_resourcemanager_folder_iam_member" "k8s-clusters-agent" {
  # Сервисному аккаунту назначается роль "k8s.clusters.agent".
  folder_id = local.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc-public-admin" {
  # Сервисному аккаунту назначается роль "vpc.publicAdmin".
  folder_id = local.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "images-puller" {
  # Сервисному аккаунту назначается роль "container-registry.images.puller".
  folder_id = local.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "encrypterDecrypter" {
  # Сервисному аккаунту назначается роль "kms.keys.encrypterDecrypter".
  folder_id = local.folder_id
  role      = "kms.keys.encrypterDecrypter"
  member    = "serviceAccount:${yandex_iam_service_account.my-regional-account.id}"
}
