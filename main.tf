terraform {
  // Snowflake setup
  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "0.69.0"
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

resource "snowflake_database" "db_snow" {
  name    = "SNOWING"
  comment = "TEMP"
}

resource "snowflake_database" "db" {
  name    = "SPINY_DB"
  comment = "Demo to show kyle you can git control snowflake."
}

resource "snowflake_schema" "schema" {
  database = "SPINY_DB"
  name     = "ML_MODELS"
  comment  = "A schema that stores all data related to our machine learning models."
}

resource "snowflake_procedure" "proc" {
  name     = "SAMPLEPROC"
  database = snowflake_database.db.name
  schema   = snowflake_schema.schema.name
  language = "JAVASCRIPT"
  arguments {
    name = "arg1"
    type = "varchar"
  }
  arguments {
    name = "arg2"
    type = "DATE"
  }
  comment             = "Procedure with 2 arguments"
  return_type         = "VARCHAR"
  execute_as          = "CALLER"
  return_behavior     = "IMMUTABLE"
  null_input_behavior = "RETURNS NULL ON NULL INPUT"
  statement           = <<EOT
  var X=1
  return X
  EOT
}