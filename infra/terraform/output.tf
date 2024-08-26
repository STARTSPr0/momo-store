output "Nodes_Endpiont" {
  description = "The IP address of the created instance"
  value       = yandex_kubernetes_cluster.k8s-cluster.master.*.external_v4_address
}

output "Nodes_IP_Adress" {
  description = "The IP address of the created instance"
  value       = yandex_kubernetes_cluster.k8s-cluster.master.*.external_v4_endpoint
}
