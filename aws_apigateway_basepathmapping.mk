_AWS_APIGATEWAY_BASEPATHMAPPING_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_BASEPATHMAPPING_BASE_PATH?=
# AGY_BASEPATHMAPPING_DOMAIN_NAME?=
# AGY_BASEPATHMAPPING_ID?=
# AGY_BASEPATHMAPPING_NAME?=
# AGY_BASEPATHMAPPING_PATCH_OPERATIONS?= op=string,path=string,value=string,from=string ...
# AGY_BASEPATHMAPPING_RESTAPI_ID?= aeds9s0no6
# AGY_BASEPATHMAPPING_RESTAPI_NAME?= WildRydes
# AGY_BASEPATHMAPPING_STAGE?=
# AGY_BASEPATHMAPPINGS_SET_NAME?=

# Derived parameters
AGY_BASEPATHMAPPING_DOMAIN_NAME?= $(AGY_DOMAIN_NAME)
AGY_BASEPATHMAPPING_NAME?= $(if $(AGY_BASEPATHMAPPING_BASE_PATH),$(AGY_BASEPATHMAPPING_DOMAIN_NAME):$(AGY_BASEPATHMAPPING_BASE_PATH))
AGY_BASEPATHMAPPING_RESTAPI_ID?= $(AGY_RESTAPI_ID)
AGY_BASEPATHMAPPING_RESTAPI_NAME?= $(AGY_RESTAPI_NAME)

# Option parameters
__AGY_BASE_PATH= $(if $(AGY_BASEPATHMAPPING_BASE_PATH), --base-path $(AGY_BASEPATHMAPPING_BASE_PATH))
__AGY_DOMAIN_NAME__BASEPATHMAPPING= $(if $(AGY_BASEPATHMAPPING_DOMAIN_NAME), --domain-name $(AGY_BASEPATHMAPPING_DOMAIN_NAME))
__AGY_BASEPATHMAPPING_ID= $(if $(AGY_BASEPATHMAPPING_ID), --basepathmapping-id $(AGY_BASEPATHMAPPING_ID))
__AGY_PATCH_OPERATIONS__BASEPATHMAPPING= $(if $(AGY_BASEPATHMAPPING_PATCH_OPERATIONS), --patch-operations $(AGY_BASEPATHMAPPING_PATCH_OPERATIONS))
__AGY_REST_API_ID__BASEPATHMAPPING= $(if $(AGY_BASEPATHMAPPING_RESTAPI_ID), --rest-api-id $(AGY_BASEPATHMAPPING_RESTAPI_ID))
__AGY_STAGE__BASEPATHMAPPING= $(if $(AGY_BASEPATHMAPPING_STAGE), --stage $(AGY_BASEPATHMAPPING_STAGE))

# UI parameters
AGY_UI_VIEW_BASEPATHMAPPINGS_FIELDS?=
AGY_UI_VIEW_BASEPATHMAPPINGS_SET_FIELDS?= $(AGY_UI_VIEW_BASEPATHMAPPINGS_FIELDS)
AGY_UI_VIEW_BASEPATHMAPPINGS_SET_SLICE?=

