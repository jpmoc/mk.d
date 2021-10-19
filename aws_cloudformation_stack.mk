_AWS_CLOUDFORMATION_STACK_MK_VERSION= $(_AWS_CLOUDFORMATION_MK_VERSION)

# CFN_STACK_BASENAME?= StackBasename
# CFN_STACK_CAPABILITIES?= CAPABILITY_IAM
CFN_STACK_CREATE_TIMEOUT?= 60
CFN_STACK_LAYERS_QUERYFILTER?= ?starts_with(StackName,'$(CFN_STACK_NAME)')
# CFN_STACK_NAME?=
# CFN_STACK_ON_FAILURE= ROLLBACK
# CFN_STACK_OUTPUT_KEY= InstanceRoleARN
# CFN_STACK_OUTPUT_VALUE= ...
# CFN_STACK_PARAMETERS_KEYVALUES?= ParameterKey=string,ParameterValue=string,UsePreviousValue=boolean,ResolvedValue=string ...
# CFN_STACK_RESOURCE_ID?= Druid1Eth1NetworkInterface
CFN_STACK_ROLLBACK_ENABLE?= false
# CFN_STACK_TAGS_KEYVALUES?= Key=string,Value=string ...

# Derived parameters

# Options parameters
__CFN_CAPABILITIES= $(if $(CFN_STACK_CAPABILITIES),--capabilities $(CFN_STACK_CAPABILITIES))
__CFN_CLIENT_REQUEST_TOKEN=
__CFN_DISABLE_ROLLBACK= $(if $(filter false, $(CFN_STACK_ROLLBACK_ENABLE)),--disable-rollback)
__CFN_ENABLE_TERMINATION_PROTECTION=
__CFN_LOGICAL_RESOURCE_ID__STACK= $(if $(CFN_STACK_RESOURCE_ID),--logical-resource-id $(CFN_STACK_RESOURCE_ID))
__CFN_ON_FAILURE= $(if $(CFN_STACK_ON_FAILURE),--on-failure $(CFN_STACK_ON_FAILURE))
__CFN_NOTIFICATION_ARNS=
__CFN_PARAMETERS= $(if $(CFN_STACK_PARAMETERS_KEYVALUES),--parameters $(CFN_STACK_PARAMETERS_KEYVALUES))
__CFN_RESOURCES_TO_SKIP=
__CFN_RETAIN_RESOURCES=
__CFN_ROLE_ARN=
__CFN_ROLLBACK_CONFIGURATION=
__CFN_STACK_NAME= $(if $(CFN_STACK_NAME),--stack-name $(CFN_STACK_NAME))
__CFN_STACK_STATUS_FILTER= $(if $(CFN_UI_LAYER_STATUS_FILTERS),--stack-status-filter $(CFN_UI_LAYER_STATUS_FILTERS) )
__CFN_TAGS__STACK= $(if $(CFN_STACK_TAGS_KEYVALUES),--tags $(CFN_STACK_TAGS_KEYVALUES))
__CFN_TEMPLATE_BODY_XOR_URL= $(if $(CFN_S3PROJECT_BUCKET_NAME),$(__CFN_TEMPLATE_URL),$(__CFN_TEMPLATE_BODY))
__CFN_TIMEOUT_IN_MINUTES= $(if $(CFN_STACK_CREATE_TIMEOUT),--timeout-in-minutes $(CFN_STACK_CREATE_TIMEOUT))

