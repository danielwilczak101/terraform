terraform {
  // Snowflake setup
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.61.0"
    }
  }
  // Terraform setup.
  cloud {
    organization = "danielwilczak"

    workspaces {
      name = "terraform"
    }
  }
}

provider "snowflake" {
  // Filled in by terraform wrokspace envirement variables.
}

resource "snowflake_database" "demo_update" {
  name    = "DEMO_UPDATE"
  comment = "Database for me Terraform demo"
}