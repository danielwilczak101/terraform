terraform {
  required_providers {
    snowflake = {
      source  = "chanzuckerberg/snowflake"
      version = "0.25.17"
    }
  }

  backend "remote" {
    organization = "danielwilczak"

    workspaces {
      name = "terraform"
    }
  }
}

provider "snowflake" {
  SNOWFLAKE_ACCOUNT = var.SNOWFLAKE_ACCOUNT
  SNOWFLAKE_REGION = var.SNOWFLAKE_REGION
  SNOWFLAKE_USER = var.SNOWFLAKE_USER
  SNOWFLAKE_PASSWORD = var.SNOWFLAKE_PASSWORD
}

resource "snowflake_database" "demo" {
  name    = "DEMO"
  comment = "Database for me Terraform demo"
}