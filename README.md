## Hospital Readmission Analysis — Diabetes Dataset

## Project Overview

Hospital readmissions are a major cost and quality challenge in healthcare systems.
This project analyzes a diabetes patient dataset to identify **clinical and demographic factors associated with 30-day readmission risk**.

The goal is to demonstrate end-to-end data analyst skills including:

- Data cleaning
- SQL-based exploratory data analysis (EDA)
- Business-focused analytical queries
- Dashboard-ready insights


##  Business Objectives

This analysis answers key healthcare questions:

- Does uncontrolled A1C increase readmission risk?
- Which racial/ethnic groups show higher insulin usage?
- Which hospital departments have higher readmission rates?
- How does insulin therapy change relate to readmissions?
- What is the distribution of patients across age groups?


##  Dataset

-- Source:** Public Diabetes Hospital Dataset( Kaggle)
-- Granularity:** Patient encounter level
    *Key Features:**

  - Demographics (age, gender, race)
  - Clinical metrics (A1C result, insulin usage)
  - Hospital utilization (time in hospital, medications)
  - Readmission status


##  Data Cleaning Steps

Performed in `01_data_cleaning.sql`.

**Key transformations:**

- Created working clean table
- Removed duplicate patient encounters
- Standardized missing values (`? → NULL`)
- Removed invalid gender records
- Created binary readmission flag (`readmit_30`)
- Engineered A1C risk categories
- Converted age ranges to numeric midpoint
- Created age group segmentation
- Built high-risk patient flag


##  Exploratory Data Analysis (EDA)

Performed in `02_eda_analysis.sql`.

**EDA includes:**

- Patient distribution by age group
- Overall readmission distribution
- Gender distribution
- Basic population profiling


##  Business Analysis

Performed in `03_business_analysis.sql`.

**Key analyses:**

- A1C control vs readmission risk
- Insulin usage by race/ethnicity
- Department-level readmission comparison
- Readmission by insulin therapy type
- Risk segmentation analysis


##  Tools & Technologies

- **SQL Server** — Data cleaning & analysis
- **Power BI** — Dashboard visualization
- **Excel** — Initial inspection
- **GitHub** — Version control & portfolio


##  Key Insights

- Patients with uncontrolled A1C show higher readmission risk.
- Older age groups have greater hospital readmission risk.
- Insulin therapy changes correlate with readmission patterns.
- Certain specialties show elevated readmission rates.



##  Dashboard Preview

> *##  Hospital Readmission Dashboard
> 
<img width="1920" height="1020" alt="readmission_dashboard png" src="https://github.com/user-attachments/assets/61d9069f-e890-4cee-a144-632260a042d0" />

![Readmission Dashboard](images/readmission_dashboard.png)


## 📁 Project Structure

```
Hospital-Readmission-Analysis
│
├── 01_data_cleaning.sql
├── 02_eda_analysis.sql
├── 03_business_analysis.sql
├── dashboard.png
└── README.md
```


## 💡 What This Project Demonstrates

✅ Real-world healthcare analytics
✅ Advanced SQL data transformation
✅ Feature engineering
✅ Business-oriented analysis
✅ Dashboard storytelling



##  Author

**Sidra Khan**
Aspiring Data Analyst | Pharm.D. Background
Focused on analytics and data-driven decision making.

---

##  Future Improvements

* Add predictive modeling for readmission risk
* Build interactive Power BI dashboard
* Perform cohort analysis
* Add statistical significance testing

---

⭐ *If you found this project useful, feel free to star the repository.*

