-- =========================================
-- Project: Hospital Readmission Analysis (Diabetes Dataset)
-- File: 02_eda_analysis.sql
-- Author: Sidra Khan
-- =========================================



-- =========================================
-- Section: Patient Distribution by Age Group
-- Description: Calculate the total number of patients in each age group
-- Purpose: Understand the demographic distribution of patients

SELECT age_group, COUNT(*)
FROM diabetes_clean
GROUP BY age_group;


-- =========================================
-- Section: Overall Readmission Distribution
-- Description: Calculate the total number of patients who were readmitted vs not readmitted
-- Purpose: Identify general readmission patterns in the dataset
-- =========================================

SELECT readmitted, COUNT(*)
FROM diabetes_clean
GROUP BY readmitted;

-- =========================================
-- Section: Patient Count by Gender
-- Description: Calculate the total number of patients for each gender
-- Purpose: Understand gender distribution and analyze gender-based trends
-- =========================================

SELECT GENDER, COUNT(*) AS patient_count
FROM diabetes_clean

GROUP BY GENDER;

