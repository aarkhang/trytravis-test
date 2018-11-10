variable name_suffix {
  description = "Suffix for resource names"
}

variable zone {
  description = "Zone"
}

variable machine_type {
  description = "Machine type"
}

variable app_disk_image {
  description = "Disk image for reddit app"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable db_address {
  description = "IP address of mongodb server"
}

variable enable_deploy {
  description = "Boolean flag for enable/disable application deploy"
  default     = false
}

variable env_name {
  description = "Name of environment (production, stage, develop...)"
}
