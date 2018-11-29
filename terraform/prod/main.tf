provider "google" {
  version = "1.4.0"
  project = "${var.project}"
  region  = "${var.region}"
}

module "db" {
  source           = "../modules/db"
  name_suffix      = "${var.name_suffix}"
  zone             = "${var.zone}"
  machine_type     = "${var.machine_type}"
  db_disk_image    = "${var.db_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  env_name         = "${var.env_name}"
}

module "app" {
  source           = "../modules/app"
  name_suffix      = "${var.name_suffix}"
  zone             = "${var.zone}"
  machine_type     = "${var.machine_type}"
  app_disk_image   = "${var.app_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  db_address       = "${module.db.db_internal_ip}"
  enable_deploy    = "${var.enable_deploy}"
  env_name         = "${var.env_name}"
}

module "vpc" {
  source        = "../modules/vpc"
  name_suffix   = "${var.name_suffix}"
  source_ranges = ["80.252.153.106/32"]
}
