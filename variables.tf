#Variable declarations for the GCP website
#Fill those in with your own values in the .tfvars file
variable "gcp_cred_file" {
    description = "location of the GCP credentials file"
}
variable "gcp_project_id" {
    description = "google cloud project id"
}
variable "gcp_region" {
    description = "choosen gcp region"
    default = "europe-north1"
}
variable "gcp_zone" {
    description = "choosen gcp zone"
    default = "europe-north1-a"
}

variable "gcp_dns_zone" {
    description = "choosen gcp dns zone"
}

variable "gcp_subdomain" {
  description = "choosen subdomain"
}

variable "gcp_cluster_name" {
    description = "choosen gcp cluster name"
    default = "k8s-cluster"
}

variable "gke_num_nodes" {
   description = "number of nodes for the GKE cluster"
   default = 3
}

variable "machine_type" {
   description = "machine type for the GKE cluster"
   default = "n1-standard-1"
}
  