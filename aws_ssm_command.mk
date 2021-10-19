_AWS_SSM_COMMAND_MK_VERSION =$(_AWS_SSM_MK_VERSION)

# SSM_COMMAND_COMMENT?= "This is a command comment!"
# SSM_COMMAND_DOCUMENT_HASH?=
# SSM_COMMAND_DOCUMENT_HASHTYPE?=
# SSM_COMMAND_DOCUMENT_NAME?=
# SSM_COMMAND_DOCUMENT_VERSION?=
# SSM_COMMAND_ID?= 4522cb38-f6fa-4f5a-9a96-b8211fd39c0d
SSM_COMMAND_INDEX?= 0
# SSM_COMMAND_INSTANCE_IDS?= i-0cb2b964d3e14fd9f i-0cb2b964d3e14fd9f
# SSM_COMMAND_MAX_CONCURRENCY?=
# SSM_COMMAND_MAX_ERRORS?=
# SSM_COMMAND_NOTIFICATION_CONFIG?=
# SSM_COMMAND_OUTPUT_S3BUCKETNAME?=
# SSM_COMMAND_OUTPUT_S3KEYPREFIX?=
# SSM_COMMAND_OUTPUT_S3REGION?=
# SSM_COMMAND_PARAMETERS?= commands=["echo helloWorld"]
# SSM_COMMAND_SERVICEROLE_ARN?=
# SSM_COMMAND_TARGETS?= Key=instanceids,Values=i-0cb2b964d3e14fd9f,i-0cb2b964d3e14fd9f ...
# SSM_COMMANDS_SET_NAME?= my-commands-set

# Derived variables
SSM_COMMAND_DOCUMENT_NAME?= $(SSM_DOCUMENT_NAME)
SSM_COMMAND_INSTANCE_IDS?= $(EC2_INSTANCE_IDS)
# SSM_COMMAND_OUTPUT_S3REGION?= $(AWS_REGION)

# Option variables
__SSM_COMMAND_ID= $(if $(SSM_COMMAND_ID), --command-id $(SSM_COMMAND_ID))
__SSM_COMMENT= $(if $(SSM_COMMAND_COMMENT), --comment $(SSM_COMMAND_COMMENT))
__SSM_DOCUMENT_NAME_COMMAND= $(if $(SSM_COMMAND_DOCUMENT_NAME), --document-name $(SSM_COMMAND_DOCUMENT_NAME))
__SSM_FILTERS_COMMAND=
__SSM_INSTANCE_ID= $(if $(SSM_COMMANDS_INSTANCE_ID), --instance-id $(SSM_COMMANDS_INSTANCE_ID))
__SSM_INSTANCE_IDS= $(if $(SSM_COMMAND_INSTANCE_IDS), --instance-ids $(SSM_COMMAND_INSTANCE_IDS))
__SSM_OUTPUT_S3_BUCKET_NAME= $(if $(SSM_COMMAND_OUTPUT_S3BUCKETNAME), --output-s3-bucket-name $(SSM_COMMAND_OUTPUT_S3BUCKETNAME))
__SSM_OUTPUT_S3_KEY_PREFIX= $(if $(SSM_COMMAND_OUTPUT_S3KEYPREFIX), --output-s3-key-prefix $(SSM_COMMAND_OUTPUT_S3KEYPREFIX))
__SSM_OUTPUT_S3_REGION= $(if $(SSM_COMMAND_OUTPUT_S3REGION), --output-s3-region $(SSM_COMMAND_OUTPUT_S3REGION))
__SSM_PARAMETERS_COMMAND= $(if $(SSM_COMMAND_PARAMETERS), --parameters $(SSM_COMMAND_PARAMETERS))

# UI variables
SSM_UI_VIEW_COMMANDS_FIELDS?= .{status:Status,documentName:DocumentName,CommandId:CommandId,targets:join(' ', InstanceIds[0:1]),targetErrorCompletedCounts:join('/', [to_string(TargetCount), to_string(ErrorCount), to_string(CompletedCount)])}
SSM_UI_VIEW_COMMANDS_SET_FIELDS?= $(SSM_UI_VIEW_COMMANDS_FIELDS)

#--- Utilities

#--- MACRO
_ssm_get_command_id= $(call _ssm_get_command_id_I, $(SSM_COMMAND_INDEX))
_ssm_get_command_id_I= $(shell $(AWS) ssm list-commands --query "Commands[$(1)].CommandId" --output text | head -1)# Bug to remove 'None'

#----------------------------------------------------------------------
# USAGE
#

_ssm_view_makefile_macros ::
	@echo 'AWS::SSM::Command ($(_AWS_SSM_COMMAND_MK_VERSION)) macros:'
	@echo '    _ssm_get_command_id_{|I}                    - Get command index'
	@echo

_ssm_view_makefile_targets ::
	@echo 'AWS::SSM::Command ($(_AWS_SSM_COMMAND_MK_VERSION)) targets:'
	@echo '    _ssm_send_command                           - Send a command to one or more instances'
	@echo '    _ssm_show_command                           - Show details of a command'
	@echo '    _ssm_view_commands                          - View commands'
	@echo '    _ssm_view_commands_set                      - View a set of commands'
	@echo

