resource "snowflake_database" "dbt_database_1" {
  name    = "DBT_DEV"
  comment = "DBT development database."
}

resource "snowflake_database" "dbt_database_2" {
  name    = "DBT_TEST"
  comment = "Dbt testing database."
}

resource "snowflake_database" "dbt_database_3" {
  name    = "DBT_PROD"
  comment = "Dbt production database"
}
