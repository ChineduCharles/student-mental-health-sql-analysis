/*
Project: Beyond Length of Stay: Exploring Student Mental Health with SQL
File: 03_mental_health_profile.sql
Purpose: Summarize mental-health measures across all valid student records.
*/

-- 1. Overall averages for the three primary mental-health measures.
SELECT
    COUNT(*) AS student_count,
    ROUND(AVG(todep), 2) AS average_phq,
    ROUND(AVG(tosc), 2) AS average_scs,
    ROUND(AVG(toas), 2) AS average_acculturative_stress
FROM students
WHERE inter_dom IN ('Inter', 'Dom');

-- 2. Depression-severity distribution across valid students.
SELECT
    depsev AS depression_severity,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY depsev
ORDER BY
    CASE depsev
        WHEN 'Min' THEN 1
        WHEN 'Mild' THEN 2
        WHEN 'Mod' THEN 3
        WHEN 'ModSev' THEN 4
        WHEN 'Sev' THEN 5
    END;
