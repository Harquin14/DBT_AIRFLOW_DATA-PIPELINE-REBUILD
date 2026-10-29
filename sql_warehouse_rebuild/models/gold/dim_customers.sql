SELECT 
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
    cst_id AS customer_id,
    ci.cst_key AS customer_number,
    ci.cst_firstname AS first_name,
    ci.cst_lastname AS last_name,
    l.cntry AS country,
    ca.bdate AS birthdate,
    CASE 
        WHEN ci.cst_gndr <> 'n/a' THEN ci.cst_gndr
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender,
    ci.cst_marital_status AS marital_status,
    ci.cst_create_date AS create_date
FROM {{ref ('cust_info')}}  AS ci
LEFT JOIN {{ ref ('cust_az_12')}} AS ca ON ci.cst_key = ca.cid
LEFT JOIN {{ ref ('loc_a_101') }} AS l ON ci.cst_key = l.cid;