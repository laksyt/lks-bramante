# Kafka — for ingestion of pricing and analytics data
resource "aiven_kafka" "kfk_ingestion" {
  project                 = aiven_project.root.project
  service_name            = "${var.aiven_project_name}-kfk-${var.region_id}-ingestion-${random_id.suffix["kfk_ingestion"].hex}"
  cloud_name              = var.cloud_name
  plan                    = "business-4"
  maintenance_window_dow  = "sunday"
  maintenance_window_time = "04:00:00"

  kafka_user_config {
    kafka_connect = true
    kafka_version = "2.8"

    kafka_authentication_methods {
      certificate = true
      sasl        = true
    }
  }
}

# Kafka topic — for pricing and analytics data
resource "aiven_kafka_topic" "kft_analytics" {
  project      = aiven_project.root.project
  service_name = aiven_kafka.kfk_ingestion.service_name
  topic_name   = "${var.aiven_project_name}-kft-${var.region_id}-analytics-${random_id.suffix["kft_analytics"].hex}"
  partitions   = 5
  replication  = 3
}
