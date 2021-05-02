terraform {
  required_version = ">= 0.14"
  required_providers {
    aiven = {
      source  = "aiven/aiven"
      version = "2.1.11"
    }
  }
}

provider "aiven" {
  api_token = var.aiven_api_token
}

# Parent project to hold the entire infrastructure
resource "aiven_project" "root" {
  project           = "${var.aiven_project_name}-${random_id.suffix["project"].hex}"
  card_id           = var.aiven_billing_card_id
  copy_from_project = var.aiven_billing_project_name
}
