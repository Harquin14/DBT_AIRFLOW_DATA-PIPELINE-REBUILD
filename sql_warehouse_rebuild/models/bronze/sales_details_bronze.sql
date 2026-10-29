select *
from {{ source('source', 'sales_details') }}