-- =========================================
-- Hospital Readmission Analysis
-- Step 2: Exploratory Data Analysis
-- =========================================



-- Distribution of patients by age group
-- Description: Calculate total patients for age group

SELECT age_group, COUNT(*)
FROM diabetes_clean
GROUP BY age_group;

-- Overall readmission distribution
-- Description: Calculate total patients which are readmitted

SELECT readmitted, COUNT(*)
FROM diabetes_clean
GROUP BY readmitted;

-- Count by Gender
-- Calculate total patientd by Gender

SELECT GENDER, COUNT(*) AS patient_count
FROM diabetes_clean

GROUP BY GENDER;
