resource "snowflake_database" "database_1" {
  // 
  name    = "DEMO_JACK"
  comment = "Database for me Terraform demo"
}

resource "snowflake_database" "database_2" {
  // 
  name    = "DEMO_DAN"
  comment = "Database for me Terraform demo"
}
