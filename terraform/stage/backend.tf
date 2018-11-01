terraform {
  backend "gcs" {
    bucket = "infra-219311-tfstate"
    prefix = "stage"
  }
}
