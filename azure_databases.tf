resource "snowflake_database" "azure_role_1" {
  name    = "AZURE_PIPELINE_DEV"
  comment = "Azure pipelining development envirement."
}

resource "snowflake_database" "azure_role_2" {
  name    = "AZURE_PIPELINE_TST"
  comment = "Azure pipelining test envirement."
}

resource "snowflake_database" "azure_role_3" {
  name    = "AZURE_PIPELINE_PRD"
  comment = "Azure pipelining prd envirement."
}
