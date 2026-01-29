-- =========================
-- EXPLORACIÓN DEL DATASET
-- =========================
-- Vista general
SELECT * FROM StudentsPerformance;

-- Total de estudiantes
SELECT COUNT(*) AS total_estudiantes FROM StudentsPerformance;

-- Visualizar columnas
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'StudentsPerformance';



-- ===========
-- ANÁLISIS 
-- ===========

-- Pregunta 1 ¿Qué porcentaje de estudiantes está por debajo de un umbral (p. ej. 60%)?
-- Comentario de análisis
-- Un 28,5% del grupo se encuentra bajo el umbral definido, lo que refleja una proporción relevante de estudiantes con bajo rendimiento académico.
SELECT
    CAST(
    ROUND(
        SUM(
            CASE
                WHEN(
                    CAST(math_score AS FLOAT)
                    + CAST(writing_score AS FLOAT)
                    + CAST(reading_score AS FLOAT))/3 < 60
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2)
        AS DECIMAL(5,2)
    ) AS porcentaje_bajo_umbral
FROM StudentsPerformance;

-- Pregunta 2 ¿Existen diferencias de rendimiento según género en el promedio general y por asignatura?
-- Comentario de análisis
-- Las mujeres presentan un mejor promedio general que los hombres. 
-- Al desagregar por asignatura esta tendencia se mantiene en lectura y escritura.
-- Sin embargo, en matemática los hombres obtienen mejores resultados.
SELECT 
    gender AS genero,
    ROUND(
        AVG(
            (CAST(math_score AS FLOAT) 
            + CAST(reading_score AS FLOAT) 
            + CAST(writing_score AS FLOAT)) / 3
        ), 1
    ) AS promedio_general,
    ROUND(AVG(CAST(math_score AS FLOAT)),1) AS promedio_matematica,
    ROUND(AVG(CAST(reading_score AS FLOAT)),1) AS promedio_lectura,
    ROUND(AVG(CAST(writing_score AS FLOAT)),1) AS promedio_escritura
FROM StudentsPerformance
GROUP BY gender;

-- Pregunta 3 ¿Existen diferencias según raza o etnia en las diferentes asignaturas?
-- Comentario de análisis
-- En todas las asignaturas se observa el mismo patrón de desempeño por raza/etnia.
-- Los promedios se ordenan de mayor a menor de la siguiente forma: grupo A, grupo B, grupo C, grupo D, grupo E. 
SELECT
    race_ethnicity AS raza_etnia,
    ROUND(AVG(CAST(math_score AS FLOAT)),1) AS promedio_matematica,
    ROUND(AVG(CAST(writing_score AS FLOAT)),1) AS promedio_escritura,
    ROUND(AVG(CAST(reading_score AS FLOAT)),1) AS promedio_lectura
FROM StudentsPerformance
GROUP BY race_ethnicity;

-- Pregunta 4 ¿Influye el nivel educacional de los padres en el rendimiento general?
-- Comentario de análisis
-- De manera general el nivel educacional de los padres influye en el rendimiento de los estudiantes.
-- Se observa que a mayor nivel educativo de los padres, mayor es el promedio general del estudiante.
-- No obstante, hay una excepción, los estudiantes cuyos padres tienen 'some high school'presentan un promedio general aproximadamente 2 décimas superior que aquellos con padres con 'high school'.
SELECT
    parental_level_of_education AS educacion_padres,
    ROUND(
        AVG(
            (CAST(math_score AS FLOAT) 
            + CAST(reading_score AS FLOAT) 
            + CAST(writing_score AS FLOAT)) / 3
        ), 1
    ) AS promedio_general
FROM StudentsPerformance
GROUP BY parental_level_of_education
ORDER BY promedio_general DESC;

-- Pregunta 5 ¿Hay una relación entre el tipo de almuerzo y el rendimiento académico general?
-- Comentario de análisis
-- Los estudiantes con almuerzo 'standard' tiene un promedio general superior al de los estudiantes que almuerzan el menú 'free/reduced'.
SELECT
    lunch AS tipo_almuerzo,
    ROUND(
        AVG(
            (CAST(math_score AS FLOAT) 
            + CAST(reading_score AS FLOAT) 
            + CAST(writing_score AS FLOAT)) / 3
        ), 1
    ) AS promedio_general
FROM StudentsPerformance
GROUP BY lunch;

-- Pregunta 6 ¿Hay una relación entre la preparación del test inicial y el rendimiento por asignatura?
-- Comentario de análisis
-- Se observa que los estudiantes que completaron el test_preparation_course tienen promedios más altos en matemática, lectura y escritura, en comparación con aquellos que no lo realizaron.
SELECT 
    test_preparation_course AS test_inicial,
    ROUND(AVG(CAST(math_score AS FLOAT)),1) AS promedio_matematica,
    ROUND(AVG(CAST(writing_score AS FLOAT)),1) AS promedio_escritura,
    ROUND(AVG(CAST(reading_score AS FLOAT)),1) AS promedio_lectura
FROM StudentsPerformance
GROUP BY test_preparation_course;




