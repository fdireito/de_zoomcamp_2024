select *
from {{ source('staging','fhv_tripdata') }}