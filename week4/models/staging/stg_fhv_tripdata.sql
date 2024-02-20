{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging', 'fhv_tripdata') }}

),

renamed as (

    select
        dispatching_base_num,
        cast(pickup_datetime as timestamp) as pickup_datetime,
        cast(dropoff_datetime as timestamp) as dropoff_datetime,
        {{ dbt.safe_cast("pulocationid", api.Column.translate_type("integer")) }} as pickup_locationid,
        {{ dbt.safe_cast("dolocationid", api.Column.translate_type("integer")) }} as dropoff_locationid,
        {{ dbt.safe_cast("sr_flag", api.Column.translate_type("integer")) }} as shared_ride_flag,
        affiliated_base_number

    from source

)

select 
    *
from renamed
where pickup_datetime >= '2019-01-01'
    AND pickup_datetime < '2020-01-01'
