_AWS_APIGATEWAY_USAGEPLANKEY_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_USAGEPLANKEY_ID?=
# AGY_USAGEPLANKEY_KEY_ID?=
# AGY_USAGEPLANKEY_KEY_TYPE?=
# AGY_USAGEPLANKEY_NAME?=
# AGY_USAGEPLANKEY_USAGEPLAN_ID?=
# AGY_USAGEPLANKEYS_SET_NAME?=

# Derived parameters

# Option parameters
__AGY_KEY_ID= $(if $(AGY_USAGEPLANKEY_KEY_ID), --key-id $(AGY_USAGEPLANKEY_KEY_ID))
__AGY_KEY_TYPE= $(if $(AGY_USAGEPLANKEY_KEY_TYPE), --key-type $(AGY_USAGEPLANKEY_KEY_TYPE))
__AGY_USAGE_PLAN_ID__USAGEPLANKEY= $(if $(AGY_USAGEPLANKEY_USAGEPLAN_ID), --usage-plan-key-id $(AGY_USAGEPLANKEY_USAGEPLAN_ID))

# UI parameters
AGY_UI_VIEW_USAGEPLANKEYS_FIELDS?=
AGY_UI_VIEW_USAGEPLANKEYS_SET_FIELDS?= $(AGY_UI_VIEW_USAGEPLANKEYS_FIELDS)
AGY_UI_VIEW_USAGEPLANKEYS_SET_SLICE?=

#--- MACROS
_agy_get_usageplankey_id=

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::UsagePlanKey ($(_AWS_APIGATEWAY_USAGEPLANKEY_MK_VERSION)) macros:'
	@echo '    _agy_get_usageplankey_id                     - Get the ID of an usage-plan-key'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::UsagePlanKey ($(_AWS_APIGATEWAY_USAGEPLANKEY_MK_VERSION)) parameters:'
	@echo '    AGY_USAGEPLANKEY_ID=$(AGY_USAGEPLANKEY_ID)'
	@echo '    AGY_USAGEPLANKEY_KEY_ID=$(AGY_USAGEPLANKEY_KEY_ID)'
	@echo '    AGY_USAGEPLANKEY_KEY_TYPE=$(AGY_USAGEPLANKEY_KEY_TYPE)'
	@echo '    AGY_USAGEPLANKEY_NAME=$(AGY_USAGEPLANKEY_NAME)'
	@echo '    AGY_USAGEPLANKEY_USAGEPLAN_ID=$(AGY_USAGEPLANKEY_USAGEPLAN_ID)'
	@echo '    AGY_USAGEPLANKEY_SET_NAME=$(AGY_USAGEPLANKEY_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::UsagePlanKey ($(_AWS_APIGATEWAY_USAGEPLANKEY_MK_VERSION)) targets:'
	@echo '    _agy_create_usageplankey                   - Create a new usage-plan-key'
	@echo '    _agy_delete_usageplankey                   - Delete an existing usage-plan-key'
	@echo '    _agy_show_usageplankey                     - Show everything related to an usage-plan-key'
	@echo '    _agy_show_usageplankey_description         - Show description of a usage-plan-key'
	@#echo '    _agy_update_usageplankey                   - Update an usage-plan-key'
	@echo '    _agy_view_usageplankeys                    - View usage-plan-keys'
	@echo '    _agy_view_usageplankeys_set                - View a set of usage-plan-keys'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_usageplankey:
	@$(INFO) '$(AWS_UI_LABEL)Creating usage-plan-key "$(AGY_USAGEPLANKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-usage-plan-key $(__AGY_KEY_ID) $(__AGY_KEY_TYPE) $(__AGY_USAGE_PLAN_ID__USAGEPLANKEY)

_agy_delete_usageplankey:
	@$(INFO) '$(AWS_UI_LABEL)Deleting usage-plan-key "$(AGY_USAGEPLANKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-usage-plan-key $(__AGY_KEY_ID) $(__AGY_USAGE_PLAN_ID)

_agy_show_usageplankey:: _agy_show_usageplankey_description

_agy_show_usageplankey_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of usage-plan-key "$(AGY_USAGEPLANKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-usage-plan-key $(__AGY_KEY_ID) $(__AGY_USAGE_PLAN_ID)

_agy_update_usageplankey:

_agy_view_usageplankeys:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all usage-plan-keys ...'; $(NORMAL)
	$(AWS) apigateway get-usage-plan-keys $(_X__AGY_NAME_QUERY__USAGEPLANKEY) $(__AGY_USAGE_PLAN_ID__USAGEPLANKEY) --query "items[]$(AGY_UI_VIEW_USAGEPLANKEYS_FIELDS)"

_agy_view_usageplankeys_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing usage-plan-keys-set "$(AGY_USAGEPLANKEYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Usage-plan-keys are grouped based on the provided key-id and slice'; $(NORMAL)
	$(AWS) apigateway get-usage-plan-keys $(__AGY_NAME_QUERY__USAGEPLANKEY) $(__AGY_USAGE_PLAN_ID__USAGEPLANKEY) --query "items[$(AGY_UI_VIEW_USAGEPLANKEYS_SET_SLICE)]$(AGY_UI_VIEW_USAGEPLANKEYS_SET_FIELDS)"
