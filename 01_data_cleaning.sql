
-- =========================================
-- Hospital Readmission Analysis
-- Step 1: Data Cleaning
-- Author: Sidra Khan
-- =========================================






SELECT *
INTO diabetes_clean
FROM diabetic_data;



SELECT patient_nbr, COUNT(*) AS duplicate
FROM diabetes_clean
GROUP BY patient_nbr
HAVING COUNT(*) > 1;


DELETE FROM diabetes_clean
WHERE patient_nbr NOT IN (
    SELECT MIN(patient_nbr)
    FROM diabetes_clean
    GROUP BY patient_nbr, encounter_id
);




SELECT 
    COUNT(*) AS Total_Rows,
    COUNT(DISTINCT patient_nbr ) AS Unique_Values
FROM diabetes_clean;


SELECT 
    patient_nbr,
    encounter_id,
    COUNT(*) AS Duplicate_Count
FROM diabetes_clean
GROUP BY patient_nbr, encounter_id
HAVING COUNT(*) > 1;

SELECT DISTINCT gender
FROM diabetes_clean;

DELETE FROM diabetes_clean
WHERE gender = 'Unknown/Invalid';

ALTER TABLE diabetes_clean
ADD readmit_30 BIT;

UPDATE diabetes_clean
SET readmit_30 =
    CASE
        WHEN readmitted = '<30' THEN 1
        ELSE 0
    END;


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


ALTER TABLE diabetes_clean
ADD age_group VARCHAR(20);

UPDATE diabetes_clean
SET age_group =
    CASE
        WHEN age_mid < 40 THEN 'Young'
        WHEN age_mid < 65 THEN 'Middle-aged'
        ELSE 'Older'
    END;

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

SELECT patient_nbr, MIN(time_in_hospital), MAX(time_in_hospital)
FROM diabetes_clean
GROUP BY patient_nbr ;

SELECT patient_nbr, MIN(num_medications), MAX(num_medications)
FROM diabetes_clean
GROUP BY patient_nbr;

SELECT COUNT(*) FROM diabetes_clean;
SELECT COUNT(*) FROM diabetes_clean WHERE readmit_30 IS NULL;
SELECT COUNT(*) FROM diabetes_clean WHERE age_mid IS NULL;




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

    -------------------

    UPDATE diabetes_clean
SET medical_specialty = 'Unknown'
WHERE medical_specialty IS NULL;
