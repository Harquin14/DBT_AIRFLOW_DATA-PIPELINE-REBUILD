 SELECT prd_id, 
           REPLACE( SUBSTRING(prd_key,1,5),'-','_') cat_id,
            SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
            prd_nm,
            COALESCE(prd_cost, 0) AS prd_cost,
            CASE UPPER(TRIM(prd_line))
                WHEN 'R' THEN 'Road'
                WHEN 'M' THEN 'Mountain'
                WHEN 'T' THEN 'Touring'
                WHEN 'S' THEN 'Other Sales'
                ELSE 'n/a'
            END AS prd_line,
            CAST(prd_start_dt AS DATE) AS prd_start_dt,
            CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
        FROM {{ ref('prd_info_bronze') }};
