/*
Project: Beyond Length of Stay: Exploring Student Mental Health with SQL
File: 01_data_quality.sql
Purpose: Validate respondent rows, audit missingness, and inspect coding before analysis.
*/

-- 1. Count raw rows, valid student records, and non-student rows.
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (
        WHERE inter_dom IN ('Inter', 'Dom')
    ) AS valid_student_records,
    COUNT(*) FILTER (
        WHERE TRIM(COALESCE(inter_dom, '')) = ''
    ) AS non_student_rows
FROM students;

-- 2. Audit missing values across every column for valid student records.
WITH valid_students AS (
    SELECT *
    FROM students
    WHERE inter_dom IN ('Inter', 'Dom')
),
column_values AS (
    SELECT
        j.key AS column_name,
        j.value AS column_value
    FROM valid_students AS s
    CROSS JOIN LATERAL jsonb_each_text(to_jsonb(s)) AS j(key, value)
)
SELECT
    column_name,
    COUNT(*) AS total_records,
    COUNT(*) FILTER (
        WHERE column_value IS NULL
           OR TRIM(column_value) = ''
    ) AS missing_values,
    ROUND(
        100.0 * COUNT(*) FILTER (
            WHERE column_value IS NULL
               OR TRIM(column_value) = ''
        ) / COUNT(*),
        2
    ) AS missing_percentage
FROM column_values
GROUP BY column_name
ORDER BY missing_values DESC, column_name;

-- 3. Inspect records with missing intimate/relationship-status values.
SELECT
    inter_dom,
    academic,
    gender,
    age,
    intimate
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
  AND (
      intimate IS NULL
      OR TRIM(intimate) = ''
  );

-- 4. Inspect records with missing numerical Internet help-seeking scores.
SELECT
    inter_dom,
    dep,
    internet,
    internet_bi
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
  AND (
      internet IS NULL
      OR TRIM(CAST(internet AS TEXT)) = ''
  );

-- 5. Compare the numerical Internet score with its supplied binary field.
SELECT
    internet,
    internet_bi,
    COUNT(*) AS student_count
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY internet, internet_bi
ORDER BY internet NULLS LAST, internet_bi;

-- 6. Validate ranges of the main numerical variables.
SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    MIN(stay) AS min_stay,
    MAX(stay) AS max_stay,
    MIN(japanese) AS min_japanese,
    MAX(japanese) AS max_japanese,
    MIN(english) AS min_english,
    MAX(english) AS max_english,
    MIN(todep) AS min_phq,
    MAX(todep) AS max_phq,
    MIN(tosc) AS min_scs,
    MAX(tosc) AS max_scs,
    MIN(toas) AS min_acculturative_stress,
    MAX(toas) AS max_acculturative_stress
FROM students
WHERE inter_dom IN ('Inter', 'Dom');

-- 7. Validate categories used later in the analysis.
SELECT 'inter_dom' AS variable, inter_dom AS category, COUNT(*) AS student_count
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom
UNION ALL
SELECT 'gender', gender, COUNT(*)
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY gender
UNION ALL
SELECT 'academic', academic, COUNT(*)
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY academic
UNION ALL
SELECT 'stay_cate', stay_cate, COUNT(*)
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY stay_cate
UNION ALL
SELECT 'japanese_cate', japanese_cate, COUNT(*)
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY japanese_cate
UNION ALL
SELECT 'english_cate', english_cate, COUNT(*)
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY english_cate
UNION ALL
SELECT 'depsev', depsev, COUNT(*)
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY depsev
ORDER BY variable, category;
