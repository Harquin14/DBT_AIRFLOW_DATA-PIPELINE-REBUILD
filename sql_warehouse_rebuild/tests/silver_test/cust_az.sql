{{config(Severity =  'warn') }}

SELECT 1 FROM {{ ref ('cust_az_12')}}
WHERE
cid IS NULL