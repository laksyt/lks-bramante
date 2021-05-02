# Läksyt: Bramante

<p align="center">
<em>‘Läksyt’ is plural for ‘homework’ in Finnish<br>(according to <a href="https://translate.google.com/?sl=fi&tl=en&text=l%C3%A4ksyt&op=translate">Google Translate</a>)</em>
</p>

A solution architecture plan for migrating a global retailer company from a dated GCP/on-prem infrastructure (centered on a PostgreSQL instance) onto services provided by Aiven.io.

## Plan

The proposed solution architecture plan is showcased in the `presentation.pdf` file.
All the source files for the presentation (the Powerpoint file and the Visio diagrams) can be found in the `src` directory.

## Terraform

The foundation for the proposed infrastructure can be created using the provided Terraform configuration:

- Duplicate the `terraform.tfvars.sample` file, removing the `.sample` suffix.
- Fill out the variables in the `terraform.tfvars` file, following the instructions within:
  - At the very least, the authentication token for an Aiven admin account is required.
  - Some billing data may be needed as well.
- Run the following commands in the repository’s root directory:
  - `terraform init`
  - `terraform apply`

The infrastructure is defined in the `*.tf` files in the root of the repository.
Some of the services come integrated out of the box.
Additional configuration will be required to migrate the client’s infrastructure, including but not limited to:

- Creating appropriate tables in the Aiven PostgreSQL instances.
- Migrating data from client’s PostgreSQL instances.
- Ensuring proper integration with client’s suppliers and affiliates.
- Fine-tuning Aiven service plans to client’s workloads.
