_AWS_APIGATEWAY_DEPLOYMENT_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_DEPLOYMENT_CACHECLUSTER_ENABLED?= false
# AGY_DEPLOYMENT_CACHECLUSTER_SIZE?=
# AGY_DEPLOYMENT_CANARY_SETTINGS?=
# AGY_DEPLOYMENT_DESCRIPTION?=
# AGY_DEPLOYMENT_ID?=
AGY_DEPLOYMENT_INDEX?= 0
# AGY_DEPLOYMENT_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_DEPLOYMENT_RESTAPI_ID?= aeds9s0no6
# AGY_DEPLOYMENT_RESTAPI_NAME?= WildRydes
# AGY_DEPLOYMENT_STAGE_DESCRIPTION?=
# AGY_DEPLOYMENT_STAGE_NAME?=
# AGY_DEPLOYMENT_VARIABLES?=
# AGY_DEPLOYMENTS_SET_NAME?=

# Derived parameters
AGY_DEPLOYMENT_NAME?= $(if $(AGY_DEPLOYMENT_INDEX),deployment-$(AGY_DEPLOYMENT_INDEX))
AGY_DEPLOYMENT_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_DEPLOYMENT_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_CACHE_CLUSTER_ENABLED= $(if $(filter true, $(AGY_DEPLOYMENT_CACHECLUSTER_ENABLED)), --cache-cluster-enabled, --no-cache-cluster-enabled)
__AGY_CACHE_CLUSTER_SIZE= $(if $(AGY_DEPLOYMENT_CACHECLUSTER_SIZE), --cache-cluster-size $(AGY_DEPLOYMENT_CACHECLUSTER_SIZE))
__AGY_CANARY_SETTINGS= $(if $(AGY_DEPLOYMENT_CANARY_SETTINGS), --canary-settings $(AGY_DEPLOYMENT_CANARY_SETTINGS))
__AGY_DEPLOYMENT_ID= $(if $(AGY_DEPLOYMENT_ID), --deployment-id $(AGY_DEPLOYMENT_ID))
__AGY_DESCRIPTION__DEPLOYMENT= $(if $(AGY_DEPLOYMENT_DESCRIPTION), --description $(AGY_DEPLOYMENT_DESCRIPTION))
__AGY_EMBED__DEPLOYMENT=
__AGY_PATCH_OPERATIONS__DEPLOYMENT= $(if $(AGY_DEPLOYMENT_PATCH_OPERATIONS), --patch-operations $(AGY_DEPLOYMENT_PATCH_OPERATIONS))
__AGY_REST_API_ID__DEPLOYMENT= $(if $(AGY_DEPLOYMENT_RESTAPI_ID), --rest-api-id $(AGY_DEPLOYMENT_RESTAPI_ID))
__AGY_STAGE_DESCRIPTION= $(if $(AGY_DEPLOYMENT_STAGE_DESCRIPTION), --stage-description $(AGY_DEPLOYMENT_STAGE_DESCRIPTION))
__AGY_STAGE_NAME= $(if $(AGY_DEPLOYMENT_STAGE_NAME), --stage-name $(AGY_DEPLOYMENT_STAGE_NAME))
__AGY_VARIABLES__DEPLOYMENT= $(if $(AGY_DEPLOYMENT_VARIABLES), --variables $(AGY_DEPLOYMENT_VARIABLES))

# UI parameters
AGY_UI_VIEW_DEPLOYMENTS_FIELDS?=
AGY_UI_VIEW_DEPLOYMENTS_SET_FIELDS?= $(AGY_UI_VIEW_DEPLOYMENTS_FIELDS)
AGY_UI_VIEW_DEPLOYMENTS_SET_SLICE?=

