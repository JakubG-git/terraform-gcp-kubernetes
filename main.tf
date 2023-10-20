#Get the managed zone and save for later use
data "google_dns_managed_zone" "website_zone" {
    name = var.gcp_dns_zone
}
#Reserve a static IP address
resource "google_compute_address" "external_ip" {
  name = "cluster-ip"
  region = var.gcp_region
}
