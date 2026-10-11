# Beyond Length of Stay: Exploring Student Mental Health with SQL

## Overview

This project extends DataCamp's **Analyzing Students' Mental Health** guided SQL project using survey data from an international university in Japan.

The original task focused on whether length of stay was associated with depression, social connectedness, and acculturative stress among international students. I extended the work by validating the data, profiling the survey population, comparing international and domestic students, and revisiting the length-of-stay question while accounting for the number of respondents behind each group average.

The aim was not simply to reproduce a guided query, but to demonstrate a fuller SQL analysis workflow and more careful interpretation of grouped survey data.

## Analytical Questions

1. Is the dataset suitable for respondent-level analysis?
2. Who is represented in the survey?
3. How do mental-health patterns compare between international and domestic students?
4. How does length of stay relate to depression, social connectedness, and acculturative stress among international students?
5. How does group sample size affect the reliability of those comparisons?

## Tools and SQL Techniques

- PostgreSQL / SQL in DataCamp DataLab
- Filtering and conditional logic
- Aggregation with `COUNT()`, `AVG()`, `MIN()`, and `MAX()`
- `GROUP BY`
- `CASE` expressions
- Window functions with `OVER()` and `PARTITION BY`
- Conditional aggregation
- Common Table Expressions (CTEs)
- PostgreSQL JSON functions for dataset-wide missing-value assessment

## Data Quality Assessment

The raw dataset contained **286 rows**. After validation, **268 rows** were identified as student responses: 201 international and 67 domestic students. Eighteen rows with blank student-status values contained summary-style information and were excluded from respondent-level analysis.

A full missing-value audit found missingness in only two fields among valid respondents:

- `internet`: 26 missing values (9.70%)
- `intimate`: 8 missing values (2.99%)

The primary mental-health measures used in the analysis were complete. Missing responses were not imputed without sufficient evidence.

## Student Population Profile

International students made up **75%** of the valid sample. Gender composition was very similar between international and domestic students, while international students included a larger proportion of graduate and older students.

## Mental Health Comparison

The depression-severity distribution did not support a simple conclusion that international students experienced more severe depressive symptoms than domestic students. Domestic students had a somewhat larger share of respondents in moderate-or-higher severity categories, showing that the comparison is more nuanced than student status alone.

## Length of Stay Analysis

The exact-year analysis revealed a key reliability issue: several stay groups after four years contained only one or a few respondents. Those averages were therefore treated cautiously.

Broader stay categories produced a more stable comparison:

| Stay category | Students | Avg. PHQ | Avg. SCS | Avg. Acculturative Stress |
|---|---:|---:|---:|---:|
| Short | 95 | 7.48 | 38.11 | 72.80 |
| Medium | 85 | 8.72 | 37.11 | 77.85 |
| Long | 21 | 7.86 | 35.57 | 78.81 |

## Key Findings

- Average acculturative stress increased from **72.80** in the short-stay group to **78.81** in the long-stay group.
- Average social connectedness declined from **38.11** to **35.57** across the same categories.
- Depression did not follow a simple linear pattern: average PHQ rose from **7.48** to **8.72**, then declined to **7.86**.
- Examining group size materially changed the interpretation of the exact-year results; averages based on one or a few respondents were not given the same weight as larger groups.

## Conclusion

In this sample, longer residence among international students was more consistently associated with **higher acculturative stress and lower social connectedness** than with steadily increasing depressive symptoms.

The project also reinforces a broader analytical lesson: an average should not be interpreted without considering how many observations produced it.

## Limitations

- The survey comes from one university and should not be generalized to all students.
- The data is cross-sectional, so observed relationships should not be interpreted as causal.
- Some exact-year length-of-stay groups contain very small samples.
- The dataset does not contain a unique respondent identifier, so duplicate respondents cannot be independently verified.
- A small number of fields contain missing values.

## Repository Structure

```text
student-mental-health-sql-analysis/
├── README.md
├── data/
│   └── README.md
├── notebook/
│   └── student_mental_health_analysis.ipynb
└── sql/
    ├── 01_data_quality.sql
    ├── 02_population_profile.sql
    ├── 03_mental_health_profile.sql
    ├── 04_international_vs_domestic.sql
    └── 05_length_of_stay.sql
```

## Attribution

This project was inspired by and extends DataCamp's **Analyzing Students' Mental Health** guided SQL project. The extended data-quality assessment, comparative analysis, sample-size evaluation, interpretation, and portfolio presentation were developed as part of my independent analysis.
