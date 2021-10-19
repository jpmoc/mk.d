_AWS_APIGATEWAY_METHOD_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_METHOD_APIKEY_REQUIRED?=
# AGY_METHOD_AUTHORIZATION_SCOPES?=
# AGY_METHOD_AUTHORIZATION_TYPE?=
# AGY_METHOD_AUTHORIZER_ID?=
# AGY_METHOD_HTTP_METHOD?=
# AGY_METHOD_INPUTS_DIRPATH?=
# AGY_METHOD_NAME?=
# AGY_METHOD_OPERATION_NAME?=
# AGY_METHOD_OUTPUTS_DIRPATH?=
# AGY_METHOD_PATCH_OPERATIONS?=
# AGY_METHOD_REQUEST_MODELS?=
# AGY_METHOD_REQUEST_PARAMETERS?=
# AGY_METHOD_REQUEST_VALLIDATORID?=
# AGY_METHOD_RESOURCE_ID?=
# AGY_METHOD_RESOURCE_NAME?=
# AGY_METHOD_RESTAPI_ID?=
# AGY_METHOD_RESTAPI_NAME?=
# AGY_METHOD_TEST_QUERYSTRING?= "/pets/1"
# AGY_METHODS_SET_NAME?= my-method-responses-set

# Derived parameters
AGY_METHOD_INPUTS_DIRPATH?= $(AGY_INPUTS_DIRPATH)
AGY_METHOD_NAME?= $(AGY_METHOD_RESTAPI_NAME):$(AGY_METHOD_RESOURCE_NAME):$(AGY_METHOD_HTTP_METHOD)
AGY_METHOD_OUTPUTS_DIRPATH?= $(AGY_OUTPUTS_DIRPATH)
AGY_METHOD_RESOURCE_ID?= $(AGY_RESOURCE_ID)
AGY_METHOD_RESOURCE_NAME?= $(AGY_RESOURCE_NAME)
AGY_METHOD_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_METHOD_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_API_KEY_REQUIRED= $(if $(filter true, $(AGY_METHOD_APIKEY_REQUIRED)), --api-key-required, --no-api-key-required)
__AGY_AUTHORIZATION_SCOPES= $(if $(AGY_METHOD_AUTHORIZATION_SCOPES), --authorization-scopes $(AGY_METHOD_AUTHORIZATION_SCOPES))
__AGY_AUTHORIZATION_TYPE= $(if $(AGY_METHOD_AUTHORIZATION_TYPE), --authorization-type $(AGY_METHOD_AUTHORIZATION_TYPE))
__AGY_AUTHORIZER_ID= $(if $(AGY_METHOD_AUTHORIZER_ID), --authorizer-id $(AGY_METHOD_AUTHORIZER_ID))
__AGY_HTTP_METHOD__METHOD= $(if $(AGY_METHOD_HTTP_METHOD), --http-method $(AGY_METHOD_HTTP_METHOD))
__AGY_OPERATION_NAME= $(if $(AGY_METHOD_OPERATION_NAME), --operation-name $(AGY_METHOD_OPERATION_NAME))
__AGY_PATCH_OPERATIONS__METHOD= $(if $(AGY_METHOD_PATCH_OPERATIONS), --patch-operations $(AGY_METHOD_PATCH_OPERATIONS))
__AGY_PATH_WITH_QUERY_STRING= $(if $(AGY_METHOD_TEST_QUERYSTRING), --path-with-query-string $(AGY_METHOD_TEST_QUERYSTRING))
__AGY_REQUEST_MODELS= $(if $(AGY_METHOD_REQUEST_MODELS), --request-models $(AGY_METHOD_REQUEST_MODELS))
__AGY_REQUEST_PARAMETERS= $(if $(AGY_METHOD_REQUEST_PARAMETERS), --request-parameters $(AGY_METHOD_REQUEST_PARAMETERS))
__AGY_REQUEST_VALIDATORID= $(if $(AGY_METHOD_REQUEST_VALIDATORID), --request-validator-id $(AGY_METHOD_REQUEST_VALIDATORID))
__AGY_RESOURCE_ID__METHOD= $(if $(AGY_METHOD_RESOURCE_ID), --resource-id $(AGY_METHOD_RESOURCE_ID))
__AGY_REST_API_ID__METHOD= $(if $(AGY_METHOD_RESTAPI_ID), --rest-api-id $(AGY_METHOD_RESTAPI_ID))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::Method ($(_AWS_APIGATEWAY_METHOD_MK_VERSION)) macros:'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::Method ($(_AWS_APIGATEWAY_METHOD_MK_VERSION)) parameters:'
	@echo '    AGY_METHOD_APIKEY_REQUIRED=$(AGY_METHOD_APIKEY_REQUIRED)'
	@echo '    AGY_METHOD_AUTHORIZATION_SCOPES=$(AGY_METHOD_AUTHORIZATION_SCOPES)'
	@echo '    AGY_METHOD_AUTHORIZATION_TYPE=$(AGY_METHOD_AUTHORIZATION_TYPE)'
	@echo '    AGY_METHOD_AUTHORIZER_ID=$(AGY_METHOD_AUTHORIZER_ID)'
	@echo '    AGY_METHOD_HTTP_METHOD=$(AGY_METHOD_HTTP_METHOD)'
	@echo '    AGY_METHOD_NAME=$(AGY_METHOD_NAME)'
	@echo '    AGY_METHOD_OPERATTION_NAME=$(AGY_METHOD_OPERATION_NAME)'
	@echo '    AGY_METHOD_OUTPUTS_DIRPATH=$(AGY_METHOD_OUTPUTS_DIRPATH)'
	@echo '    AGY_METHOD_PATCH_OPERATIONS=$(AGY_METHOD_PATCH_OPERATIONS)'
	@echo '    AGY_METHOD_REQUEST_MODELS=$(AGY_METHOD_REQUEST_MODELS)'
	@echo '    AGY_METHOD_REQUEST_PARAMETERS=$(AGY_METHOD_REQUEST_PARAMETERS)'
	@echo '    AGY_METHOD_REQUEST_VALIDATORID=$(AGY_METHOD_REQUEST_VALIDATORID)'
	@echo '    AGY_METHOD_RESOURCE_ID=$(AGY_METHOD_RESOURCE_ID)'
	@echo '    AGY_METHOD_RESOURCE_NAME=$(AGY_METHOD_RESOURCE_NAME)'
	@echo '    AGY_METHOD_RESTAPI_ID=$(AGY_METHOD_RESTAPI_ID)'
	@echo '    AGY_METHOD_RESTAPI_NAME=$(AGY_METHOD_RESTAPI_NAME)'
	@echo '    AGY_METHOD_TEST_QUERYSTRING=$(AGY_METHOD_TEST_QUERYSTRING)'
	@echo '    AGY_METHODS_SET_NAME=$(AGY_METHODS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::Method ($(_AWS_APIGATEWAY_METHOD_MK_VERSION)) targets:'
	@echo '    _agy_create_method                   - Create a new method'
	@echo '    _agy_delete_method                   - Delete an existing method'
	@echo '    _agy_show_method                     - Show everything related to a method'
	@echo '    _agy_show_method_description         - Show description of a method'
	@echo '    _agy_update_method                   - Update a method'
	@echo '    _agy_view_methods                    - View methods'
	@echo '    _agy_view_methods_set                - View set of methods'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_method:
	@$(INFO) '$(AWS_UI_LABEL)Creating method "$(AGY_METHOD_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway put-method $(__AGY_API_KEY_REQUIRED) $(__AGY_AUTHORIZATION_SCOPES) $(__AGY_AUTHORIZATION_TYPE) $(__AGY_AUTHORIZER_ID) $(__AGY_HTTP_METHOD__METHOD) $(__AGY_OPEATION_NAME) $(__AGY_REQUEST_MODELS) $(__AGY_REQUEST_PARAMETERS__MODEL) $(__AGY_REQUEST_VALIDATOR_ID) $(__AGY_RESOURCE_ID__METHOD) $(__AGY_REST_API_ID__METHOD)

