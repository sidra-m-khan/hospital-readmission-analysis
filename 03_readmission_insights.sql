-- =========================================
-- Hospital Readmission Analysis
-- Step 3: Readmission Insights
-- =========================================



--5 clinical/business questions--

--1. Which patient age groups have the highest 30-day readmission rates?

--  Age group vs readmission rate:--

SELECT  age_group, 
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY age_group, 
ORDER BY Readmit_Rate_Percent DESC;


-- 2. Does uncontrolled A1C result increase readmission risk?--

-- A1C result vs readmission rate:--

SELECT A1C_FLAG,
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY A1C_Flag
ORDER BY Readmit_Rate_Percent DESC;



-- 3.Which racial/ethnic group has the highest incidence of insulin usage?--

--Race vs insulin usage--

SELECT
    race,
    insulin,
    COUNT(*) AS Total_Patients
FROM diabetes_clean
GROUP BY race, insulin
ORDER BY race, insulin DESC;


-- 4.Which hospital departments have the highest readmission rates?--

--  Department vs readmission rate--

SELECT
    medical_specialty,
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY medical_specialty
HAVING COUNT(*) > 50    -- remove very small departments (important!)
ORDER BY Readmit_Rate_Percent DESC;


5-- What is the distribution of readmissions by insulin therapy type (Up, Down, Steady, None)?--

-- Insulin therapy vs readmission--

SELECT
    insulin,
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY insulin
ORDER BY Readmit_Rate_Percent DESC;

---
SELECT age_group,
    
    COUNT(*) AS Total_Patients,
    SUM(CAST(readmit_30 AS FLOAT)) AS Readmitted,
    SUM(CAST(readmit_30 AS FLOAT)) * 100.0 / COUNT(*) AS Readmit_Rate_Percent
FROM diabetes_clean
GROUP BY  age_group
ORDER BY Readmit_Rate_Percent DESC;
