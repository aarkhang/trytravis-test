resource "google_compute_instance" "db" {
  name         = "${var.instance_name}"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"

  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  tags = ["reddit-db"]

  # определение сетевого интерфейса
  network_interface {
    network    = "default"
    network_ip = "${google_compute_address.db_ip.address}"

    access_config = {}
  }

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }
}

resource "google_compute_firewall" "firewall_mongo" {
  name        = "${var.fw_mongo_name}"
  description = "Allow MongoDB access from instances with given tag"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["27017"]
  }

  # правило применимо к инстансам с тегом ...
  target_tags = ["reddit-db"]

  # порт будет доступен только для инстансов с тегом ...
  source_tags = ["reddit-app"]
}

resource "google_compute_address" "db_ip" {
  name         = "${var.db_ip_name}"
  address_type = "INTERNAL"
}
