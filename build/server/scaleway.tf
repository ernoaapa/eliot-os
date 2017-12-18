variable "region" {
  default = "ams1"
}
provider "scaleway" {
  region       = "${var.region}"
}

resource "scaleway_ip" "ip" {
  server = "${scaleway_server.linuxkit-server.id}"
}

# Ubuntu Xenial
variable "amis" {
  type = "map"
  default = {
    "par1" = "e1a0daf2-a61f-40bf-ba3c-f86ec4baa3bf",
    "ams1" = "2da46fbf-6dbf-4406-8134-e5696c1c3c34",
  }
}

resource "scaleway_server" "linuxkit-server" {
  name  = "linuxkit-server"
  image = "${lookup(var.amis, var.region)}" 
  type  = "ARM64-2GB"
  security_group = "${scaleway_security_group.http.id}"
}

resource "scaleway_security_group" "http" {
  name        = "http"
  description = "allow HTTP and HTTPS traffic"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}