_AWS_APIGATEWAY_APIKEY_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_APIKEY_ID?= aeds9s0no6
# AGY_APIKEY_CUSTOMER_ID?=
# AGY_APIKEY_DESCRIPTION?=
# AGY_APIKEY_DISTINCTID_ENABLED?= true
# AGY_APIKEY_ENABLED?=
# AGY_APIKEY_NAME?=
# AGY_APIKEY_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_APIKEY_STAGEKEYS?=
# AGY_APIKEY_VALUE?= 8bklk8bl1k3sB38D9B3l0enyWT8c09B30lkq0blk
# AGY_APIKEYS_SET_NAME?=

# Derived parameters

# Option parameters
__AGY_API_KEY= $(if $(AGY_APIKEY_ID), --api-key $(AGY_APIKEY_ID))
__AGY_CUSTOMER_ID= $(if $(AGY_APIKEY_CUSTOMER_ID), --customer-id $(AGY_APIKEY_CUSTOMER_ID))
__AGY_DESCRIPTION__APIKEY= $(if $(AGY_APIKEY_DESCRIPTION), --description $(AGY_APIKEY_DESCRIPTION))
__AGY_ENABLED__APIKEY= $(if $(filter true, $(AGY_APIKEY_ENABLED)), --enabled, --no-enabled)
__AGY_GENERATE_DISTINCT_ID= $(if $(filter true, $(AGY_APIKEY_DISTINCTID_ENABLED)), --generate-distinct-id, --no-generate-distinct-id)
__AGY_NAME__APIKEY= $(if $(AGY_APIKEY_NAME), --name $(AGY_APIKEY_NAME))
__AGY_PATCH_OPERATIONS__APIKEY= $(if $(AGY_APIKEY_PATCH_OPERATIONS), --patch-operations $(AGY_APIKEY_PATCH_OPERATIONS))
__AGY_STAGE_KEYS__APIKEY= $(if $(AGY_APIKEY_STAGEKEYS), --stage-keys $(AGY_APIKEY_STAGEKEYS))
__AGY_VALUE__APIKEY= $(if $(AGY_APIKEY_VALUE), --value $(AGY_APIKEY_VALUE))

# UI parameters
AGY_UI_VIEW_APIKEYS_FIELDS?= .{Id:id,enabled:enabled,createdDate:createdDate,lastUpdatedDate:lastUpdatedDate,stageKeys:join(' ',stageKeys)}
AGY_UI_VIEW_APIKEYS_SET_FIELDS?= $(AGY_UI_VIEW_APIKEYS_FIELDS)
AGY_UI_VIEW_APIKEYS_SET_SLICE?=

#--- MACROS
_agy_get_apikey_value= $(call _agy_get_apikey_value_I, $(AGY_APIKEY_ID))
_agy_get_apikey_value_I= $(shell $(AWS) apigateway get-api-key --api-key $(1) --include-value --query "value" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::ApiKey ($(_AWS_APIGATEWAY_APIKEY_MK_VERSION)) macros:'
	@echo '    _agy_get_apikey_value_{|I}            - Get the value of a API-key (Id)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::ApiKey ($(_AWS_APIGATEWAY_APIKEY_MK_VERSION)) parameters:'
	@echo '    AGY_APIKEY_CUSTOMER_ID=$(AGY_APIKEY_CUSTOMER_ID)'
	@echo '    AGY_APIKEY_DESCRIPTION=$(AGY_APIKEY_DESCRIPTION)'
	@echo '    AGY_APIKEY_DISTINCTID_ENABLED=$(AGY_APIKEY_DISTINCTID_ENABLED)'
	@echo '    AGY_APIKEY_ENABLED=$(AGY_APIKEY_ENABLED)'
	@echo '    AGY_APIKEY_ID=$(AGY_APIKEY_ID)'
	@echo '    AGY_APIKEY_NAME=$(AGY_APIKEY_NAME)'
	@echo '    AGY_APIKEY_PATCH_OPERATIONS=$(AGY_APIKEY_PATCH_OPERATIONS)'
	@echo '    AGY_APIKEY_STAGEKEYS=$(AGY_APIKEY_STAGEKEYS)'
	@echo '    AGY_APIKEY_VALUE=$(AGY_APIKEY_VALUE)'
	@echo '    AGY_APIKEYS_SET_NAME=$(AGY_APIKEYS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::ApiKey ($(_AWS_APIGATEWAY_APIKEY_MK_VERSION)) targets:'
	@echo '    _agy_create_apikey                   - Create a new API-key'
	@echo '    _agy_delete_apikey                   - Delete an existing API-key'
	@echo '    _agy_show_apikey                     - Show everything related to an API-key'
	@echo '    _agy_show_apikey_description         - Show description of an API-key'
	@echo '    _agy_update_apikey                   - Update an API-key'
	@echo '    _agy_view_apikeys                    - View API-keys'
	@echo '    _agy_view_apikeys_set                - View a set of API-keys'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Creating api-key "$(AGY_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-api-key $(__AGY_CUSTOMER_ID) $(__AGY_DESCRIPTION__APIKEY) $(__AGY_ENABLED__APIKEY) $(__AGY_GENERATE_DISTINCT_ID) $(__AGY_NAME__APIKEY) $(__AGY_STAGE_KEYS__APIKEY) $(__AGY_VALUE__APIKEY)

_agy_delete_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Deleting api-key "$(AGY_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-api-key $(__AGY_API_KEY)

_agy_show_apikey:: _agy_show_apikey_description

_agy_show_apikey_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of api-key "$(AGY_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-api-key $(__AGY_API_KEY) $(__AGY_INCLUDE_VALUE)

_agy_update_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Updating api-key "$(AGY_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-api-key $(__AGY_API_KEY) $(__AGY_PATCH_OPERATIONS__APIKEY)

_agy_view_apikeys:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all API keys ...'; $(NORMAL)
	$(AWS) apigateway get-api-keys $(_X__AGY_CUSTOMER_ID) $(__AGY_INCLUDE_VALUES) $(_X__NAME_QUERY) --query "items[]$(AGY_UI_VIEW_APIKEYS_FIELDS)"

_agy_view_apikeys_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing API-keys-set "$(AGY_APIKEYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'API-keys are grouped based on the provided slice'; $(NORMAL)
	$(AWS) apigateway get-api-keys $(__AGY_CUSTOMER_ID) $(__AGY_INCLUDE_VALUES) $(__NAME_QUERY) --query "items[$(AGY_UI_VIEW_APIKEYS_SET_SLICE)]$(AGY_UI_VIEW_APIKEYS_SET_FIELDS)"
