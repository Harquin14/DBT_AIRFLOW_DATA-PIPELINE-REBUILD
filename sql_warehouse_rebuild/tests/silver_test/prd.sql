{{config(Severity =  'warn') }}

SELECT 1 FROM {{ ref ('prd_info')}}
WHERE
prd_id IS NULL