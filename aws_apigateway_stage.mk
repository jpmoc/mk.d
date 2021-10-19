_AWS_APIGATEWAY_STAGE_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_STAGE_AWS_REGION?= us-west-2
# AGY_STAGE_CACHECLUSTER_ENABLED?= false
# AGY_STAGE_CACHECLUSTER_SIZE?=
# AGY_STAGE_CANARY_SETTINGS?=
# AGY_STAGE_DEPLOYMENT_ID?=
# AGY_STAGE_DESCRIPTION?=
# AGY_STAGE_DOCUMENTATION_VERSION?=
# AGY_STAGE_ID?=
# AGY_STAGE_INVOKE_URL?= https://moujdy1zrf.execute-api.us-west-2.amazonaws.com/dev
# AGY_STAGE_NAME?= my-stage
# AGY_STAGE_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_STAGE_RESTAPI_ID?= aeds9s0no6
# AGY_STAGE_RESTAPI_NAME?= WildRydes
# AGY_STAGE_TAGS?=
# AGY_STAGE_VARIABLES?=
# AGY_STAGES_SET_NAME?=

# Derived parameters
AGY_STAGE_AWS_REGION?= $(AWS_REGION)
AGY_STAGE_DEPLOYMENT_ID?= $(AGY_DEPLOYMENT_ID)
AGY_STAGE_DEPLOYMENT_NAME?= $(AGY_DEPLOYMENT_NAME)
AGY_STAGE_INVOKE_URL?= https://$(AGY_STAGE_RESTAPI_ID).execute-api.$(AGY_STAGE_AWS_REGION).amazonaws.com/$(AGY_STAGE_NAME)
AGY_STAGE_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_STAGE_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_CACHE_CLUSTER_ENABLED= $(if $(filter true, $(AGY_STAGE_CACHECLUSTER_ENABLED)), --cache-cluster-enabled, --no-cache-cluster-enabled)
__AGY_CACHE_CLUSTER_SIZE= $(if $(AGY_STAGE_CACHECLUSTER_SIZE), --cache-cluster-size $(AGY_STAGE_CACHECLUSTER_SIZE))
__AGY_CANARY_SETTINGS= $(if $(AGY_STAGE_CANARY_SETTINGS), --canary-settings $(AGY_STAGE_CANARY_SETTINGS))
__AGY_DEPLOYMENT_ID__STAGE= $(if $(AGY_STAGE_DEPLOYMENT_ID), --deployment-id $(AGY_STAGE_DEPLOYMENT_ID))
__AGY_DESCRIPTION__STAGE= $(if $(AGY_STAGE_DESCRIPTION), --description $(AGY_STAGE_DESCRIPTION))
__AGY_DOCUMENTATION_VERSION= $(if $(AGY_STAGE_DOCUMENTATION_VERSION), --documentation-version $(AGY_STAGE_DOCUMENTATION_VERSION))
__AGY_PATCH_OPERATIONS__STAGE= $(if $(AGY_STAGE_PATCH_OPERATIONS), --patch-operations $(AGY_STAGE_PATCH_OPERATIONS))
__AGY_REST_API_ID__STAGE= $(if $(AGY_STAGE_RESTAPI_ID), --rest-api-id $(AGY_STAGE_RESTAPI_ID))
__AGY_STAGE_DESCRIPTION= $(if $(AGY_STAGE_STAGE_DESCRIPTION), --stage-description $(AGY_STAGE_STAGE_DESCRIPTION))
__AGY_STAGE_ID= $(if $(AGY_STAGE_ID), --stage-id $(AGY_STAGE_ID))
__AGY_STAGE_NAME= $(if $(AGY_STAGE_NAME), --stage-name $(AGY_STAGE_NAME))
__AGY_TAGS__STAGE= $(if $(AGY_STAGE_TAGS), --tags $(AGY_STAGE_TAGS))
__AGY_VARIABLES__STAGE= $(if $(AGY_STAGE_VARIABLES), --variables $(AGY_STAGE_VARIABLES))

# UI parameters
AGY_UI_VIEW_STAGES_FIELDS?=
AGY_UI_VIEW_STAGES_SET_FIELDS?= $(AGY_UI_VIEW_STAGES_FIELDS)
AGY_UI_VIEW_STAGES_SET_SLICE?=

