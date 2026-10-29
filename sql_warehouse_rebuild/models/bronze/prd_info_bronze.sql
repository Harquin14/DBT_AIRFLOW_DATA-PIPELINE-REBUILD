select *
from {{ source('source', 'prd_info') }}