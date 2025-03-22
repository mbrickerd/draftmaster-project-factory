# draftmaster-project-factory

This repository houses the DraftMaster Project Factory, a comprehensive infrastructure-as-code solution for provisioning and managing foundational Azure resources. The Project Factory is designed to create consistent and standardised baseline resources for any Azure project, establishing the groundwork for further development.

The Project Factory automates the creation of essential resources including resource groups per environment, storage containers for Terraform state management, and necessary IAM configurations. It implements a structured approach to infrastructure provisioning, ensuring consistent deployment patterns across multiple projects.

## Benefits

- **Standardization**: Consistent foundational resources across all DraftMaster projects
- **Automation**: Streamlined project bootstrapping process
- **Separation of Concerns**: Clear distinction between foundational infrastructure and project-specific resources
- **Governance**: Centralised management of project environments and permissions
- **Reproducibility**: Consistent infrastructure deployment across development, testing, and production environments

## Getting Started

The Project Factory can be used to provision foundation resources for new Azure projects by configuring project definitions and applying the Terraform configurations.

## Prerequisites

The following tools are required to work with this repository:

- [**terraform**](https://www.terraform.io/) - Infrastructure as Code tool to provision and manage cloud resources
- [**terraform-docs**](https://terraform-docs.io/) - Generate documentation from Terraform modules
- [**tflint**](https://github.com/terraform-linters/tflint) - Terraform linter for detecting errors and enforcing best practices
- [**checkov**](https://www.checkov.io/2.Basics/Installing%20Checkov.html) - Static code analysis tool for infrastructure as code
- [**make**](https://www.gnu.org/software/make/manual/make.html) - Build automation tool (installed by default on most OS)
- [**pre-commit**](https://pre-commit.com/) - Framework for managing git pre-commit hooks

## Repository Structure

```
.
├── components/                       // Directory containing reusable factory components
│   ├── project-factory/              // Core component for project resource provisioning
│   ├── project-iam-factory/          // IAM and permissions management
│   ├── storage-factory/              // Storage account and container management
│   └── vnet-factory/                 // Virtual network configuration
├── projects/                         // Directory containing project configurations
│   └── hm-draftmaster.yml            // Project definition for DraftMaster
├── terraform-bootstrap/              // Bootstrap infrastructure configuration
│   ├── README.md                     // Bootstrap-specific documentation
│   ├── backend.tf                    // Terraform backend configuration
│   ├── locals.tf                     // Local values
│   ├── main.tf                       // Primary resource declarations
│   ├── providers.tf                  // Provider configuration
│   └── versions.tf                   // Required providers and versions
├── backend.tf                        // Terraform backend configuration
├── CODEOWNERS                        // Defines owners for code reviews
├── checkov.yaml                      // Configuration for Checkov static code analysis
├── locals.tf                         // Local values
├── main.tf                           // Primary resource declarations
├── Makefile                          // Contains commands for development workflow
├── providers.tf                      // Provider configuration
├── README.md                         // Project documentation
└── versions.tf                       // Required providers and versions
```

## Core Components

### Bootstrap Infrastructure

The `terraform-bootstrap` directory contains configurations to establish the management foundation:

- Creates a management subscription resource group
- Provisions a storage account for Terraform state
- Sets up storage containers for both bootstrap and project resources
- Establishes the baseline for all other deployments

### Project Factory

The Project Factory is comprised of several components:

1. **Project Factory** (`components/project-factory/`):
   - Creates resource groups for each environment
   - Establishes foundational resources required by all projects

2. **Project IAM Factory** (`components/project-iam-factory/`):
   - Manages access controls and permissions
   - Ensures proper segregation of duties across environments

3. **Storage Factory** (`components/storage-factory/`):
   - Provisions storage resources for project data
   - Creates storage containers as needed

4. **VNet Factory** (`components/vnet-factory/`):
   - Establishes network foundations for projects
   - Configures virtual networks according to standards

## Project Definition

Projects are defined in YAML configuration files within the `projects/` directory. Each project configuration specifies:

- Project name and identifiers
- Environments (dev, test, prod, etc.)
- Subscription mappings for each environment
- Required permissions and access controls
- Other project-specific parameters

Example project configuration:

```yaml
# Example project definition structure (simplified)
name: example-project

environments:
  - name: dev
    subscription_id: "00000000-0000-0000-0000-000000000000"
  - name: test
    subscription_id: "11111111-1111-1111-1111-111111111111"
  - name: prod
    subscription_id: "22222222-2222-2222-2222-222222222222"
    
permissions:
  - role: Contributor
    principals:
      - "dev-team-group-id"
```

## Usage

### Deploying a New Project

1. Create a new project definition in the `projects/` directory
2. Initialise and apply the Terraform configuration:

```bash
terraform init
terraform plan -out=plan.tfplan
terraform apply "plan.tfplan"
```

## Development

### Pre-commit Hooks

This repository uses pre-commit to run checks before committing changes. To install pre-commit hooks:

```bash
pre-commit install
```

To run pre-commit checks manually:

```bash
pre-commit run --all-files
```

### Make Commands

The repository includes a Makefile to simplify common development tasks:

#### Generate Documentation

Generate documentation for all components:

```bash
make docs
```

#### Test

Run all validation tools (format, lint, validate, security checks):

```bash
make test
```

Individual commands are also available:

```bash
make fmt      # Format Terraform code
make lint     # Run tflint
make validate # Run terraform validate
make checkov  # Run security checks with Checkov
```

## Next Steps

After deploying the foundation resources using this Project Factory, project-specific resources will be developed in a separate repository. The foundation established by this Project Factory provides the essential infrastructure upon which those project-specific resources can be built.

## Contributing

- Fork the repository
- Create a feature branch (`git checkout -b feature/amazing-feature`)
- Make your changes
- Run linting and validation (`make test`)
- Update documentation (`make docs`)
- Commit your changes (`git commit -m 'Add amazing feature'`)
- Push to the branch (`git push origin feature/amazing-feature`)
- Open a Pull Request
