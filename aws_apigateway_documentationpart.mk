_AWS_APIGATEWAY_DOCUMENTATIONPART_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_DOCUMENTATIONPART_BODY?=
# AGY_DOCUMENTATIONPART_BODY_FILEPATH?=
# AGY_DOCUMENTATIONPART_ID?=
# AGY_DOCUMENTATIONPART_LOCATION?=
# AGY_DOCUMENTATIONPART_LOCATION_STATUS?=
# AGY_DOCUMENTATIONPART_MODE?=
# AGY_DOCUMENTATIONPART_NAME?=
# AGY_DOCUMENTATIONPART_NAME_QUERY?=
# AGY_DOCUMENTATIONPART_PATH?=
# AGY_DOCUMENTATIONPART_POSITION?=
# AGY_DOCUMENTATIONPART_PROPERTIES?=
# AGY_DOCUMENTATIONPART_RESTAPI_ID?= aeds9s0no6
# AGY_DOCUMENTATIONPART_RESTAPI_NAME?= WildRydes
# AGY_DOCUMENTATIONPART_TYPE?=
# AGY_DOCUMENTATIONPARTS_SET_NAME?=

# Derived parameters
AGY_DOCUMENTATIONPART_BODY?= $(if $(AGY_DOCUMENTATIONPART_BODY_FILEPATH),file://$(AGY_DOCUMENTATIONPART_BODY_FILEPATH))
# AGY_DOCUMENTATIONPART_NAME?= $(if $(AGY_DOCUMENTATIONPART_INDEX),documentation-part-$(AGY_DOCUMENTATIONPART_INDEX))
AGY_DOCUMENTATIONPART_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_DOCUMENTATIONPART_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_BODY__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_BODY), --body $(AGY_DOCUMENTATIONPART_BODY))
__AGY_DOCUMENTATION_PART_ID= $(if $(AGY_DOCUMENTATIONPART_ID), --documentation-part-id $(AGY_DOCUMENTATIONPART_ID))
__AGY_FAIL_ON_WARNINGS__DOCUMENTATIONPART= --no-fail-on-warnings
__AGY_LIMIT__DOCUMENTATIONPART=
__AGY_LOCATION= $(if $(AGY_DOCUMENTATIONPART_LOCATION), --location $(AGY_DOCUMENTATIONPART_LOCATION))
__AGY_LOCATION_STATUS= $(if $(AGY_DOCUMENTATIONPART_LOCATION_STATUS), --location $(AGY_DOCUMENTATIONPART_LOCATION_STATUS))
__AGY_MODE__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_MODE), --mode $(AGY_DOCUMENTATIONPART_MODE))
__AGY_NAME_QUERY__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_NAME_QUERY), --name-query $(AGY_DOCUMENTATIONPART_NAME_QUERY))
__AGY_PATCH_OPERATIONS__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_PATCH_OPERATIONS), --patch-operations $(AGY_DOCUMENTATIONPART_PATCH_OPERATIONS))
__AGY_PATH__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_PATH), --path $(AGY_DOCUMENTATIONPART_PATH))
__AGY_POSITION__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_POSITION), --position $(AGY_DOCUMENTATIONPART_POSITION))
__AGY_PROPERTIES= $(if $(AGY_DOCUMENTATIONPART_PROPERTIES), --properties $(AGY_DOCUMENTATIONPART_PROPERTIES))
__AGY_REST_API_ID__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_RESTAPI_ID), --rest-api-id $(AGY_DOCUMENTATIONPART_RESTAPI_ID))
__AGY_TYPE__DOCUMENTATIONPART= $(if $(AGY_DOCUMENTATIONPART_TYPE), --type $(AGY_DOCUMENTATIONPART_TYPE))

# UI parameters
AGY_UI_VIEW_DOCUMENTATIONPARTS_FIELDS?=
AGY_UI_VIEW_DOCUMENTATIONPARTS_SET_FIELDS?= $(AGY_UI_VIEW_DOCUMENTATIONPARTS_FIELDS)
AGY_UI_VIEW_DOCUMENTATIONPARTS_SET_SLICE?=

