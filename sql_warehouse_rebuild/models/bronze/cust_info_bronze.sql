select *
from {{ source('source', 'cust_info') }}