# UI parameters
CFN_UI_LAYER_EVENT_SLICE?= 0:20:1
# All layers but those which were correctly deleted!
CFN_UI_LAYER_STATUS_FILTERS=  CREATE_IN_PROGRESS CREATE_FAILED CREATE_COMPLETE
CFN_UI_LAYER_STATUS_FILTERS+= ROLLBACK_IN_PROGRESS ROLLBACK_FAILED ROLLBACK_COMPLETE
CFN_UI_LAYER_STATUS_FILTERS+= DELETE_IN_PROGRESS DELETE_FAILED
CFN_UI_LAYER_STATUS_FILTERS+= UPDATE_IN_PROGRESS UPDATE_COMPLETE_CLEANUP_IN_PROGRESS UPDATE_COMPLETE
CFN_UI_LAYER_STATUS_FILTERS+= UPDATE_ROLLBACK_IN_PROGRESS UPDATE_ROLLBACK_FAILED
CFN_UI_LAYER_STATUS_FILTERS+= UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS UPDATE_ROLLBACK_COMPLETE
CFN_UI_LAYER_REASON_SLICE?= $(CFN_UI_LAYER_EVENT_SLICE)

CFN_UI_SHOW_LAYER_REASONS_FIELDS?= .{LogicalResourceId:LogicalResourceId,ResourceStatus:ResourceStatus,ResourceStatusReason:ResourceStatusReason}
CFN_UI_SHOW_LAYER_EVENTS_FIELDS?= .{Timestamp:Timestamp,LogicalResourceId:LogicalResourceId,ResourceStatus:ResourceStatus}
CFN_UI_SHOW_LAYER_EVENTS_FIELDS?= .{Timestamp:Timestamp,LogicalResourceId:LogicalResourceId,ResourceType:ResourceType,ResourceStatus:ResourceStatus,ResourceStatusReason:ResourceStatusReason}
CFN_UI_SHOW_LAYER_OUTPUTS_FIELDS?= .{OutputKey:OutputKey,OutputValue:OutputValue}
CFN_UI_SHOW_LAYER_PARAMETERS_FIELDS?= .{ParameterKey:ParameterKey,ParameterValue:ParameterValue}
CFN_UI_SHOW_LAYER_RESOURCES_FIELDS?= .{PhysicalResourceId:PhysicalResourceId,ResourceStatus:ResourceStatus,LogicalResourceId:LogicalResourceId,ResourceType:ResourceType}
CFN_UI_SHOW_LAYER_STATUS_FIELDS?= .{CreationTime:CreationTime,StackName:StackName,StackStatus:StackStatus}

CFN_UI_SHOW_STACK_EVENTS_QUERYFILTER?= $(CFN_STACK_LAYER_QUERYFILTER)
CFN_UI_SHOW_STACK_EVENTS_FIELDS?= $(CFN_UI_SHOW_LAYER_EVENTS_FIELDS)
CFN_UI_SHOW_STACK_OUTPUTS_FIELDS?= $(CFN_UI_SHOW_LAYER_OUTPUTS_FIELDS)
CFN_UI_SHOW_STACK_REASONS_FIELDS?= $(CFN_UI_SHOW_LAYER_REASONS_FIELDS)
CFN_UI_SHOW_STACK_RESOURCES_FIELDS?= $(CFN_UI_SHOW_LAYER_RESOURCES_FIELDS)
CFN_UI_SHOW_STACK_STATUS_QUERYFILTER?= $(CFN_STACK_LAYER_QUERYFILTER)
CFN_UI_SHOW_STACK_STATUS_FIELDS?= .{CreationTime:CreationTime,StackName:StackName,StackStatus:StackStatus}
CFN_UI_SHOW_STACK_STATUS_FIELDS?= .{CreationTime:CreationTime,StackName:StackName,TemplateDescription:TemplateDescription,StackStatus:StackStatus}

CFN_UI_VIEW_STACK_STATUS_FIELDS?= $(CFN_UI_SHOW_STACK_STATUS_FIELDS)
CFN_UI_WATCH_INTERVAL?= 5
CFN_UI_WATCH_STACK_EVENTS_FIELDS?= .[Timestamp,LogicalResourceId,ResourceStatus]

#--- Utilities

