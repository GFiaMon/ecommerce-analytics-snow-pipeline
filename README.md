# E-commerce Analytics Pipeline

A modern data pipeline that ingests raw data from Amazon S3, transforms it in Snowflake using dbt, and orchestrates workflows with Apache Airflow.

![Pipeline Architecture](https://via.placeholder.com/800x400.png?text=S3+→+Snowflake+→+dbt+→+Airflow) 
*(Consider adding architecture diagram later)*

## Project Overview

This repository contains an end-to-end data pipeline that:
1. **Ingests raw data** from S3 buckets into Snowflake
2. **Transforms data** using dbt to create star schema models
3. **Orchestrates workflows** with Airflow DAGs
4. **Generates analytics-ready tables** for business intelligence

## Key Features

- **Cloud Storage**: Raw data stored in AWS S3 buckets
- **Snowflake Integration**: Automated data loading into Snowflake
- **dbt Transformations**:
  - Staging layer for raw data
  - Star schema models for analytics
  - Fact & dimension tables
- **Airflow Orchestration**:
  - Scheduled pipeline runs
  - Dependency management
  - Error handling & retries

## Technology Stack

| Component       | Technology                 |
|-----------------|----------------------------|
| **Cloud Storage** | AWS S3                   |
| **Data Warehouse**| Snowflake                |
| **Transformation**| dbt (Data Build Tool)    |
| **Orchestration** | Apache Airflow           |
| **Version Control**| GitHub                  |

## Project Structure
