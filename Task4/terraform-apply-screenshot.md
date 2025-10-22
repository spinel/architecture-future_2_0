
```bash
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # google_compute_backend_service.web_backend will be created
  + resource "google_compute_backend_service" "web_backend" {
      + connection_draining_timeout_sec = 30
      + creation_timestamp               = (known after apply)
      + fingerprint                     = (known after apply)
      + id                              = (known after apply)
      + name                            = "budushee-web-backend"
      + port_name                       = "http"
      + project                         = "budushee-2-0-dev"
      + protocol                        = "HTTP"
      + self_link                       = (known after apply)
      + session_affinity                = "NONE"
      + timeout_sec                     = 10
    }

  # google_compute_firewall.app_firewall will be created
  + resource "google_compute_firewall" "app_firewall" {
      + creation_timestamp = (known after apply)
      + description       = "Allow traffic from web servers to application servers"
      + direction         = "INGRESS"
      + id                = (known after apply)
      + name              = "budushee-app-firewall"
      + network           = "budushee-vpc"
      + priority          = 1000
      + project           = "budushee-2-0-dev"
      + self_link         = (known after apply)
      + source_tags       = ["web-server"]
      + target_tags       = ["app-server"]
    }

  # google_compute_firewall.db_firewall will be created
  + resource "google_compute_firewall" "db_firewall" {
      + creation_timestamp = (known after apply)
      + description       = "Allow database connections from application servers"
      + direction         = "INGRESS"
      + id                = (known after apply)
      + name              = "budushee-db-firewall"
      + project           = "budushee-2-0-dev"
      + self_link         = (known after apply)
      + source_tags       = ["app-server"]
      + target_tags       = ["db-server"]
    }

  # google_compute_firewall.ssh_firewall will be created
  + resource "google_compute_firewall" "ssh_firewall" {
      + creation_timestamp = (known after apply)
      + description       = "Allow SSH access to all servers"
      + direction         = "INGRESS"
      + id                = (known after apply)
      + name              = "budushee-ssh-firewall"
      + project           = "budushee-2-0-dev"
      + self_link         = (known after apply)
      + source_ranges     = ["0.0.0.0/0"]
      + target_tags       = ["web-server", "app-server", "db-server", "monitoring-server"]
    }

  # google_compute_firewall.web_firewall will be created
  + resource "google_compute_firewall" "web_firewall" {
      + creation_timestamp = (known after apply)
      + description       = "Allow HTTP and HTTPS traffic to web servers"
      + direction         = "INGRESS"
      + id                = (known after apply)
      + name              = "budushee-web-firewall"
      + project           = "budushee-2-0-dev"
      + self_link         = (known after apply)
      + source_ranges     = ["0.0.0.0/0"]
      + target_tags       = ["web-server"]
    }

  # google_compute_global_address.web_ip will be created
  + resource "google_compute_global_address" "web_ip" {
      + address      = (known after apply)
      + address_type = "EXTERNAL"
      + creation_timestamp = (known after apply)
      + id           = (known after apply)
      + ip_version   = "IPV4"
      + name         = "budushee-web-ip"
      + project      = "budushee-2-0-dev"
      + self_link    = (known after apply)
    }

  # google_compute_global_forwarding_rule.web_forwarding_rule will be created
  + resource "google_compute_global_forwarding_rule" "web_forwarding_rule" {
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + ip_address         = (known after apply)
      + ip_protocol        = "TCP"
      + load_balancing_scheme = "EXTERNAL"
      + name               = "budushee-web-forwarding-rule"
      + port_range         = "80"
      + project            = "budushee-2-0-dev"
      + self_link          = (known after apply)
      + target             = (known after apply)
    }

  # google_compute_http_health_check.web_health_check will be created
  + resource "google_compute_http_health_check" "web_health_check" {
      + check_interval_sec  = 10
      + creation_timestamp  = (known after apply)
      + healthy_threshold   = 2
      + id                  = (known after apply)
      + name                = "budushee-web-health-check"
      + port                = 80
      + project             = "budushee-2-0-dev"
      + request_path        = "/"
      + self_link           = (known after apply)
      + timeout_sec         = 5
      + unhealthy_threshold = 3
    }

  # google_compute_instance.app_server will be created
  + resource "google_compute_instance" "app_server" {
      + can_ip_forward      = false
      + cpu_platform        = (known after apply)
      + current_status      = "RUNNING"
      + deletion_protection = false
      + description         = ""
      + desired_status      = "RUNNING"
      + enable_display      = false
      + guest_accelerator   = (known after apply)
      + id                  = (known after apply)
      + instance_id         = (known after apply)
      + label_fingerprint   = (known after apply)
      + machine_type        = "n1-standard-4"
      + metadata            = {
          + "ssh-keys" = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC..."
          + "startup-script" = "#!/bin/bash\napt-get update\napt-get install -y docker.io docker-compose\nsystemctl enable docker\nsystemctl start docker"
        }
      + metadata_fingerprint = (known after apply)
      + name                = "budushee-app-server"
      + project             = "budushee-2-0-dev"
      + self_link           = (known after apply)
      + tags                = ["app-server"]
      + tags_fingerprint    = (known after apply)
      + zone                = "europe-west1-b"

      + boot_disk {
          + auto_delete                = true
          + device_name                = "persistent-disk-0"
          + disk_encryption_key_raw    = (sensitive value)
          + initialize_params {
              + image  = "ubuntu-os-cloud/ubuntu-2004-lts"
              + labels = (known after apply)
              + size   = 100
              + type   = "pd-ssd"
            }
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)
        }

      + network_interface {
          + ipv6_access_type = (known after apply)
          + name            = "nic0"
          + network         = (known after apply)
          + network_ip      = (known after apply)
          + queue_count     = (known after apply)
          + stack_type      = "IPV4_ONLY"
          + subnetwork      = (known after apply)
        }
    }

  # google_compute_instance.db_server will be created
  + resource "google_compute_instance" "db_server" {
      + can_ip_forward      = false
      + cpu_platform        = (known after apply)
      + current_status      = "RUNNING"
      + deletion_protection = false
      + description         = ""
      + desired_status      = "RUNNING"
      + enable_display      = false
      + guest_accelerator   = (known after apply)
      + id                  = (known after apply)
      + instance_id         = (known after apply)
      + label_fingerprint   = (known after apply)
      + machine_type        = "n1-standard-8"
      + metadata            = {
          + "ssh-keys" = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC..."
          + "startup-script" = "#!/bin/bash\napt-get update\napt-get install -y postgresql postgresql-contrib\nsystemctl enable postgresql\nsystemctl start postgresql"
        }
      + metadata_fingerprint = (known after apply)
      + name                = "budushee-db-server"
      + project             = "budushee-2-0-dev"
      + self_link           = (known after apply)
      + tags                = ["db-server"]
      + tags_fingerprint    = (known after apply)
      + zone                = "europe-west1-b"

      + boot_disk {
          + auto_delete                = true
          + device_name                = "persistent-disk-0"
          + disk_encryption_key_raw    = (sensitive value)
          + initialize_params {
              + image  = "ubuntu-os-cloud/ubuntu-2004-lts"
              + labels = (known after apply)
              + size   = 500
              + type   = "pd-ssd"
            }
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)
        }

      + network_interface {
          + ipv6_access_type = (known after apply)
          + name            = "nic0"
          + network         = (known after apply)
          + network_ip      = (known after apply)
          + queue_count     = (known after apply)
          + stack_type      = "IPV4_ONLY"
          + subnetwork      = (known after apply)
        }
    }

  # google_compute_instance.monitoring_server will be created
  + resource "google_compute_instance" "monitoring_server" {
      + can_ip_forward      = false
      + cpu_platform        = (known after apply)
      + current_status      = "RUNNING"
      + deletion_protection = false
      + description         = ""
      + desired_status      = "RUNNING"
      + enable_display      = false
      + guest_accelerator   = (known after apply)
      + id                  = (known after apply)
      + instance_id         = (known after apply)
      + label_fingerprint   = (known after apply)
      + machine_type        = "n1-standard-2"
      + metadata            = {
          + "ssh-keys" = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC..."
          + "startup-script" = "#!/bin/bash\napt-get update\napt-get install -y docker.io docker-compose\nsystemctl enable docker\nsystemctl start docker"
        }
      + metadata_fingerprint = (known after apply)
      + name                = "budushee-monitoring-server"
      + project             = "budushee-2-0-dev"
      + self_link           = (known after apply)
      + tags                = ["monitoring-server"]
      + tags_fingerprint    = (known after apply)
      + zone                = "europe-west1-b"

      + boot_disk {
          + auto_delete                = true
          + device_name                = "persistent-disk-0"
          + disk_encryption_key_raw    = (sensitive value)
          + initialize_params {
              + image  = "ubuntu-os-cloud/ubuntu-2004-lts"
              + labels = (known after apply)
              + size   = 50
              + type   = "pd-ssd"
            }
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)
        }

      + network_interface {
          + ipv6_access_type = (known after apply)
          + name            = "nic0"
          + network         = (known after apply)
          + network_ip      = (known after apply)
          + queue_count     = (known after apply)
          + stack_type      = "IPV4_ONLY"
          + subnetwork      = (known after apply)
        }
    }

  # google_compute_instance.web_server will be created
  + resource "google_compute_instance" "web_server" {
      + can_ip_forward      = false
      + cpu_platform        = (known after apply)
      + current_status      = "RUNNING"
      + deletion_protection = false
      + description         = ""
      + desired_status      = "RUNNING"
      + enable_display      = false
      + guest_accelerator   = (known after apply)
      + id                  = (known after apply)
      + instance_id         = (known after apply)
      + label_fingerprint   = (known after apply)
      + machine_type        = "n1-standard-2"
      + metadata            = {
          + "ssh-keys" = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC..."
          + "startup-script" = "#!/bin/bash\napt-get update\napt-get install -y nginx docker.io\nsystemctl enable nginx\nsystemctl start nginx\nsystemctl enable docker\nsystemctl start docker"
        }
      + metadata_fingerprint = (known after apply)
      + name                = "budushee-web-server"
      + project             = "budushee-2-0-dev"
      + self_link           = (known after apply)
      + tags                = ["web-server"]
      + tags_fingerprint    = (known after apply)
      + zone                = "europe-west1-b"

      + boot_disk {
          + auto_delete                = true
          + device_name                = "persistent-disk-0"
          + disk_encryption_key_raw    = (sensitive value)
          + initialize_params {
              + image  = "ubuntu-os-cloud/ubuntu-2004-lts"
              + labels = (known after apply)
              + size   = 50
              + type   = "pd-ssd"
            }
          + kms_key_self_link          = (known after apply)
          + mode                       = "READ_WRITE"
          + source                     = (known after apply)
        }

      + network_interface {
          + access_config {
              + nat_ip       = (known after apply)
              + network_tier = (known after apply)
            }
          + ipv6_access_type = (known after apply)
          + name            = "nic0"
          + network         = (known after apply)
          + network_ip      = (known after apply)
          + queue_count     = (known after apply)
          + stack_type      = "IPV4_ONLY"
          + subnetwork      = (known after apply)
        }
    }

  # google_compute_instance_group.web_group will be created
  + resource "google_compute_instance_group" "web_group" {
      + creation_timestamp = (known after apply)
      + description        = "Instance group for web servers"
      + fingerprint        = (known after apply)
      + id                 = (known after apply)
      + name               = "budushee-web-group"
      + project            = "budushee-2-0-dev"
      + self_link          = (known after apply)
      + size               = (known after apply)
      + zone               = "europe-west1-b"
    }

  # google_compute_network.vpc_network will be created
  + resource "google_compute_network" "vpc_network" {
      + auto_create_subnetworks         = false
      + delete_default_routes_on_create = false
      + description                     = "VPC network for Будущее 2.0 infrastructure"
      + gateway_ipv4                    = (known after apply)
      + id                              = (known after apply)
      + mtu                             = 1460
      + name                            = "budushee-vpc"
      + project                         = "budushee-2-0-dev"
      + routing_mode                    = "REGIONAL"
      + self_link                       = (known after apply)
    }

  # google_compute_router.nat_router will be created
  + resource "google_compute_router" "nat_router" {
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "budushee-nat-router"
      + network            = (known after apply)
      + project            = "budushee-2-0-dev"
      + region             = "europe-west1"
      + self_link          = (known after apply)
    }

  # google_compute_router_nat.nat_gateway will be created
  + resource "google_compute_router_nat" "nat_gateway" {
      + icmp_idle_timeout_sec                = 30
      + id                                   = (known after apply)
      + log_config {
          + enable = false
          + filter = "ERRORS_ONLY"
        }
      + min_ports_per_vm                    = 64
      + name                                 = "budushee-nat-gateway"
      + nat_ip_allocate_option               = "AUTO_ONLY"
      + project                              = "budushee-2-0-dev"
      + region                               = "europe-west1"
      + router                               = (known after apply)
      + source_subnetwork_ip_ranges_to_nat   = "ALL_SUBNETWORKS_ALL_IP_RANGES"
      + tcp_established_idle_timeout_sec      = 1200
      + tcp_transitory_idle_timeout_sec      = 30
      + udp_idle_timeout_sec                 = 30
    }

  # google_compute_subnetwork.private_subnet will be created
  + resource "google_compute_subnetwork" "private_subnet" {
      + creation_timestamp = (known after apply)
      + description        = "Private subnet for application and database servers"
      + fingerprint        = (known after apply)
      + gateway_address    = (known after apply)
      + id                 = (known after apply)
      + ip_cidr_range      = "10.0.2.0/24"
      + name               = "budushee-private-subnet"
      + network            = (known after apply)
      + project            = "budushee-2-0-dev"
      + region             = "europe-west1"
      + self_link          = (known after apply)
    }

  # google_compute_subnetwork.public_subnet will be created
  + resource "google_compute_subnetwork" "public_subnet" {
      + creation_timestamp = (known after apply)
      + description        = "Public subnet for web servers"
      + fingerprint        = (known after apply)
      + gateway_address    = (known after apply)
      + id                 = (known after apply)
      + ip_cidr_range      = "10.0.1.0/24"
      + name               = "budushee-public-subnet"
      + network            = (known after apply)
      + project            = "budushee-2-0-dev"
      + region             = "europe-west1"
      + self_link          = (known after apply)
    }

  # google_compute_target_http_proxy.web_proxy will be created
  + resource "google_compute_target_http_proxy" "web_proxy" {
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "budushee-web-proxy"
      + project            = "budushee-2-0-dev"
      + self_link          = (known after apply)
      + url_map            = (known after apply)
    }

  # google_compute_url_map.web_url_map will be created
  + resource "google_compute_url_map" "web_url_map" {
      + creation_timestamp = (known after apply)
      + default_service   = (known after apply)
      + fingerprint       = (known after apply)
      + id                = (known after apply)
      + name              = "budushee-web-url-map"
      + project           = "budushee-2-0-dev"
      + self_link          = (known after apply)
    }

Plan: 20 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + estimated_monthly_cost = {
      + app_server_cost        = "~$100/month (n1-standard-4)"
      + db_server_cost         = "~$200/month (n1-standard-8)"
      + load_balancer_cost     = "~$20/month"
      + monitoring_server_cost = "~$50/month (n1-standard-2)"
      + storage_cost           = "~$30/month (700GB SSD)"
      + total_estimated_cost   = "~$450/month"
      + web_server_cost        = "~$50/month (n1-standard-2)"
    }
  + next_steps = [
      + "1. Configure SSL certificates on load balancer",
      + "2. Deploy applications using Docker containers",
      + "3. Set up database with proper security",
      + "4. Configure monitoring and alerting",
      + "5. Set up automated backups",
      + "6. Configure CI/CD pipeline",
    ]

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

google_compute_network.vpc_network: Creating...
google_compute_network.vpc_network: Creation complete after 2s [id=projects/budushee-2-0-dev/global/networks/budushee-vpc]
google_compute_subnetwork.public_subnet: Creating...
google_compute_subnetwork.private_subnet: Creating...
google_compute_subnetwork.public_subnet: Creation complete after 1s [id=projects/budushee-2-0-dev/regions/europe-west1/subnetworks/budushee-public-subnet]
google_compute_subnetwork.private_subnet: Creation complete after 1s [id=projects/budushee-2-0-dev/regions/europe-west1/subnetworks/budushee-private-subnet]
google_compute_router.nat_router: Creating...
google_compute_router.nat_router: Creation complete after 1s [id=projects/budushee-2-0-dev/regions/europe-west1/routers/budushee-nat-router]
google_compute_router_nat.nat_gateway: Creating...
google_compute_router_nat.nat_gateway: Creation complete after 1s [id=projects/budushee-2-0-dev/regions/europe-west1/routers/budushee-nat-router/nats/budushee-nat-gateway]
google_compute_firewall.web_firewall: Creating...
google_compute_firewall.app_firewall: Creating...
google_compute_firewall.db_firewall: Creating...
google_compute_firewall.ssh_firewall: Creating...
google_compute_firewall.web_firewall: Creation complete after 1s [id=projects/budushee-2-0-dev/global/firewalls/budushee-web-firewall]
google_compute_firewall.app_firewall: Creation complete after 1s [id=projects/budushee-2-0-dev/global/firewalls/budushee-app-firewall]
google_compute_firewall.db_firewall: Creation complete after 1s [id=projects/budushee-2-0-dev/global/firewalls/budushee-db-firewall]
google_compute_firewall.ssh_firewall: Creation complete after 1s [id=projects/budushee-2-0-dev/global/firewalls/budushee-ssh-firewall]
google_compute_instance.web_server: Creating...
google_compute_instance.app_server: Creating...
google_compute_instance.db_server: Creating...
google_compute_instance.monitoring_server: Creating...
google_compute_instance.web_server: Still creating... [10s elapsed]
google_compute_instance.app_server: Still creating... [10s elapsed]
google_compute_instance.db_server: Still creating... [10s elapsed]
google_compute_instance.monitoring_server: Still creating... [10s elapsed]
google_compute_instance.web_server: Still creating... [20s elapsed]
google_compute_instance.app_server: Still creating... [20s elapsed]
google_compute_instance.db_server: Still creating... [20s elapsed]
google_compute_instance.monitoring_server: Still creating... [20s elapsed]
google_compute_instance.web_server: Still creating... [30s elapsed]
google_compute_instance.app_server: Still creating... [30s elapsed]
google_compute_instance.db_server: Still creating... [30s elapsed]
google_compute_instance.monitoring_server: Still creating... [30s elapsed]
google_compute_instance.web_server: Creation complete after 35s [id=projects/budushee-2-0-dev/zones/europe-west1-b/instances/budushee-web-server]
google_compute_instance.app_server: Creation complete after 36s [id=projects/budushee-2-0-dev/zones/europe-west1-b/instances/budushee-app-server]
google_compute_instance.db_server: Creation complete after 37s [id=projects/budushee-2-0-dev/zones/europe-west1-b/instances/budushee-db-server]
google_compute_instance.monitoring_server: Creation complete after 38s [id=projects/budushee-2-0-dev/zones/europe-west1-b/instances/budushee-monitoring-server]
google_compute_global_address.web_ip: Creating...
google_compute_global_address.web_ip: Creation complete after 1s [id=projects/budushee-2-0-dev/global/addresses/budushee-web-ip]
google_compute_http_health_check.web_health_check: Creating...
google_compute_http_health_check.web_health_check: Creation complete after 1s [id=projects/budushee-2-0-dev/global/healthChecks/budushee-web-health-check]
google_compute_instance_group.web_group: Creating...
google_compute_instance_group.web_group: Creation complete after 1s [id=projects/budushee-2-0-dev/zones/europe-west1-b/instanceGroups/budushee-web-group]
google_compute_backend_service.web_backend: Creating...
google_compute_backend_service.web_backend: Creation complete after 2s [id=projects/budushee-2-0-dev/global/backendServices/budushee-web-backend]
google_compute_url_map.web_url_map: Creating...
google_compute_url_map.web_url_map: Creation complete after 1s [id=projects/budushee-2-0-dev/global/urlMaps/budushee-web-url-map]
google_compute_target_http_proxy.web_proxy: Creating...
google_compute_target_http_proxy.web_proxy: Creation complete after 1s [id=projects/budushee-2-0-dev/global/targetHttpProxies/budushee-web-proxy]
google_compute_global_forwarding_rule.web_forwarding_rule: Creating...
google_compute_global_forwarding_rule.web_forwarding_rule: Creation complete after 1s [id=projects/budushee-2-0-dev/global/forwardingRules/budushee-web-forwarding-rule]

Apply complete! Resources: 20 added, 0 changed, 0 destroyed.

Outputs:

estimated_monthly_cost = {
  "app_server_cost" = "~$100/month (n1-standard-4)"
  "db_server_cost" = "~$200/month (n1-standard-8)"
  "load_balancer_cost" = "~$20/month"
  "monitoring_server_cost" = "~$50/month (n1-standard-2)"
  "storage_cost" = "~$30/month (700GB SSD)"
  "total_estimated_cost" = "~$450/month"
  "web_server_cost" = "~$50/month (n1-standard-2)"
}
infrastructure_summary = {
  "app_server" = "budushee-app-server"
  "db_server" = "budushee-db-server"
  "load_balancer_ip" = "34.102.136.205"
  "monitoring_server" = "budushee-monitoring-server"
  "project_name" = "budushee"
  "private_subnet" = "budushee-private-subnet"
  "public_subnet" = "budushee-public-subnet"
  "region" = "europe-west1"
  "vpc_name" = "budushee-vpc"
  "web_server" = "budushee-web-server"
  "zone" = "europe-west1-b"
}
load_balancer_ip = "34.102.136.205"
load_balancer_url = "http://34.102.136.205"
next_steps = [
  "1. Configure SSL certificates on load balancer",
  "2. Deploy applications using Docker containers",
  "3. Set up database with proper security",
  "4. Configure monitoring and alerting",
  "5. Set up automated backups",
  "6. Configure CI/CD pipeline",
]
web_server_public_ip = "34.102.136.205"
web_server_ssh_command = "ssh -i ~/.ssh/id_rsa ubuntu@34.102.136.205"
```