#--- MACROS
_cfn_get_stack_layers_names= $(call _cfn_get_stack_layers_names_F, $(CFN_STACK_LAYERS_QUERYFILTER))
_cfn_get_stack_layers_names_F= $(shell $(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[$(strip $(1))].StackName" --output text)

_cfn_get_stack_output_value= $(call _cfn_get_stack_output_value_K, $(CFN_STACK_OUTPUT_KEY))
_cfn_get_stack_output_value_K= $(call _cfn_get_stack_output_value_KN, $(1), $(CFN_STACK_NAME))
_cfn_get_stack_output_value_KN= $(shell $(AWS) cloudformation describe-stacks --query "Stacks[?starts_with(StackName,'$(strip $(2))')].Outputs[] | @[?OutputKey=='$(strip $(1))'].OutputValue" --output text)

_cfn_get_stack_status= $(call _cfn_get_stack_status_N, $(CFN_STACK_NAME))
_cfn_get_stack_status_N= $(shell $(AWS) cloudformation list-stacks --query "StackSummaries[?StackName=='$(strip $(1))'].StackStatus" --output text)

#----------------------------------------------------------------------
# USAGE
#

_cfn_view_framework_macros ::
	@echo 'AWS::CloudFormatioN::Stack ($(_AWS_CLOUDFORMATION_STACK_MK_VERSION)) macros:'
	@echo '    _cfn_get_stack_output_value_{|K|KN}          - Get an output value from a stack (outputKey,stackName)'
	@echo '    _cfn_get_stack_status_{|N}                   - Get the status of a stack (stackName)'
	@echo

_cfn_view_framework_parameters ::
	@echo 'AWS::CloudFormatioN::Stack ($(_AWS_CLOUDFORMATION_STACK_MK_VERSION)) parameters:'
	@echo '    CFN_STACK_ON_FAILURE=$(CFN_STACK_ON_FAILURE)'
	@echo '    CFN_STACK_BASENAME=$(CFN_STACK_BASENAME)'
	@echo '    CFN_STACK_CAPABILITIES=$(CFN_STACK_CAPABILITIES)'
	@echo '    CFN_STACK_CREATE_TIMEOUT=$(CFN_STACK_CREATE_TIMEOUT)'
	@echo '    CFN_STACK_LAYER_NAME=$(CFN_STACK_LAYER_NAME)'
	@echo '    CFN_STACK_LAYERS_QUERYFILTER=$(CFN_STACK_LAYERS_QUERYFILTER)'
	@echo '    CFN_STACK_LAYERS_NAMES=$(CFN_STACK_LAYERS_NAMES)'
	@echo '    CFN_STACK_NAME=$(CFN_STACK_NAME)'
	@echo '    CFN_STACK_OUTPUT_KEY=$(CFN_STACK_OUTPUT_KEY)'
	@echo '    CFN_STACK_OUTPUT_VALUE=$(CFN_STACK_OUTPUT_VALUE)'
	@echo '    CFN_STACK_PARAMETERS_KEYVALUES=$(CFN_STACK_PARAMETERS_KEYVALUES)'
	@echo '    CFN_STACK_RESOURCE_ID=$(CFN_STACK_RESOURCE_ID)'
	@echo '    CFN_STACK_ROLLBACK_ENABLE=$(CFN_STACK_ROLLBACK_ENABLE)'
	@echo '    CFN_STACK_TAGS_KEYVALUES=$(CFN_STACK_TAGS_KEYVALUES)'
	@echo

_cfn_view_framework_targets ::
	@echo 'AWS::CloudFormatioN::Stack ($(_AWS_CLOUDFORMATION_STACK_MK_VERSION)) targets:'
	@echo '    _cfn_cancel_stack_update                     - Cancel an on-going stack update'
	@echo '    _cfn_continue_stack_rollback                 - Continue rollbacking back a stack'
	@echo '    _cfn_create_stack                            - Create the stack'
	@echo '    _cfn_enable_stack_termination_protection     - Enable stack termination protection'
	@echo '    _cfn_delete_stack                            - Delete the existing stack'
	@echo '    _cfn_disable_stack_termination_protection    - Disable stack termination protection'
	@echo '    _cfn_show_stack                              - Show everything about a stack'
	@echo '    _cfn_show_stack_events                       - Show events of a stack'
	@echo '    _cfn_show_stack_outputs                      - Show outputs of a stack'
	@echo '    _cfn_show_stack_policy                       - Show the policy attached to the stack'
	@echo '    _cfn_show_stack_reasons                      - Show reasons of a stack'
	@echo '    _cfn_show_stack_resources                    - Show resources of a stack'
	@echo '    _cfn_show_stack_status                       - View status of a stack'
	@echo '    _cfn_update_stack                            - Update the existing stack'
	@echo '    _cfn_view_stacks                             - View list of stacks'
	@echo '    _cfn_watch_stack_events                      - View stack events as they come'
	@echo '    _cfn_watch_stack_reasons                     - View stack reasons as they come'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__cfn_show_stack_events_layer:
	echo -n '|  '; $(PURPLE) 'Layer: $(CFN_STACK_LAYER_NAME)'; $(WHITE) -n
	$(AWS) cloudformation describe-stack-events --stack-name $(CFN_STACK_LAYER_NAME) --query 'StackEvents[$(CFN_UI_LAYER_EVENT_SLICE)]$(CFN_UI_SHOW_STACK_EVENTS_FIELDS)' 2>/dev/null | tail -n+6

__cfn_show_stack_parameters_layer:
	echo -n '|  '; $(PURPLE) 'Layer: $(CFN_STACK_LAYER_NAME)'; $(WHITE) -n
	$(AWS) cloudformation describe-stacks --query "Stacks[?StackName=='$(CFN_STACK_LAYER_NAME)'].Parameters[]$(CFN_UI_SHOW_LAYER_PARAMETERS_FIELDS)" 2>/dev/null | tail -n+6

__cfn_show_stack_reasons_layer:
	echo -n '|  '; $(PURPLE) 'Layer: $(CFN_STACK_LAYER_NAME)'; $(WHITE) -n
	$(AWS) cloudformation describe-stack-events --stack-name $(CFN_STACK_LAYER_NAME) --query 'StackEvents[?ResourceStatusReason!=None]$(CFN_UI_SHOW_STACK_REASONS_FIELDS) | [$(CFN_UI_LAYER_REASON_SLICE)]' 2>/dev/null | tail -n+6

__cfn_show_stack_resources_layer:
	echo -n '|  '; $(PURPLE) 'Layer: $(CFN_STACK_LAYER_NAME)'; $(WHITE) -n
	$(AWS) cloudformation list-stack-resources  --stack-name $(CFN_STACK_LAYER_NAME) --query "StackResourceSummaries[]$(CFN_UI_SHOW_STACK_RESOURCES_FIELDS)" 2>/dev/null | tail -n+6

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfn_cancel_stack_update:
	@$(INFO) '$(AWS_UI_LABEL)Canceling update of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	-$(AWS) cloudformation cancel-update-stack $(__CFN_STACK_NAME)

_cfn_continue_stack_rollback:
	@$(INFO) '$(AWS_UI_LABEL)Continue rolling back the stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	-$(AWS) cloudformation continue-update-rollback $(__CFN_RESOURCES_TO_SKIP) $(__CFN_ROLE_ARN) $(__CFN_STACK_NAME)

_cfn_create_stack:
	@$(INFO) '$(AWS_UI_LABEL)Creating stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation create-stack $(strip $(__CFN_CAPABILITIES) $(__CFN_CLIENT_REQUEST_TOKEN) $(__CFN_DISABLE_ROLLBACK) $(__CFN_ENABLE_TERMINATION_POLICY) $(__CFN_ON_FAILURE) $(__CFN_NOTIFICATION_ARNS) $(__CFN_PARAMETERS) $(__CFN_RESOURCE_TYPES) $(__CFN_ROLE_ARN) $(__CFN_ROLLBACK_CONFIGURATION) $(__CFN_STACK_NAME) $(__CFN_STACK_POLICY_BODY) $(__CFN_STACK_POLICY_URL) $(__CFN_TAGS__STACK) $(__CFN_TEMPLATE_BODY_XOR_URL) $(__CFN_TIMEOUT_IN_MINUTES) )

_cfn_enable_stack_termination_protection:
	@$(INFO) '$(AWS_UI_LABEL)Enabling termination protection for stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation update-termination-protection --enable-termination-protection $(__CFN_STACK_NAME)

_cfn_delete_stack:
	@$(INFO) '$(AWS_UI_LABEL)Deleting stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The instance termination protection may need to be removed'; $(NORMAL)
	$(AWS) cloudformation delete-stack $(__CFN_CLIENT_REQUEST_TOKEN) $(__CFN_RETAIN_RESOURCES) $(__CFN_ROLE_ARN) $(__CFN_STACK_NAME)

_cfn_disable_stack_termination_protection:
	@$(INFO) '$(AWS_UI_LABEL)Disabling termination protection for stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation update-termination-protection --no-enable-termination-protection $(__CFN_STACK_NAME)

_cfn_get_stack_output_value:
	@$(INFO) '$(AWS_UI_LABEL)Getting value of output "$(CFN_STACK_OUTPUT_NAME)" in stack-layer "$(CFN_STACK_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stacks --query "Stacks[?starts_with(StackName,'${CFN_STACK_NAME}')].Outputs[] | @[?OutputKey=='${CFN_STACK_OUTPUT_NAME}'].OutputValue" --output text

_cfn_show_stack: _cfn_show_stack_events _cfn_show_stack_outputs _cfn_show_stack_parameters _cfn_show_stack_policy _cfn_show_stack_reasons _cfn_show_stack_resources _cfn_show_stack_status

_cfn_show_stack_events:
	@$(INFO) '$(AWS_UI_LABEL)Showing events in stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	@$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[$(CFN_UI_SHOW_STACK_EVENTS_QUERYFILTER)]$(CFN_UI_SHOW_STACK_STATUS_FIELDS)"
	@#$(WARN) 'Layers: $(CFN_STACK_LAYERS_NAMES)'; $(NORMAL)
	@$(foreach L, $(CFN_STACK_LAYERS_NAMES), \
		$(MAKE) --no-print-directory --quiet CFN_STACK_LAYER_NAME=$(L) __cfn_show_stack_events_layer; \
	)

_cfn_show_stack_outputs:
	@$(INFO) '$(AWS_UI_LABEL)Showing outputs of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stacks --query "Stacks[$(CFN_STACK_LAYER_QUERYFILTER)].Outputs[]$(CFN_UI_SHOW_STACK_OUTPUTS_FIELDS)"

_cfn_show_stack_parameters:
	@$(INFO) '$(AWS_UI_LABEL)Showing parameters of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	@$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[$(CFN_UI_SHOW_STACK_EVENTS_QUERYFILTER)]$(CFN_UI_SHOW_STACK_STATUS_FIELDS)"
	@#$(WARN) 'Layers: $(CFN_STACK_LAYERS_NAMES)'; $(NORMAL)
	@$(foreach L, $(CFN_STACK_LAYERS_NAMES), \
		$(MAKE) --no-print-directory --quiet CFN_STACK_LAYER_NAME=$(L) __cfn_show_stack_parameters_layer; \
	)

_cfn_show_stack_policy:
	@$(INFO) '$(AWS_UI_LABEL)Showing policy of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation get-stack-policy $(__CFN_STACK_NAME) 

_cfn_show_stack_reasons:
	@$(INFO) '$(AWS_UI_LABEL)Showing reasons of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	@$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[$(CFN_UI_SHOW_STACK_EVENTS_QUERYFILTER)]$(CFN_UI_SHOW_STACK_STATUS_FIELDS)"
	@#$(WARN) 'Layers: $(CFN_STACK_LAYERS_NAMES)'; $(NORMAL)
	@$(foreach L, $(CFN_STACK_LAYERS_NAMES), \
		$(MAKE) --no-print-directory --quiet CFN_STACK_LAYER_NAME=$(L) __cfn_show_stack_reasons_layer; \
	)

_cfn_show_stack_resources:
	@$(INFO) '$(AWS_UI_LABEL)Showing resources of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	@$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[$(CFN_UI_SHOW_STACK_EVENTS_QUERYFILTER)]$(CFN_UI_SHOW_STACK_STATUS_FIELDS)"
	@#$(WARN) 'Layers: $(CFN_STACK_LAYERS_NAMES)'; $(NORMAL)
	@$(foreach L, $(CFN_STACK_LAYERS_NAMES), \
		$(MAKE) --no-print-directory --quiet CFN_STACK_LAYER_NAME=$(L) __cfn_show_stack_resources_layer; \
	)

_cfn_show_stack_status:
	@$(INFO) '$(AWS_UI_LABEL)Showing status for stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[$(CFN_UI_SHOW_STACK_STATUS_QUERYFILTER)]$(CFN_UI_SHOW_STACK_STATUS_FIELDS)"

_cfn_update_stack: 
	@$(INFO) '$(AWS_UI_LABEL)Updating stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Make sure that the stack exists and that its policy allows for updates'; $(NORMAL)
	@$(WARN) 'This operation is valid only if the stack is NOT in an IN_PROGRESS state'; $(NORMAL)
	$(AWS) cloudformation update-stack $(__CFN_CAPABILITIES) $(__CFN_PARAMETERS) $(__CFN_STACK_NAME) $(__CFN_TEMPLATE_BODY_XOR_URL)

_cfn_update_stack_policy:
	@$(INFO) '$(AWS_UI_LABEL)Updating the policy of stack "$(CFN_STACK_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation set-stack-policy $(__CFN_STACK_NAME) $(__CFN_STACK_POLICY_URL)

_cfn_view_stacks:
	@$(INFO) '$(AWS_UI_LABEL)Viewing stacks ...'; $(NORMAL)
	$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[]$(CFN_UI_VIEW_STACK_STATUS_FIELDS)" 


ifeq ($(CMN_MODE_INTERACTIVE), true)

_cfn_watch_stack_events:
	watch -n $(CFN_UI_WATCH_INTERVAL) --color "$(MAKE) -e --quiet _cfn_watch_stack_events_header _cfn_show_stack_events _cfn_watch_stack_events_footer"

else

_cfn_watch_stack_events:
	@$(WARN) -n 'This stack operation can take a few minutes ...'
	@_MATCHED=0; while [ $${_MATCHED} -eq 0 ]; do \
		_STACK_STATUS=`$(AWS) cloudformation describe-stacks --stack-name $(CFN_STACK_NAME) --query 'Stacks[].StackStatus' --output text 2>/dev/null`; \
		if [ -z $${_STACK_STATUS} ]; then _STACK_STATUS=DELETE_COMPLETE; fi; \
		_MATCHED=`expr match "$${_STACK_STATUS}" ".*_COMPLETE$$" + match "$${_STACK_STATUS}" ".*_FAILED$$"`; \
		echo -n '.' ; sleep 1 ; \
	done; $(INFO) "\n$(AWS_UI_LABEL)The stack operation on $(CFN_STACK_NAME) completed with status : $${_STACK_STATUS}"; $(NORMAL)

endif

_cfn_watch_stack_events_footer ::

_cfn_watch_stack_events_header ::

_cfn_watch_stack_reasons:
	watch -n $(CFN_UI_WATCH_INTERVAL) --color "$(MAKE) -e --quiet _cfn_show_stack_reasons"
