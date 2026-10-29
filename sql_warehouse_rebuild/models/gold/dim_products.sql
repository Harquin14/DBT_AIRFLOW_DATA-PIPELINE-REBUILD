SELECT
    ROW_NUMBER() OVER (ORDER BY pi.prd_id, pi.prd_start_dt) AS product_key,
    pi.prd_id AS product_id, 
    pi.prd_key AS product_number,
    pi.prd_nm AS product_name,
    pi.cat_id AS category_id,
    pc.cat AS category,
    pc.subcat AS subcategory,
    pc.maintenance,
    pi.prd_cost AS cost,
    pi.prd_line AS product_line,
    pi.prd_start_dt AS start_date
FROM {{ ref ('prd_info') }} AS pi
LEFT JOIN {{ ref ('px_cat_g_1_v_2') }} pc ON pi.cat_id = pc.id
WHERE pi.prd_end_dt IS NULL;