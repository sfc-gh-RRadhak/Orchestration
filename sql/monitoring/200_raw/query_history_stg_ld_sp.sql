truncate table {environment}_plt_rl_snowflake_db.info_schema.query_history_stg;
copy into
                {environment}_plt_rl_snowflake_db.info_schema.query_history_stg
            from
                (
                select
                      $1  -- organization_name  
                    , $2  -- account_name  
                    , $3  -- region_name  
                    , $4  -- query_id  
                    , $5  -- query_text  
                    , $6  -- database_name  
                    , $7  -- schema_name  
                    , $8  -- query_type  
                    , $9  --session_id  
                    , $10 --user_name  
                    , $11 --role_name  
                    , $12 --warehouse_name  
                    , $13 --warehouse_size  
                    , $14 --warehouse_type  
                    , $15 --cluster_number  
                    , $16 --query_tag 
                    , $17 --execution_status  
                    , $18 --error_code  
                    , $19 --error_message  
                    , $20 --start_time  
                    , $21 --end_time  
                    , $22 --total_elapsed_time  
                    , $23 --bytes_scanned  
                    , $24 --rows_produced  
                    , $25 --compilation_time  
                    , $26 --execution_time  
                    , $27 --queued_provisioning_time  
                    , $28 --queued_repair_time  
                    , $29 --queued_overload_time  
                    , $30 --transaction_blocked_time  
                    , $31 --outbound_data_transfer_cloud  
                    , $32 --outbound_data_transfer_region  
                    , $33 --outbound_data_transfer_bytes  
                    , $34 --inbound_data_transfer_cloud  
                    , $35 --inbound_data_transfer_region  
                    , $36 --inbound_data_transfer_bytes  
                    , $37 --credits_used_cloud_services  
                    , $38 --list_external_file_time  
                    , $39 --release_version  
                    , $40 --cexternal_function_total_invocations  
                    , $41 --external_function_total_sent_rows  
                    , $42 --external_function_total_received_rows  
                    , $43 --external_function_total_sent_bytes  
                    , $44 --external_function_total_received_bytes  
                    ,metadata$filename                      -- dw_file_name
                    ,metadata$file_row_number               -- dw_file_row_no
                    ,current_timestamp()                    -- dw_load_ts
                from
                    @{stage}/query_history s
                )
            file_format = ( type=csv field_optionally_enclosed_by = '"' )
            purge = true;