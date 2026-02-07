-- ==============================
-- MODELO ANALÍTICO INTERMEDIO
-- ==============================

-- 1. Tabla analítica intermedia con promedios por asignatura y tipo de almuerzo
WITH avg_by_lunch AS (
    SELECT
        lunch AS grupo,
        'Matemática' AS asignatura,
        ROUND(AVG(CAST(math_score AS FLOAT)),1) AS promedio
    FROM StudentsPerformance
    GROUP BY lunch

    UNION ALL

    SELECT
        lunch,
        'Lectura',
        ROUND(AVG(CAST(reading_score AS FLOAT)),1)
    FROM StudentsPerformance
    GROUP BY lunch

    UNION ALL

    SELECT 
        lunch,
        'Escritura',
        ROUND(AVG(CAST(writing_score AS FLOAT)),1)
    FROM StudentsPerformance
    GROUP BY lunch
)

SELECT *
FROM avg_by_lunch;