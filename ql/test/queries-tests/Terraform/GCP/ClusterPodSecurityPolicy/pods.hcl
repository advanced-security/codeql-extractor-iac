resource "google_container_cluster" "cluster1" {
  name               = "cluster1"
  location           = "us-central1"
  initial_node_count = 1
}

resource "google_container_cluster" "cluster2" {
  name               = "cluster2"
  location           = "us-central1"
  initial_node_count = 1

  pod_security_policy_config {
    enabled = "false"
  }
}

resource "google_container_cluster" "cluster3" {
  name               = "cluster3"
  location           = "us-central1"
  initial_node_count = 1

  pod_security_policy_config {
    enabled = "true"
  }
}
