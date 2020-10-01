copy into
     @{stage}/{load_name}/{fileName}
from
(
    select
         'MCKESSON'             as organization_name
        ,current_account()      as account_name
        ,current_region()       as region_name
        ,qh.*
    from
        table( snowflake.information_schema.query_history( end_time_range_start=>dateadd( minutes, -{minutes}, current_timestamp()) ) ) qh
    order by
        qh.end_time
)
file_format      = ( type=csv field_optionally_enclosed_by = '"' )
overwrite        = false
single           = false
include_query_id = true
detailed_output  = true
 
 

