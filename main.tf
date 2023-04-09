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
  // required
  username = "danielwilczak"
  account  = "op06195" # the Snowflake account identifier

  // optional, exactly one must be set
  password = "Dmw0234567!@"

  // optional
  region = "ca-central-1.aws" # required if using legacy format for account identifier
}

resource "snowflake_database" "DEMO_NOT_ANYMORE" {
  name    = "DEMO_NOT_ANYMORE"
  comment = "Database for me Terraform demo"
}
