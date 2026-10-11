/*
Project: Beyond Length of Stay: Exploring Student Mental Health with SQL
File: 04_international_vs_domestic.sql
Purpose: Compare mental-health patterns between international and domestic students.
*/

-- 1. Compare average mental-health scores.
SELECT
    inter_dom,
    COUNT(*) AS student_count,
    ROUND(AVG(todep), 2) AS average_phq,
    ROUND(AVG(tosc), 2) AS average_scs,
    ROUND(AVG(toas), 2) AS average_acculturative_stress
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom
ORDER BY inter_dom;

-- 2. Compare depression-severity distributions within each group.
SELECT
    inter_dom,
    depsev AS depression_severity,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY inter_dom),
        2
    ) AS percentage_within_group
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom, depsev
ORDER BY
    inter_dom,
    CASE depsev
        WHEN 'Min' THEN 1
        WHEN 'Mild' THEN 2
        WHEN 'Mod' THEN 3
        WHEN 'ModSev' THEN 4
        WHEN 'Sev' THEN 5
    END;
