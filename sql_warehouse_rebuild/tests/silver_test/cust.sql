{{config(Severity =  'warn') }}

SELECT 1 FROM {{ ref ('cust_info')}}
WHERE
cst_id IS NULL