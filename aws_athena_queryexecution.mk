_AWS_ATHENA_QUERYEXECUTION_MK_VERSION=$(_AWS_ATHENA_MK_VERSION)

ATA_QUERYEXECUTION_DATABASE?= default
# ATA_QUERYEXECUTION_ID?=
# ATA_QUERYEXECUTION_IDS?=
ATA_QUERYEXECUTION_INDEX?= 0
ATA_QUERYEXECUTION_NAME?= Unsaved
# ATA_QUERYEXECUTION_OUTPUT_S3FOLDER?= s3://my-bucket/path/to/
# ATA_QUERYEXECUTION_OUTPUT_S3LOCATION?= s3://my-bucket/path/to/results.csv
# ATA_QUERYEXECUTION_RESULT_CONFIG?= OutputLocation=s3://test/,EncryptionConfiguration={EncryptionOption=string,KmsKey=string}
ATA_QUERYEXECUTION_SLICE?= 0:10:1
# ATA_QUERYEXECUTION_SQL?=
# ATA_QUERYEXECUTION_SQL_FILEPATH?=
# ATA_RESULTS_S3BUCKET?=
# ATA_RESULTS_S3BUCKET_DEFAULT?=

# Derived variables
ATA_QUERYEXECUTION_OUTPUT_BUCKET?= s3://aws-athena-query-results-123456789012-us-west-2
ATA_QUERYEXECUTION_OUTPUT_FILEPATH?= $(if $(ATA_QUERYEXECUTION_ID), /tmp/$(ATA_QUERYEXECUTION_ID))
ATA_QUERYEXECUTION_RESULT_CONFIG?= $(if $(ATA_QUERYEXECUTION_OUTPUT_S3FOLDER), OutputLocation=$(ATA_QUERYEXECUTION_OUTPUT_S3FOLDER))
ATA_QUERYEXECUTION_SQL?= $(if $(ATA_QUERYEXECUTION_SQL_FILEPATH), file://$(ATA_QUERYEXECUTION_SQL_FILEPATH))
ATA_RESULTS_S3BUCKET?= $(ATA_RESULTS_S3BUCKET_DEFAULT)
ATA_RESULTS_S3BUCKET_DEFAULT?= s3://aws-athena-query-results-$(AWS_ACCOUNT_ID)-$(AWS_REGION)

# Options variables
__ATA_QUERY_EXECUTION_CONTEXT?= $(if $(ATA_QUERYEXECUTION_DATABASE), --query-execution-context Database=$(ATA_QUERYEXECUTION_DATABASE))
__ATA_QUERY_EXECUTION_ID?= $(if $(ATA_QUERYEXECUTION_ID), --query-execution-id $(ATA_QUERYEXECUTION_ID))
__ATA_QUERY_EXECUTION_IDS?= $(if $(ATA_QUERYEXECUTION_IDS), --query-execution-ids $(ATA_QUERYEXECUTION_IDS))
__ATA_QUERY_STRING?= $(if $(ATA_QUERYEXECUTION_SQL), --query-string $(ATA_QUERYEXECUTION_SQL))
__ATA_RESULT_CONFIGURATION?= $(if $(ATA_QUERYEXECUTION_RESULT_CONFIG), --result-configuration $(ATA_QUERYEXECUTION_RESULT_CONFIG))

# UI variables
ATA_UI_SHOW_QUERYEXECUTION_SUMMARY_FIELDS?= .{Status:Status,Statistics:Statistics,ResultConfiguration:ResultConfiguration,QueryExecutionId:QueryExecutionId,QueryExecutionContext:QueryExecutionContext}
ATA_UI_VIEW_QUERYEXECUTION_SET_FIELDS?= .{QueryExecutionId:QueryExecutionId,state:Status.State,database:QueryExecutionContext.Database,submissionDateTime:Status.SubmissionDateTime,completionDateTime:Status.CompletionDateTime}  | sort_by(@,&submissionDateTime) | reverse(@)

#--- Utilities
# ATA_CAT_BIN?= csvlook
# ATA_CAT?= $(__ATA_CAT_ENVIRONMENT) $(ATA_CAT_ENVIRONMENT) $(ATA_CAT) $(__ATA_CAT_OPTIONS) $(ATA_CAT_OPTIOBS)

#--- Macros
#
# Returns the last submitted(?) query
_ata_get_queryexecution_id= $(call _ata_get_queryexecution_id_I, $(ATA_QUERYEXECUTION_INDEX))
_ata_get_queryexecution_id_I= $(shell $(AWS) athena list-query-executions --query "QueryExecutionIds[$(1)]" --output text)

_ata_get_queryexecution_ids= $(call _ata_get_queryexecution_ids_S, $(ATA_QUERYEXECUTION_SLICE))
_ata_get_queryexecution_ids_S= $(shell $(AWS) athena list-query-executions --query "QueryExecutionIds[$(1)]"  --output text)

_ata_get_queryexecution_output_s3folder= $(call _ata_get_queryexecution_output_s3folder_D, $(shell date "+%Y/%m/%d"))
_ata_get_queryexecution_output_s3folder_D= $(call _ata_get_queryexecution_output_s3folder_DN, $(1), $(ATA_QUERYEXECUTION_NAME))
_ata_get_queryexecution_output_s3folder_DN= $(call _ata_get_queryexecution_output_s3folder_DNB, $(1), $(2), $(ATA_RESULTS_S3BUCKET))
_ata_get_queryexecution_output_s3folder_DNB= $(shell echo $(strip $(3))/$(strip $(2))/$(strip $(1))/)

_ata_get_queryexecution_output_s3location= $(call _ata_get_queryexecution_output_s3location_I, $(ATA_QUERYEXECUTION_ID))
_ata_get_queryexecution_output_s3location_I= $(shell $(AWS) athena get-query-execution  --query-execution-id $(1) --query "QueryExecution.ResultConfiguration.OutputLocation" --output text)

_ata_get_queryexecution_output_s3location_default= $(call _ata_get_queryexecution_output_s3location_default_D, $(shell date "+%Y/%m/%d"))
_ata_get_queryexecution_output_s3location_default_D= $(call _ata_get_queryexecution_output_s3location_default_DI, $(1), $(ATA_QUERYEXECUTION_ID))
_ata_get_queryexecution_output_s3location_default_DI= $(call _ata_get_queryexecution_output_s3location_default_DIN, $(1), $(2), $(ATA_QUERYEXECUTION_NAME))
_ata_get_queryexecution_output_s3location_default_DIN= $(call _ata_get_queryexecution_output_s3location_default_DINB, $(1), $(2), $(3), $(ATA_RESULTS_S3BUCKET_DEFAULT))
_ata_get_queryexecution_output_s3location_default_DINB= $(shell echo $(strip $(4))/$(strip $(3))/$(strip $(1))/$(strip $(2)).csv)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ata_view_makefile_macros ::
	@echo 'AWS::AThenA::QueryExecution ($(_AWS_ATHENA_QUERYEXECUTION_MK_VERSION)) macros:'
	@echo '    _ata_get_queryexecution_id_{|I}                         - Get the ID of a query-execution (Index)'
	@echo '    _ata_get_queryexecution_ids_{|S}                        - Get the IDs of query-executions (Slice)'
	@echo '    _ata_get_queryexecution_output_s3folder_{|D|DN|DNB}     - Get the S3 folder of the output for a query-execution (Date,Name,Bucket)'
	@echo '    _ata_get_queryexecution_output_s3location_{|I}          - Get the S3 location of the output for a query-execution (Id)'
	@echo '    _ata_get_queryexecution_output_s3location_default{|I}   - Get the default S3 location of the output for a query-execution (Id)'
	@echo

_ata_view_makefile_targets ::
	@echo 'AWS::AThenA::QueryExecution ($(_AWS_ATHENA_QUERYEXECUTION_MK_VERSION)) targets:'
	@echo '    _ata_show_queryexecution                                - Show details of query-execution'
	@echo '    _ata_show_queryexecution_results                        - Show results of query-execution'
	@echo '    _ata_show_queryexecution_sql                            - Show SQL statement of query-execution'
	@echo '    _ata_show_queryexecution_summary                        - Show summary of query-execution'
	@echo '    _ata_start_queryexecution                               - Start query-execution'
	@echo '    _ata_stop_queryexecution                                - Stop query-execution'
	@echo '    _ata_view_queryexecutions                               - View query-executions'
	@echo '    _ata_view_queryexecutions_ids                           - View IDs of query-executions'
	@echo '    _ata_view_queryexecutions_set                           - View set of query-executions'
	@echo 

_ata_view_makefile_variables ::
	@echo 'AWS::AThenA::QueryExecution ($(_AWS_ATHENA_QUERYEXECUTION_MK_VERSION)) variables:'
	@echo '    ATA_QUERYEXECUTION_DATABASE=$(ATA_QUERYEXECUTION_DATABASE)'
	@echo '    ATA_QUERYEXECUTION_ID=$(ATA_QUERYEXECUTION_ID)'
	@echo '    ATA_QUERYEXECUTION_IDS=$(ATA_QUERYEXECUTION_IDS)'
	@echo '    ATA_QUERYEXECUTION_INDEX=$(ATA_QUERYEXECUTION_INDEX)'
	@echo '    ATA_QUERYEXECUTION_NAME=$(ATA_QUERYEXECUTION_NAME)'
	@echo '    ATA_QUERYEXECUTION_OUTPUT_FILEPATH=$(ATA_QUERYEXECUTION_OUTPUT_FILEPATH)'
	@echo '    ATA_QUERYEXECUTION_OUTPUT_S3FOLDER=$(ATA_QUERYEXECUTION_OUTPUT_S3FOLDER)'
	@echo '    ATA_QUERYEXECUTION_OUTPUT_S3LOCATION=$(ATA_QUERYEXECUTION_OUTPUT_S3LOCATION)'
	@echo '    ATA_QUERYEXECUTION_RESULT_CONFIG=$(ATA_QUERYEXECUTION_RESULT_CONFIG)'
	@echo '    ATA_QUERYEXECUTION_SLICE=$(ATA_QUERYEXECUTION_SLICE)'
	@echo '    ATA_QUERYEXECUTION_SQL=$(ATA_QUERYEXECUTION_SQL)'
	@echo '    ATA_QUERYEXECUTION_SQL_FILEPATH=$(ATA_QUERYEXECUTION_SQL_FILEPATH)'
	@echo '    ATA_RESULTS_S3BUCKET=$(ATA_RESULTS_S3BUCKET)'
	@echo '    ATA_RESULTS_S3BUCKET_DEFAULT=$(ATA_RESULTS_S3BUCKET_DEFAULT)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ata_show_queryexecution: _ata_show_queryexecution_sql _ata_show_queryexecution_summary
	@$(WARN) "Query results are available in a separate query"; $(NORMAL)

_ata_show_queryexecution_results:
	@$(INFO) '$(AWS_UI_LABEL)Showing results of query-execution "$(ATA_QUERYEXECUTION_NAME)" ...'; $(NORMAL)
	$(AWS) s3 cp $(ATA_QUERYEXECUTION_OUTPUT_S3LOCATION) $(ATA_QUERYEXECUTION_OUTPUT_FILEPATH)
	csvlook $(ATA_QUERYEXECUTION_OUTPUT_FILEPATH) | less -S -F  -#2   # -N
	@$(WARN) 'Post-processing to try:'
	# csvgrep -e iso-8859-1 -c 1 -m "de" worldcitiespop | csvgrep -c 5 -r "\d+" | csvsort -r -c 5 -l | csvcut -c 1,2,4,6 | head -n 11 | csvlook
	# More @ https://csvkit.readthedocs.io/en/1.0.3/
	@$(NORMAL)

_ata_show_queryexecution_sql:
	@$(INFO) '$(AWS_UI_LABEL)Showing SQL Query of query-execution "$(ATA_QUERYEXECUTION_NAME)" ...'; $(NORMAL)
	$(CYAN); $(AWS) athena get-query-execution $(__ATA_QUERY_EXECUTION_ID) --query "QueryExecution.Query" --output text; $(WHITE)

_ata_show_queryexecution_summary:
	@$(INFO) '$(AWS_UI_LABEL)Showing summary of query-execution "$(ATA_QUERYEXECUTION_NAME)" ...'; $(NORMAL)
	$(AWS) athena get-query-execution $(__ATA_QUERY_EXECUTION_ID) --query "QueryExecution$(ATA_UI_SHOW_QUERYEXECUTION_SUMMARY_FIELDS)"

_ata_start_queryexecution:
	@$(INFO) '$(AWS_UI_LABEL)Starting query-execution ...'; $(NORMAL)
	$(AWS) athena start-query-execution $(__ATA_QUERY_EXECUTION_CONTEXT) $(__ATA_QUERY_STRING) $(__ATA_RESULT_CONFIGURATION)

_ata_stop_queryexecution:
	@$(INFO) '$(AWS_UI_LABEL)Stopping query-execution ...'; $(NORMAL)
	$(AWS) athena stop-query-execution $(__ATA_QUERY_EXECUTION_ID)

_ata_view_queryexecutions: _ata_view_queryexecutions_ids _ata_view_queryexecutions_set

_ata_view_queryexecutions_ids:
	@$(INFO) '$(AWS_UI_LABEL)Viewing query-executions ...'; $(NORMAL)
	@$(WARN) 'IDs are ordered by submission date: most recent one at the top, oldest one at the bottom'; $(NORMAL)
	$(AWS) athena list-query-executions --query "QueryExecutionIds[]"

_ata_view_queryexecutions_set: ATA_QUERYEXECUTION_IDS= $(call _ata_get_queryexecution_ids)
_ata_view_queryexecutions_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing query-execution set ...'; $(NORMAL)
	@$(WARN) 'Query-execution slice: $(ATA_QUERYEXECUTION_SLICE)'; $(NORMAL)
	@#$(WARN) 'The order of the returned Named-query is consistent, but not based on creation data!!!'; $(NORMAL)
	$(AWS) athena batch-get-query-execution $(__ATA_QUERY_EXECUTION_IDS) --query "QueryExecutions[]$(ATA_UI_VIEW_QUERYEXECUTION_SET_FIELDS)"
