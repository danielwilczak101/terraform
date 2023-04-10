resource "snowflake_role" "azure_1" {
  name    = "DEV_DATA_LOADER_ROLE"
  comment = "Role for database"
}

resource "snowflake_role" "azure_2" {
  name    = "TST_DATA_LOADER_ROLE"
  comment = "Role for database"
}

resource "snowflake_role" "azure_3" {
  name    = "PRD_DATA_LOADER_ROLE"
  comment = "Role for database"
}
