#!/bin/bash

# This script is designed to extract all data from a specific table
# in a database and save it as an SQL file.
# As per the assignment, it will dump the 'sales_data' table
# into 'sales_data.sql'.

# --- PLEASE CONFIGURE YOUR DATABASE DETAILS BELOW ---
# You will need to replace the placeholder values (e.g., "your_username")
# with the actual credentials and connection details for your database.

# Database connection details
DB_HOST="localhost"         # Replace with your database host (e.g., IP address or 'localhost')
DB_USER="your_username"     # Replace with your database username
DB_PASSWORD="your_password" # Replace with your database password
DB_NAME="your_database_name"  # Replace with the name of your database

# Table and output file configuration
TABLE_NAME="sales_data"
OUTPUT_FILE="sales_data.sql"

# The following command uses 'mysqldump', which is for MySQL/MariaDB databases.
echo "Starting data dump for table '$TABLE_NAME' from database '$DB_NAME'..."

# Command to dump the data from the specified table into the output file.
mysqldump --host="$DB_HOST" --user="$DB_USER" --password="$DB_PASSWORD" "$DB_NAME" "$TABLE_NAME" > "$OUTPUT_FILE"

# Check the exit code of the last command to see if it was successful.
if [ $? -eq 0 ]; then
  echo "Successfully extracted all rows from '$TABLE_NAME' into '$OUTPUT_FILE'."
else
  echo "Error: The data dump operation failed. Please check your database credentials and connection details."
  rm -f "$OUTPUT_FILE"
  exit 1
fi

echo "Data dump complete."

