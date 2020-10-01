
use role     sysadmin;
use database gsitzman_db;
use schema   supplylogix;


--------------------------------------------------------------------
-- truncate stage prior to bulk load
--
truncate table chain_item_json_stg;

--------------------------------------------------------------------
-- load all staged files
--
copy into
    {database}.{schema}.chain_item_json_stg
from
    (
    select
         $1:NDC::string          
        ,$1::variant                                          
        ,metadata$filename                               -- dw_file_name
        ,metadata$file_row_number                        -- dw_file_row_no
        ,current_timestamp()                             -- dw_load_ts
    from
        @{stage}/{stage_file_path_pattern}/
    )

pattern = '.*/\\d\\d\\d\\d/\\d\\d/\\d\\d/[0-9]/*.*chain_items.json.gz'
file_format   = ( format_name = '{format_name}' )
--purge = true
;

