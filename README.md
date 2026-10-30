# SQL Server to Databricks Data Warehouse Rebuild

This project rebuilds a SQL Server data warehouse on Databricks using dbt.
Source data from CRM and ERP systems is provided as CSV files and has been
loaded into a Databricks catalog. dbt is used to transform that data through
the Silver and Gold layers of a medallion architecture.

The original warehouse project was built with SQL Server. This rebuild adapts
its data transformations and analytical model for Databricks SQL and dbt.

## Project goals

- Rebuild the analytical warehouse on Databricks.
- Clean, standardize, and integrate source data with dbt.
- Create business-ready models for reporting and analysis.
- Model sales, customers, and products in a structure suitable for analytical
  queries.
- Document the transformation project and its run workflow.

## Architecture

![Uploading rebuild.jpg…]()


The input data is already available in Databricks. This repository focuses on
the dbt transformations and warehouse models; it does not implement the CSV
ingestion process.

## Medallion layers

| Layer | Role in this rebuild |
|---|---|
| **Bronze** | dbt table models select the source data registered in the Databricks catalog. |
| **Silver** | dbt models clean and standardize customer, location, product, category, and sales data. |
| **Gold** | dbt models combine the Silver data into customer and product dimensions and a sales fact for analytics. |

The Gold layer follows a dimensional modeling approach, with `dim_customers`
and `dim_products` dimensions joined to `fact_sales`.

## Source data

The dbt sources are declared in
[`sql_warehouse_rebuild/models/source/sources.yml`](./sql_warehouse_rebuild/models/source/sources.yml).
They currently include:

- `cust_info`
- `cust_az_12`
- `loc_a_101`
- `prd_info`
- `px_cat_g_1_v_2`
- `sales_details`

The source declaration points to the `sql_replication.source` catalog and
schema. Update it if your Databricks source tables are in a different location.

## dbt project

The dbt project lives in [`sql_warehouse_rebuild/`](./sql_warehouse_rebuild/).

```text
sql_warehouse_rebuild/
├── analyses/        # Standalone analytical SQL
├── macros/          # Reusable dbt macros
├── models/
│   ├── source/      # Databricks source declarations
│   ├── bronze/      # Source-facing table models
│   ├── silver/      # Cleansed and standardized models
│   └── gold/        # Analytics-ready dimensions and fact
├── snapshots/       # dbt snapshot definitions
├── tests/           # Custom SQL data-quality tests
└── dbt_project.yml
```

## Requirements and configuration

- Python 3.11 or later
- [uv](https://docs.astral.sh/uv/)
- A Databricks workspace with the source tables available
- A dbt profile named `sql_warehouse_rebuild`

Install the project dependencies from the repository root:

```powershell
uv sync
```

Configure the dbt profile using your Databricks workspace and compute
credentials. Keep secrets out of source control; use environment variables or
an untracked local profile file.

## Running dbt

Run the following commands from the repository root:

```powershell
# Check the profile and connection
uv run dbt debug --project-dir sql_warehouse_rebuild --profiles-dir .

# Parse the project
uv run dbt parse --project-dir sql_warehouse_rebuild --profiles-dir .

# Build models
uv run dbt run --project-dir sql_warehouse_rebuild --profiles-dir .

# Run data-quality tests
uv run dbt test --project-dir sql_warehouse_rebuild --profiles-dir .

# Run snapshots
uv run dbt snapshot --project-dir sql_warehouse_rebuild --profiles-dir .

# Generate documentation and lineage artifacts
uv run dbt docs generate --project-dir sql_warehouse_rebuild --profiles-dir .
```

To rebuild models in a folder, use a dbt path selector. For example:

```powershell
uv run dbt run --project-dir sql_warehouse_rebuild --profiles-dir . --select path:models/bronze
```

Use `--full-refresh` when you intentionally want to recreate selected
incremental models from their full source data. The current layer
materializations are configured in `sql_warehouse_rebuild/dbt_project.yml`.

## Scope

This repository contains the Databricks/dbt warehouse rebuild. The previous
SQL Server implementation is the source of the rebuild requirements; the
transformations for this version run in dbt against Databricks. Airflow
orchestration is not included in the current implementation.
