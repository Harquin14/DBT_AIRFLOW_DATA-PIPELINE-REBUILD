{{config(Severity =  'warn') }}

SELECT 1 FROM {{ ref ('px_cat_g_1_v_2_bronze')}}
WHERE
id IS NULL