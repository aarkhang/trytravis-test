provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source        = "../modules/db"
  instance_name = "reddit-db-stage"
  fw_mongo_name = "allow-mongo-stage"
  db_ip_name    = "mongo-ip-stage"

  zone             = "${var.zone}"
  machine_type     = "${var.machine_type}"
  db_disk_image    = "${var.db_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
}

module "app" {
  source           = "../modules/app"
  instance_name    = "reddit-app-stage"
  fw_puma_name     = "allow-puma-stage"
  app_ip_name      = "reddit-ip-stage"
  zone             = "${var.zone}"
  machine_type     = "${var.machine_type}"
  app_disk_image   = "${var.app_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  db_address       = "${module.db.db_internal_ip}"
}

module "vpc" {
  source        = "../modules/vpc"
  firewall_name = "allow-ssh-stage"
  source_ranges = ["0.0.0.0/0"]
}
