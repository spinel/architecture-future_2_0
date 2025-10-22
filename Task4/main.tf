# Terraform configuration for "Будущее 2.0" infrastructure
# Provider configuration
terraform {
  required_version = ">= 1.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# VPC Network
resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
  description             = "VPC network for Будущее 2.0 infrastructure"
}

# Public Subnet
resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.project_name}-public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  description   = "Public subnet for web servers"
}

# Private Subnet
resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.project_name}-private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  description   = "Private subnet for application and database servers"
}

# Internet Gateway (implicit in GCP)
# NAT Gateway for private subnet
resource "google_compute_router" "nat_router" {
  name    = "${var.project_name}-nat-router"
  region  = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.project_name}-nat-gateway"
  router                            = google_compute_router.nat_router.name
  region                            = var.region
  nat_ip_allocate_option            = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

# Security Groups (Firewall Rules)
# Web servers security group
resource "google_compute_firewall" "web_firewall" {
  name    = "${var.project_name}-web-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
  description   = "Allow HTTP and HTTPS traffic to web servers"
}

# Application servers security group
resource "google_compute_firewall" "app_firewall" {
  name    = "${var.project_name}-app-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "8443"]
  }

  source_tags = ["web-server"]
  target_tags = ["app-server"]
  description = "Allow traffic from web servers to application servers"
}

# Database servers security group
resource "google_compute_firewall" "db_firewall" {
  name    = "${var.project_name}-db-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["5432", "3306"]
  }

  source_tags = ["app-server"]
  target_tags = ["db-server"]
  description = "Allow database connections from application servers"
}

# SSH access for all servers
resource "google_compute_firewall" "ssh_firewall" {
  name    = "${var.project_name}-ssh-firewall"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server", "app-server", "db-server", "monitoring-server"]
  description   = "Allow SSH access to all servers"
}

# Web Server Instance
resource "google_compute_instance" "web_server" {
  name         = "${var.project_name}-web-server"
  machine_type = var.web_server_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.web_server_image
      size  = var.web_server_disk_size
      type  = "pd-ssd"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.public_subnet.id
    access_config {
      // Ephemeral public IP
    }
  }

  tags = ["web-server"]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y nginx docker.io
    systemctl enable nginx
    systemctl start nginx
    systemctl enable docker
    systemctl start docker
  EOF
}

# Application Server Instance
resource "google_compute_instance" "app_server" {
  name         = "${var.project_name}-app-server"
  machine_type = var.app_server_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.app_server_image
      size  = var.app_server_disk_size
      type  = "pd-ssd"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.private_subnet.id
  }

  tags = ["app-server"]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io docker-compose
    systemctl enable docker
    systemctl start docker
  EOF
}

# Database Server Instance
resource "google_compute_instance" "db_server" {
  name         = "${var.project_name}-db-server"
  machine_type = var.db_server_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.db_server_image
      size  = var.db_server_disk_size
      type  = "pd-ssd"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.private_subnet.id
  }

  tags = ["db-server"]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y postgresql postgresql-contrib
    systemctl enable postgresql
    systemctl start postgresql
  EOF
}

# Monitoring Server Instance
resource "google_compute_instance" "monitoring_server" {
  name         = "${var.project_name}-monitoring-server"
  machine_type = var.monitoring_server_machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.monitoring_server_image
      size  = var.monitoring_server_disk_size
      type  = "pd-ssd"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.private_subnet.id
  }

  tags = ["monitoring-server"]

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y docker.io docker-compose
    systemctl enable docker
    systemctl start docker
  EOF
}

# Load Balancer
resource "google_compute_http_health_check" "web_health_check" {
  name               = "${var.project_name}-web-health-check"
  request_path       = "/"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 3
}

resource "google_compute_backend_service" "web_backend" {
  name        = "${var.project_name}-web-backend"
  protocol    = "HTTP"
  port_name   = "http"
  timeout_sec = 10

  backend {
    group = google_compute_instance_group.web_group.id
  }

  health_checks = [google_compute_http_health_check.web_health_check.id]
}

resource "google_compute_instance_group" "web_group" {
  name        = "${var.project_name}-web-group"
  description = "Instance group for web servers"
  zone        = var.zone

  instances = [google_compute_instance.web_server.id]

  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_url_map" "web_url_map" {
  name            = "${var.project_name}-web-url-map"
  default_service = google_compute_backend_service.web_backend.id
}

resource "google_compute_target_http_proxy" "web_proxy" {
  name    = "${var.project_name}-web-proxy"
  url_map = google_compute_url_map.web_url_map.id
}

resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
  name       = "${var.project_name}-web-forwarding-rule"
  target     = google_compute_target_http_proxy.web_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.web_ip.address
}

resource "google_compute_global_address" "web_ip" {
  name = "${var.project_name}-web-ip"
}
