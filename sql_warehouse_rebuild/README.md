# SQL Warehouse Rebuild

This folder contains the dbt project for the Databricks warehouse rebuild. It
organizes transformations into Bronze, Silver, and Gold layers, with source
declarations, SQL models, tests, and snapshots.

For architecture, setup, and command examples, see the repository
[README](../README.md).

Run dbt commands from the repository root, for example:

```powershell
uv run dbt run --project-dir sql_warehouse_rebuild --profiles-dir .
```
