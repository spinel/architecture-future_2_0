# Terraform variables for "Будущее 2.0" infrastructure
# This file contains the actual values for the variables defined in variables.tf

# Project Configuration
project_id    = "budushee-2-0-dev"
project_name  = "budushee"
region        = "europe-west1"
zone          = "europe-west1-b"

# Network Configuration
public_subnet_cidr  = "10.0.1.0/24"
private_subnet_cidr = "10.0.2.0/24"

# SSH Configuration
ssh_user             = "ubuntu"
ssh_public_key_path  = "~/.ssh/id_rsa.pub"

# Web Server Configuration
web_server_machine_type = "n1-standard-2"
web_server_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
web_server_disk_size   = 50

# Application Server Configuration
app_server_machine_type = "n1-standard-4"
app_server_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
app_server_disk_size   = 100

# Database Server Configuration
db_server_machine_type = "n1-standard-8"
db_server_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
db_server_disk_size   = 500

# Monitoring Server Configuration
monitoring_server_machine_type = "n1-standard-2"
monitoring_server_image       = "ubuntu-os-cloud/ubuntu-2004-lts"
monitoring_server_disk_size   = 50

# Environment Configuration
environment = "dev"

# Common Tags
common_tags = {
  Project     = "Будущее 2.0"
  Environment = "dev"
  ManagedBy   = "terraform"
  Owner       = "devops-team"
  CostCenter  = "IT-Infrastructure"
  Compliance  = "GDPR"
}

# Backup Configuration
enable_backup         = true
backup_retention_days = 30

# Monitoring Configuration
enable_monitoring  = true
monitoring_email  = "admin@budushee-2-0.com"

# Security Configuration
allowed_cidr_blocks = [
  "0.0.0.0/0"  # In production, restrict this to specific IP ranges
]

enable_ssl = true

# Cost Optimization
enable_preemptible  = false  # Set to true for cost optimization in dev environment
enable_auto_scaling = false  # Set to true for production environment
