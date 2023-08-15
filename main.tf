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
  handler = "main"
  statement           = <<EOT
import os
from sklearn.compose import ColumnTransformer
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import PolynomialFeatures
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split, GridSearchCV
from joblib import dump

def main(session):
  # Load features
  df = session.table('MARKETING_BUDGETS_FEATURES').to_pandas()
  X = df.drop('REVENUE', axis = 1)
  y = df['REVENUE']

  # Split dataset into training and test
  X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state = 42)

  # Preprocess numeric columns
  numeric_features = ['SEARCH_ENGINE','SOCIAL_MEDIA','VIDEO','EMAIL']
  numeric_transformer = Pipeline(steps=[('poly',PolynomialFeatures(degree = 2)),('scaler', StandardScaler())])
  preprocessor = ColumnTransformer(transformers=[('num', numeric_transformer, numeric_features)])

  # Create pipeline and train
  pipeline = Pipeline(steps=[('preprocessor', preprocessor),('classifier', LinearRegression(n_jobs=-1))])
  model = GridSearchCV(pipeline, param_grid={}, n_jobs=-1, cv=10)
  model.fit(X_train, y_train)

  # Upload trained model to a stage
  model_file = os.path.join('/tmp', 'model.joblib')
  dump(model, model_file)
  session.file.put(model_file, "@ml_models",overwrite=True)

  # Return model R2 score on train and test data
  return {"R2 score on Train": model.score(X_train, y_train),"R2 score on Test": model.score(X_test, y_test)}
EOT
}

