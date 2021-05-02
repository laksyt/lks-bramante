resource "random_id" "suffix" {
  for_each = toset([
    "project",
    "pgs_orders",
    "pgs_analytics",
    "kfk_ingestion",
    "kfc_connect",
    "avx_kfkconnect",
    "kft_analytics",
    "kfx_dbsink"
  ])
  keepers = {
    project_name = "${var.aiven_project_name}"
  }

  byte_length = 2
}
