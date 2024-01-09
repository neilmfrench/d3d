provider "google" {
  credentials = file("... your GCP credentials")
  project     = var.project_id
  region      = var.region
}

resource "google_compute_instance" "vm_instance" {
  name           = var.instance_name
  machine_type   = var.machine_type
  zone           = var.zone
  tags           = ["d3d"]
  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    // left empty deliberately - creates public IP 
    access_config { }
  }

  metadata_startup_script = "apt-get update" 
}

resource "google_compute_firewall" "allow_ssh_http" {
  name    = "allow-ssh-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
