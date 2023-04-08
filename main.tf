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
  username = "${env.USERNAME}"
  account  = "${env.ACCOUNT}" # the Snowflake account identifier

  // optional, exactly one must be set
  password = "${env.PASSWORD}"

  // optional
  region = "${env.REGION}" # required if using legacy format for account identifier
}

resource "snowflake_database" "demo_update" {
  name    = "DEMO_UPDATE"
  comment = "Database for me Terraform demo"
}