resource "snowflake_database" "sandbox_1" {
  name    = "SANDBOX"
  comment = "Database the give admin access to devs to allow for development."
}
