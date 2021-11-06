

terraform {
  backend "gcs" {
    bucket = "msds434-w7-terraform"
    prefix = "/state/myapp"
  }
}
