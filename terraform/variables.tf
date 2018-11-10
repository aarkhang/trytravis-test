variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable zone {
  description = "Zone"
  default     = "europe-west1-b"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable public_key2_path {
  description = "Path to the second public key used for ssh access"
}

variable private_key2_path {
  description = "Path to the second private key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable machine_type {
  description = "Machine type"
  default     = "f1-micro"
}