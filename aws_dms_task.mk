_AWS_DMS_TASK_MK_VERSION=$(_AWS_DMS_MK_VERSION)

# DMS_TASK_ARN?=
# DMS_TASK_CDC_START_TIME?=
# DMS_TASK_IDENTIFIER?= my-task
# DMS_TASK_INSTANCE_ARN?=
# DMS_TASK_LOG_GROUP?=
# DMS_TASK_LOG_STREAM?=
# DMS_TASK_MIGRATION_TYPE?= full-load
# DMS_TASK_RELOAD_TABLES?= SchemaName=dms_sample,TableName=nfl_data ...
# DMS_TASK_SETTINGS?=
# DMS_TASK_SOURCE_ARN?=
# DMS_TASK_START_TYPE?= resume-processing
# DMS_TASK_TABLE_MAPPINGS_FILEPATH?= table-mapping.json
# DMS_TASK_TAGS?= Key=string,Value=string ...
# DMS_TASK_TARGET_ARN?=
# DMS_TASKS_FILTERS?=

# Derived variables
DMS_TASK_INSTANCE_ARN?= $(DMS_INSTANCE_ARN)
DMS_TASK_SETTINGS?= $(if $(DMS_TASK_SETTINGS_FILEPATH), file://$(DMS_TASK_SETTINGS_FILEPATH))
DMS_TASK_SOURCE_ARN?= $(DMS_SOURCE_ARN)
DMS_TASK_TABLE_MAPPINGS?= $(if $(DMS_TASK_TABLE_MAPPINGS_FILEPATH), file://$(DMS_TASK_TABLE_MAPPINGS_FILEPATH))
DMS_TASK_TARGET_ARN?= $(DMS_TARGET_ARN)

# Option variables
__DMS_CDC_START_TIME= $(if $(DMS_TASK_CDC_START_TIME), --cdc-start-time $(DMS_TASK_CDC_START_TIME))
__DMS_FILTERS_TASKS= $(if $(DMS_TASKS_FILTERS), --filter $(DMS_TASKS_FILTERS))
__DMS_MIGRATION_TYPE= $(if $(DMS_TASK_MIGRATION_TYPE), --migration-type $(DMS_TASK_MIGRATION_TYPE))
__DMS_REPLICATION_TASK_ARN= $(if $(DMS_TASK_ARN), --replication-task-arn $(DMS_TASK_ARN))
__DMS_REPLICATION_TASK_IDENTIFIER= $(if $(DMS_TASK_IDENTIFIER), --replication-task-identifier $(DMS_TASK_IDENTIFIER))
__DMS_REPLICATION_TASK_SETTINGS= $(if $(DMS_TASK_SETTINGS), --replication-task-settings $(DMS_TASK_SETTINGS))
__DMS_REPLICATION_INSTANCE_ARN= $(if $(DMS_TASK_INSTANCE_ARN), --replication-instance-arn $(DMS_TASK_INSTANCE_ARN))
__DMS_SOURCE_ENDPOINT_ARN= $(if $(DMS_TASK_SOURCE_ARN), --source-endpoint-arn $(DMS_TASK_SOURCE_ARN))
__DMS_START_REPLICATION_TASK_TYPE= $(if $(DMS_TASK_START_TYPE), --start-replication-task-type $(DMS_TASK_START_TYPE))
__DMS_TABLES_TO_RELOAD= $(if $(DMS_TASK_RELOAD_TABLES), --tables-to-reload $(DMS_TASK_RELOAD_TABLES))
__DMS_TARGET_ENDPOINT_ARN= $(if $(DMS_TASK_TARGET_ARN), --target-endpoint-arn $(DMS_TASK_TARGET_ARN))
__DMS_TABLE_MAPPINGS= $(if $(DMS_TASK_TABLE_MAPPINGS), --table-mappings $(DMS_TASK_TABLE_MAPPINGS))
__DMS_TAGS_TASK= $(if $(DMS_TASK_TAGS), --tags $(DMS_TASK_TAGS))

# UI variables
DMS_UI_CREATE_TASK_FIELDS?= $(DMS_UI_VIEW_TASKS_FIELDS)
DMS_UI_DELETE_TASK_FIELDS?= $(DMS_UI_VIEW_TASKS_FIELDS)
DMS_UI_SHOW_TASK_FIELDS?= .{SourceEndpointArn:SourceEndpointArn,ReplicationTaskIdentifier:ReplicationTaskIdentifier,ReplicationInstanceArn:ReplicationInstanceArn,ReplicationTaskStats:ReplicationTaskStats,Status:Status,ReplicationTaskArn:ReplicationTaskArn,StopReason:StopReason,ReplicationTaskCreationDate:ReplicationTaskCreationDate,MigrationType:MigrationType,TargetEndpointArn:TargetEndpointArn}
DMS_UI_SHOW_TASK_STATISTICS_CRC_FIELDS?= .{_Inserts:Inserts,_Ddls:Ddls,TableName:TableName,_Updates:Updates,TableState:TableState,SchemaName:SchemaName,_Deletes:Deletes}
DMS_UI_SHOW_TASK_STATISTICS_FULLLOAD_FIELDS?= .{_FullLoadErrorRows:FullLoadErrorRows,_FullLoadCondtnlChkFailedRows:FullLoadCondtnlChkFailedRows,TableName:TableName,_FullLoadRows:FullLoadRows,TableState:TableState,SchemaName:SchemaName}
DMS_UI_SHOW_TASK_STATISTICS_VALIDATION_FIELDS?= .{_ValidationPendingRecords:ValidationPendingRecords,ValidationState:ValidationState,_ValidationSuspendedRecords:ValidationSuspendedRecords,TableName:TableName,_ValidationFailedRecords:ValidationFailedRecords,SchemaName:SchemaName}
DMS_UI_START_TASK_FIELDS?= .{ReplicationTaskStartDate:ReplicationTaskStartDate,ReplicationTaskIdentifier:ReplicationTaskIdentifier,MigrationType:MigrationType,Status:Status}
DMS_UI_STOP_TASK_FIELDS?= .{ReplicationTaskIdentifier:ReplicationTaskIdentifier,ReplicationTaskStartDate:ReplicationTaskStartDate,_Status:Status,_ReplicationTaskCreationDate:ReplicationTaskCreationDate,_MigrationType:MigrationType}
DMS_UI_VIEW_TASKS_FIELDS?= .{TaskIdentifier:ReplicationTaskIdentifier,_Status:Status,TaskCreationDate:ReplicationTaskCreationDate,_MigrationType:MigrationType}
DMS_UI_WATCH_INTERVAL?= 5

#--- Utilities

#--- MACROS
_dms_get_task_arn=$(call _dms_get_task_arn_I, $(DMS_TASK_IDENTIFIER))
_dms_get_task_arn_I=$(shell $(AWS) dms describe-replication-tasks --query "ReplicationTasks[?ReplicationTaskIdentifier=='$(strip $(1))'].ReplicationTaskArn" --output text)

_dms_get_task_log_group=$(call _dms_get_task_log_group_I,$(DMS_INSTANCE_IDENTIFIER))
_dms_get_task_log_group_I=$(if $(1),$(shell echo 'dms-tasks-$(strip $(1))'))

_dms_get_task_log_stream=$(call _dms_get_task_log_stream_A,$(DMS_TASK_ARN))
_dms_get_task_log_stream_A=$(if $(1),$(shell echo 'dms-task-$(lastword $(subst :,$(SPACE),$(1)))'))

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros ::
	@echo 'AWS::DMS::Task ($(_AWS_DMS_TASK_MK_VERSION)) macros:'
	@echo '    _dms_get_task_arn_{|I}                - Get the ARN of a replication task (Identifier)'
	@echo

_dms_view_makefile_targets ::
	@echo 'AWS::DMS::Task ($(_AWS_DMS_TASK_MK_VERSION)) targets:'
	@echo '    _dms_create_task                      - Create a replication task'
	@echo '    _dms_delete_task                      - Delete an existing replication task'
	@echo '    _dms_reload_task_tables               - Reload tables from a runnnig task'
	@echo '    _dms_show_task                        - Show details of a replication task'
	@echo '    _dms_show_task_assessment_results     - Show assessment results of a replication task'
	@echo '    _dms_show_task_logs                   - Show logs of a replication task'
	@echo '    _dms_show_task_settings               - Show settings of a replication task'
	@echo '    _dms_show_task_statistics             - Show statistics of a replication task'
	@echo '    _dms_show_task_statistics_crc         - Show CRC statistics of a replication task'
	@echo '    _dms_show_task_statistics_fullload    - Show full-load statistics of a replication task'
	@echo '    _dms_show_task_statistics_validation  - Show validation statistics of a replication task'
	@echo '    _dms_show_task_table_mapping          - Show details of a replication task'
	@echo '    _dms_start_task                       - Start a replication task'
	@echo '    _dms_start_task_assessment            - Start replication task assessment for unsupported data types in source'
	@echo '    _dms_stop_task                        - Stop a replication task'
	@echo '    _dms_update_task                      - Update an existing replication task'
	@echo '    _dms_view_tasks                       - View replication tasks'
	@echo '    _dms_watch_task_statistics            - Watch statistics of a task'
	@echo '    _dms_watch_task_statistics_footer     - Footer of watch task statistics'
	@echo '    _dms_watch_task_statistics_header     - Watch statistics of a task'
	@echo 

_dms_view_makefile_variables ::
	@echo 'AWS::DMS::Task ($(_AWS_DMS_TASK_MK_VERSION)) variables:'
	@echo '    DMS_TASK_ARN=$(DMS_TASK_ARN)'
	@echo '    DMS_TASK_CDC_START_TIME=$(DMS_TASK_CDC_START_TIME)'
	@echo '    DMS_TASK_IDENTIFIER=$(DMS_TASK_IDENTIFIER)'
	@echo '    DMS_TASK_INSTANCE_ARN=$(DMS_TASK_INSTANCE_ARN)'
	@echo '    DMS_TASK_LOG_GROUP=$(DMS_TASK_LOG_GROUP)'
	@echo '    DMS_TASK_LOG_STREAM=$(DMS_TASK_LOG_STREAM)'
	@echo '    DMS_TASK_MIGRATION_TYPE=$(DMS_TASK_MIGRATION_TYPE)'
	@echo '    DMS_TASK_RELOAD_TABLES=$(DMS_TASK_RELOAD_TABLES)'
	@echo '    DMS_TASK_SETTINGS=$(DMS_TASK_SETTINGS)'
	@echo '    DMS_TASK_SOURCE_ARN=$(DMS_TASK_SOURCE_ARN)'
	@echo '    DMS_TASK_START_TYPE=$(DMS_TASK_START_TYPE)'
	@echo '    DMS_TASK_TABLE_MAPPINGS_FILEPATH=$(DMS_TASK_TABLE_MAPPINGS_FILEPATH)'
	@echo '    DMS_TASK_TABLE_MAPPINGS=$(DMS_TASK_TABLE_MAPPINGS)'
	@echo '    DMS_TASK_TARGET_ARN=$(DMS_TASK_TARGET_ARN)'
	@echo '    DMS_TASKS_FILTERS=$(DMS_TASKS_FILTERS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__dms_reload_task_info:
	@$(INFO) '$(AWS_UI_LABEL)Restarting DMS replication task "$(DMS_TASK_IDENTIFIER)" and reloading tables ...'; $(NORMAL)
	@$(WARN) 'This operation is valid only for failed tasks, start or resume the task otherwise'; $(NORMAL)

__dms_resume_task_info:
	@$(INFO) '$(AWS_UI_LABEL)Resuming DMS replication task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)

__dms_start_task_info:
	@$(INFO) '$(AWS_UI_LABEL)Starting DMS replication task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'This operation is valid only for tasks running for the first time, resume task otherwise'; $(NORMAL)

__dms_start_task:
	@$(WARN) 'Start type: $(DMS_TASK_START_TYPE)'; $(NORMAL)
	$(AWS) dms start-replication-task $(__DMS_CDC_START_TIME) $(__DMS_REPLICATION_TASK_ARN) $(__DMS_START_REPLICATION_TASK_TYPE) --query 'ReplicationTask$(DMS_UI_START_TASK_FIELDS)'

__dms_watch_task_statistics_crc:
	echo -n '|  '; $(PURPLE) 'CRC statistics'; $(WHITE) -n
	$(AWS) dms describe-table-statistics $(__DMS_REPLICATION_TASK_ARN) --query "TableStatistics[]$(DMS_UI_SHOW_TASK_STATISTICS_CRC_FIELDS)" 2>/dev/null | tail -n+4

__dms_watch_task_statistics_fullload:
	echo -n '|  '; $(PURPLE) 'Full-load statistics'; $(WHITE) -n
	$(AWS) dms describe-table-statistics $(__DMS_REPLICATION_TASK_ARN) --query "TableStatistics[]$(DMS_UI_SHOW_TASK_STATISTICS_FULLLOAD_FIELDS)" 2>/dev/null | tail -n+4

__dms_watch_task_statistics_validation:
	echo -n '|  '; $(PURPLE) 'Validation statistics'; $(WHITE) -n
	$(AWS) dms describe-table-statistics $(__DMS_REPLICATION_TASK_ARN) --query "TableStatistics[]$(DMS_UI_SHOW_TASK_STATISTICS_VALIDATION_FIELDS)" 2>/dev/null | tail -n+4



#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_create_task:
	@$(INFO) '$(AWS_UI_LABEL)Creating DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms create-replication-task $(__DMS_CDC_START_TIME) $(__DMS_MIGRATION_TYPE) $(__DMS_REPLICATION_INSTANCE_ARN) $(__DMS_REPLICATION_TASK_IDENTIFIER) $(__DMS_REPLICATION_TASK_SETTINGS) $(__DMS_SOURCE_ENDPOINT_ARN) $(__DMS_TABLE_MAPPINGS) $(__DMS_TAGS_TASK) $(__DMS_TARGET_ENDPOINT_ARN) --query "ReplicationTask$(DMS_UI_CREATE_TASK_FIELDS)"

_dms_delete_task:
	@$(INFO) '$(AWS_UI_LABEL)Creating DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms delete-replication-task $(__DMS_REPLICATION_TASK_ARN) --query "ReplicationTask$(DMS_UI_DELETE_TASK_FIELDS)"

_dms_reload_task_tables:
	@$(INFO) '$(AWS_UI_LABEL)Reloading select tables from task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'Operation valid only on a running task'; $(NORMAL)
	$(AWS) dms reload-tables $(__DMS_REPLICATION_TASK_ARN) $(__DMS_TABLES_TO_RELOAD)

_dms_restart_task: override DMS_TASK_START_TYPE= reload-target
_dms_restart_task: __dms_reload_target_info __dms_start_task

_dms_resume_task: override DMS_TASK_START_TYPE= resume-processing
_dms_resume_task: __dms_resume_task_info __dms_start_task

_dms_show_task:
	@$(INFO) '$(AWS_UI_LABEL)Showing details of  DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT include task-settings and table-mappings'; $(NORMAL)
	$(AWS) dms describe-replication-tasks --query "ReplicationTasks[?ReplicationTaskIdentifier=='$(DMS_TASK_IDENTIFIER)']$(DMS_UI_SHOW_TASK_FIELDS)"

_dms_show_task_assessment_results:
	@$(INFO) '$(AWS_UI_LABEL)Showing assessment results of DMS task "$(DMS_TASK_IDENTIFIER)" source endpoint ...'; $(NORMAL)
	$(AWS) dms describe-replication-task-assessment-results $(__DMS_REPLICATION_TASK_ARN) 

_dms_show_task_logs:
	@$(INFO) '$(AWS_UI_LABEL)Showing logs of DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms describe-replication-instance-task-logs $(__DMS_REPLICATION_INSTANCE_ARN) 

_dms_show_task_settings:
	@$(INFO) '$(AWS_UI_LABEL)Showing settings of DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms describe-replication-tasks --query "ReplicationTasks[?ReplicationTaskIdentifier=='$(DMS_TASK_IDENTIFIER)'].ReplicationTaskSettings" --output text  | jq --monochrome-output '.'

_dms_show_task_statistics: _dms_show_task_statistics_crc _dms_show_task_statistics_fullload _dms_show_task_statistics_validation

_dms_show_task_statistics_crc:
	@$(INFO) '$(AWS_UI_LABEL)Showing CRC statistics of DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms describe-table-statistics $(__DMS_REPLICATION_TASK_ARN) --query "TableStatistics[]$(DMS_UI_SHOW_TASK_STATISTICS_CRC_FIELDS)"

_dms_show_task_statistics_fullload:
	@$(INFO) '$(AWS_UI_LABEL)Showing full-load statistics of DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms describe-table-statistics $(__DMS_REPLICATION_TASK_ARN) --query "TableStatistics[]$(DMS_UI_SHOW_TASK_STATISTICS_FULLLOAD_FIELDS)"

_dms_show_task_statistics_validation:
	@$(INFO) '$(AWS_UI_LABEL)Showing validation statistics of DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms describe-table-statistics $(__DMS_REPLICATION_TASK_ARN) --query "TableStatistics[]$(DMS_UI_SHOW_TASK_STATISTICS_VALIDATION_FIELDS)"

_dms_show_task_table_mappings:
	@$(INFO) '$(AWS_UI_LABEL)Showing table-mappings of DMS task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) dms describe-replication-tasks --query "ReplicationTasks[?ReplicationTaskIdentifier=='$(DMS_TASK_IDENTIFIER)'].TableMappings" --output text  | jq --monochrome-output '.'

_dms_start_task: override DMS_TASK_START_TYPE= start-replication
_dms_start_task: __dms_start_task_info __dms_start_task

_dms_start_task_assessment:
	@$(INFO) '$(AWS_UI_LABEL)Starting assessment of DMS replication task "$(DMS_TASK_IDENTIFIER)" source endpoint ...'; $(NORMAL)
	@$(WARN) 'Operation not available if source type is "mongodb"'; $(NORMAL)
	$(AWS) dms start-replication-task-assessment $(__DMS_REPLICATION_TASK_ARN)

_dms_stop_task:
	@$(INFO) '$(AWS_UI_LABEL)Stopping DMS replication task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'Only tasks in the 'running' state can be stopped'; $(NORMAL)
	$(AWS) dms stop-replication-task $(__DMS_REPLICATION_TASK_ARN) --query "ReplicationTask$(DMS_UI_STOP_TASK_FIELDS)"

_dms_update_task:
	@$(INFO) '$(AWS_UI_LABEL)Updating DMS replication task "$(DMS_TASK_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'A task must be stopped before you can modify it'; $(NORMAL)
	@$(WARN) 'This operation cannot change source and target endpoints'; $(NORMAL)
	$(AWS) dms modify-replication-task $(__DMS_CDC_START_TIME) $(__DMS_MIGRATION_TYPE) $(__DMS_REPLICATION_TASK_ARN) $(__DMS_REPLICATION_TASK_IDENTIFIER) $(__DMS_REPLICATION_TASK_SETTINGS) $(__DMS_TABLE_MAPPINGS)

_dms_view_tasks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DMS tasks ...'; $(NORMAL)
	$(AWS) dms describe-replication-tasks $(__DMS_FILTERS_TASKS) --query "ReplicationTasks[]$(DMS_UI_VIEW_TASKS_FIELDS)"

_dms_watch_task_statistics:
	watch -n $(DMS_UI_WATCH_INTERVAL) --color "$(MAKE) -e --quiet _dms_watch_task_statistics_header _dms_show_task __dms_watch_task_statistics_crc __dms_watch_task_statistics_fullload __dms_watch_task_statistics_validation _dms_watch_task_statistics_footer"

_dms_watch_task_statistics_footer ::
_dms_watch_task_statistics_header ::
