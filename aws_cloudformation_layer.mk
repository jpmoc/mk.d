_AWS_CLOUDFORMATION_LAYER_MK_VERSION= $(_AWS_CLOUDFORMATION_MK_VERSION)

# CFN_LAYER_NAME?= Logs001msi-InstancesStack-1CZN8U4WI9Q6H
# CFN_LAYER_OUTPUT_KEY?=
# CFN_LAYER_OUTPUT_VALUE?=
# CFN_LAYER_PARAMETERS_KEYVALUES?=
# CFN_LAYER_RESOURCE_ID?= Druid1Eth1NetworkInterface
# CFN_LAYER_TAGS_KEYVALUES?= Key=string,Value=string ...
# CFN_LAYERS_NAMES?= Logs001msi-InstancesStack-1CZN8U4WI9Q6H ...

# Derived parameters
CFN_LAYER_NAME?= $(CFN_STACK_NAME)
CFN_LAYER_NAMES?= $(CFN_LAYER_NAME)

# Options
__CFN_LAYER_NAME= $(if $(CFN_LAYER_NAME),--stack-name $(CFN_LAYER_NAME))
__CFN_LOGICAL_RESOURCE_ID= $(if $(CFN_LAYER_RESOURCE_ID),--logical-resource-id $(CFN_LAYER_RESOURCE_ID))
## __CFN_PARAMETERS__LAYER= $(if $(CFN_LAYER_PARAMETERS_KEYVALUES),--parameters $(CFN_LAYER_PARAMETERS_KEYVALUES))
## __CFN_RETAIN_RESOURCES=
__CFN_LAYER_STATUS_FILTER= $(if $(CFN_UI_LAYER_STATUS_FILTERS),--stack-status-filter $(CFN_UI_LAYER_STATUS_FILTERS) )
__CFN_TAGS__LAYER= $(if $(CFN_LAYER_TAGS_KEYVALUES),--tags $(CFN_LAYER_TAGS_KEYVALUES))

# Customizations
CFN_UI_LAYER_EVENT_QUERYFILTER?= 0:20:1
# All layers but those which were correctly deleted!
CFN_UI_LAYER_STATUS_FILTERS=  CREATE_IN_PROGRESS CREATE_FAILED CREATE_COMPLETE
CFN_UI_LAYER_STATUS_FILTERS+= ROLLBACK_IN_PROGRESS ROLLBACK_FAILED ROLLBACK_COMPLETE
CFN_UI_LAYER_STATUS_FILTERS+= DELETE_IN_PROGRESS DELETE_FAILED
CFN_UI_LAYER_STATUS_FILTERS+= UPDATE_IN_PROGRESS UPDATE_COMPLETE_CLEANUP_IN_PROGRESS UPDATE_COMPLETE
CFN_UI_LAYER_STATUS_FILTERS+= UPDATE_ROLLBACK_IN_PROGRESS UPDATE_ROLLBACK_FAILED
CFN_UI_LAYER_STATUS_FILTERS+= UPDATE_ROLLBACK_COMPLETE_CLEANUP_IN_PROGRESS UPDATE_ROLLBACK_COMPLETE
CFN_UI_LAYER_REASON_QUERYFILTER?= $(CFN_UI_LAYER_EVENT_QUERYFILTER)

_CFN_SHOW_LAYER_REASONS_FIELDS?= .{LogicalResourceId:LogicalResourceId,ResourceStatus:ResourceStatus,ResourceStatusReason:ResourceStatusReason}
_CFN_SHOW_LAYER_EVENTS_FIELDS?= .{Timestamp:Timestamp,LogicalResourceId:LogicalResourceId,ResourceStatus:ResourceStatus}
_CFN_SHOW_LAYER_EVENTS_FIELDS?= .{Timestamp:Timestamp,LogicalResourceId:LogicalResourceId,ResourceType:ResourceType,ResourceStatus:ResourceStatus,ResourceStatusReason:ResourceStatusReason}
_CFN_SHOW_LAYER_OUTPUTS_FIELDS?= .{OutputKey:OutputKey,OutputValue:OutputValue}
_CFN_SHOW_LAYER_PARAMETERS_FIELDS?= .{ParameterKey:ParameterKey,ParameterValue:ParameterValue}
_CFN_SHOW_LAYER_RESOURCES_FIELDS?= .{PhysicalResourceId:PhysicalResourceId,ResourceStatus:ResourceStatus,LogicalResourceId:LogicalResourceId,ResourceType:ResourceType}
_CFN_SHOW_LAYER_STATUS_FIELDS?= .{CreationTime:CreationTime,StackName:StackName,StackStatus:StackStatus}

