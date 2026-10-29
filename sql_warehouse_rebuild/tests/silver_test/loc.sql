{{config(Severity =  'warn') }}

SELECT 1 FROM {{ ref ('loc_a_101')}}
WHERE
cid IS NULL