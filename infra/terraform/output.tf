output "Cluster_IP_Adress" {
  description = "Kubernetes cluster IP"
  value       = yandex_kubernetes_cluster.k8s-cluster.master.*.external_v4_address
}

output "Cluster_ID" {
  description = "Kubernetes cluster ID"
  value       = yandex_kubernetes_cluster.k8s-cluster.id
}

output "Cluster_Name" {
  description = "Kubernetes cluster name"
  value       = yandex_kubernetes_cluster.k8s-cluster.name
}