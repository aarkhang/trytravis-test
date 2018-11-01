variable firewall_name {
  description = "Name of firewall rule"
}

variable source_ranges {
  description = "Allowed IP addresses"
  type        = "list"
}
