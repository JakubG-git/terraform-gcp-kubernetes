#Get the managed zone and save for later use
data "google_dns_managed_zone" "website_zone" {
    name = var.gcp_dns_zone
}
#Create a VPC network
resource "google_compute_network" "kube-network" {
  name = "${var.gcp_cluster_name}-network"
  auto_create_subnetworks = false
}
#Create a subnet
resource "google_compute_subnetwork" "kube-subnet" {
    name = "${var.gcp_cluster_name}-subnet"
    ip_cidr_range = "10.10.10.0/24"
    region = var.gcp_region
    network = google_compute_network.kube-network.self_link
}

resource "google_dns_managed_zone" "kube-dns-zone" {
  name = "${var.gcp_subdomain}"
  dns_name = "${var.gcp_subdomain}.${var.gcp_dns_zone}."
  description = "Kubernetes DNS zone"
  visibility = "public"
}

resource "google_dns_record_set" "kube-dns-record" {
  name = "${var.gcp_cluster_name}.${google_dns_managed_zone.kube-dns-zone.dns_name}"
  type = "A"
  ttl = 300
  managed_zone = google_dns_managed_zone.kube-dns-zone.name
  rrdatas = [google_container_cluster.primary.endpoint]
}