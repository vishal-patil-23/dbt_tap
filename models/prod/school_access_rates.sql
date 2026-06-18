{{ config(
    materialized = "table"
) }}

SELECT
    school_name,
    COUNT(*) AS total_students,
    COUNTIF(activities_accessed > 0) AS students_with_any_access,
    SUM(total_activity) AS total_activities_sent,
    SUM(activities_accessed) AS total_activities_accessed,
    AVG(student_access_rate) AS average_student_access_rate,
    ROUND(
        AVG(student_access_rate) * 100,
        2
    ) AS school_access_rate_pct
FROM
    {{ ref('student_access_rates') }}
GROUP BY
    1
ORDER BY
    school_access_rate_pct DESC