#--- MACROS
_agy_get_documentationpart_id= $(call _agy_get_documentationpart_id_I, $(AGY_DOCUMENTATIONPART_INDEX))
_agy_get_documentationpart_id_I= $(call _agy_get_documentationpart_id_IR, $(1), $(AGY_DOCUMENTATIONPART_RESTAPI_ID))
_agy_get_documentationpart_id_IR= $(shell $(AWS) apigateway get-documentation-parts --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::DocumentationPart ($(_AWS_APIGATEWAY_DOCUMENTATIONPART_MK_VERSION)) macros:'
	@echo '    _agy_get_documentationpart_id_{|N|NR}            - Get the ID of a documentation-part (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::DocumentationPart ($(_AWS_APIGATEWAY_DOCUMENTATIONPART_MK_VERSION)) parameters:'
	@echo '    AGY_DOCUMENTATIONPART_BODY=$(AGY_DOCUMENTATIONPART_BODY)'
	@echo '    AGY_DOCUMENTATIONPART_BODY_FILEPATH=$(AGY_DOCUMENTATIONPART_BODY_FILEPATH)'
	@echo '    AGY_DOCUMENTATIONPART_ID=$(AGY_DOCUMENTATIONPART_ID)'
	@echo '    AGY_DOCUMENTATIONPART_LOCATION=$(AGY_DOCUMENTATIONPART_LOCATION)'
	@echo '    AGY_DOCUMENTATIONPART_LOCATION_STATUS=$(AGY_DOCUMENTATIONPART_LOCATION_STATUS)'
	@echo '    AGY_DOCUMENTATIONPART_MODE=$(AGY_DOCUMENTATIONPART_MODE)'
	@echo '    AGY_DOCUMENTATIONPART_NAME=$(AGY_DOCUMENTATIONPART_NAME)'
	@echo '    AGY_DOCUMENTATIONPART_NAME_QUERY=$(AGY_DOCUMENTATIONPART_NAME_QUERY)'
	@echo '    AGY_DOCUMENTATIONPART_PATCH_OPERATIONS=$(AGY_DOCUMENTATIONPART_PATCH_OPERATIONS)'
	@echo '    AGY_DOCUMENTATIONPART_PATH=$(AGY_DOCUMENTATIONPART_PATH)'
	@echo '    AGY_DOCUMENTATIONPART_POSITION=$(AGY_DOCUMENTATIONPART_POSITION)'
	@echo '    AGY_DOCUMENTATIONPART_PROPERTIES=$(AGY_DOCUMENTATIONPART_PROPERTIES)'
	@echo '    AGY_DOCUMENTATIONPART_RESTAPI_ID=$(AGY_DOCUMENTATIONPART_RESTAPI_ID)'
	@echo '    AGY_DOCUMENTATIONPART_RESTAPI_NAME=$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)'
	@echo '    AGY_DOCUMENTATIONPART_TYPE=$(AGY_DOCUMENTATIONPART_TYPE)'
	@echo '    AGY_DOCUMENTATIONPARTS_SET_NAME=$(AGY_DOCUMENTATIONPARTS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::DocumentationPart ($(_AWS_APIGATEWAY_DOCUMENTATIONPART_MK_VERSION)) targets:'
	@echo '    _agy_create_documentationpart                   - Create a new documentation-part'
	@echo '    _agy_delete_documentationpart                   - Delete an existing documentation-part'
	@echo '    _agy_import_documentationpart                   - Import a new documentation-part'
	@echo '    _agy_show_documentationpart                     - Show everything related to an documentation-part'
	@echo '    _agy_show_documentationpart_description         - Show description of a documentation-part'
	@echo '    _agy_update_documentationpart                   - Update an documentation-part'
	@echo '    _agy_view_documentationparts                    - View documentation-parts'
	@echo '    _agy_view_documentationparts_set                - View a set of documentation-parts'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_documentationpart:
	@$(INFO) '$(AWS_UI_LABEL)Creating documentation-part "$(AGY_DOCUMENTATIONPART_NAME)" in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-documentation-part $(__AGY_LOCATION) $(__AGY_PROPERTIES) $(__AGY_REST_API_ID__DOCUMENTATIONPART)

_agy_delete_documentationpart:
	@$(INFO) '$(AWS_UI_LABEL)Deleting documentation-part "$(AGY_DOCUMENTATIONPART_NAME)" in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-documentation-part $(__AGY_DOCUMENTATION_PART_ID) $(__AGY_REST_API_ID__DOCUMENTATIONPART)

_agy_import_documentationpart:
	@$(INFO) '$(AWS_UI_LABEL)Importing documentation-part "$(AGY_DOCUMENTATIONPART_NAME)" in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway import-documentation-part $(__BODY__DOCUMENTATIONPART) $(__AGY_FAIL_ON_WARNINGS__DOCUMENTATIONPART) $(__AGY_MODE_DOCUMENTATIONPART) $(__AGY_REST_API_ID__DOCUMENTATIONPART)

_agy_show_documentationpart:: _agy_show_documentationpart_description

_agy_show_documentationpart_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of documentation-part "$(AGY_DOCUMENTATIONPART_NAME)" in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-documentation-part $(__AGY_DOCUMENTATION_PART_ID) $(__AGY_REST_API_ID__DOCUMENTATIONPART)

_agy_update_documentationpart:
	@$(INFO) '$(AWS_UI_LABEL)Updating documentation-part "$(AGY_DOCUMENTATIONPART_NAME)" in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-documentation-part $(__AGY_DOCUMENTATION_PART_ID) $(__AGY_PATCH_OPERATIONS__DOCUMENTATIONPART) $(__AGY_REST_API_ID__DOCUMENTATIONPART)

_agy_view_documentationparts:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all documentation-parts in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-documentation-parts $(_X__AGY_LIMIT__DOCUMENTATIONPART) $(_X__AGY_LOCATION_STATUS) $(_X__AGY_NAME_QUERY__DOCUMENTATIONPART) $(_X__AGY_PATH__DOCUMENTATIONPART) $(_X__AGY_POSITION__DOCUMENTATIONPART) $(__AGY_REST_API_ID__DOCUMENTATIONPART) $(_X__AGY_TYPE__DOCUMENTATIONPART) --query "items[]$(AGY_UI_VIEW_DOCUMENTATIONPARTS_FIELDS)"

_agy_view_documentationparts_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documentation-parts-set "$(AGY_DOCUMENTATIONPARTS_SET_NAME)" in rest-api "$(AGY_DOCUMENTATIONPART_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'documentation-parts are grouped based on the provided rest-api-id and slice'; $(NORMAL)
	$(AWS) apigateway get-documentation-parts $(__AGY_LIMIT__DOCUMENTATIONPART) $(__AGY_LOCATION_STATUS) $(__AGY_NAME_QUERY__DOCUMENTATIONPART) $(__AGY_PATH__DOCUMENTATIONPART) $(__AGY_POSITION__DOCUMENTATIONPART) $(__AGY_REST_API_ID__DOCUMENTATIONPART) $(__AGY_TYPE__DOCUMENTATIONPART) --query "items[$(AGY_UI_VIEW_DOCUMENTATIONPARTS_SET_SLICE)]$(AGY_UI_VIEW_DOCUMENTATIONPARTS_SET_FIELDS)"
