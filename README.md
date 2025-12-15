# ISTQB + SQL Beginner Test Cases

This repo is a beginner project to practice ISTQB-style test case writing and basic SQL checks for database testing.

## What you practice
- Writing test cases with: ID, Title, Preconditions, Steps, Test Data, Expected Result
- SQL validation queries for CRUD and constraints
- Simple database model: Customers + Orders

## How to run (SQLite)
1. Install SQLite
2. Create DB and run scripts:
   - sqlite3 shop.db < schema/01_create_tables.sql
   - sqlite3 shop.db < schema/02_seed_data.sql
3. Run SQL checks:
   - sqlite3 shop.db < testcases/sql_testcases.sql

## Notes
- SQL scripts validate database behavior after actions like INSERT/UPDATE/DELETE.
- Test case writing follows a clear structure used in many ISTQB-aligned examples.