_ssm_view_makefile_variables ::
	@echo 'AWS::SSM::Command ($(_AWS_SSM_COMMAND_MK_VERSION)) variables:'
	@echo '    SSM_COMMAND_COMMENT=$(SSM_COMMAND_COMMENT)'
	@echo '    SSM_COMMAND_DOCUMENT_HASH=$(SSM_COMMAND_DOCUMENT_HASH)'
	@echo '    SSM_COMMAND_DOCUMENT_HASHTYPE=$(SSM_COMMAND_DOCUMENT_HASHTYPE)'
	@echo '    SSM_COMMAND_DOCUMENT_NAME=$(SSM_COMMAND_DOCUMENT_NAME)'
	@echo '    SSM_COMMAND_DOCUMENT_VERSION=$(SSM_COMMAND_DOCUMENT_VERSION)'
	@echo '    SSM_COMMAND_ID=$(SSM_COMMAND_ID)'
	@echo '    SSM_COMMAND_INDEX=$(SSM_COMMAND_INDEX)'
	@echo '    SSM_COMMAND_INSTANCE_IDS=$(SSM_COMMAND_INSTANCE_IDS)'
	@echo '    SSM_COMMAND_MAX_CONCURRENCY=$(SSM_COMMAND_MAX_CONCURRENCY)'
	@echo '    SSM_COMMAND_MAX_ERRORS=$(SSM_COMMAND_MAX_ERRORS)'
	@echo '    SSM_COMMAND_NOTIFICATION_CONFIG=$(SSM_COMMAND_NOTIFICATION_CONFIG)'
	@echo '    SSM_COMMAND_OUTPUT_S3BUCKETNAME=$(SSM_COMMAND_OUTPUT_S3BUCKETNAME)'
	@echo '    SSM_COMMAND_OUTPUT_S3KEYPREFIX=$(SSM_COMMAND_OUTPUT_S3KEYPREFIX)'
	@echo '    SSM_COMMAND_OUTPUT_S3REGION=$(SSM_COMMAND_OUTPUT_S3REGION)'
	@echo '    SSM_COMMAND_PARAMETERS=$(SSM_COMMAND_PARAMETERS)'
	@echo '    SSM_COMMAND_SERVICEROLE_ARN=$(SSM_COMMAND_SERVICEROLE_ARN)'
	@echo '    SSM_COMMAND_TARGETS=$(SSM_COMMAND_TARGETS)'
	@echo '    SSM_COMMANDS_SET_NAME=$(SSM_COMMANDS_SET_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ssm_send_command:
	@$(INFO) '$(AWS_UI_LABEL)Sending command to instances ...'; $(NORMAL)
	$(AWS) ssm send-command $(__SSM_COMMENT) $(__SSM_DOCUMENT_HASH_COMMAND) $(__SSM_DOCUMENT_HASH_TYPE_COMMAND) $(__SSM_DOCUMENT_NAME_COMMAND) $(__SSM_DOCUMENT_VERSION_COMMAND) $(__SSM_INSTANCE_IDS) $(__SSM_MAX_CONCURRENCY) $(__SSM_MAX_ERRORS) $(__SSM_NOTIFICATION_CONFIG) $(__SSM_OUTPUT_S3_BUCKET_NAME) $(__SSM_OUTPUT_S3_KEY_PREFIX) $(__SSM_OUTPUT_S3_REGION) $(__SSM_PARAMETERS_COMMAND) $(__SSM_SERVICE_ROLE_ARN) $(__SSM_TARGETS_COMMAND) $(__SSM_TIMEOUT_SECONDS)

_ssm_show_command:
	@$(INFO) '$(AWS_UI_LABEL)Showing command "$(SSM_COMMAND_ID)" ...'; $(NORMAL)
	$(AWS) ssm list-commands $(__SSM_COMMAND_ID) $(_X__SSM_FILTERS_COMMAND) $(_X__SSM_INSTANCE_ID)

_ssm_view_commands:
	@$(INFO) '$(AWS_UI_LABEL)Viewing commands ...'; $(NORMAL)
	@$(WARN) 'Commands are ordered from most recent to leas recent execution'; $(NORMAL)
	$(AWS) ssm list-commands $(_X__SSM_COMMAND_ID) $(_X__SSM_FILTERS_COMMAND) $(_X__SSM_INSTANCE_ID) --query "Commands[]$(SSM_UI_VIEW_COMMANDS_FIELDS)"

_ssm_view_commands_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing commands-set "$(SSM_COMMANDS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Commands are ordered from most recent to leas recent execution'; $(NORMAL)
	@$(WARN) 'Command-set are grouped based on their target instance-id'; $(NORMAL)
	$(AWS) ssm list-commands $(_X__SSM_COMMAND_ID) $(_X__SSM_FILTERS_COMMAND) $(__SSM_INSTANCE_ID) --query "Commands[]$(SSM_UI_VIEW_COMMANDS_SET_FIELDS)"