```
┌─────────────────────────────────────────────────────────────────────────────────┐
│                                                                                 │
│  ✅ Apply complete! Resources: 20 added, 0 changed, 0 destroyed.              │
│                                                                                 │
│  📊 Outputs:                                                                    │
│                                                                                 │
│  estimated_monthly_cost = {                                                    │
│    "app_server_cost" = "~$100/month (n1-standard-4)"                          │
│    "db_server_cost" = "~$200/month (n1-standard-8)"                           │
│    "load_balancer_cost" = "~$20/month"                                         │
│    "monitoring_server_cost" = "~$50/month (n1-standard-2)"                    │
│    "storage_cost" = "~$30/month (700GB SSD)"                                  │
│    "total_estimated_cost" = "~$450/month"                                     │
│    "web_server_cost" = "~$50/month (n1-standard-2)"                           │
│  }                                                                              │
│                                                                                 │
│  infrastructure_summary = {                                                    │
│    "app_server" = "budushee-app-server"                                        │
│    "db_server" = "budushee-db-server"                                          │
│    "load_balancer_ip" = "34.102.136.205"                                      │
│    "monitoring_server" = "budushee-monitoring-server"                          │
│    "project_name" = "budushee"                                                 │
│    "private_subnet" = "budushee-private-subnet"                                │
│    "public_subnet" = "budushee-public-subnet"                                   │
│    "region" = "europe-west1"                                                   │
│    "vpc_name" = "budushee-vpc"                                                 │
│    "web_server" = "budushee-web-server"                                        │
│    "zone" = "europe-west1-b"                                                   │
│  }                                                                              │
│                                                                                 │
│  load_balancer_ip = "34.102.136.205"                                          │
│  load_balancer_url = "http://34.102.136.205"                                   │
│                                                                                 │
│  🎯 next_steps = [                                                             │
│    "1. Configure SSL certificates on load balancer",                          │
│    "2. Deploy applications using Docker containers",                          │
│    "3. Set up database with proper security",                                  │
│    "4. Configure monitoring and alerting",                                    │
│    "5. Set up automated backups",                                              │
│    "6. Configure CI/CD pipeline",                                              │
│  ]                                                                              │
│                                                                                 │
│  web_server_public_ip = "34.102.136.205"                                      │
│  web_server_ssh_command = "ssh -i ~/.ssh/id_rsa ubuntu@34.102.136.205"        │
│                                                                                 │
└─────────────────────────────────────────────────────────────────────────────────┘
```
