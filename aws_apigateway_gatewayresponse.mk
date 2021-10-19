_AWS_APIGATEWAY_GATEWAYRESPONSE_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_GATEWAYRESPONSE_NAME?=
# AGY_GATEWAYRESPONSE_PATCH_OPERATIONS?=
# AGY_GATEWAYRESPONSE_RESPONSE_PARAMETERS?=
# AGY_GATEWAYRESPONSE_RESPONSE_TEMPLATES?=
# AGY_GATEWAYRESPONSE_RESPONSE_TYPE?= UNAUTHORIZED
# AGY_GATEWAYRESPONSE_REST_API_ID?=
# AGY_GATEWAYRESPONSE_STATUSCODE?= 401
# AGY_GATEWAYRESPONSES_SET_NAME?= my-gateway-responses-set

# Derived parameters
AGY_GATEWAYRESPONSE_NAME?= $(AGY_GATEWAYRESPONSE_RESPONSE_TYPE)
AGY_GATEWAYRESPONSE_RESTAPI_ID?= $(AGY_RESTAPI_ID)

# Option parameters
__AGY_LIMIT__GATEWAYRESPONSE=
__AGY_PATCH_OPERATIONS__GATEWAYRESPONSE= $(if $(AGY_GATEWAYRESPONSE_PATCH_OPERATIONS), --patch-operations $(AGY_GATEWAYRESPONSE_PATCH_OPERATIONS))
__AGY_POSITION__GATEWAYRESPONSE=
__AGY_RESPONSE_PARAMETERS= $(if $(AGY_GATEWAYRESPONSE_RESPONSE_PARAMETERS), --response-parameters $(AGY_GATEWAYRESPONSE_RESPONSE_PARAMETERS))
__AGY_RESPONSE_TEMPLATES= $(if $(AGY_GATEWAYRESPONSE_RESPONSE_TEMPLATES), --response-templates $(AGY_GATEWAYRESPONSE_RESPONSE_TEMPLATES))
__AGY_RESPONSE_TYPE= $(if $(AGY_GATEWAYRESPONSE_RESPONSE_TYPE), --response-type $(AGY_GATEWAYRESPONSE_RESPONSE_TYPE))
__AGY_REST_API_ID__GATEWAYRESPONSE= $(if $(AGY_GATEWAYRESPONSE_RESTAPI_ID), --rest-api-id $(AGY_GATEWAYRESPONSE_RESTAPI_ID))
__AGY_STATUS_CODE= $(if $(AGY_GATEWAYRESPONSE_STATUSCODE), --status-code $(AGY_GATEWAYRESPONSE_STATUSCODE))

# UI parameters
AGY_UI_VIEW_GATEWAYRESPONSES_FIELDS?= .{StatusCode:statusCode,ResponseType:responseType,defaultResponse:defaultResponse}
AGY_UI_VIEW_GATEWAYRESPONSES_SET_FIELDS?= $(AGY_UI_VIEW_GATEWAYRESPONSES_FIELDS)
AGY_UI_VIEW_GATEWAYRESPONSES_SET_SLICE?=

