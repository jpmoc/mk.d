_AWS_APIGATEWAY_USAGEPLAN_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_USAGEPLAN_API_STAGES?=
# AGY_USAGEPLAN_DESCRIPTION?=
# AGY_USAGEPLAN_ID?=
# AGY_USAGEPLAN_KEY_ID?=
# AGY_USAGEPLAN_NAME?= V1.0.3
# AGY_USAGEPLAN_QUOTA?=
# AGY_USAGEPLAN_THROTTLE?=
# AGY_USAGEPLANS_SET_NAME?=

# Derived parameters

# Option parameters
__AGY_API_STAGES= $(if $(AGY_USAGEPLAN_API_STAGES), --api-stages $(AGY_USAGEPLAN_API_STAGES))
__AGY_DESCRIPTION_USAGEPLAN= $(if $(AGY_USAGEPLAN_DESCRIPTION), --description $(AGY_USAGEPLAN_DESCRIPTION))
__AGY_KEY_ID= $(if $(AGY_USAGEPLAN_KEY_ID), --key-id $(AGY_USAGEPLAN_KEY_ID))
__AGY_LIMIT__USAGEPLAN=
__AGY_NAME_USAGEPLAN= $(if $(AGY_USAGEPLAN_NAME), --name $(AGY_USAGEPLAN_NAME))
__AGY_PATCH_OPERATIONS__USAGEPLAN= $(if $(AGY_USAGEPLAN_PATCH_OPERATIONS), --patch-operations $(AGY_USAGEPLAN_PATCH_OPERATIONS))
__AGY_POSITION__USAGEPLAN=
__AGY_QUOTA= $(if $(AGY_USAGEPLAN_QUOTA), --quota $(AGY_USAGEPLAN_QUOTA))
__AGY_THROTTLE= $(if $(AGY_USAGEPLAN_THROTTLE), --throttle $(AGY_USAGEPLAN_THROTTLE))
__AGY_USAGE_PLAN_ID= $(if $(AGY_USAGEPLAN_ID), --usage-plan-id $(AGY_USAGEPLAN_ID))

# UI parameters
AGY_UI_VIEW_USAGEPLANS_FIELDS?=
AGY_UI_VIEW_USAGEPLANS_SET_FIELDS?= $(AGY_UI_VIEW_USAGEPLANS_FIELDS)
AGY_UI_VIEW_USAGEPLANS_SET_SLICE?=

#--- MACROS
_agy_get_usageplan_id=

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::UsagePlan ($(_AWS_APIGATEWAY_USAGEPLAN_MK_VERSION)) macros:'
	@echo '    _agy_get_usageplan_id                     - Get the ID of an usage-plan'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::UsagePlan ($(_AWS_APIGATEWAY_USAGEPLAN_MK_VERSION)) parameters:'
	@echo '    AGY_USAGEPLAN_API_STAGES=$(AGY_USAGEPLAN_API_STAGES)'
	@echo '    AGY_USAGEPLAN_DESCRIPTION=$(AGY_USAGEPLAN_DESCRIPTION)'
	@echo '    AGY_USAGEPLAN_ID=$(AGY_USAGEPLAN_ID)'
	@echo '    AGY_USAGEPLAN_KEY_ID=$(AGY_USAGEPLAN_KEY_ID)'
	@echo '    AGY_USAGEPLAN_NAME=$(AGY_USAGEPLAN_NAME)'
	@echo '    AGY_USAGEPLAN_PATCH_OPERATIONS=$(AGY_USAGEPLAN_PATCH_OPERATIONS)'
	@echo '    AGY_USAGEPLAN_QUOTA=$(AGY_USAGEPLAN_QUOTA)'
	@echo '    AGY_USAGEPLAN_THROTTLE=$(AGY_USAGEPLAN_THROTTLE)'
	@echo '    AGY_USAGEPLAN_SET_NAME=$(AGY_USAGEPLAN_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::UsagePlan ($(_AWS_APIGATEWAY_USAGEPLAN_MK_VERSION)) targets:'
	@echo '    _agy_create_usageplan                   - Create a new usage-plan'
	@echo '    _agy_delete_usageplan                   - Delete an existing usage-plan'
	@echo '    _agy_show_usageplan                     - Show everything related to a usage-plan'
	@echo '    _agy_show_usageplan_description         - Show description of a usage-plan'
	@echo '    _agy_update_usageplan                   - Update a usage-plan'
	@echo '    _agy_view_usageplans                    - View usage-plans'
	@echo '    _agy_view_usageplans_set                - View a set of usage-plans'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_usageplan:
	@$(INFO) '$(AWS_UI_LABEL)Creating usage-plan "$(AGY_USAGEPLAN_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-usage-plan $(__AGY_API_STAGES) $(__AGY_DESCRIPTION__USAGEPLAN) $(__AGY_NAME_USAGEPLAN) $(__AGY_QUOTA) $(__AGY_THROTTLE)

_agy_delete_usageplan:
	@$(INFO) '$(AWS_UI_LABEL)Deleting usage-plan "$(AGY_USAGEPLAN_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-usage-plan $(__AGY_USAGE_PLAN_ID)

_agy_show_usageplan:: _agy_show_usageplan_description

_agy_show_usageplan_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of usage-plan "$(AGY_USAGEPLAN_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-usage-plan $(__AGY_USAGE_PLAN_ID)

_agy_update_usageplan:
	@$(INFO) '$(AWS_UI_LABEL)Updating usage-plan "$(AGY_USAGEPLAN_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-usage-plan $(__AGY_PATCH_OPERATIONS__USAGEPLAN) $(__AGY_USAGE_PLAN_ID)

_agy_view_usageplans:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all usage-plans ...'; $(NORMAL)
	$(AWS) apigateway get-usage-plans $(_X__AGY_KEY_ID) --query "items[]$(AGY_UI_VIEW_USAGEPLANS_FIELDS)"

_agy_view_usageplans_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing usage-plans-set "$(AGY_USAGEPLANS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Usage-plans are grouped based on the provided key-id and slice'; $(NORMAL)
	$(AWS) apigateway get-usage-plans $(__AGY_KEY_ID) --query "items[$(AGY_UI_VIEW_USAGEPLANS_SET_SLICE)]$(AGY_UI_VIEW_USAGEPLANS_SET_FIELDS)"