#--- MACROS
_agy_get_basepathmapping_id= $(call _agy_get_basepathmapping_id_I, $(AGY_BASEPATHMAPPING_INDEX))
_agy_get_basepathmapping_id_I= $(call _agy_get_basepathmapping_id_IR, $(1), $(AGY_BASEPATHMAPPING_RESTAPI_ID))
_agy_get_basepathmapping_id_IR= $(shell $(AWS) apigateway get-basepathmappings --rest-api-id $(2) --query "items[$(1)].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::BasePathMapping ($(_AWS_APIGATEWAY_BASEPATHMAPPING_MK_VERSION)) macros:'
	@echo '    _agy_get_basepathmapping_id_{|N|NR}            - Get the ID of a basepathmapping (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::BasePathMapping ($(_AWS_APIGATEWAY_BASEPATHMAPPING_MK_VERSION)) parameters:'
	@echo '    AGY_BASEPATHMAPPING_BASE_PATH=$(AGY_BASEPATHMAPPING_BASE_PATH)'
	@echo '    AGY_BASEPATHMAPPING_DOMAIN_NAME=$(AGY_BASEPATHMAPPING_DOMAIN_NAME)'
	@echo '    AGY_BASEPATHMAPPING_ID=$(AGY_BASEPATHMAPPING_ID)'
	@echo '    AGY_BASEPATHMAPPING_NAME=$(AGY_BASEPATHMAPPING_NAME)'
	@echo '    AGY_BASEPATHMAPPING_PATCH_OPERATIONS=$(AGY_BASEPATHMAPPING_PATCH_OPERATIONS)'
	@echo '    AGY_BASEPATHMAPPING_RESTAPI_ID=$(AGY_BASEPATHMAPPING_RESTAPI_ID)'
	@echo '    AGY_BASEPATHMAPPING_RESTAPI_NAME=$(AGY_BASEPATHMAPPING_RESTAPI_NAME)'
	@echo '    AGY_BASEPATHMAPPING_STAGE=$(AGY_BASEPATHMAPPING_STAGE)'
	@echo '    AGY_BASEPATHMAPPINGS_SET_NAME=$(AGY_BASEPATHMAPPINGS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::BasePathMapping ($(_AWS_APIGATEWAY_BASEPATHMAPPING_MK_VERSION)) targets:'
	@echo '    _agy_create_basepathmapping                   - Create a new basepathmapping'
	@echo '    _agy_delete_basepathmapping                   - Delete an existing basepathmapping'
	@echo '    _agy_show_basepathmapping                     - Show everything related to an basepathmapping'
	@echo '    _agy_show_basepathmapping_description         - Show description an basepathmapping'
	@echo '    _agy_update_basepathmapping                   - Update an basepathmapping'
	@echo '    _agy_view_basepathmappings                    - View basepathmappings'
	@echo '    _agy_view_basepathmappings_set                - View a set of basepathmappings'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_basepathmapping:
	@$(INFO) '$(AWS_UI_LABEL)Creating base-path-mapping "$(AGY_BASEPATHMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-base-path-mapping $(__AGY_BASE_PATH) $(__AGY_DOMAIN_NAME__BASEPATHMAPPING) $(__AGY_REST_API_ID__BASEPATHMAPPING) $(__AGY_STAGE)

_agy_delete_basepathmapping:
	@$(INFO) '$(AWS_UI_LABEL)Deleting base-path-mapping "$(AGY_BASEPATHMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-base-path-mapping $(__AGY_BASE_PATH) $(__AGY_DOMAIN_NAME__BASEPATHMAPPING)

_agy_show_basepathmapping:: _agy_show_basepathmapping_description

_apy_shoe_basepathmapping_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing base-path-mapping "$(AGY_BASEPATHMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-base-path-mapping $(__AGY_BASEPATHMAPPING_ID) $(__AGY_EMBED__BASEPATHMAPPING) $(__AGY_REST_API_ID__BASEPATHMAPPING)

_agy_update_basepathmapping:
	@$(INFO) '$(AWS_UI_LABEL)Updating base-path-mapping "$(AGY_BASEPATHMAPPING_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-base-path-mapping $(__AGY_BASEPATHMAPPING_ID) $(__AGY_PATCH_OPERATIONS__BASEPATHMAPPING) $(__AGY_REST_API_ID__BASEPATHMAPPING)

_agy_view_basepathmappings:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all base-path-mappings in domain "$(AGY_BASEPATHMAPPING_DOMAIN_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-base-path-mappings $(__AGY_DOMAIN_NAME__BASEPATHMAPPING) --query "items[]$(AGY_UI_VIEW_BASEPATHMAPPINGS_FIELDS)"

_agy_view_basepathmappings_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing base-path-mappings-set "$(AGY_BASEPATHMAPPINGS_SET_NAME)" in domain "$(AGY_BASEPATHMAPPING_DOMAIN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'basepathmappings are grouped based on the provided domain and slice'; $(NORMAL)
	$(AWS) apigateway get-base-path-mappings $(__AGY_DOMAIN_NAME__BASEPATHMAPPING) --query "items[$(AGY_UI_VIEW_BASEPATHMAPPINGS_SET_SLICE)]$(AGY_UI_VIEW_BASEPATHMAPPINGS_SET_FIELDS)"