#--- MACROS
_agy_get_deployment_id= $(call _agy_get_deployment_id_I, $(AGY_DEPLOYMENT_INDEX))
_agy_get_deployment_id_I= $(call _agy_get_deployment_id_IR, $(1), $(AGY_DEPLOYMENT_RESTAPI_ID))
_agy_get_deployment_id_IR= $(shell $(AWS) apigateway get-deployments --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::Deployment ($(_AWS_APIGATEWAY_DEPLOYMENT_MK_VERSION)) macros:'
	@echo '    _agy_get_deployment_id_{|N|NR}            - Get the ID of a deployment (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::Deployment ($(_AWS_APIGATEWAY_DEPLOYMENT_MK_VERSION)) parameters:'
	@echo '    AGY_DEPLOYMENT_CACHECLUSTER_ENABLED=$(AGY_DEPLOYMENT_CACHECLUSTER_ENABLED)'
	@echo '    AGY_DEPLOYMENT_CACHECLUSTER_SIZE=$(AGY_DEPLOYMENT_CACHECLUSTER_SIZE)'
	@echo '    AGY_DEPLOYMENT_CANARY_SETTINGS=$(AGY_DEPLOYMENT_CANARY_SETTINGS)'
	@echo '    AGY_DEPLOYMENT_DESCRIPTION=$(AGY_DEPLOYMENT_DESCRIPTION)'
	@echo '    AGY_DEPLOYMENT_ID=$(AGY_DEPLOYMENT_ID)'
	@echo '    AGY_DEPLOYMENT_INDEX=$(AGY_DEPLOYMENT_INDEX)'
	@echo '    AGY_DEPLOYMENT_NAME=$(AGY_DEPLOYMENT_NAME)'
	@echo '    AGY_DEPLOYMENT_PATCH_OPERATIONS=$(AGY_DEPLOYMENT_PATCH_OPERATIONS)'
	@echo '    AGY_DEPLOYMENT_RESTAPI_ID=$(AGY_DEPLOYMENT_RESTAPI_ID)'
	@echo '    AGY_DEPLOYMENT_RESTAPI_NAME=$(AGY_DEPLOYMENT_RESTAPI_NAME)'
	@echo '    AGY_DEPLOYMENT_STAGE_DESCRIPTION=$(AGY_DEPLOYMENT_STAGE_DESCRIPTION)'
	@echo '    AGY_DEPLOYMENT_STATE_NAME=$(AGY_DEPLOYMENT_STAGE_NAME)'
	@echo '    AGY_DEPLOYMENT_VARIABLES=$(AGY_DEPLOYMENT_VARIABLES)'
	@echo '    AGY_DEPLOYMENTS_SET_NAME=$(AGY_DEPLOYMENTS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::Deployment ($(_AWS_APIGATEWAY_DEPLOYMENT_MK_VERSION)) targets:'
	@echo '    _agy_create_deployment                   - Create a new deployment'
	@echo '    _agy_delete_deployment                   - Delete an existing deployment'
	@echo '    _agy_show_deployment                     - Show everything related to a deployment'
	@echo '    _agy_show_deployment_description         - Show description of a deployment'
	@echo '    _agy_update_deployment                   - Update a deployment'
	@echo '    _agy_view_deployments                    - View deployments'
	@echo '    _agy_view_deployments_set                - View a set of deployments'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_deployment:
	@$(INFO) '$(AWS_UI_LABEL)Creating deployment "$(AGY_DEPLOYMENT_NAME)" in rest-api "$(AGY_DEPLOYMENT_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-deployment $(__AGY_CACHE_CLUSTER_ENABLED) $(__AGY_CACHE_CLUSTER_SIZE) $(__AGY_CANARY_SETTINGS) $(__AGY_DESCRIPTION__DEPLOYMENT) $(__AGY_REST_API_ID__DEPLOYMENT) $(__AGY_STAGE_DESCRIPTION) $(__AGY_STAGE_NAME) $(__AGY_VARIABLES__DEPLOYMENT)

_agy_delete_deployment:
	@$(INFO) '$(AWS_UI_LABEL)Deleting deployment "$(AGY_DEPLOYMENT_NAME)" in rest-api "$(AGY_DEPLOYMENT_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-deployment $(__AGY_DEPLOYMEMT_ID) $(__AGY_REST_API_ID__DEPLOYMENT)

_agy_show_deployment:: _agy_show_deployment_description

_agy_show_deployment_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of deployment "$(AGY_DEPLOYMENT_NAME)" in rest-api "$(AGY_DEPLOYMENT_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-deployment $(__AGY_DEPLOYMENT_ID) $(__AGY_EMBED__DEPLOYMENT) $(__AGY_REST_API_ID__DEPLOYMENT)

_agy_update_deployment:
	@$(INFO) '$(AWS_UI_LABEL)Updating deployment "$(AGY_DEPLOYMENT_NAME)" in rest-api "$(AGY_DEPLOYMENT_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-deployment $(__AGY_DEPLOYMENT_ID) $(__AGY_PATCH_OPERATIONS__DEPLOYMENT) $(__AGY_REST_API_ID__DEPLOYMENT)

_agy_view_deployments:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all deployments in rest-api "$(AGY_DEPLOYMENT_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-deployments $(__AGY_REST_API_ID__DEPLOYMENT) --query "items[]$(AGY_UI_VIEW_DEPLOYMENTS_FIELDS)"

_agy_view_deployments_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing deployments-set "$(AGY_DEPLOYMENTS_SET_NAME)" in rest-api "$(AGY_DEPLOYMENT_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'deployments are grouped based on the provided rest-api-id and slice'; $(NORMAL)
	$(AWS) apigateway get-deployments $(__AGY_REST_API_ID__DEPLOYMENT) --query "items[$(AGY_UI_VIEW_DEPLOYMENTS_SET_SLICE)]$(AGY_UI_VIEW_DEPLOYMENTS_SET_FIELDS)"
