-- =========================================
-- Project: Hospital Readmission Analysis (Diabetes Dataset)
-- File: 01_data_cleaning.sql
-- Author: Sidra Khan
-- Description: Clean and preprocess diabetic hospital dataset for analysis
-- =========================================


-- =========================================
-- Section: Create Working Table
-- Description: Create a working copy of the original dataset for cleaning
-- =========================================

SELECT *
INTO diabetes_clean
FROM diabetic_data;

-- =========================================
-- Section: Identify Duplicate Patients
-- Description: Find duplicate patient records by patient number
-- =========================================

SELECT patient_nbr, COUNT(*) AS duplicate
FROM diabetes_clean
GROUP BY patient_nbr
HAVING COUNT(*) > 1;

-- =========================================
-- Section: Remove Duplicate Records
-- Description: Keep only the first encounter for each patient to remove duplicates
-- ========================================= 

DELETE FROM diabetes_clean
WHERE patient_nbr NOT IN (
    SELECT MIN(patient_nbr)
    FROM diabetes_clean
    GROUP BY patient_nbr, encounter_id);


-- =========================================
-- Section: Count Total and Unique Rows
-- Description: Check number of total rows and unique patients after cleaning
-- =========================================

SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT patient_nbr ) AS Unique_Values
FROM diabetes_clean;


-- =========================================
-- Section: Identify Duplicate Encounters
-- Description: Find patient encounters that are duplicated
-- =========================================

SELECT 
    patient_nbr,
    encounter_id,
    COUNT(*) AS Duplicate_Count
FROM diabetes_clean
GROUP BY patient_nbr, encounter_id
HAVING COUNT(*) > 1;


-- =========================================
-- Section: Remove Invalid Gender Values
-- Description: Delete records with 'Unknown/Invalid' gender
-- =========================================

SELECT DISTINCT gender
FROM diabetes_clean;

DELETE FROM diabetes_clean
WHERE gender = 'Unknown/Invalid';


-- =========================================
-- Section: Add Binary Readmission Column
-- Description: Create readmit_30 column for patients readmitted within 30 days
-- =========================================

ALTER TABLE diabetes_clean
ADD readmit_30 BIT;

UPDATE diabetes_clean
SET readmit_30 =
    CASE
        WHEN readmitted = '<30' THEN 1
        ELSE 0
    END;

-- =========================================
-- Section: Clean A1C Results
-- Description: Replace 'None' with NULL and create A1C_flag column for risk categorization
-- =========================================

UPDATE diabetes_clean
SET A1Cresult = NULL
WHERE A1Cresult = 'None';


ALTER TABLE diabetes_clean
ADD A1C_flag VARCHAR(20);

UPDATE diabetes_clean
SET A1C_flag =
    CASE
        WHEN A1Cresult = '>8' THEN 'Uncontrolled'
        WHEN A1Cresult = '>7' THEN 'Elevated'
        WHEN A1Cresult = 'Normal' THEN 'Controlled'
        ELSE NULL
    END;

-- =========================================
-- Section: Add Age Midpoint Column
-- Description: Convert age ranges to numeric midpoint values for analysis
-- =========================================

    ALTER TABLE diabetes_clean
ADD age_mid INT;

UPDATE diabetes_clean
SET age_mid =
    CASE
        WHEN age = '[0-10)' THEN 5
        WHEN age = '[10-20)' THEN 15
        WHEN age = '[20-30)' THEN 25
        WHEN age = '[30-40)' THEN 35
        WHEN age = '[40-50)' THEN 45
        WHEN age = '[50-60)' THEN 55
        WHEN age = '[60-70)' THEN 65
        WHEN age = '[70-80)' THEN 75
        WHEN age = '[80-90)' THEN 85
        WHEN age = '[90-100)' THEN 95
    END;


-- =========================================
-- Section: Create Age Group Column
-- Description: Categorize patients into Young, Middle-aged, Older
-- =========================================

ALTER TABLE diabetes_clean
ADD age_group VARCHAR(20);

UPDATE diabetes_clean
SET age_group =
    CASE
        WHEN age_mid < 40 THEN 'Young'
        WHEN age_mid < 65 THEN 'Middle-aged'
        ELSE 'Older'
    END;

-- =========================================
-- Section: Flag High-Risk Patients
-- Description: Identify patients with uncontrolled A1C and insulin therapy
-- =========================================

ALTER TABLE diabetes_clean
ADD high_risk BIT;

UPDATE diabetes_clean
SET high_risk =
    CASE
        WHEN A1C_flag = 'Uncontrolled'
             AND insulin IN ('Up','Down')
        THEN 1
        ELSE 0
    END;



-- =========================================
-- Section: Check Min/Max of Continuous Columns
-- Description: Explore time_in_hospital and num_medications ranges
-- =========================================

SELECT patient_nbr, MIN(time_in_hospital), MAX(time_in_hospital)
FROM diabetes_clean
GROUP BY patient_nbr ;

SELECT patient_nbr, MIN(num_medications), MAX(num_medications)
FROM diabetes_clean
GROUP BY patient_nbr;


-- =========================================
-- Section: Check Null Values
-- Description: Count rows with null values for key columns
-- =========================================

SELECT COUNT(*) FROM diabetes_clean;
SELECT COUNT(*) FROM diabetes_clean WHERE readmit_30 IS NULL;
SELECT COUNT(*) FROM diabetes_clean WHERE age_mid IS NULL;


-- =========================================
-- Section: Replace Invalid Values in Categorical Columns
-- Description: Replace '?' with NULL for race, weight, payer_code, medical_specialty
-- =========================================

SELECT COUNT(*) 
FROM diabetes_clean
WHERE race = '?';

UPDATE diabetes_clean
SET 
    race = CASE WHEN race = '?' THEN NULL ELSE race END,
    weight = CASE WHEN weight = '?' THEN NULL ELSE weight END,
    payer_code = CASE WHEN payer_code = '?' THEN NULL ELSE payer_code END,
    medical_specialty = CASE WHEN medical_specialty = '?' THEN NULL ELSE medical_specialty END
WHERE 
    race = '?' 
    OR weight = '?' 
    OR payer_code = '?' 
    OR medical_specialty = '?';

    -- =========================================
-- Section: Replace NULL Medical Specialty
-- Description: Fill missing medical_specialty values with 'Unknown'
-- =========================================

    UPDATE diabetes_clean
SET medical_specialty = 'Unknown'
WHERE medical_specialty IS NULL;

