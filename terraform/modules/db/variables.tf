variable name_suffix {
  description = "Suffix for resource names"
}

variable zone {
  description = "Zone"
}

variable machine_type {
  description = "Machine type"
}

variable db_disk_image {
  description = "Disk image for reddit db"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable env_name {
  description = "Name of environment (production, stage, develop...)"
}
