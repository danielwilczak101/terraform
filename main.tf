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
      name = "Spiny_Snowflake"
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

resource "snowflake_database" "db" {
  name    = "SPINY_DB"
  comment = "Demo to show kyle you can git control snowflake procedure for ML models."
}

resource "snowflake_schema" "schema" {
  database = "SPINY_DB"
  name     = "ML_MODELS"
  comment  = "A schema that stores all data related to our machine learning models."
}

resource "snowflake_warehouse" "warehouse" {
  name           = "SNOWPARK_OPT_WH"
  warehouse_size = "MEDIUM"
  warehouse_type = "SNOWPARK-OPTIMIZED"
}

resource "snowflake_procedure" "proc" {
  name     = "SAMPLE_PROC"
  database = snowflake_database.db.name
  schema   = snowflake_schema.schema.name
  language = "PYTHON"
  runtime_version = "3.8"
  comment             = "Creates a stored procedure that trains a linear regression model"
  return_type         = "VARIANT"
  packages = ["snowflake-snowpark-python", "scikit-learn", "joblib"]
  statement           = <<EOT
  
  EOT
}

