-- =========================================
-- Hospital Readmission Analysis
-- Step 2: Exploratory Data Analysis
-- =========================================



-- Distribution of patients by age group

SELECT age_group, COUNT(*)
FROM diabetes_clean
GROUP BY age_group;

-- Overall readmission distribution
SELECT readmitted, COUNT(*)
FROM diabetes_clean
GROUP BY readmitted;

-- Count by Gender
SELECT GENDER, COUNT(*) AS patient_count
FROM diabetes_clean
GROUP BY GENDER;