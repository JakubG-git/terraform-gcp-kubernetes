data "google_container_engine_versions" "gke_versions" {
  location = var.gcp_region
}

resource "google_container_cluster" "primary" {
    name = "${var.gcp_cluster_name}"
    location = var.gcp_zone

    initial_node_count = 1
    remove_default_node_pool = true
    
    network = google_compute_network.kube-network.self_link
    subnetwork = google_compute_subnetwork.kube-subnet.self_link
    # Unfortunetly this field is read only
    # private_cluster_config {
    #   public_endpoint = google_compute_address.external_ip.address
    # }
}

resource "google_container_node_pool" "primary_nodes" {
    name = google_container_cluster.primary.name
    location = var.gcp_zone
    cluster = google_container_cluster.primary.name
    node_count = var.gke_num_nodes

    node_config {
      oauth_scopes = [
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]

      disk_size_gb = 30


      labels = {
        env = var.gcp_project_id
      }

      machine_type = var.machine_type
      tags         = ["gke-node", "${var.gcp_cluster_name}", "${var.gcp_project_id}-gke-node"]
      metadata = {
        disable-legacy-endpoints = "true"
      }
  }

}

