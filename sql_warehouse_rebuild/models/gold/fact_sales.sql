SELECT 
    sd.sls_ord_num AS order_number,
    p.product_key,
    cs.customer_key,
    sd.sls_order_dt AS order_date,
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales_amount,
    sd.sls_quantity AS quantity,
    sd.sls_price AS price
FROM {{ref ('sales_detail') }} sd
LEFT JOIN {{ ref ('dim_products')}} p ON sd.sls_prd_key = p.product_number
LEFT JOIN {{ ref ('dim_customers')}} cs ON sd.sls_cust_id = cs.customer_id;