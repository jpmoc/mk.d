_AWS_APIGATEWAY_DOCUMENTATIONVERSION_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_DOCUMENTATIONVERSION_DESCRIPTION?=
# AGY_DOCUMENTATIONVERSION_NAME?= V1.0.3
# AGY_DOCUMENTATIONVERSION_RESTAPI_ID?= aeds9s0no6
# AGY_DOCUMENTATIONVERSION_RESTAPI_NAME?= WildRydes
# AGY_DOCUMENTATIONVERSION_STAGE_NAME?=
# AGY_DOCUMENTATIONVERSIONS_SET_NAME?=

# Derived parameters
AGY_DOCUMENTATIONVERSION_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_DOCUMENTATIONVERSION_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_DESCRIPTION_DOCUMENTATIONVERSION= $(if $(AGY_DOCUMENTATIONVERSION_DESCRIPTION), --description $(AGY_DOCUMENTATIONVERSION_DESCRIPTION))
__AGY_DOCUMENTATION_VERSION= $(if $(AGY_DOCUMENTATIONVERSION_NAME), --documentation-version $(AGY_DOCUMENTATIONVERSION_NAME))
__AGY_LIMIT__DOCUMENTATIONVERSION=
__AGY_PATCH_OPERATIONS__DOCUMENTATIONVERSION= $(if $(AGY_DOCUMENTATIONVERSION_PATCH_OPERATIONS), --patch-operations $(AGY_DOCUMENTATIONVERSION_PATCH_OPERATIONS))
__AGY_POSITION__DOCUMENTATIONVERSION=
__AGY_REST_API_ID__DOCUMENTATIONVERSION= $(if $(AGY_DOCUMENTATIONVERSION_RESTAPI_ID), --rest-api-id $(AGY_DOCUMENTATIONVERSION_RESTAPI_ID))
__AGY_STAGE_NAME__DOCUMENTATIONVERSION= $(if $(AGY_DOCUMENTATIONVERSION_STAGE_NAME), --stage-name $(AGY_DOCUMENTATIONVERSION_STAGE_NAME))

# UI parameters
AGY_UI_VIEW_DOCUMENTATIONVERSIONS_FIELDS?=
AGY_UI_VIEW_DOCUMENTATIONVERSIONS_SET_FIELDS?= $(AGY_UI_VIEW_DOCUMENTATIONVERSIONS_FIELDS)
AGY_UI_VIEW_DOCUMENTATIONVERSIONS_SET_SLICE?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::DocumentationVersion ($(_AWS_APIGATEWAY_DOCUMENTATIONVERSION_MK_VERSION)) macros:'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::DocumentationVersion ($(_AWS_APIGATEWAY_DOCUMENTATIONVERSION_MK_VERSION)) parameters:'
	@echo '    AGY_DOCUMENTATIONVERSION_NAME=$(AGY_DOCUMENTATIONVERSION_NAME)'
	@echo '    AGY_DOCUMENTATIONVERSION_PATCH_OPERATIONS=$(AGY_DOCUMENTATIONVERSION_PATCH_OPERATIONS)'
	@echo '    AGY_DOCUMENTATIONVERSION_RESTAPI_ID=$(AGY_DOCUMENTATIONVERSION_RESTAPI_ID)'
	@echo '    AGY_DOCUMENTATIONVERSION_RESTAPI_NAME=$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)'
	@echo '    AGY_DOCUMENTATIONVERSION_STAGE_NAME=$(AGY_DOCUMENTATIONVERSION_STAGE_NAME)'
	@echo '    AGY_DOCUMENTATIONVERSIONS_SET_NAME=$(AGY_DOCUMENTATIONVERSIONS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::DocumentationVersion ($(_AWS_APIGATEWAY_DOCUMENTATIONVERSION_MK_VERSION)) targets:'
	@echo '    _agy_create_documentationversion                   - Create a new documentation-version'
	@echo '    _agy_delete_documentationversion                   - Delete an existing documentation-version'
	@echo '    _agy_show_documentationversion                     - Show everything related to an documentation-version'
	@echo '    _agy_show_documentationversion_description         - Show description of a documentation-version'
	@echo '    _agy_update_documentationversion                   - Update an documentation-version'
	@echo '    _agy_view_documentationversions                    - View documentation-versions'
	@echo '    _agy_view_documentationversions_set                - View a set of documentation-versions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_documentationversion:
	@$(INFO) '$(AWS_UI_LABEL)Creating documentation-version "$(AGY_DOCUMENTATIONVERSION_NAME)" in rest-api "$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-documentation-version $(__AGY_DESCRIPTION__DOCUMENTATIONVERSION) $(__AGY_DOCUMENTATION_VERSION) $(__AGY_REST_API_ID__DOCUMENTATIONVERSION) $(__AGY_STAGE_NAME__DOCUMENTATIONVERSION)

_agy_delete_documentationversion:
	@$(INFO) '$(AWS_UI_LABEL)Deleting documentation-version "$(AGY_DOCUMENTATIONVERSION_NAME)" in rest-api "$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-documentation-version $(__AGY_DOCUMENTATION_VERSION) $(__AGY_REST_API_ID__DOCUMENTATIONVERSION)

_agy_show_documentationversion:: _agy_show_documentationversion_description

_agy_show_documentationversion_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing documentation-version "$(AGY_DOCUMENTATIONVERSION_NAME)" in rest-api "$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-documentation-version $(__AGY_DOCUMENTATION_VERSION) $(__AGY_REST_API_ID__DOCUMENTATIONVERSION)

_agy_update_documentationversion:
	@$(INFO) '$(AWS_UI_LABEL)Updating documentation-version "$(AGY_DOCUMENTATIONVERSION_NAME)" in rest-api "$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-documentation-version $(__AGY_DOCUMENTATION_VERSION) $(__AGY_PATCH_OPERATIONS__DOCUMENTATIONVERSION) $(__AGY_REST_API_ID__DOCUMENTATIONVERSION)

_agy_view_documentationversions:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all documentation-versions in rest-api "$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-documentation-versions $(_X__AGY_LIMIT__DOCUMENTATIONVERSION) $(_X__AGY_POSITION__DOCUMENTATIONVERSION) $(__AGY_REST_API_ID__DOCUMENTATIONVERSION) --query "items[]$(AGY_UI_VIEW_DOCUMENTATIONVERSIONS_FIELDS)"

_agy_view_documentationversions_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing documentation-versions-set "$(AGY_DOCUMENTATIONVERSIONS_SET_NAME)" in rest-api "$(AGY_DOCUMENTATIONVERSION_RESTAPI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'documentation-versions are grouped based on the provided rest-api-id and slice'; $(NORMAL)
	$(AWS) apigateway get-documentation-versions $(__AGY_LIMIT__DOCUMENTATIONVERSION) $(__AGY_POSITION__DOCUMENTATIONVERSION) $(__AGY_REST_API_ID__DOCUMENTATIONVERSION) --query "items[$(AGY_UI_VIEW_DOCUMENTATIONVERSIONS_SET_SLICE)]$(AGY_UI_VIEW_DOCUMENTATIONVERSIONS_SET_FIELDS)"
