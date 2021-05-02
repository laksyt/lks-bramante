# PostgreSQL #1 — for orders and other webapp data
resource "aiven_pg" "pgs_orders" {
  project                 = aiven_project.root.project
  service_name            = "${var.aiven_project_name}-pgs-${var.region_id}-orders-${random_id.suffix["pgs_orders"].hex}"
  cloud_name              = var.cloud_name
  plan                    = "business-4"
  maintenance_window_dow  = "sunday"
  maintenance_window_time = "04:00:00"

  pg_user_config {
    pg_version = 13
  }
}

# PostgreSQL #2 — for analytics and pricing data
resource "aiven_pg" "pgs_analytics" {
  project                 = aiven_project.root.project
  service_name            = "${var.aiven_project_name}-pgs-${var.region_id}-analytics-${random_id.suffix["pgs_analytics"].hex}"
  cloud_name              = var.cloud_name
  plan                    = "business-4"
  maintenance_window_dow  = "sunday"
  maintenance_window_time = "04:00:00"

  pg_user_config {
    pg_version = 13
  }
}
