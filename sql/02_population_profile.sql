/*
Project: Beyond Length of Stay: Exploring Student Mental Health with SQL
File: 02_population_profile.sql
Purpose: Describe the composition of the valid survey sample.
*/

-- 1. International vs domestic composition.
SELECT
    inter_dom,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) / SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom
ORDER BY student_count DESC;

-- 2. Gender composition within each student group.
SELECT
    inter_dom,
    gender,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY inter_dom),
        2
    ) AS percentage_within_group
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom, gender
ORDER BY inter_dom, student_count DESC;

-- 3. Academic-level composition within each student group.
SELECT
    inter_dom,
    academic,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY inter_dom),
        2
    ) AS percentage_within_group
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom, academic
ORDER BY inter_dom, student_count DESC;

-- 4. Age summary by student group.
SELECT
    inter_dom,
    COUNT(*) AS student_count,
    ROUND(AVG(age), 2) AS average_age,
    MIN(age) AS minimum_age,
    MAX(age) AS maximum_age
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom
ORDER BY inter_dom;

-- 5. Age-category composition within each student group.
SELECT
    inter_dom,
    age_cate,
    COUNT(*) AS student_count,
    ROUND(
        100.0 * COUNT(*) /
        SUM(COUNT(*)) OVER (PARTITION BY inter_dom),
        2
    ) AS percentage_within_group
FROM students
WHERE inter_dom IN ('Inter', 'Dom')
GROUP BY inter_dom, age_cate
ORDER BY inter_dom, age_cate;