#--- MACROS
_agy_get_stage_id= $(call _agy_get_stage_id_I, $(AGY_STAGE_INDEX))
_agy_get_stage_id_I= $(call _agy_get_stage_id_IR, $(1), $(AGY_STAGE_RESTAPI_ID))
_agy_get_stage_id_IR= $(shell $(AWS) apigateway get-stages --rest-api-id $(2) --query "item[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::Stage ($(_AWS_APIGATEWAY_STAGE_MK_VERSION)) macros:'
	@echo '    _agy_get_stage_id_{|N|NR}            - Get the ID of a stage (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::Stage ($(_AWS_APIGATEWAY_STAGE_MK_VERSION)) parameters:'
	@echo '    AGY_STAGE_AWS_REGION=$(AGY_STAGE_AWS_REGION)'
	@echo '    AGY_STAGE_CACHECLUSTER_ENABLED=$(AGY_STAGE_CACHECLUSTER_ENABLED)'
	@echo '    AGY_STAGE_CACHECLUSTER_SIZE=$(AGY_STAGE_CACHECLUSTER_SIZE)'
	@echo '    AGY_STAGE_CANARY_SETTINGS=$(AGY_STAGE_CANARY_SETTINGS)'
	@echo '    AGY_STAGE_DEPLOYMENT_ID=$(AGY_STAGE_DEPLOYMENT_ID)'
	@echo '    AGY_STAGE_DEPLOYMENT_NAME=$(AGY_STAGE_DEPLOYMENT_NAME)'
	@echo '    AGY_STAGE_DESCRIPTION=$(AGY_STAGE_DESCRIPTION)'
	@echo '    AGY_STAGE_DOCUMENTATION_VERSION=$(AGY_STAGE_DOCUMENTATION_VERSION)'
	@echo '    AGY_STAGE_ID=$(AGY_STAGE_ID)'
	@echo '    AGY_STAGE_INVOKE_URL=$(AGY_STAGE_INVOKE_URL)'
	@echo '    AGY_STAGE_NAME=$(AGY_STAGE_NAME)'
	@echo '    AGY_STAGE_PATCH_OPERATIONS=$(AGY_STAGE_PATCH_OPERATIONS)'
	@echo '    AGY_STAGE_RESTAPI_ID=$(AGY_STAGE_RESTAPI_ID)'
	@echo '    AGY_STAGE_RESTAPI_NAME=$(AGY_STAGE_RESTAPI_NAME)'
	@echo '    AGY_STAGE_TAGS=$(AGY_STAGE_STAGE_TAGS)'
	@echo '    AGY_STAGE_VARIABLES=$(AGY_STAGE_VARIABLES)'
	@echo '    AGY_STAGES_SET_NAME=$(AGY_STAGES_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::Stage ($(_AWS_APIGATEWAY_STAGE_MK_VERSION)) targets:'
	@echo '    _agy_create_stage                   - Create a new stage'
	@echo '    _agy_curl_stage                     - Curl a stage'
	@echo '    _agy_delete_stage                   - Delete an existing stage'
	@echo '    _agy_show_stage                     - Show everything related to a stage'
	@echo '    _agy_show_stage_description         - Show description of a stage'
	@echo '    _agy_update_stage                   - Update a stage'
	@echo '    _agy_view_stages                    - View stages'
	@echo '    _agy_view_stages_set                - View a set of stages'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_stage:
	@$(INFO) '$(AWS_UI_LABEL)Creating stage "$(AGY_STAGE_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-stage $(__AGY_CACHE_CLUSTER_ENABLED) $(__AGY_CACHE_CLUSTER_SIZE) $(__AGY_CANARY_SETTINGS) $(__AGY_DEPLOYMENT_ID__STAGE) $(__AGY_DESCRIPTION__STAGE) $(__AGY_DOCUMENTATION_VERSION) $(__AGY_REST_API_ID__STAGE) $(__AGY_STAGE_DESCRIPTION) $(__AGY_STAGE_NAME) $(__AGY_TAGS__STAGE) $(__AGY_VARIABLES__STAGE)

_agy_curl_stage:
	@$(INFO) '$(AWS_UI_LABEL)Curling invoke-url of stage "$(AGY_STAGE_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	curl $(AGY_STAGE_INVOKE_URL)

_agy_delete_stage:
	@$(INFO) '$(AWS_UI_LABEL)Deleting stage "$(AGY_STAGE_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-stage $(__AGY_REST_API_ID__STAGE) $(__AGY_STAGE_NAME)

_agy_show_stage :: _agy_show_stage_invokeurl _agy_show_stage_description

_agy_show_stage_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of stage "$(AGY_STAGE_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-stage $(__AGY_REST_API_ID__STAGE) $(__AGY_STAGE_NAME)

_agy_show_stage_invokeurl:
	@$(INFO) '$(AWS_UI_LABEL)Showing invoke-url of stage "$(AGY_STAGE_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Invoke URL: $(AGY_STAGE_INVOKE_URL)'; $(NORMAL)

_agy_update_stage:
	@$(INFO) '$(AWS_UI_LABEL)Updating stage "$(AGY_STAGE_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-stage $(__AGY_PATCH_OPERATIONS__STAGE) $(__AGY_REST_API_ID__STAGE) $(__AGY_STAGE_NAME)

_agy_view_stages:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all stages in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-stages $(_X__AGY_DEPLOYMENT_ID__STAGE) $(__AGY_REST_API_ID__STAGE) --query "item[]$(AGY_UI_VIEW_STAGES_FIELDS)"

_agy_view_stages_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing stages-set "$(AGY_STAGES_SET_NAME)" in rest-api "$(AGY_STAGE_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Stages are grouped based on the provided deployment, rest-api, and slice'; $(NORMAL)
	$(AWS) apigateway get-stages $(__AGY_DEPLOYMENT_ID__STAGE) $(__AGY_REST_API_ID__STAGE) --query "item[$(AGY_UI_VIEW_STAGES_SET_SLICE)]$(AGY_UI_VIEW_STAGES_SET_FIELDS)"
