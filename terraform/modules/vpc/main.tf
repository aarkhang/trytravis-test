resource "google_compute_firewall" "firewall_ssh" {
  name        = "allow-ssh${var.name_suffix}"
  description = "Allow SSH from somewhere"
  network     = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = "${var.source_ranges}"
}
