-- ==============
-- EXPLORACIÓN
-- ==============
-- 1. Rendimiento por asignatura según lunch
SELECT
    lunch AS grupo,
    'Matemática' AS asignatura,
    ROUND(AVG(CAST(math_score AS FLOAT)),1) AS promedio
FROM StudentsPerformance
GROUP BY lunch

UNION ALL

SELECT
    lunch AS grupo,
    'Lectura' AS asignatura,
    ROUND(AVG(CAST(reading_score AS FLOAT)),1) AS promedio
FROM StudentsPerformance
GROUP BY lunch

UNION ALL

SELECT 
    lunch AS grupo,
    'Escritura' AS asignatura,
    ROUND(AVG(CAST(writing_score AS FLOAT)),1)
FROM StudentsPerformance
GROUP BY lunch;