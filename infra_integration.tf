# Kafka Connect — for integrating Kafka with other internal services
resource "aiven_kafka_connect" "kfc_connect" {
  project                 = aiven_project.root.project
  service_name            = "${var.aiven_project_name}-kfc-${var.region_id}-connect-${random_id.suffix["kfc_connect"].hex}"
  cloud_name              = var.cloud_name
  plan                    = "startup-4"
  maintenance_window_dow  = "sunday"
  maintenance_window_time = "04:00:00"
}

# Aiven integration between Kafka and Kafka Connect
resource "aiven_service_integration" "avx_kfkconnect" {
  project                  = aiven_project.root.project
  integration_type         = "kafka_connect"
  source_service_name      = aiven_kafka.kfk_ingestion.service_name
  destination_service_name = aiven_kafka_connect.kfc_connect.service_name

  kafka_connect_user_config {
    kafka_connect {
      group_id             = "${var.aiven_project_name}-avx-${var.region_id}-kfkconnect-${random_id.suffix["avx_kfkconnect"].hex}"
      config_storage_topic = "__connect_configs"
      status_storage_topic = "__connect_status"
      offset_storage_topic = "__connect_offsets"
    }
  }
}

# Kafka JDBC sink connector — for dumping ingested data directly into database
resource "aiven_kafka_connector" "kfx_dbsink" {
  project        = aiven_project.root.project
  service_name   = aiven_kafka_connect.kfc_connect.service_name
  connector_name = "${var.aiven_project_name}-kfx-${var.region_id}-dbsink-${random_id.suffix["kfx_dbsink"].hex}"

  config = {
    "topics"          = aiven_kafka_topic.kft_analytics.topic_name
    "connector.class" = "io.aiven.connect.jdbc.JdbcSinkConnector"
    "name"            = "${var.aiven_project_name}-kfx-${var.region_id}-dbsink-${random_id.suffix["kfx_dbsink"].hex}"
    "connection.url"  = "jdbc:${aiven_pg.pgs_analytics.service_uri}"
  }
}
