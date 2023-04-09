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

variable "SNOWFLAKE_USERNAME" { type = string }
variable "SNOWFLAKE_ACCOUNT" { type = string }
variable "SNOWFLAKE_PASSWORD" { type = string }
variable "SNOWFLAKE_REGION" { type = string }

provider "snowflake" {
  // required
  username = var.SNOWFLAKE_USERNAME
  account  = var.SNOWFLAKE_ACCOUNT

  // optional, exactly one must be set
  password = var.SNOWFLAKE_PASSWORD

  // optional
  region = var.SNOWFLAKE_REGION
}

resource "snowflake_database" "database_1" {
  // 
  name    = "DEMO_JACKING"
  comment = "Database for me Terraform demo"
}

resource "snowflake_database" "database_2" {
  // 
  name    = "DEMO_DAN"
  comment = "Database for me Terraform demo"
}
