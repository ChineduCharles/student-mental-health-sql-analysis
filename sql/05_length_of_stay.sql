/*
Project: Beyond Length of Stay: Exploring Student Mental Health with SQL
File: 05_length_of_stay.sql
Purpose: Revisit the original length-of-stay question while accounting for group size.
*/

-- 1. Original exact-year comparison for international students.
SELECT
    stay,
    COUNT(*) AS student_count,
    ROUND(AVG(todep), 2) AS average_phq,
    ROUND(AVG(tosc), 2) AS average_scs,
    ROUND(AVG(toas), 2) AS average_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay;

-- 2. Broader stay categories provide more stable group-level comparisons.
SELECT
    stay_cate,
    COUNT(*) AS student_count,
    ROUND(AVG(todep), 2) AS average_phq,
    ROUND(AVG(tosc), 2) AS average_scs,
    ROUND(AVG(toas), 2) AS average_acculturative_stress
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay_cate
ORDER BY
    CASE stay_cate
        WHEN 'Short' THEN 1
        WHEN 'Medium' THEN 2
        WHEN 'Long' THEN 3
    END;
