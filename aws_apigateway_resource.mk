_AWS_APIGATEWAY_RESOURCE_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_RESOURCE_ID?=
# AGY_RESOURCE_NAME?=
# AGY_RESOURCE_PARENT_ID?=
# AGY_RESOURCE_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_RESOURCE_PATH?= /
# AGY_RESOURCE_PATH_PART?= new-resource
# AGY_RESOURCE_RESTAPI_ID?= aeds9s0no6
# AGY_RESOURCE_RESTAPI_NAME?= WildRydes
# AGY_RESOURCES_SET_NAME?=

# Derived parameters
AGY_RESOURCE_NAME?= $(AGY_RESOURCE_RESTAPI_NAME):$(AGY_RESOURCE_PATH_PART)
AGY_RESOURCE_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_RESOURCE_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_EMBED__RESOURCE=
__AGY_RESOURCE_ID= $(if $(AGY_RESOURCE_ID), --resource-id $(AGY_RESOURCE_ID))
__AGY_PARENT_ID= $(if $(AGY_RESOURCE_PARENT_ID), --parent-id $(AGY_RESOURCE_PARENT_ID))
__AGY_PATCH_OPERATIONS__RESOURCE= $(if $(AGY_RESOURCE_PATCH_OPERATIONS), --patch-operations $(AGY_RESOURCE_PATCH_OPERATIONS))
__AGY_PATH_PART= $(if $(AGY_RESOURCE_PATH_PART), --path-part $(AGY_RESOURCE_PATH_PART))
__AGY_REST_API_ID__RESOURCE= $(if $(AGY_RESOURCE_RESTAPI_ID), --rest-api-id $(AGY_RESOURCE_RESTAPI_ID))

# UI parameters
AGY_UI_VIEW_RESOURCES_FIELDS?= .{Id:id,parentId:parentId,Path:path,pathPart:pathPart}
AGY_UI_VIEW_RESOURCES_SET_FIELDS?= $(AGY_UI_VIEW_RESOURCES_FIELDS)
AGY_UI_VIEW_RESOURCES_SET_SLICE?=

#--- MACROS
_agy_get_resource_id= $(call _agy_get_resource_id_P, $(AGY_RESOURCE_PATH))
_agy_get_resource_id_P= $(call _agy_get_resource_id_PR, $(1), $(AGY_RESOURCE_RESTAPI_ID))
_agy_get_resource_id_PR= $(shell $(AWS) apigateway get-resources --rest-api-id $(2) --query "items[?path=='$(strip $(1))'].id" --output text)

_agy_get_resource_path= $(call _agy_get_resource_id_I, $(AGY_RESOURCE_ID))
_agy_get_resource_path_I= $(call _agy_get_resource_id_IR, $(1), $(AGY_RESOURCE_RESTAPI_ID))
_agy_get_resource_path_IR= $(shell $(AWS) apigateway get-resource --resource-id $(1) --rest-api-id $(2) --query "items[$(1)].path" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::Resource ($(_AWS_APIGATEWAY_RESOURCE_MK_VERSION)) macros:'
	@echo '    _agy_get_resource_id_{|P|PR}            - Get the ID of a resource (Path,RestAPI)'
	@echo '    _agy_get_resource_path_{|I|IR}          - Get the path of a resource (Id,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::Resource ($(_AWS_APIGATEWAY_RESOURCE_MK_VERSION)) parameters:'
	@echo '    AGY_RESOURCE_ID=$(AGY_RESOURCE_ID)'
	@echo '    AGY_RESOURCE_NAME=$(AGY_RESOURCE_ID)'
	@echo '    AGY_RESOURCE_PARENT_ID=$(AGY_RESOURCE_PARENT_ID)'
	@echo '    AGY_RESOURCE_PATCH_OPERATIONS=$(AGY_RESOURCE_PATCH_OPERATIONS)'
	@echo '    AGY_RESOURCE_PATH=$(AGY_RESOURCE_PATH)'
	@echo '    AGY_RESOURCE_PATH_PART=$(AGY_RESOURCE_PATH_PART)'
	@echo '    AGY_RESOURCE_RESTAPI_ID=$(AGY_RESOURCE_RESTAPI_ID)'
	@echo '    AGY_RESOURCE_RESTAPI_NAME=$(AGY_RESOURCE_RESTAPI_NAME)'
	@echo '    AGY_RESOURCES_SET_NAME=$(AGY_RESOURCES_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::Resource ($(_AWS_APIGATEWAY_RESOURCE_MK_VERSION)) targets:'
	@echo '    _agy_create_resource                   - Create a new resource'
	@echo '    _agy_delete_resource                   - Delete an existing resource'
	@echo '    _agy_show_resource                     - Show everything related to a resource'
	@echo '    _agy_show_resource_description         - Show description of a resource'
	@echo '    _agy_update_resource                   - Update an resource'
	@echo '    _agy_view_resources                    - View resources'
	@echo '    _agy_view_resources_set                - View a set of resources'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_resource:
	@$(INFO) '$(AWS_UI_LABEL)Creating resource "$(AGY_RESOURCE_NAME)" in rest-api "$(AGY_RESOURCE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-resource $(__AGY_PARENT_ID) $(__AGY_PATH_PART) $(__AGY_REST_API_ID__RESOURCE)

_agy_delete_resource:
	@$(INFO) '$(AWS_UI_LABEL)Deleting resource "$(AGY_RESOURCE_NAME)" in rest-api "$(AGY_RESOURCE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-resource $(__AGY_RESOURCE_ID) $(__AGY_REST_API_ID__RESOURCE)

_agy_show_resource: _agy_show_resource_description

_agy_show_resource_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of resource "$(AGY_RESOURCE_NAME)" in rest-api "$(AGY_RESOURCE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-resource $(__AGY_EMBED__RESOURCE) $(__AGY_RESOURCE_ID) $(__AGY_REST_API_ID__RESOURCE)

_agy_update_resource:
	@$(INFO) '$(AWS_UI_LABEL)Updating resource "$(AGY_RESOURCE_NAME)" in rest-api "$(AGY_RESOURCE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-resource $(__AGY_PATCH_OPERATIONS__RESOURCE) $(__AGY_RESOURCE_ID) $(__AGY_REST_API_ID__RESOURCE)

_agy_view_resources:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all resources in rest-api "$(AGY_RESOURCE_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-resources $(__AGY_EMBED__RESOURCE) $(__AGY_REST_API_ID__RESOURCE) --query "items[]$(AGY_UI_VIEW_RESOURCES_FIELDS)"

_agy_view_resources_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing resources-set "$(AGY_RESOURCES_SET_NAME)" in rest-api "$(AGY_RESOURCE_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'resources are grouped based on the provided rest-api-id and slice'; $(NORMAL)
	$(AWS) apigateway get-resources $(__AGY_EMBED__RESOURCE) $(__AGY_REST_API_ID__RESOURCE) --query "items[$(AGY_UI_VIEW_RESOURCES_SET_SLICE)]$(AGY_UI_VIEW_RESOURCES_SET_FIELDS)"
