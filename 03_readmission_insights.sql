-- =========================================
-- Project: Hospital Readmission Analysis (Diabetes Dataset)
-- File: 03_business_analysis.sql
-- Author: Sidra Khan
-- =========================================


-- -- =========================================
-- Section: Readmission Rate by Age Group
-- Description: Calculate total patients and readmission rates for each age group
-- Purpose: Identify age groups at higher risk of30- days  hospital readmission
-- =========================================


SELECT  age_group, 
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY age_group, 
ORDER BY Readmit_Rate_Percent DESC;


-- =========================================
-- Section: Readmission Risk by Uncontrolled A1C
-- Description: Analyze whether patients with high/uncontrolled A1C values have higher readmission risk
-- Purpose: Identify if poor blood sugar control contributes to readmissions
-- =========================================


SELECT A1C_FLAG,
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY A1C_Flag
ORDER BY Readmit_Rate_Percent DESC;



-- =========================================
-- Section: Insulin Usage by Racial/Ethnic Group
-- Description: Compare insulin usage rates among different racial and ethnic groups
-- Purpose: Identify which groups use more insulin and potential disparities in care
-- =========================================

SELECT
    race,
    insulin,
    COUNT(*) AS Total_Patients
FROM diabetes_clean
GROUP BY race, insulin
ORDER BY race, insulin DESC;


-- =========================================
-- Section: Readmission Rates by Hospital Department
-- Description: Analyze readmission rates across hospital departments
-- Purpose: Identify departments with highest readmission rates to focus interventions
-- =========================================

SELECT
    medical_specialty,
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY medical_specialty
HAVING COUNT(*) > 50    -- remove very small departments (important!)
ORDER BY Readmit_Rate_Percent DESC;


-- =========================================
-- Section: Readmission by Insulin Therapy Type
-- Description: Examine readmission patterns based on insulin therapy type (Up, Down, Steady, None)
-- Purpose: Determine which therapy type is associated with higher readmission risk
-- =========================================

SELECT
    insulin,
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY insulin
ORDER BY Readmit_Rate_Percent DESC;




