terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.61.0"
    }
  }
}

provider "snowflake" {
  // required
  username = "danielwilczak"
  account  = "op06195" # the Snowflake account identifier
  region = "ca-central-1.aws"
  // optional, exactly one must be set
  password  = "Dmw0234567!@"
}

resource "snowflake_database" "AZURE_PIPELINE_PRD" {
  name                        = "AZURE_PIPELINE_PRD"
  comment                     = "Production azure account for pipelining."
  data_retention_time_in_days = 3
}

resource "snowflake_database" "AZURE_PIPELINE_TST" {
  name                        = "AZURE_PIPELINE_TST"
  comment                     = "Test azure account for pipelining."
  data_retention_time_in_days = 3
}

resource "snowflake_database" "AZURE_PIPELINE_DE" {
  name                        = "AZURE_PIPELINE_DEV"
  comment                     = "Dev azure account for pipelining."
  data_retention_time_in_days = 3
}