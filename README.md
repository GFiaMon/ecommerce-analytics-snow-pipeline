# 🛒 E-commerce Analytics Pipeline

A modern data pipeline that ingests raw data from Amazon S3, transforms it in Snowflake using dbt, and orchestrates workflows with Apache Airflow.  
*(Data journey: 🌩️ S3 → ❄️ Snowflake → 🔧 dbt → ✈️ Airflow)*

## 🗺️ Project Overview

This repository contains an end-to-end data pipeline that:  
1. **📥 Ingests raw data** from S3 buckets into Snowflake  
2. **🔄 Transforms data** using dbt to create star schema models  
3. **🎛️ Orchestrates workflows** with Airflow DAGs  
4. **📊 Generates analytics-ready tables** for business intelligence  

## 🚀 Key Features

- **☁️ Cloud Storage**: Raw data stored in AWS S3 buckets  
- **❄️ Snowflake Integration**: Automated data loading into Snowflake  
- **🔧 dbt Transformations**:  
  - Staging layer for raw data  
  - Star schema models for analytics  
  - Fact & dimension tables  
- **✈️ Airflow Orchestration**:  
  - Scheduled pipeline runs  
  - Dependency management  
  - Error handling & retries  

---

## 🛠️ Technology Stack

| Component       | Technology                 |
|-----------------|----------------------------|
| **☁️ Cloud Storage** | AWS S3                   |
| **❄️ Data Warehouse**| Snowflake                |
| **🔧 Transformation**| dbt (Data Build Tool)    |
| **✈️ Orchestration** | Apache Airflow           |
| **🐙 Version Control**| GitHub                  |

---

## 📂 Project Structure

```
ecommerce-analytics/
├── 📁 dbt/                  
│   ├── 📁 models/           
│   │   ├── 📁 staging/      # Raw source tables
│   │   ├── 📁 marts/        # Business-friendly datasets
│   │   └── 📁 star_schema/  # Fact & dimension tables
│   ├── 📁 macros/           # Reusable SQL components
│   ├── 📁 snapshots/        # (Future) Slowly Changing Dimensions
│   ├── 📄 dbt_project.yml   # dbt configuration
│   └── 📄 packages.yml      # dbt dependencies
├── 📁 airflow/              
│   └── 📁 dags/             
│       └── 📄 pipeline.py   # Airflow workflow definitions
├── 📄 .gitignore            # Excluded files/folders
└── 📄 README.md             # This documentation

---

## 🏁 Getting Started

### ⚙️ Prerequisites

- ✅ AWS account with S3 buckets
- ✅ Snowflake account
- ✅ Python 3.8+
- 🔧 [dbt Cloud or CLI](https://www.getdbt.com/)
- ✈️ [Apache Airflow](https://airflow.apache.org/)

### 🔌 Installation

1. **Clone repository**:
   ```bash
   git clone https://github.com/your-username/ecommerce-analytics.git
   cd ecommerce-analytics
   ```

2. **Install Python dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Configure Snowflake connection**  
   Create `dbt/profiles.yml`:
   ```yaml
   ecommerce:
     target: dev
     outputs:
       dev:
         type: snowflake
         account: <your-account>
         user: <your-username>
         password: <your-password>
         role: <your-role>
         database: <your-database>
         warehouse: <your-warehouse>
         schema: <your-schema>
   ```

4. **Set up Airflow connections**  
   Configure in Airflow UI:
   - ❄️ Snowflake connection  

---

## 🕹️ Usage

### Running dbt Models
```bash
# Run full pipeline 🚀
dbt run --profiles-dir dbt/

# Run specific models 🎯  
dbt run --models marts.sales --profiles-dir dbt/
```

### Triggering Airflow DAG
1. Start Airflow webserver:
   ```bash
   airflow webserver --port 8080
   ```

2. Start Airflow scheduler:
   ```bash
   airflow scheduler
   ```

3. Access Airflow UI at `localhost:8080`  
4. Enable and trigger `ecommerce_pipeline` DAG 🚦  

---

## 🔄 Pipeline Details

### Data Flow
1. **📥 Ingestion**: CSV/JSON files from S3 → Snowflake tables  
2. **🧹 Staging**: Raw data validation & basic cleaning  
3. **🔀 Transformation**:  
   - Create dimension tables (Clients, Products, Time)  
   - Build fact tables (Sales, Orders)  
4. **🎛️ Orchestration**: Airflow manages dependencies between tasks  

### Key Models
| Model              | Type     | Description                     |
|--------------------|----------|---------------------------------|
| `stg_orders`       | 🧱 Staging  | Raw order data from S3          |
| `dim_clients`      | 📐 Dimension| Client information              |
| `fact_sales`       | 💰 Fact     | Sales transactions with metrics|

---

## 🤝 Contributing

1. 🍴 Fork the repository  
2. 🌱 Create feature branch (`git checkout -b feature/improvement`)  
3. 💾 Commit changes (`git commit -m 'Add new feature'`)  
4. 📤 Push to branch (`git push origin feature/improvement`)  
5. 🔀 Open Pull Request  

---

⚠️ **Note**: This project requires proper configuration of AWS and Snowflake credentials before use.  
🔒 **Never commit sensitive information to version control!**

---

Made with ❤️ by Guillermo Fiallo Montero