_agy_delete_method:
	@$(INFO) '$(AWS_UI_LABEL)Deleting method "$(AGY_METHOD_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-method $(__AGY_HTTP_METHOD__METHOD) $(__AGY_RESOURCE_ID__METHOD) $(__AGY_REST_API_ID__METHOD)

_agy_show_method:: _agy_show_method_description

_agy_show_method_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of method "$(AGY_METHOD_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-method $(__AGY_HTTP_METHOD__METHOD) $(__AGY_RESOURCE_ID__METHOD) $(__AGY_REST_API_ID__METHOD)

_agy_test_method:
	@$(INFO) '$(AWS_UI_LABEL)Testing method "$(AGY_METHOD_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway test-invoke-method $(__AGY_BODY) $(__AGY_CLIENT_CERTIFICATE_ID) $(__AGY_HEADERS) $(__AGY_HTTP_METHOD__METHOD) $(__AGY_MULTI_VALUE_HEADERS) $(__AGY_PATH_WITH_QUERY_STRING) $(__AGY_RESOURCE_ID__METHOD) $(__AGY_REST_API_ID__METHOD) $(__AGY_STAGE_VARIABLES) --output json | tee $(AGY_METHOD_OUTPUTS_DIRPATH)test_method.json
	@$(WARN) 'Reformatting log output ...'; $(NORMAL)
	jq --monochrome-output -r '.log' $(AGY_METHOD_OUTPUTS_DIRPATH)test_method.json
	@$(WARN) 'Reformatting headers and body ...'; $(NORMAL)
	jq --monochrome-output -r '.headers' $(AGY_METHOD_OUTPUTS_DIRPATH)test_method.json
	jq --monochrome-output -r '.body' $(AGY_METHOD_OUTPUTS_DIRPATH)test_method.json

_agy_update_method:
	@$(INFO) '$(AWS_UI_LABEL)Updating method "$(AGY_METHOD_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-method $(__AGY_HTTP_METHOD__METHOD) $(__AGY_PATCH_OPERATIONS__METHOD) $(__AGY_RESOURCE_ID__METHOD) $(__AGY_REST_API_ID__METHOD)

_agy_view_methods:
	@$(INFO) '$(AWS_UI_LABEL)Viewing methods ...'; $(NORMAL)

_agy_view_methods_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing methods-set "$(AGY_METHODS_SET_NAME)" ...'; $(NORMAL)