_CFN_SHOW_LAYER_EVENTS_QUERYFILTER?= $(CFN_LAYER_LAYER_QUERYFILTER)
_CFN_SHOW_LAYER_EVENTS_FIELDS?= $(_CFN_SHOW_LAYER_EVENTS_FIELDS)
_CFN_SHOW_LAYER_OUTPUTS_FIELDS?= $(_CFN_SHOW_LAYER_OUTPUTS_FIELDS)
_CFN_SHOW_LAYER_REASONS_FIELDS?= $(_CFN_SHOW_LAYER_REASONS_FIELDS)
_CFN_SHOW_LAYER_RESOURCES_FIELDS?= $(_CFN_SHOW_LAYER_RESOURCES_FIELDS)
_CFN_SHOW_LAYER_STATUS_QUERYFILTER?= $(CFN_LAYER_LAYER_QUERYFILTER)
_CFN_SHOW_LAYER_STATUS_FIELDS?= .{CreationTime:CreationTime,StackName:StackName,StackStatus:StackStatus}
_CFN_SHOW_LAYER_STATUS_FIELDS?= .{CreationTime:CreationTime,StackName:StackName,TemplateDescription:TemplateDescription,StackStatus:StackStatus}

_CFN_LIST_LAYER_STATUS_FIELDS?= $(_CFN_SHOW_LAYER_STATUS_FIELDS)
_CFN_WATCH_LAYER_INTERVAL?= 5
_CFN_WATCH_LAYER_EVENTS_FIELDS?= .[Timestamp,LogicalResourceId,ResourceStatus]

# Macros
_cfn_get_layer_physicalresource_id_N= $(call _cfn_get_layer_physicalresource_id_NN, $(1), $(CFN_LAYER_NAME))
_cfn_get_layer_physicalresource_id_NN= $(shell $(AWS) cloudformation describe-stack-resource --stack-name $(2) --logical-resource-id $(1) --query "StackResourceDetail.PhysicalResourceId" --output text)

_cfn_get_layer_output_value= $(call _cfn_get_layer_output_value_K, $(CFN_LAYER_OUTPUT_KEY))
_cfn_get_layer_output_value_K= $(call _cfn_get_layer_output_value_KN, $(1), $(CFN_LAYER_NAME))
_cfn_get_layer_output_value_KN= $(shell $(AWS) cloudformation describe-stacks --stack-name $(2) --query "Stacks[0].Outputs[?OutputKey=='$(strip $(1))'].OutputValue" --output text)

_cfn_get_layer_status= $(call _cfn_get_layer_status_N, $(CFN_LAYER_NAME))
_cfn_get_layer_status_N= $(shell $(AWS) cloudformation list-stacks --query "StackSummaries[?StackName=='$(strip $(1))'].StackStatus" --output text)

#----------------------------------------------------------------------
# USAGE
#

_cfn_list_macros ::
	@echo 'AWS::CloudFormatioN::Layer ($(_AWS_CLOUDFORMATION_LAYER_MK_VERSION)) macros:'
	@echo '    _cfn_get_layer_physicalresource_id_{N|NN}    - Get a physical-resource id given a logical name (resourceName,layerName)'
	@echo '    _cfn_get_layer_output_value_{|K|KN}          - Get an output from a stack-layer (outputKey,layerName)'
	@echo '    _cfn_get_layer_status_{|N}                   - Get the status of a layer (layerName)'
	@echo

_cfn_list_parameters ::
	@echo 'AWS::CloudFormatioN::Layer ($(_AWS_CLOUDFORMATION_LAYER_MK_VERSION)) parameters:'
	@echo '    CFN_LAYER_NAME=$(CFN_LAYER_NAME)'
	@echo '    CFN_LAYER_OUTPUT_KEY=$(CFN_LAYER_OUTPUT_KEY)'
	@echo '    CFN_LAYER_OUTPUT_VALUE=$(CFN_LAYER_OUTPUT_VALUE)'
	@echo '    CFN_LAYER_NAMES=$(CFN_LAYER_NAMES)'
	@echo '    CFN_LAYER_PARAMETERS_KEYVALUES=$(CFN_LAYER_PARAMETERS_KEYVALUES)'
	@echo '    CFN_LAYER_RESOURCE_ID=$(CFN_LAYER_RESOURCE_ID)'
	@echo '    CFN_LAYER_TAGS_KEYVALUES=$(CFN_LAYER_TAGS_KEYVALUES)'
	@echo '    CFN_LAYERS_SET_NAME=$(CFN_LAYERS_SET_NAME)'
	@echo

_cfn_list_targets ::
	@echo 'AWS::CloudFormatioN::Layer ($(_AWS_CLOUDFORMATION_LAYER_MK_VERSION)) targets:'
	@echo '    _cfn_list_layers                             - List all layers'
	@echo '    _cfn_list_layers_set                         - List set of layers'
	@echo '    _cfn_show_layer                              - Show everything about a layer'
	@echo '    _cfn_show_layer_events                       - Show events of a layer'
	@echo '    _cfn_show_layer_outputs                      - Show outputs of a layer'
	@echo '    _cfn_show_layer_parameters                   - Show paramters of a layer'
	@echo '    _cfn_show_layer_reasons                      - Show reasons of a layer'
	@echo '    _cfn_show_layer_resource                     - Show details of a resource in a layer'
	@echo '    _cfn_show_layer_resources                    - Show resources of a layer'
	@echo '    _cfn_show_layer_status                       - Show status of a layer'
	@echo '    _cfn_show_layer_summary                      - Show summary of a layer'
	@echo '    _cfn_watch_layer_events                      - Watch events of a layer'
	@echo '    _cfn_watch_layer_reasons                     - Watch reasons of a layer'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cfn_delete_layer:
	@$(INFO) '$(CFN_UI_LABEL)Deleting layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The instance termination protection may need to be removed'; $(NORMAL)
	# $(AWS) cloudformation delete-stack $(__CFN_CLIENT_REQUEST_TOKEN) $(__CFN_RETAIN_RESOURCES) $(__CFN_ROLE_ARN) $(__CFN_STACK_NAME)

