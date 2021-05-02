variable "aiven_api_token" {
  type      = string
  sensitive = true
}

variable "aiven_project_name" {
  type    = string
  default = "sample-project-name"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]*$", var.aiven_project_name))
    error_message = "Project name should begin with a lowercase English letter and contain only lowercase English letters, digits, and dashes."
  }
}

variable "aiven_billing_card_id" {
  type    = string
  default = null

  validation {
    condition     = var.aiven_billing_card_id == null || can(regex("^([0-9]{4}|[0-9]{16})$", var.aiven_billing_card_id))
    error_message = "When provided, the billing card ID must be a string of either 4 or 16 digits."
  }
}

variable "aiven_billing_project_name" {
  type    = string
  default = null

  validation {
    condition     = var.aiven_billing_project_name == null || can(regex("^[A-Za-z][A-Za-z0-9_-]*$", var.aiven_billing_project_name))
    error_message = "When provided, the billing project name must be a valid identifier string."
  }
}

variable "cloud_name" {
  type    = string
  default = "google-europe-north1"

  validation {
    condition     = can(regex("^(aws|azure|do|google|upcloud)-[a-z0-9-]+$", var.cloud_name))
    error_message = "The default cloud name must be a cloud identifier ('aws', 'azure', 'do', 'google', or 'upcloud'), followed by a dash, followed by the cloud-specific region identifier."
  }
}

variable "region_id" {
  type    = string
  default = "euno1"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.region_id))
    error_message = "The region identifier should be a single ‘word’ (lowercase alphanumerical string) that would fit well into a Terraform resource name."
  }
}
