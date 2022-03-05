WITH cte_1 AS (
    -- split first half of date to represent fiscal_year
    SELECT company, fiscal_year/10000 AS fiscal_year FROM dividend
),cte_2 AS (
    SELECT company, fiscal_year,
        -- 2 immeditate fiscal year of dividend distribution after every year
        lead( fiscal_year,1) OVER ( PARTITION BY company ORDER BY fiscal_year) AS fyr1,
        lead( fiscal_year,2) over( PARTITION BY company ORDER BY fiscal_year) AS fyr2               
    FROM cte_1
)
-- aggregate reuslts as array
SELECT ARRAY_AGG(DISTINCT company) AS valuestocks
FROM cte_2
-- dividend distribution for three consecutive years
WHERE fiscal_year = fyr1 - 1 AND fiscal_year = fyr2 - 2;