# Variables for "Будущее 2.0" infrastructure

# Project Configuration
variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "budushee-2-0"
}

variable "project_name" {
  description = "Project name for resource naming"
  type        = string
  default     = "budushee"
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP zone for compute instances"
  type        = string
  default     = "europe-west1-b"
}

# Network Configuration
variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

# SSH Configuration
variable "ssh_user" {
  description = "SSH username for instances"
  type        = string
  default     = "ubuntu"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Web Server Configuration
variable "web_server_machine_type" {
  description = "Machine type for web server"
  type        = string
  default     = "n1-standard-2"
}

variable "web_server_image" {
  description = "OS image for web server"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "web_server_disk_size" {
  description = "Disk size for web server (GB)"
  type        = number
  default     = 50
}

# Application Server Configuration
variable "app_server_machine_type" {
  description = "Machine type for application server"
  type        = string
  default     = "n1-standard-4"
}

variable "app_server_image" {
  description = "OS image for application server"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "app_server_disk_size" {
  description = "Disk size for application server (GB)"
  type        = number
  default     = 100
}

# Database Server Configuration
variable "db_server_machine_type" {
  description = "Machine type for database server"
  type        = string
  default     = "n1-standard-8"
}

variable "db_server_image" {
  description = "OS image for database server"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "db_server_disk_size" {
  description = "Disk size for database server (GB)"
  type        = number
  default     = 500
}

# Monitoring Server Configuration
variable "monitoring_server_machine_type" {
  description = "Machine type for monitoring server"
  type        = string
  default     = "n1-standard-2"
}

variable "monitoring_server_image" {
  description = "OS image for monitoring server"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "monitoring_server_disk_size" {
  description = "Disk size for monitoring server (GB)"
  type        = number
  default     = 50
}

# Environment Configuration
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

# Tags
variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "Будущее 2.0"
    Environment = "dev"
    ManagedBy   = "terraform"
    Owner       = "devops-team"
  }
}

# Backup Configuration
variable "enable_backup" {
  description = "Enable automated backups"
  type        = bool
  default     = true
}

variable "backup_retention_days" {
  description = "Number of days to retain backups"
  type        = number
  default     = 30
}

# Monitoring Configuration
variable "enable_monitoring" {
  description = "Enable monitoring and alerting"
  type        = bool
  default     = true
}

variable "monitoring_email" {
  description = "Email for monitoring alerts"
  type        = string
  default     = "admin@budushee-2-0.com"
}

# Security Configuration
variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed to access the infrastructure"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_ssl" {
  description = "Enable SSL/TLS encryption"
  type        = bool
  default     = true
}

# Cost Optimization
variable "enable_preemptible" {
  description = "Use preemptible instances for cost optimization"
  type        = bool
  default     = false
}

variable "enable_auto_scaling" {
  description = "Enable auto-scaling for instances"
  type        = bool
  default     = false
}
