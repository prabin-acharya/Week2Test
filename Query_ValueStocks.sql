WITH cte_1 AS (
    SELECT company, fiscal_year/10000 AS fiscal_year FROM dividend
),cte_2 AS (
    SELECT company, fiscal_year,
        lead( fiscal_year,1) OVER ( PARTITION BY company ORDER BY fiscal_year) AS fyr1,
        lead( fiscal_year,2) over( PARTITION BY company ORDER BY fiscal_year) AS fyr2               
    FROM cte_1
)

SELECT DISTINCT company AS valuestocks
FROM cte_2
WHERE fiscal_year = fyr1 - 1 AND fiscal_year = fyr2 - 2 
ORDER BY company;