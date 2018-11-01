provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source           = "../modules/db"
  instance_name    = "reddit-db-prod"
  fw_mongo_name    = "allow-mongo-prod"
  db_ip_name       = "mongo-ip-prod"
  zone             = "${var.zone}"
  machine_type     = "${var.machine_type}"
  db_disk_image    = "${var.db_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
}

module "app" {
  source           = "../modules/app"
  instance_name    = "reddit-app-prod"
  fw_puma_name     = "allow-puma-prod"
  app_ip_name      = "reddit-ip-prod"
  zone             = "${var.zone}"
  machine_type     = "${var.machine_type}"
  app_disk_image   = "${var.app_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  db_address       = "${module.db.db_internal_ip}"
}

module "vpc" {
  source        = "../modules/vpc"
  firewall_name = "allow-ssh-prod"
  source_ranges = ["80.252.153.106/32"]
}
