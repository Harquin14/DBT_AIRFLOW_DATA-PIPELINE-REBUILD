{{ config(
    materialized='incremental',
    unique_key='cst_id',
) }}

WITH bronze_customers AS (

    SELECT 
        cst_id,
        cst_key,
        cst_firstname,
        cst_lastname,
        cst_marital_status,
        cst_gndr,
        cst_create_date
    FROM {{ ref('cust_info_bronze') }}
    WHERE cst_id IS NOT NULL

    {% if is_incremental() %}
        -- Predicate pushdown limits the data scanned
        AND cst_create_date >= COALESCE((SELECT MAX(cst_create_date) FROM {{ this }}), '1900-01-01')
    {% endif %}

)

SELECT 
    cst_id, 
    cst_key, 
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    
    CASE UPPER(TRIM(cst_marital_status))
        WHEN 'S' THEN 'Single'
        WHEN 'M' THEN 'Married'
        ELSE 'n/a' 
    END AS cst_marital_status,
    
    CASE UPPER(TRIM(cst_gndr))
        WHEN 'F' THEN 'Female'
        WHEN 'M' THEN 'Male'
        ELSE 'n/a' 
    END AS cst_gender,
    
    cst_create_date 

FROM bronze_customers
QUALIFY ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) = 1