#--- MACROS
_agy_get_gatewayresponse_statuscode= $(call _agy_get_gatewayresponse_statuscode_T, $(AGY_GATEWAYRESPONSE_TYPE))
_agy_get_gatewayresponse_statuscode_T= $(call _agy_get_gatewayresponse_statuscode_TR, $(1), $(AGY_GATEWAYRESPONSE_RESTAPI_ID))
_agy_get_gatewayresponse_statuscode_TR= $(shell $(AWS) apigateway get-gateway-responses --rest-api-id $(2) --query "items[?responseType='$(strip $(1))'].statusCode" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::GatewayResponse ($(_AWS_APIGATEWAY_GATEWAYRESPONSE_MK_VERSION)) macros:'
	@echo '    _agy_get_gatewayresponse_id_{|T|TR}            - Get the ID of a gateway-response (Type,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::GatewayResponse ($(_AWS_APIGATEWAY_GATEWAYRESPONSE_MK_VERSION)) parameters:'
	@echo '    AGY_GATEWAYRESPONSE_NAME=$(AGY_GATEWAYRESPONSE_NAME)'
	@echo '    AGY_GATEWAYRESPONSE_PATCH_OPERATIONS=$(AGY_GATEWAYRESPONSE_PATCH_OPERATIONS)'
	@echo '    AGY_GATEWAYRESPONSE_RESPONSE_PARAMETERS=$(AGY_GATEWAYRESPONSE_RESPONSE_PARAMETERS)'
	@echo '    AGY_GATEWAYRESPONSE_RESPONSE_TEMPLATES=$(AGY_GATEWAYRESPONSE_RESPONSE_TEMPLATES)'
	@echo '    AGY_GATEWAYRESPONSE_RESPONSE_TYPE=$(AGY_GATEWAYRESPONSE_RESPONSE_TYPE)'
	@echo '    AGY_GATEWAYRESPONSE_RESTAPI_ID=$(AGY_GATEWAYRESPONSE_RESTAPI_ID)'
	@echo '    AGY_GATEWAYRESPONSE_STATUSCODE=$(AGY_GATEWAYRESPONSE_STATUSCODE)'
	@echo '    AGY_GATEWAYRESPONSES_SET_NAME=$(AGY_GATEWAYRESPONSES_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::GatewayResponse ($(_AWS_APIGATEWAY_GATEWAYRESPONSE_MK_VERSION)) targets:'
	@echo '    _agy_create_gatewayresponse                   - Create a new gateway-response'
	@echo '    _agy_delete_gatewayresponse                   - Delete an existing gateway-response'
	@echo '    _agy_show_gatewayresponse                     - Show everything related to an gateway-response'
	@echo '    _agy_update_gatewayresponse                   - Update an gateway-response'
	@echo '    _agy_view_gatewayresponses                    - View gateway-responses'
	@echo '    _agy_view_gatewayresponses_set                - View a set of gateway-responses'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_gatewayresponse:
	@$(INFO) '$(AWS_UI_LABEL)Creating gateway-response "$(AGY_GATEWAYRESPONSE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway put-gateway-response $(__AGY_REPONSE_PARAMETERS) $(__AGY_RESPONSE_TEMPLATES) $(__AGY_RESPONSE_TYPE) $(__AGY_REST_API_ID__GATEWAYRESPONSE) $(__AGY_STATUS_CODE)

_agy_delete_gatewayresponse:
	@$(INFO) '$(AWS_UI_LABEL)Deleting gateway-response "$(AGY_GATEWAYRESPONSE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-gateway-response $(__AGY_RESPONSE_TYPE) $(__AGY_REST_API_ID__GATEWAYRESPONSE)

_agy_show_gatewayresponse:: _agy_show_gatewayresponse_description

_agy_show_gatewayresponse_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of gateway-response "$(AGY_GATEWAYRESPONSE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-gateway-response $(__AGY_RESPONSE_TYPE) $(__AGY_REST_API_ID__GATEWAYRESPONSE)

_agy_update_gatewayresponse:
	@$(INFO) '$(AWS_UI_LABEL)Updating gateway-response "$(AGY_GATEWAYRESPONSE_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-gateway-response $(__AGY_PATCH_OPERATIONS__GATEWAYRESPONSE) $(__AGY_RESPONSE_TYPE) $(__AGY_REST_API_ID__GATEWAYRESPONSE)

_agy_view_gatewayresponses:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all gateway-responses ...'; $(NORMAL)
	$(AWS) apigateway get-gateway-responses $(_X__AGY_LIMIT__GATEWAYRESPONSE) $(_X__AGY_POSITION__GATEWAYRESPONSE) $(__AGY_REST_API_ID__GATEWAYRESPONSE) --query "items[]$(AGY_UI_VIEW_GATEWAYRESPONSES_FIELDS)"

_agy_view_gatewayresponses_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing gateway-responses-set "$(AGY_GATEWAYRESPONSES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Gateway-responses are grouped based on the provided slice'; $(NORMAL)
	$(AWS) apigateway get-gateway-responses $(_X__AGY_LIMIT__GATEWAYRESPONSE) $(_X__AGY_POSITION__GATEWAYRESPONSE) $(__AGY_REST_API_ID__GATEWAYRESPONSE) --query "items[$(AGY_UI_VIEW_GATEWAYRESPONSES_SET_SLICE)]$(AGY_UI_VIEW_GATEWAYRESPONSES_SET_FIELDS)"
