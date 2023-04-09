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
  region   = "ca-central-1.aws"
  account  = "op06195"
  username = var.username
  password = var.password
}

variable "username" {
  default = env.USERNAME
}

variable "password" {
  default = env.PASSWORD
}

resource "snowflake_database" "demo_update" {
  name    = "DEMO_UPDATE"
  comment = "Database for me Terraform demo"
}
