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

  // optional, exactly one must be set
  password               = "Dmw0234567!@"
}