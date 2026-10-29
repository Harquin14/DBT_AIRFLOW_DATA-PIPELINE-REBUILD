SELECT 
            CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
                 ELSE cid END AS cid,
            CASE WHEN bdate > GETDATE() THEN NULL
                 ELSE bdate END AS bdate,
            CASE WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
                 WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
                 ELSE 'n/a' END AS gen
        FROM {{ ref ('cust_az_12_bronze') }};