_AWS_APIGATEWAY_MODEL_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_MODEL_CONTENT_TYPE?=
# AGY_MODEL_DESCRIPTION?=
# AGY_MODEL_NAME?= my-model
# AGY_MODEL_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_MODEL_RESTAPI_ID?= aeds9s0no6
# AGY_MODEL_RESTAPI_NAME?= WildRydes
# AGY_MODELS_SET_NAME?=

# Derived parameters
AGY_MODEL_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_MODEL_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_CONTENT_TYPE= $(if $(AGY_MODEL_CONTENT_TYPE), --content-type $(AGY_MODEL_CONTENT_TYPE))
__AGY_DESCRIPTION__MODEL= $(if $(AGY_MODEL_DESCRIPTION), --description $(AGY_MODEL_DESCRIPTION))
__AGY_MODEL_NAME= $(if $(AGY_MODEL_NAME), --model-name $(AGY_MODEL_NAME))
__AGY_NAME__MODEL= $(if $(AGY_MODEL_NAME), --name $(AGY_MODEL_NAME))
# __AGY_PATCH_OPERATIONS__MODEL= $(if $(AGY_MODEL_PATCH_OPERATIONS), --patch-operations $(AGY_MODEL_PATCH_OPERATIONS))
__AGY_REST_API_ID__MODEL= $(if $(AGY_MODEL_RESTAPI_ID), --rest-api-id $(AGY_MODEL_RESTAPI_ID))
__AGY_SCHEMA= $(if $(AGY_MODEL_SCHEMA), --schema $(AGY_MODEL_SCHEMA))

# UI parameters
AGY_UI_VIEW_MODELS_FIELDS?=
AGY_UI_VIEW_MODELS_SET_FIELDS?= $(AGY_UI_VIEW_MODELS_FIELDS)
AGY_UI_VIEW_MODELS_SET_SLICE?=

#--- MACROS
_agy_get_model_id= $(call _agy_get_model_id_I, $(AGY_MODEL_INDEX))
_agy_get_model_id_I= $(call _agy_get_model_id_IR, $(1), $(AGY_MODEL_RESTAPI_ID))
_agy_get_model_id_IR= $(shell $(AWS) apigateway get-models --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::Model ($(_AWS_APIGATEWAY_MODEL_MK_VERSION)) macros:'
	@echo '    _agy_get_model_id_{|N|NR}            - Get the ID of a model (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::Model ($(_AWS_APIGATEWAY_MODEL_MK_VERSION)) parameters:'
	@echo '    AGY_MODEL_CACHECLUSTER_ENABLED=$(AGY_MODEL_CACHECLUSTER_ENABLED)'
	@echo '    AGY_MODEL_CACHECLUSTER_SIZE=$(AGY_MODEL_CACHECLUSTER_SIZE)'
	@echo '    AGY_MODEL_CANARY_SETTINGS=$(AGY_MODEL_CANARY_SETTINGS)'
	@echo '    AGY_MODEL_DESCRIPTION=$(AGY_MODEL_DESCRIPTION)'
	@echo '    AGY_MODEL_ID=$(AGY_MODEL_ID)'
	@echo '    AGY_MODEL_INDEX=$(AGY_MODEL_INDEX)'
	@echo '    AGY_MODEL_PATCH_OPERATIONS=$(AGY_MODEL_PATCH_OPERATIONS)'
	@echo '    AGY_MODEL_RESTAPI_ID=$(AGY_MODEL_RESTAPI_ID)'
	@echo '    AGY_MODEL_RESTAPI_NAME=$(AGY_MODEL_RESTAPI_NAME)'
	@echo '    AGY_MODEL_STAGE_DESCRIPTION=$(AGY_MODEL_STAGE_DESCRIPTION)'
	@echo '    AGY_MODEL_STATE_NAME=$(AGY_MODEL_STAGE_NAME)'
	@echo '    AGY_MODEL_VARIABLES=$(AGY_MODEL_VARIABLES)'
	@echo '    AGY_MODELS_SET_NAME=$(AGY_MODELS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::Model ($(_AWS_APIGATEWAY_MODEL_MK_VERSION)) targets:'
	@echo '    _agy_create_model                   - Create a new API-key'
	@echo '    _agy_delete_model                   - Delete an existing API-key'
	@echo '    _agy_show_model                     - Show everything related to an API-key'
	@echo '    _agy_update_model                   - Update an API-key'
	@echo '    _agy_view_models                    - View API-keys'
	@echo '    _agy_view_models_set                - View a set of API-keys'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_model:
	@$(INFO) '$(AWS_UI_LABEL)Creating model "$(AGY_MODEL_NAME)" in rest-api "$(AGY_MODEL_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-model $(__AGY_CONTENT_TYPE) $(__AGY_DESCRIPTION__MODEL) $(__AGY_NAME__MODEL) $(__AGY_REST_API_ID__MODEL) $(__AGY_SCHEMA)

_agy_delete_model:
	@$(INFO) '$(AWS_UI_LABEL)Deleting model "$(AGY_MODEL_NAME)" in rest-api "$(AGY_MODEL_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-model $(__AGY_MODEL_NAME) $(__AGY_REST_API_ID__MODEL)

_agy_show_model:: _agy_show_model_description

_agy_show_model_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of model "$(AGY_MODEL_NAME)" in rest-api "$(AGY_MODEL_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-model $(__AGY_FLATTEN) $(__AGY_MODEL_NAME) $(__AGY_REST_API_ID__MODEL)

_agy_update_model:
	@$(INFO) '$(AWS_UI_LABEL)Updating model "$(AGY_MODEL_NAME)" in rest-api "$(AGY_MODEL_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-model $(__AGY_MODEL_NAME) $(__AGY_REST_API_ID__MODEL) $(__AGY_PATCH_OPERATIONS__MODEL)

_agy_view_models:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all models in rest-api "$(AGY_MODEL_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-models $(__AGY_REST_API_ID__MODEL) --query "items[]$(AGY_UI_VIEW_MODELS_FIELDS)"

_agy_view_models_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing models-set "$(AGY_MODELS_SET_NAME)" in rest-api "$(AGY_MODEL_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'models are grouped based on the provided rest-api-id and slice'; $(NORMAL)
	$(AWS) apigateway get-models $(__AGY_REST_API_ID__MODEL) --query "items[$(AGY_UI_VIEW_MODELS_SET_SLICE)]$(AGY_UI_VIEW_MODELS_SET_FIELDS)"
