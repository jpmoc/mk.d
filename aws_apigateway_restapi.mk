_AWS_APIGATEWAY_RESTAPI_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_RESTAPI_API_VERSION?=
AGY_RESTAPI_APIKEY_SOURCE?= HEADER
# AGY_RESTAPI_BINARYMEDIA_TYPES?= "string" "string" ...
# AGY_RESTAPI_BODY?=
# AGY_RESTAPI_BODY_FILEPATH?= ./swagger.json
# AGY_RESTAPI_CLONEFROM?=
# AGY_RESTAPI_COMPRESSION_MINSIZE?=
# AGY_RESTAPI_DESCRIPTION?= "This is my api description"
AGY_RESTAPI_ENDPOINT_CONFIG?= types=EDGE
# AGY_RESTAPI_ID?=
# AGY_RESTAPI_INPUTS_DIRPATH?= ./in
# AGY_RESTAPI_NAME?= my-first-apiA
AGY_RESTAPI_PARAMETERS?= endpointConfigurationTypes=EDGE
# AGY_RESTAPI_POLICY?=
# AGY_RESTAPIS_SET_NAME?=

# Derived parameters
__AGY_RESTAPI_BODY?= $(if $(AGY_RESTAPI_BODY_FILEPATH),file://$(AGY_RESTAPI_BODY_FILEPATH))

# Option parameters
__AGY_API_KEY_SOURCE= $(if $(AGY_RESTAPI_APIKEY_SOURCE), --api-key-source $(AGY_RESTAPI_APIKEY_SOURCE))
__AGY_API_VERSION= $(if $(AGY_RESTAPI_API_VERSION), --api-version $(AGY_RESTAPI_API_VERSION))
__AGY_BINARY_MEDIA_TYPES= $(if $(AGY_RESTAPI_BINARYMEDIA_TYPES), --binary-media-types $(AGY_RESTAPI_BINARYMEDIA_TYPES))
__AGY_BODY__RESTAPI= $(if $(AGY_RESTAPI_BODY), --body $(AGY_RESTAPI_BODY))
__AGY_CLONE_FROM= $(if $(AGY_RESTAPI_CLONE_FROM), --clone-from $(AGY_RESTAPI_CLONE_FROM))
__AGY_DESCRIPTION__RESTAPI= $(if $(AGY_RESTAPI_DESCRIPTION), --description $(AGY_RESTAPI_DESCRIPTION))
__AGY_ENDPOINT_CONFIGURATION= $(if $(AGY_RESTAPI_ENDPOINT_CONFIG), --endpoint-configuration $(AGY_RESTAPI_ENDPOINT_CONFIG))
__AGY_FAIL_ON_WARNINGS__RESTAPI= --no-fail-on-warnings
__AGY_MINIMUM_COMPRESSION_SIZE= $(if $(AGY_RESTAPI_COMPRESSION_MINSIZE), --minimum-compression-size $(AGY_RESTAPI_COMPRESSION_MINSIZE))
__AGY_NAME__RESTAPI= $(if $(AGY_RESTAPI_NAME), --name $(AGY_RESTAPI_NAME))
__AGY_PARAMETERS= $(if $(AGY_RESTAPI_PARAMETERS), --parameters $(AGY_RESTAPI_PARAMETERS))
__AGY_PATCH_OPERATIONS__RESTAPI= $(if $(AGY_RESTAPI_PATCH_OPERATIONS), --patch-operations $(AGY_RESTAPI_PATCH_OPERATIONS))
__AGY_POLICY= $(if $(AGY_RESTAPI_POLICY), --policy $(AGY_RESTAPI_POLICY))
__AGY_REST_API_ID= $(if $(AGY_RESTAPI_ID), --rest-api-id $(AGY_RESTAPI_ID))

# UI parameters
AGY_UI_VIEW_RESTAPIS_FIELDS?= .{apiKeySource:apiKeySource,createdDate:createdDate,description:description,Id:id,Name:name,endpointConfiguration: endpointConfiguration.types[] | join(' ',@)}
AGY_UI_VIEW_RESTAPIS_SET_FIELDS?= $(AGY_UI_VIEW_RESTAPIS_FIELDS)
AGY_UI_VIEW_RESTAPIS_SET_SLICE?=

#--- MACROS
_agy_get_restapi_id= $(call _agy_get_restapi_id_N, $(AGY_RESTAPI_NAME))
_agy_get_restapi_id_N= $(shell $(AWS) apigateway get-rest-apis --query "items[?name=='$(strip $(1))'].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::RestApi ($(_AWS_APIGATEWAY_RESTAPI_MK_VERSION)) macros:'
	@echo '    _agy_get_restapi_id_{|N}               - Get the ID of a rest-API (Name)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::RestApi ($(_AWS_APIGATEWAY_RESTAPI_MK_VERSION)) parameters:'
	@echo '    AGY_RESTAPI_API_VERSION=$(AGY_RESTAPI_API_VERSION)'
	@echo '    AGY_RESTAPI_APIKEY_SOURCE=$(AGY_RESTAPI_APIKEY_SOURCE)'
	@echo '    AGY_RESTAPI_BINARYMEDIA_TYPES=$(AGY_RESTAPI_BINARYMEDIA_TYPES)'
	@echo '    AGY_RESTAPI_BODY=$(AGY_RESTAPI_BODY)'
	@echo '    AGY_RESTAPI_BODY_FILEPATH=$(AGY_RESTAPI_BODY_FILEPATH)'
	@echo '    AGY_RESTAPI_CLONE_FROM=$(AGY_RESTAPI_CLONE_FROM)'
	@echo '    AGY_RESTAPI_COMPRESION_MINSIZE=$(AGY_RESTAPI_COMPRESION_MINSIZE)'
	@echo '    AGY_RESTAPI_DESCRIPTION=$(AGY_RESTAPI_DESCRIPTION)'
	@echo '    AGY_RESTAPI_ENDPOINT_CONFIG=$(AGY_RESTAPI_ENDPOINT_CONFIG)'
	@echo '    AGY_RESTAPI_ID=$(AGY_RESTAPI_ID)'
	@echo '    AGY_RESTAPI_INPUTS_DIRPATH=$(AGY_RESTAPI_INPUTS_DIRPATH)'
	@echo '    AGY_RESTAPI_NAME=$(AGY_RESTAPI_NAME)'
	@echo '    AGY_RESTAPI_PARAMETERS=$(AGY_RESTAPI_PARAMETERS)'
	@echo '    AGY_RESTAPI_POLICY=$(AGY_RESTAPI_POLICY)'
	@echo '    AGY_RESTAPIS_SET_NAME=$(AGY_RESTAPIS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::RestApi ($(_AWS_APIGATEWAY_RESTAPI_MK_VERSION)) targets:'
	@echo '    _agy_create_restapi                   - Create a new rest-API'
	@echo '    _agy_delete_restapi                   - Delete an existing rest-API'
	@echo '    _agy_import_restapi                   - Import rest-API from a swagger file'
	@echo '    _agy_show_restapi                     - Show everything related to an rest-API'
	@echo '    _agy_show_restapi_description         - Show description of a rest-API'
	@echo '    _agy_update_restapi                   - Update an rest-API'
	@echo '    _agy_view_restapis                    - View rest-APIs'
	@echo '    _agy_view_restapis_set                - View a set of rest-APIs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_restapi:
	@$(INFO) '$(AWS_UI_LABEL)Creating rest-api "$(AGY_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-rest-api $(__AGY_API_KEY_SOURCE) $(__AGY_API_VERSION) $(__AGY_BINARY_MEDIA_TYPES) $(__AGY_CLONE_FROM) $(__AGY_DESCRIPTION__RESTAPI) $(__AGY_ENDPOINT_CONFIGURATION) $(__AGY_MINIMUM_COMPRESSION_SIZE) $(__AGY_NAME__RESTAPI) $(__AGY_POLICY)

_agy_delete_restapi:
	@$(INFO) '$(AWS_UI_LABEL)Deleting rest-api "$(AGY_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-rest-api $(__AGY_REST_API_ID)

_agy_import_restapi:
	@$(INFO) '$(AWS_UI_LABEL)Importing a new rest-api "$(AGY_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway import-rest-api $(__AGY_BODY__RESTAPI) $(__AGY_FAIL_ON_WARNINGS__RESTAPI) $(__AGY_PARAMETERS)

_agy_show_restapi:: _agy_show_restapi_description

_agy_show_restapi_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of rest-api "$(AGY_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-rest-api $(__AGY_REST_API_ID)

_agy_update_restapi:
	@$(INFO) '$(AWS_UI_LABEL)Updating rest-api "$(AGY_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-rest-api $(__AGY_REST_API_ID) $(__AGY_PATCH_OPERATIONS__RESTAPI)

_agy_view_restapis:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all rest-api ...'; $(NORMAL)
	$(AWS) apigateway get-rest-apis --query "items[]$(AGY_UI_VIEW_RESTAPIS_FIELDS)"

_agy_view_restapis_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing rest-api-set "$(AGY_RESTAPIS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Rest-APIs are grouped based on the provided slice'; $(NORMAL)
	$(AWS) apigateway get-rest-apis --query "items[$(AGY_UI_VIEW_RESTAPIS_SET_SLICE)]$(AGY_UI_VIEW_RESTAPIS_SET_FIELDS)"
