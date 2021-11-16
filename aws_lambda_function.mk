_AWS_LAMBDA_FUNCTION_MK_VERSION= $(_AWS_LAMBDA_MK_VERSION)

# LBA_FUNCTION_ACCOUNT_ID?=
# LBA_FUNCTION_ARN?=
# LBA_FUNCTION_CODE?= S3Bucket=bucket-name,S3Key=zip-file-object-key
# LBA_FUNCTION_CODE_SHA256?=
# LBA_FUNCTION_CODE_URL?= https://awslambda-us-west-2-tasks.s3.us-west-2.amazonaws.com/snapshots/123456789012/LogsToElasticsearch_staging-es-4fd0c854-0b46-40e9-b277-84d53e98a478?...
# LBA_FUNCTION_DEAD_LETTER_CONFIG?=
# LBA_FUNCTION_DESCRIPTION?= 'A great Function!'
# LBA_FUNCTION_ENVIRONMENT?= VAR1=value1 VAR2=value2
# LBA_FUNCTION_HANDLER?= CreateThumbnail.handler
# LBA_FUNCTION_INVOKE_CLIENTCONTEXT?=
# LBA_FUNCTION_INVOKE_EVENTFILEPATH?= /tmp/invoke_event_payload.json
LBA_FUNCTION_INVOKE_INVOCATIONTYPE?= RequestResponse
# LBA_FUNCTION_INVOKE_LOGSFILEPATH?= /tmp/invoke_logs.txt
# LBA_FUNCTION_INVOKE_LOGTYPE?= Tail
# LBA_FUNCTION_INVOKE_PAYLOAD?=
# LBA_FUNCTION_INVOKE_QUALIFIER?= <alias or version>
# LBA_FUNCTION_INVOKE_RESPONSEFILEPATH?=
# LBA_FUNCTION_KMSKEY_ARN?=
# LBA_FUNCTION_LOGGROUP_NAME?= /aws/lambda/my-function
LBA_FUNCTION_MEMORY_SIZE?= 128
# LBA_FUNCTION_NAME?= my-function
# LBA_FUNCTION_REVISION_ID?=
# LBA_FUNCTION_REGION_NAME?= us-west-2
# LBA_FUNCTION_ROLE_ARN?= arn:aws:iam::123456789012:role/Pac001a-InvalidateOnWriteExecutionRole-1U8MR768KZFRI
# LBA_FUNCTION_RUNTIME_NAME?= python2.7
# LBA_FUNCTION_STATEMENT_ID?=
# LBA_FUNCTION_TAGS_KEYVALUES?= KeyName1=string ...
# LBA_FUNCTION_TAGS_KEYS?= KeyName1 ...
LBA_FUNCTION_TIMEOUT?= 3
LBA_FUNCTION_TRACING_CONFIG?= PassThrough
# LBA_FUNCTION_URL?= https://<restapiid>.execute-api.us-east-1.amazonaws.com/Prod/hello/
LBA_FUNCTION_VERSION?= $LATEST
# LBA_FUNCTION_VPC_CONFIG?=
# LBA_FUNCTION_TRIGGER_PRINCIPAL?= sns.amazonaws.com