_cfn_get_layer_output_value:
	@$(INFO) '$(CFN_UI_LABEL)Getting value of output "$(CFN_LAYER_OUTPUT_NAME)" in stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stacks --query "Stacks[?StackName=='$(CFN_LAYER_NAME)'].Outputs[] | @[?OutputKey=='$(CFN_STACK_OUTPUT_NAME)'].OutputValue" --output text

_cfn_list_layers:
	@$(INFO) '$(CFN_UI_LABEL)Listing ALL stacks ...'; $(NORMAL)
	$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[]$(_CFN_LIST_STACK_STATUS_FIELDS)" 

_cfn_list_layers_set:
	@$(INFO) '$(CFN_UI_LABEL)Listing layers-set "$(CFN_LAYERS_SET_NAME)" ...'; $(NORMAL)

_CFN_SHOW_LAYER_TARGETS?= _cfn_show_layer_events _cfn_show_layer_outputs _cfn_show_layer_parameters _cfn_show_layer_reasons _cfn_show_layer_resources _cfn_show_layer_status
_cfn_show_layer: $(_CFN_SHOW_LAYER_TARGETS)

_cfn_show_layer_events:
	@$(INFO) '$(CFN_UI_LABEL)Showing events of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	-$(AWS) cloudformation describe-stack-events $(__CFN_LAYER_NAME) --query 'StackEvents[$(_CFN_SHOW_LAYER_EVENTS_QUERYFILTER)]$(_CFN_SHOW_LAYER_EVENTS_FIELDS)' 2>/dev/null

_cfn_show_layer_outputs:
	@$(INFO) '$(CFN_UI_LABEL)Showing outputs of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stacks --query "Stacks[?StackName=='$(CFN_LAYER_NAME)'].Outputs[]$(_CFN_SHOW_LAYER_OUTPUTS_FIELDS)"

_cfn_show_layer_parameters:
	@$(INFO) '$(CFN_UI_LABEL)Showing parameters of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stacks --query "Stacks[?StackName=='$(CFN_LAYER_NAME)'].Parameters[]$(_CFN_SHOW_LAYER_PARAMETERS_FIELDS)"

_cfn_show_layer_reasons:
	@$(INFO) '$(CFN_UI_LABEL)Showing reasons of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stack-events $(__CFN_LAYER_NAME) --query 'StackEvents[?ResourceStatusReason!=None]$(_CFN_SHOW_LAYER_REASONS_FIELDS) | [$(_CFN_SHOW_LAYER_REASON_QUERYFILTER)]'

_cfn_show_layer_resource:
	@# Great to see metadata attached to a resource!
	@$(INFO) '$(CFN_UI_LABEL)Show resource of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation describe-stack-resource $(__CFN_LAYER_NAME) $(__CFN_LOGICAL_RESOURCE_ID)
	# $(AWS) cloudformation list-stack-resources  --stack-name $(CFN_LAYER_NAME) --query "StackResourceSummaries[]$(_CFN_SHOW_STACK_RESOURCES_FIELDS)" 2>/dev/null | tail -n+6

_cfn_show_layer_resources:
	@$(INFO) '$(CFN_UI_LABEL)Showing resources of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation list-stack-resources $(__CFN_LAYER_NAME) --query 'StackResourceSummaries[]$(_CFN_SHOW_LAYER_RESOURCES_FIELDS)'

_cfn_show_layer_status:
	@$(INFO) '$(CFN_UI_LABEL)Showing status for stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	$(AWS) cloudformation list-stacks $(__CFN_STACK_STATUS_FILTER) --query "StackSummaries[?StackName=='$(CFN_LAYER_NAME)']$(_CFN_SHOW_LAYER_STATUS_FIELDS)"

_cfn_show_layer_summary:
	@$(INFO) '$(CFN_UI_LABEL)Showing summary of stack-layer "$(CFN_LAYER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Dump of everything known on that particular layer'; $(NORMAL)
	$(AWS) cloudformation get-template-summary $(__CFN_LAYER_NAME) #  --output json | jq '.'

_cfn_watch_layer_events:
	watch -n $(_CFN_WATCH_LAYER_INTERVAL) --color "$(MAKE) -e --quiet _cfn_show_layer_events"

_cfn_watch_layer_reasons:
	watch -n $(_CFN_WATCH_LAYER_INTERVAL) --color "$(MAKE) -e --quiet _cfn_show_layer_reasons"
