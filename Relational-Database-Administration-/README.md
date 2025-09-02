# Relational Database Administration Demonstrations

## Overview

This project provides a collection of scripts demonstrating key tasks in relational database administration and data analysis. It focuses on advanced SQL aggregation techniques for analytics and standard procedures for database backups. The examples use a sample `sales_data` table.

## Features

### Advanced SQL Analytics

The project includes several SQL queries that leverage advanced `GROUP BY` extensions to perform complex aggregations, which are essential for business intelligence and reporting.

*   **`CUBE`**: Generates aggregations for all possible combinations of the specified columns, providing a complete multi-dimensional perspective.
*   **`ROLLUP`**: Creates subtotals that "roll up" from the most detailed level to a grand total, useful for hierarchical data (e.g., sales by country within a year).
*   **`GROUPING SETS`**: Offers fine-grained control by allowing you to specify exactly which groupings you want to aggregate, including non-hierarchical combinations.

### Database Backup

A shell script is provided to demonstrate how to perform a logical backup of a specific table using the `mysqldump` utility. This is a fundamental task for ensuring data integrity and disaster recovery.

## Scripts

### SQL Queries

The SQL files demonstrate various aggregation methods on the `sales_data` table.

#### `CUBE(year, country)`

This query calculates the average sales across all possible combinations of `year` and `country`, including subtotals for each year, each country, and a grand average.

```sql
SELECT
    year,
    country,
    AVG(total_sales) AS average_sales
FROM
    sales_data
GROUP BY
    CUBE(year, country);
```

#### `ROLLUP(year, country)`

This query calculates the sum of sales, creating subtotals for each year and a final grand total, assuming a hierarchy of `country` within `year`.

```sql
SELECT
    year,
    country,
    SUM(total_sales) AS total_sales
FROM
    sales_data
GROUP BY
    ROLLUP(year, country);
```

#### `GROUPING SETS((country, category), ...)`

This query calculates the sum of sales for a custom-defined set of groupings: by `(country, category)`, by `country` alone, by `category` alone, and the grand total.

```sql
SELECT
    country,
    category,
    SUM(total_sales) AS total_sales
FROM
    sales_data
GROUP BY
    GROUPING SETS ((country, category), (country), (category), ());
```

### Backup Script (`E8Mg.sh`)

This shell script uses `mysqldump` to extract the `sales_data` table from a MySQL/MariaDB database and save it to a `.sql` file.

## Prerequisites

*   A running MySQL or MariaDB database server.
*   A database containing a `sales_data` table with columns such as `year`, `country`, `category`, and `total_sales`.
*   The `mysqldump` command-line utility installed (usually included with MySQL client tools).

## Usage

### Running the SQL Queries

You can execute the SQL queries in any standard SQL client connected to your database.

### Running the Backup Script

1.  **Configure the script**: Open the backup script (`E8Mg.sh` or a similar file) and update the following variables with your database connection details:
    *   `DB_HOST`
    *   `DB_USER`
    *   `DB_PASSWORD`
    *   `DB_NAME`
2.  **Make the script executable**:
    ```bash
    chmod +x E8Mg.sh
    ```
3.  **Run the script**:
    ```bash
    ./E8Mg.sh
    ```
    This will create a `sales_data.sql` file in the same directory, containing the backup of your table.

