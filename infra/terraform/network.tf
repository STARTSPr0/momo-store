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

resource "yandex_vpc_security_group" "k8s-public-services" {
  name        = "${var.cluster_name}-k8s-public-services"
  #description = "Правила группы разрешают подключение к сервисам из интернета. Примените правила только для групп узлов."
  network_id  = yandex_vpc_network.momo_network.id

  ingress {
    protocol       = "TCP"
    #description    = "Правило разрешает входящий трафик из интернета на диапазон портов NodePort. Добавьте или измените порты на нужные вам."
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 30000
    to_port        = 32767
  }
}