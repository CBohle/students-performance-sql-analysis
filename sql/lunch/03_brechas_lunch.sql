-- ==============================
-- CONSULTAS ANALÍTICAS FINALES
-- ==============================

-- Base: modelo avg_by_lunch
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
),

pivot_lunch AS (
    SELECT
        asignatura,
        MAX(CASE WHEN grupo = 'standard' THEN promedio END) AS prom_standard,
        MAX(CASE WHEN grupo = 'free/reduced' THEN promedio END) AS prom_free
    FROM avg_by_lunch
    GROUP BY asignatura
)



-- -- Promedios y brechas absolutas y porcentuales

SELECT
    asignatura,
    prom_standard,
    prom_free,
    ROUND(prom_standard - prom_free,1) AS brecha_abs,
    ROUND((prom_standard - prom_free)*100/prom_free, 1) AS brecha_pct
FROM pivot_lunch;

