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