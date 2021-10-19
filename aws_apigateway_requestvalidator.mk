_AWS_APIGATEWAY_REQUESTVALIDATOR_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_REQUESTVALIDATOR_ID?=
# AGY_REQUESTVALIDATOR_NAME?=
# AGY_REQUESTVALIDATOR_PATCH_OPERATIONS?=
# AGY_REQUESTVALIDATOR_REQUESTBODY_ENABLED?=
# AGY_REQUESTVALIDATOR_REQUESTPARAMETER_ENABLED?=
# AGY_REQUESTVALIDATOR_RESTAPI_ID?= aeds9s0no6
# AGY_REQUESTVALIDATOR_RESTAPI_NAME?= WildRydes
# AGY_REQUESTVALIDATORS_SET_NAME?=

# Derived parameters
AGY_REQUESTVALIDATOR_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_REQUESTVALIDATOR_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_NAME__REQUESTVALIDATOR= $(if $(AGY_REQUESTVALIDATOR_NAME), --name $(AGY_REQUESTVALIDATOR_NAME))
__AGY_PATCH_OPERATIONS__REQUESTVALIDATOR= $(if $(AGY_REQUESTVALIDATOR_PATCH_OPERATIONS), --patch-operations $(AGY_REQUESTVALIDATOR_PATCH_OPERATIONS))
__AGY_REQUESTVALIDATOR_ID= $(if $(AGY_REQUESTVALIDATOR_ID), --request-validator-id $(AGY_REQUESTVALIDATOR_ID))
__AGY_REST_API_ID__REQUESTVALIDATOR= $(if $(AGY_REQUESTVALIDATOR_RESTAPI_ID), --rest-api-id $(AGY_REQUESTVALIDATOR_RESTAPI_ID))
__AGY_VALIDATE_REQUEST_BODY= $(if $(filter true, $(AGY_REQUESTVALIDATOR_REQUESTBODY_ENABLED)), --validate-request-body, --no-validate-request-body))
__AGY_VALIDATE_REQUEST_PARAMETERS= $(if $(filter true, $(AGY_REQUESTVALIDATOR_REQUESTPARAMETERS_ENABLED)), --validate-request-parameters, --no-validate-request-parameters))

# UI parameters
AGY_UI_VIEW_REQUESTVALIDATORS_FIELDS?=
AGY_UI_VIEW_REQUESTVALIDATORS_SET_FIELDS?= $(AGY_UI_VIEW_REQUESTVALIDATORS_FIELDS)
AGY_UI_VIEW_REQUESTVALIDATORS_SET_SLICE?=

#--- MACROS
_agy_get_requestvalidator_id= $(call _agy_get_requestvalidator_id_I, $(AGY_REQUESTVALIDATOR_INDEX))
_agy_get_requestvalidator_id_I= $(call _agy_get_requestvalidator_id_IR, $(1), $(AGY_REQUESTVALIDATOR_RESTAPI_ID))
_agy_get_requestvalidator_id_IR= $(shell $(AWS) apigateway get-request-validators --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::RequestValidator ($(_AWS_APIGATEWAY_REQUESTVALIDATOR_MK_VERSION)) macros:'
	@echo '    _agy_get_requestvalidator_id_{|N|NR}            - Get the ID of a requestvalidator (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::RequestValidator ($(_AWS_APIGATEWAY_REQUESTVALIDATOR_MK_VERSION)) parameters:'
	@echo '    AGY_REQUESTVALIDATOR_ID=$(AGY_REQUESTVALIDATOR_ID)'
	@echo '    AGY_REQUESTVALIDATOR_NAME=$(AGY_REQUESTVALIDATOR_NAME)'
	@echo '    AGY_REQUESTVALIDATOR_PATCH_OPERATIONS=$(AGY_REQUESTVALIDATOR_PATCH_OPERATIONS)'
	@echo '    AGY_REQUESTVALIDATOR_REQUESTBODY_ENABLED=$(AGY_REQUESTVALIDATOR_REQUESTBODY_ENABLED)'
	@echo '    AGY_REQUESTVALIDATOR_REQUESTPARAMETERS_ENABLED=$(AGY_REQUESTVALIDATOR_REQUESTPARAMETERS_ENABLED)'
	@echo '    AGY_REQUESTVALIDATOR_RESTAPI_ID=$(AGY_REQUESTVALIDATOR_RESTAPI_ID)'
	@echo '    AGY_REQUESTVALIDATOR_RESTAPI_NAME=$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)'
	@echo '    AGY_REQUESTVALIDATORS_SET_NAME=$(AGY_REQUESTVALIDATORS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::RequestValidator ($(_AWS_APIGATEWAY_REQUESTVALIDATOR_MK_VERSION)) targets:'
	@echo '    _agy_create_requestvalidator                   - Create a new request-validator'
	@echo '    _agy_delete_requestvalidator                   - Delete an existing request-validator'
	@echo '    _agy_show_deployment                           - Show everything related to an request-validator'
	@echo '    _agy_update_requestvalidator                   - Update equestvalidatore an request-validator'
	@echo '    _agy_view_requestvalidators                    - View request-validators'
	@echo '    _agy_view_requestvalidators_set                - View a set of request-validators'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_requestvalidator:
	@$(INFO) '$(AWS_UI_LABEL)Creating request-validator "$(AGY_REQUESTVALIDATOR_NAME)" in rest-api "$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-request-validator $(__AGY_NAME__REQUESTVALIDATOR) $(__AGY_REST_API_ID__REQUESTVALIDATOR) $(__AGY_VALIDATE_REQUEST_BODY) $(__AGY_VALIDATE_REQUEST_PARAMETERS)

_agy_delete_requestvalidator:
	@$(INFO) '$(AWS_UI_LABEL)Deleting request-validator "$(AGY_REQUESTVALIDATOR_NAME)" in rest-api "$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-request-validator $(__AGY_REQUESTVALIDATOR_ID) $(__AGY_REST_API_ID__REQUESTVALIDATOR)

_agy_show_requestvalidator:: _agy_show_requestvalidator_description

_agy_show_requestvalidator_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing request-validator "$(AGY_REQUESTVALIDATOR_NAME)" in rest-api "$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-request-validator $(__AGY_REQUESTVALIDATOR_ID) $(__AGY_REST_API_ID__REQUESTVALIDATOR)

_agy_update_requestvalidator:
	@$(INFO) '$(AWS_UI_LABEL)Updating request-validator "$(AGY_REQUESTVALIDATOR_NAME)" in rest-api "$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-request-validator $(__AGY_PATCH_OPERATIONS__REQUESTVALIDATOR) $(__AGY_REQUESTVALIDATOR_ID) $(__AGY_REST_API_ID__REQUESTVALIDATOR)

_agy_view_requestvalidators:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all request-validators in rest-api "$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-request-validators $(__AGY_REST_API_ID__REQUESTVALIDATOR) --query "items[]$(AGY_UI_VIEW_REQUESTVALIDATORS_FIELDS)"

_agy_view_requestvalidators_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing request-validators-set "$(AGY_REQUESTVALIDATORS_SET_NAME)" in rest-api "$(AGY_REQUESTVALIDATOR_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'request-validators are grouped based on the provided rest-api and slice'; $(NORMAL)
	$(AWS) apigateway get-request-validators $(__AGY_REST_API_ID__REQUESTVALIDATOR) --query "items[$(AGY_UI_VIEW_REQUESTVALIDATORS_SET_SLICE)]$(AGY_UI_VIEW_REQUESTVALIDATORS_SET_FIELDS)"
