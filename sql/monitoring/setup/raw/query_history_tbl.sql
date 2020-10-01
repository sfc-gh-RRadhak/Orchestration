--------------------------------------------------------------------
--  Purpose: create psa tables
--
--  Revision History:
--  Date     Engineer      Description
--  -------- ------------- ----------------------------------
--  dd/mm/yy
--------------------------------------------------------------------
use role sysadmin;

use database {environment}_plt_rl_snowflake_db;
use schema info_schema;


--
-- transient staging table with no retention days
--

 create or replace transient table query_history_stg (
      organization_name varchar(500)
    , account_name varchar(500)
    , region_name varchar(500)
    , query_id varchar(500)
    , query_text varchar(16777216)
    , database_name varchar(500)
    , schema_name varchar(500)
    , query_type varchar(500)
    , session_id number(38,0)
    , user_name varchar(500)
    , role_name varchar(500)
    , warehouse_name varchar(500)
    , warehouse_size varchar(500)
    , warehouse_type varchar(500)
    , cluster_number varchar(500)
    , query_tag varchar(500)
    , execution_status varchar(500)
    , error_code varchar(500)
    , error_message varchar(500)
    , start_time timestamp_ltz(3)
    , end_time timestamp_ltz(3)
    , total_elapsed_time number(38,0)
    , bytes_scanned number(38,0)
    , rows_produced number(38,0)
    , compilation_time number(38,0)
    , execution_time number(38,0)
    , queued_provisioning_time number(38,0)
    , queued_repair_time number(38,0)
    , queued_overload_time number(38,0)
    , transaction_blocked_time number(38,0)
    , outbound_data_transfer_cloud varchar(500)
    , outbound_data_transfer_region varchar(500)
    , outbound_data_transfer_bytes number(38,0)
    , inbound_data_transfer_cloud varchar(500)
    , inbound_data_transfer_region varchar(500)
    , inbound_data_transfer_bytes number(38,0)
    , credits_used_cloud_services number(38,9)
    , list_external_file_time number(38,0)
    , release_version varchar(500)
    , external_function_total_invocations number(38,0)
    , external_function_total_sent_rows number(38,0)
    , external_function_total_received_rows number(38,0)
    , external_function_total_sent_bytes number(38,0)
    , external_function_total_received_bytes number(38,0)
    -----
    ,dw_file_name                   varchar( 250 )      not null
    ,dw_file_row_no                 number              not null
    ,dw_load_ts                     timestamp_ltz       not null
)
data_retention_time_in_days = 0
copy grants
;

--
-- permanent history table with retention days
--
create or replace table query_history
(
     dw_event_shk                   binary( 20 )        not null
    -----
   	, organization_name varchar(500)
    , account_name varchar(500)
    , region_name varchar(500)
    , query_id varchar(500)
    , query_text varchar(16777216)
    , database_name varchar(500)
    , schema_name varchar(500)
    , query_type varchar(500)
    , session_id number(38,0)
    , user_name varchar(500)
    , role_name varchar(500)
    , warehouse_name varchar(500)
    , warehouse_size varchar(500)
    , warehouse_type varchar(500)
    , cluster_number varchar(500)
    , query_tag varchar(500)
    , execution_status varchar(500)
    , error_code varchar(500)
    , error_message varchar(500)
    , start_time timestamp_ltz(3)
    , end_time timestamp_ltz(3)
    , total_elapsed_time number(38,0)
    , bytes_scanned number(38,0)
    , rows_produced number(38,0)
    , compilation_time number(38,0)
    , execution_time number(38,0)
    , queued_provisioning_time number(38,0)
    , queued_repair_time number(38,0)
    , queued_overload_time number(38,0)
    , transaction_blocked_time number(38,0)
    , outbound_data_transfer_cloud varchar(500)
    , outbound_data_transfer_region varchar(500)
    , outbound_data_transfer_bytes number(38,0)
    , inbound_data_transfer_cloud varchar(500)
    , inbound_data_transfer_region varchar(500)
    , inbound_data_transfer_bytes number(38,0)
    , credits_used_cloud_services number(38,9)
    , list_external_file_time number(38,0)
    , release_version varchar(500)
    , external_function_total_invocations number(38,0)
    , external_function_total_sent_rows number(38,0)
    , external_function_total_received_rows number(38,0)
    , external_function_total_sent_bytes number(38,0)
    , external_function_total_received_bytes number(38,0)
    -----
    ,dw_file_name                   varchar(250)      not null
    ,dw_file_row_no                 number              not null
    ,dw_load_ts                     timestamp_ltz       not null
)
data_retention_time_in_days = 1
copy grants
;

