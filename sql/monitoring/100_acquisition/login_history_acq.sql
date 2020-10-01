 copy into
    @{stage}/{load_name}/{fileName}
from
(
    select
         'MCKESSON'             as organization_name
        ,current_account()      as account_name
        ,current_region()       as region_name
        ,lh.*
    from
        table( snowflake.information_schema.login_history( time_range_start=>dateadd( minutes, -{minutes}, current_timestamp())
                                                          ,result_limit=>10000 ) 
                                                         ) lh
    order by
        event_timestamp
)
file_format      = ( type=csv field_optionally_enclosed_by = '"' )
overwrite        = false
single           = false
include_query_id = true
detailed_output  = true
;
 