# Derived parameters
LBA_FUNCTION_ACCOUNT_ID?= $(LBA_ACCOUNT_ID)
LBA_FUNCTION_ARN?= arn:aws:lambda:$(LBA_FUNCTION_REGION_NAME):$(LBA_FUNCTION_ACCOUNT_ID):function:$(LBA_FUNCTION_NAME)
LBA_FUNCTION_INVOKE_PAYLOAD?= $(if $(LBA_FUNCTION_INVOKE_EVENTFILEPATH),file://$(LBA_FUNCTION_INVOKE_EVENTFILEPATH))
LBA_FUNCTION_LOGGROUP_NAME?= $(if $(LBA_FUNCTION_NAME),/aws/lambda/$(LBA_FUNCTION_NAME))
LBA_FUNCTION_PACKAGE_FILEPATH?= $(LBA_PACKAGE_FILEPATH)
LBA_FUNCTION_REGION_NAME?= $(LBA_REGION_NAME)

# Options
__LBA_CODE= $(if $(LBA_FUNCTION_CODE),--code $(LBA_FUNCTION_CODE))
__LBA_CODE_SHA256= $(if $(LBA_FUNCTION_CODE_SHA256),--code-sha256 $(LBA_FUNCTION_CODE_SHA256))
__LBA_DEAD_LETTER_CONFIG= $(if $(LBA_FUNCTION_DEAD_LETTER_CONFIG),--dead-letter-config $(LBA_FUNCTION_DEAD_LETTER_CONFIG))
__LBA_DESCRIPTION__FUNCTION= $(if $(LBA_FUNCTION_DESCRIPTION),--description '$(LBA_FUNCTION_DESCRIPTION)')
__LBA_ENVIRONMENT= $(if $(LBA_FUNCTION_ENVIRONMENT),--environment Variables={$(subst $(SPACE),$(COMMA),$(LBA_FUNCTION_ENVIRONMENT))})
__LBA_FUNCTION_NAME= $(if $(LBA_FUNCTION_NAME),--function-name $(LBA_FUNCTION_NAME))
__LBA_FUNCTION_VERSION= $(if $(value LBA_FUNCTION_VERSION),--function-version '$(value LBA_FUNCTION_VERSION)')
__LBA_HANDLER= $(if $(LBA_FUNCTION_HANDLER),--handler $(LBA_FUNCTION_HANDLER))
__LBA_INVOCATION_TYPE= $(if $(LBA_FUNCTION_INVOKE_INVOCATIONTYPE),--invocation-type $(LBA_FUNCTION_INVOKE_INVOCATIONTYPE))
__LBA_KMS_KEY_ARN= $(if $(LBA_FUNCTION_KMSKEY_ARN),--kms-key-arn $(LBA_FUNCTION_KMSKEY_ARN))
__LBA_LAYERS=
__LBA_LOG_TYPE= $(if $(LBA_FUNCTION_INVOKE_LOGTYPE),--log-type $(LBA_FUNCTION_INVOKE_LOGTYPE))
__LBA_MEMORY_SIZE= $(if $(LBA_FUNCTION_MEMORY_SIZE),--memory-size $(LBA_FUNCTION_MEMORY_SIZE))
__LBA_PAYLOAD= $(if $(LBA_FUNCTION_INVOKE_PAYLOAD),--payload $(LBA_FUNCTION_INVOKE_PAYLOAD))
__LBA_PRINCIPAL= $(if $(LBA_FUNCTION_TRIGGER_PRINCIPAL),--principal $(LBA_FUNCTION_TRIGGER_PRINCIPAL))
__LBA_PUBLISH=
__LBA_RESOURCE__FUNCTION= $(if $(LBA_FUNCTION_ARN),--resource $(LBA_FUNCTION_ARN))
__LBA_REVISION_ID= $(if $(LBA_FUNCTION_REVISION_ID),--revision-id $(LBA_FUNCTION_REVISION_ID))
__LBA_RUNTIME= $(if $(LBA_FUNCTION_RUNTIME_NAME),--runtime $(LBA_FUNCTION_RUNTIME_NAME))
__LBA_ROLE= $(if $(LBA_FUNCTION_ROLE_ARN),--role $(LBA_FUNCTION_ROLE_ARN))
__LBA_S3_BUCKET= $(if $(LBA_DEPLOYMENT_PACKAGE_S3_BUCKET_NAME),--s3-bucket $(LBA_DEPLOYMENT_PACKAGE_S3_BUCKET_NAME))
__LBA_S3_KEY= $(if $(LBA_DEPLOYMENT_PACKAGE_S3_KEY),--s3-key $(LBA_DEPLOYMENT_PACKAGE_S3_KEY))
__LBA_STATEMENT_ID= $(if $(LBA_FUNCTION_STATEMENT_ID),--statement-id $(LBA_FUNCTION_STATEMENT_ID))
__LBA_TAGS__FUNCTION= $(if $(LBA_FUNCTION_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(LBA_FUNCTION_TAGS_KEYVALUES)))
__LBA_TAG_KEYS__FUNCTION= $(if $(LBA_FUNCTION_TAGS_KEYS),--tag-keys $(LBA_FUNCTION_TAGS_KEYS))
__LBA_TIMEOUT= $(if $(LBA_FUNCTION_TIMEOUT),--timeout $(LBA_FUNCTION_TIMEOUT))
__LBA_TRACING_CONFIG= $(if $(LBA_FUNCTION_TRACING_CONFIG),--tracing-config Mode=$(LBA_FUNCTION_TRACING_CONFIG))
__LBA_VPC_CONFIG= $(if $(LBA_FUNCTION_VPC_CONFIG),--vpc-config $(LBA_FUNCTION_VPC_CONFIG))
__LBA_ZIP_FILE= $(if $(LBA_FUNCTION_PACKAGE_FILEPATH),--zip-file fileb://$(LBA_FUNCTION_PACKAGE_FILEPATH))

# Customizations
|_LBA_INVOKE_FUNCTION?= # $(if $(LBA_FUNCTION_INVOKE_LOGTYPE),--query 'LogResult' --output text |  base64 -d > $(LBA_FUNCTION_INVOKE_LOGSFILEPATH))
_LBA_LIST_FUNCTIONS_FIELDS?= .{FunctionName:FunctionName,runtime:Runtime,memorySizeMB:MemorySize,timeout:Timeout,version:Version,codeSizeB:CodeSize}
_LBA_LIST_FUNCTIONS_SET_FIELDS?= $(LBA_LIST_FUNCTIONS_FIELDS)
_LBA_LIST_FUNCTIONS_SET_QUERY_FILTER?=
_LBA_SHOW_FUNCTION_FIELDS?=
|_LBA_SHOW_FUNCTION_LOGS?= && echo
|_LBA_SHOW_FUNCTION_RESPONSE?= | jq --monochrome-output '.'

# Macros

_lba_get_function_arn= $(call _lba_get_function_arn_N, $(LBA_FUNCTION_NAME))
# _lba_get_function_arn_N= $(shell $(AWS) lambda list-functions --query "Functions[?FunctionName=='$(strip $(1))'].FunctionArn" --output text)
_lba_get_function_arn_N= $(shell echo arn:aws:lambda:$(AWS_FUNCTION_REGION_NAME):$(AWS_FUNCTION_ACCOUNT_ID):function:$(strip $(1)))

_lba_get_function_code_url= $(call _lba_get_function_code_url_N, $(LBA_FUNCTION_NAME))
_lba_get_function_code_url_N= $(shell $(AWS) lambda get-function --function-name $(1) --query "Code.Location" --output text)

_lba_get_function_name= $(call _lba_get_function_name_A, $(LBA_FUNCTION_ARN))
_lba_get_function_name_A= $(lastword $(subst :,$(SPACE),$(LBA_FUNCTION_ARN)))

_lba_get_function_role_arn= $(call _lba_get_function_role_arn_N, $(LBA_FUNCTION_NAME))
_lba_get_function_role_arn_N= $(shell $(AWS) lambda list-functions --query "Functions[?FunctionName=='$(strip $(1))'].Role" --output text)

#----------------------------------------------------------------------
# USAGE
#

_lba_list_macros ::
	@echo 'AWS::LamBdA::Function ($(_AWS_LAMBDA_FUNCTION_MK_VERSION)) macros:'
	@echo '    _lba_get_function_arn_{|N}            - Get the ARN of a function (Name)'
	@echo '    _lba_get_function_code_url_{|N}       - Get the URL for the code of a function (Name)'
	@echo '    _lba_get_function_name_{|A}           - Get the name of a function (Arn)'
	@echo '    _lba_get_function_role_arn_{|N}       - Get the ARN of a role of a function (Name)'
	@echo

_lba_list_parameters ::
	@echo 'AWS::LamBdA::Function ($(_AWS_LAMBDA_FUNCTION_MK_VERSION)) parameters:'
	@echo '    LBA_FUNCTION_ACCOUNT_ID=$(LBA_FUNCTION_ACCOUNT_ID)'
	@echo '    LBA_FUNCTION_ARN=$(LBA_FUNCTION_ARN)'
	@echo '    LBA_FUNCTION_CODE=$(LBA_FUNCTION_CODE)'
	@echo '    LBA_FUNCTION_CODE_SHA256=$(LBA_FUNCTION_CODE_SHA256)'
	@echo '    LBA_FUNCTION_CODE_URL=$(LBA_FUNCTION_CODE_URL)'
	@echo '    LBA_FUNCTION_DESCRIPTION=$(LBA_FUNCTION_DESCRIPTION)'
	@echo '    LBA_FUNCTION_ENVIRONMENT=$(LBA_FUNCTION_ENVIRONMENT)'
	@echo '    LBA_FUNCTION_HANDLER=$(LBA_FUNCTION_HANDLER)'
	@echo '    LBA_FUNCTION_INVOKE_CLIENTCONTEXT=$(LBA_FUNCTION_INVOKE_CLIENTCONTEXT)'
	@echo '    LBA_FUNCTION_INVOKE_EVENT_FILEPATH=$(LBA_FUNCTION_INVOKE_EVENTFILEPATH)'
	@echo '    LBA_FUNCTION_INVOKE_LOGSFILEPATH=$(LBA_FUNCTION_INVOKE_LOGSFILEPATH)'
	@echo '    LBA_FUNCTION_INVOKE_LOGTYPE=$(LBA_FUNCTION_INVOKE_LOGTYPE)'
	@echo '    LBA_FUNCTION_INVOKE_PAYLOAD=$(LBA_FUNCTION_INVOKE_PAYLOAD)'
	@echo '    LBA_FUNCTION_INVOKE_QUALIFIER=$(LBA_FUNCTION_INVOKE_QUALIFIER)'
	@echo '    LBA_FUNCTION_INVOKE_RESPONSEFILEPATH=$(LBA_FUNCTION_INVOKE_RESPONSEFILEPATH)'
	@echo '    LBA_FUNCTION_KMSKEY_ARN=$(LBA_FUNCTION_KMSKEY_ARN)'
	@echo '    LBA_FUNCTION_LOGGROUP_NAME=$(LBA_FUNCTION_LOGGROUP_NAME)'
	@echo '    LBA_FUNCTION_MEMORY_SIZE=$(LBA_FUNCTION_MEMORY_SIZE)'
	@echo '    LBA_FUNCTION_NAME=$(LBA_FUNCTION_NAME)'
	@echo '    LBA_FUNCTION_PACKAGE_FILEPATH=$(LBA_FUNCTION_PACKAGE_FILEPATH)'
	@echo '    LBA_FUNCTION_REGION_NAME=$(LBA_FUNCTION_REGION_NAME)'
	@echo '    LBA_FUNCTION_REVISION_ID=$(LBA_FUNCTION_REVISION_ID)'
	@echo '    LBA_FUNCTION_ROLE_ARN=$(LBA_FUNCTION_ROLE_ARN)'
	@echo '    LBA_FUNCTION_RUNTIME_NAME=$(LBA_FUNCTION_RUNTIME_NAME)'
	@echo '    LBA_FUNCTION_STATEMENT_ID=$(LBA_STATEMENT_ID)'
	@echo '    LBA_FUNCTION_TAGS_KEYS=$(LBA_FUNCTION_TAGS_KEYS)'
	@echo '    LBA_FUNCTION_TAGS_KEYVALUES=$(LBA_FUNCTION_TAGS_KEYVALUES)'
	@echo '    LBA_FUNCTION_TIMEOUT=$(LBA_FUNCTION_TIMEOUT)'
	@echo '    LBA_FUNCTION_TRACING_CONFIG=$(LBA_FUNCTION_TRACING_CONFIG)'
	@echo '    LBA_FUNCTION_URL=$(LBA_FUNCTION_URL)'
	@echo '    LBA_FUNCTION_VERSION=$(value LBA_FUNCTION_VERSION)'
	@echo '    LBA_FUNCTION_VPC_CONFIG=$(LBA_FUNCTION_VPC_CONFIG)'
	@echo '    LBA_INVOCATION_TYPE=$(LBA_INVOCATION_TYPE)'
	@echo

_lba_list_targets ::
	@echo 'AWS::LamBdA::Function ($(_AWS_LAMBDA_FUNCTION_MK_VERSION)) targets:'
	@echo '    _lba_add_permission                   - Allow an event source based on ARN'
	@echo '    _lba_create_function                  - Create a function'
	@echo '    _lba_curl_function                    - Curl a function'
	@echo '    _lba_delete_function                  - Delete a function'
	@echo '    _lba_disable_function_trigger         - Disable function trigger'
	@echo '    _lba_enable_function_trigger          - Enable function trigger'
	@echo '    _lba_invoke_function                  - Invoke a function'
	@echo '    _lba_list_functions                   - List all functions'
	@echo '    _lba_list_functions_set               - List a set of fucntions'
	@echo '    _lba_show_function                    - Show everything related to a function'
	@echo '    _lba_show_function_aliases            - Show aliases of a function'
	@echo '    _lba_show_function_code               - Show code used by a function'
	@echo '    _lba_show_function_description        - Show description of a function'
	@echo '    _lba_show_function_layers             - Show layers used by a function'
	@echo '    _lba_show_function_logs               - Show logs of a function invocation'
	@echo '    _lba_show_function_response           - Show response of a function invocation'
	@echo '    _lba_show_function_role               - Show IAM role of a function'
	@echo '    _lba_show_function_sampleevent        - Show sample-event of a function'
	@echo '    _lba_show_function_triggerpolicy      - Show trigger-policy of a function'
	@echo '    _lba_show_function_versions           - Show versions of a function'
	@echo '    _lba_tag_function                     - Tag function'
	@echo '    _lba_untag_function                   - Untag function'
	@echo '    _lba_update_function_code             - Update the code of a function'
	@echo '    _lba_update_function_config           - Update the configuration of a function'
	@echo '    _lba_version_function                 - Public a version for a function'
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_lba_add_permission:
	@$(INFO) '$(LBA_UI_LABEL)Adding an event-source/trigger to function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda add-permission $(__LBA_FUNCTION_NAME) $(__LBA_STATEMENT_ID) $(__LBA_ACTION) $(__LBA_PRINCIPAL) $(__LBA_SOURCE_ARN)

_lba_create_function:
	@$(INFO) '$(LBA_UI_LABEL)Creating function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda create-function $(strip $(__LBA_CODE) $(__LBA_DEAD_LETTER_CONFIG) $(__LBA_DESCRIPTION__FUNCTION) $(__LBA_ENVIRONMENT) $(__LBA_FUNCTION_NAME) $(__LBA_HANDLER) $(__LBA_KMS_KEY_ARN) $(__LBA_LAYERS) $(__LBA_MEMORY_SIZE) $(__LBA_PUBLISH) $(__LBA_ROLE) $(__LBA_RUNTIME) $(__LBA_TAGS) $(__LBA_TIMEOUT) $(__LBA_TRACING_CONFIG) $(__LBA_VPC_CONFIG) $(__LBA_ZIP_FILE))

_lba_curl_function:
	@$(INFO) '$(LBA_UI_LABEL)Curling function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	curl $(LBA_FUNCTION_URL)

_lba_delete_function:
	@$(INFO) '$(LBA_UI_LABEL)Deleting existing function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	-$(AWS) lambda delete-function $(__LBA_FUNCTION_NAME)

_lba_disable_function_trigger::

_lba_enable_function_trigger::

_lba_invoke_function:
	@$(INFO) '$(LBA_UI_LABEL)Invoking function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns a status code which correspond to the REAL status of the execution'; $(NORMAL)
	@$(WARN) 'The status code that may appear in the output/response is just a string!'; $(NORMAL)
	@$(if $(LBA_FUNCTION_INVOKE_EVENTFILEPATH), cat $(LBA_FUNCTION_INVOKE_EVENTFILEPATH))
	$(AWS) lambda invoke $(strip $(_LBA_CLIENT_CONTEXT) $(__LBA_FUNCTION_NAME) $(__LBA_INVOCATION_TYPE) $(__LBA_LOG_TYPE) $(__LBA_PAYLOAD) $(__LBA_QUALIFIER)) $(LBA_FUNCTION_INVOKE_RESPONSEFILEPATH) $(|_LBA_INVOKE_FUNCTION)

_lba_list_functions:
	@$(INFO) '$(LBA_UI_LABEL)Listing ALL functions ...'; $(NORMAL)
	$(AWS) lambda list-functions --query 'Functions[]$(_LBA_LIST_FUNCTIONS_FIELDS)'

_lba_list_functions_set:
	@$(INFO) '$(LBA_UI_LABEL)Listing functions-set "$(LBA_FUNCTIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Function are grouped based on provided query filter'; $(NORMAL)
	$(AWS) lambda list-functions --query 'Functions[$(_LBA_LIST_FUNCTIONS_SET_QUERYFILTER)]$(_LBA_LIST_FUNCTIONS_SET_FIELDS)'

_LBA_SHOW_FUNCTION_TARGETS?= _lba_show_function_aliases _lba_show_function_code _lba_show_function_layers _lba_show_function_logs _lba_show_function_response _lba_show_function_role _lba_show_function_tags _lba_show_function_triggers _lba_show_function_triggerpolicy _lba_show_function_sampleevent _lba_show_function_versions _lba_show_function_description
_lba_show_function: $(_LBA_SHOW_FUNCTION_TARGETS)

_lba_show_function_aliases:
	@$(INFO) '$(LBA_UI_LABEL)Showing aliases of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda list-aliases $(__LBA_FUNCTION_NAME) $(__LBA_FUNCTION_VERSION)

_lba_show_function_code:
	@$(INFO) '$(LBA_UI_LABEL)Showing code of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation requires LBA_FUNCTION_CODE_URL to be set!'; $(NORMAL)
	$(if $(LBA_FUNCTION_CODE_URL),curl -s '$(LBA_FUNCTION_CODE_URL)' | zcat)

_lba_show_function_description:
	@$(INFO) '$(LBA_UI_LABEL)Showing description of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows the details of the currently-active versions'; $(NORMAL)
	@$(WARN) 'Cloudwatch logs @ $(LBA_FUNCTION_LOGGROUP_NAME)'; $(NORMAL)
	$(AWS) lambda get-function-configuration $(__LBA_FUNCTION_NAME) $(__LBA_QUALIFIER)

_lba_show_function_layers:
	@$(INFO) '$(LBA_UI_LABEL)Showing layers of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda get-function $(__LBA_FUNCTION_NAME) $(__LBA_QUALIFER) --query "Configuration.Layers"

_lba_show_function_logs::
	@$(INFO) '$(LBA_UI_LABEL)Showing logs of latest invocation of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation outputs the logs of the latest invoke-function call'; $(NORMAL)
	@$(WARN) 'Logs were stored in $(LBA_FUNCTION_INVOKE_LOGSFILEPATH)'; $(NORMAL)
	@$(WARN) 'Cloudwatch logs @ $(LBA_FUNCTION_LOGGROUP_NAME)'; $(NORMAL)
	-$(if $(LBA_FUNCTION_INVOKE_LOGSFILEPATH),[ -f $(LBA_FUNCTION_INVOKE_LOGSFILEPATH) ] && cat $(LBA_FUNCTION_INVOKE_LOGSFILEPATH) $(|_LBA_SHOW_FUNCTION_LOGS))

_lba_show_function_response:
	@$(INFO) '$(LBA_UI_LABEL)Showing a response of latest invocation of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation outputs the returned value of the latest invoke-function call'; $(NORMAL)
	@$(WARN) 'Response was stored in $(LBA_FUNCTION_INVOKE_RESPONSEFILEPATH)'; $(NORMAL)
	-$(if $(LBA_FUNCTION_INVOKE_RESPONSEFILEPATH),[ -f $(LBA_FUNCTION_INVOKE_RESPONSEFILEPATH) ] && cat $(LBA_FUNCTION_INVOKE_RESPONSEFILEPATH) $(|_LBA_SHOW_FUNCTION_RESPONSE))

_lba_show_function_role ::
	@$(INFO) '$(LBA_UI_LABEL)Showing execution-role of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'TO BE IMPLEMENTED!'
	# $(AWS) iam

_lba_show_function_sampleevent:
	@$(INFO) '$(LBA_UI_LABEL)Showing sample-event of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Event file: $(LBA_FUNCTION_INVOKE_EVENTFILEPATH)'; $(NORMAL)
	$(if $(LBA_FUNCTION_INVOKE_EVENTFILEPATH),cat $(LBA_FUNCTION_INVOKE_EVENTFILEPATH))

_lba_show_function_tags:
	@$(INFO) '$(LBA_UI_LABEL)Showing tags of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda list-tags $(__LBA_RESOURCE__FUNCTION) --query "Tags"

_lba_show_function_triggers::

_lba_show_function_triggerpolicy:
	@$(INFO) '$(LBA_UI_LABEL)Showing trigger-policy attached to function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows the external resources that can trigger or interact with the function'; $(NORMAL)
	$(AWS) lambda get-policy $(__LBA_FUNCTION_NAME) $(__LBA_QUALIFIER) --query 'Policy' --output text  | jq --monochrome-output  '.'

_lba_show_function_versions:
	@$(INFO) '$(LBA_UI_LABEL)Showing available versions of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation shows the details for all available versions'; $(NORMAL)
	$(AWS) lambda list-versions-by-function $(__LBA_FUNCTION_NAME)

_lba_tag_function:
	@$(INFO) '$(LBA_UI_LABEL)Tagging function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda tag-resource $(__LBA_RESOURCE__FUNCTION) $(__LBA_TAGS__FUNCTION)

_lba_untag_function:
	@$(INFO) '$(LBA_UI_LABEL)Tagging function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda untag-resource $(__LBA_RESOURCE__FUNCTION) $(__LBA_TAG_KEYS__FUNCTION)

_lba_update_function_code:
	@$(INFO) '$(LBA_UI_LABEL)Updating code of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda update-function-code $(__LBA_FUNCTION_NAME) $(__LBA_PUBLISH) $(__LBA_REVISION_ID) $(__LBA_S3_BUCKET) $(__LBA_S3_KEY) $(__LBA_S3_OBJECT_VERSION) $(__LBA_ZIP_FILE) 

_lba_update_function_configuration:
	@$(INFO) '$(LBA_UI_LABEL)Updating configuration of function "$(LBA_FUNCTION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation patches the current configuration with the provided values'; $(NORMAL)
	@$(WARN) 'This operation can be used for example to add or remove layers'; $(NORMAL)
	$(AWS) lambda update-function-configuration $(strip $(__LBA_DEAD_LETTER_CONFIG) $(__LBA_DESCRIPTION__FUNCTION) $(__LBA_ENVIRONMENT) $(__LBA_FUNCTION_NAME) $(__LBA_HANDLER) $(__LBA_KMS_KEY_ARN) $(__LBA_LAYERS) $(__LBA_MEMORY_SIZE) $(__LBA_REVISION_ID) $(__LBA_ROLE) $(__LBA_RUNTIME) $(__LBA_TIMEOUT) $(__LBA_TRACING_CONFIG) $(__LBA_VPC_CONFIG))

_lba_version_function:
	@$(INFO) '$(LBA_UI_LABEL)Versioning function "$(LBA_VERSION_NAME)" ...'; $(NORMAL)
	$(AWS) lambda publish-version $(__LBA_CODE_SHA256) $(__LBA_DESCRIPTION__FUNCTION) $(__LBA_REVISION_ID) $(__LBA_VERSION_NAME)
