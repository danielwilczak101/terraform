resource "snowflake_role" "dbt_role_1" {
  name    = "CURATED_TRANSFORMER_ROLE"
  comment = "Role for database"
}

resource "snowflake_role" "dbt_role_2" {
  name    = "SANDBOX_TRANSFORMER_ROLE"
  comment = "Role for database"
}
