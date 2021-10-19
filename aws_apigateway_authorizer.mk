_AWS_APIGATEWAY_AUTHORIZER_MK_VERSION= $(_AWS_APIGATEWAY_MK_VERSION)

# AGY_AUTHORIZER_AUTH_TYPE?= cognito_user_pools
# AGY_AUTHORIZER_CREDENTIALS?=
# AGY_AUTHORIZER_ID?= xigskx
# AGY_AUTHORIZER_IDENTITY_SOURCE?= method.request.header.Authorization
# AGY_AUTHORIZER_IDENTITY_VALIDATIONEXPRESSION?=
# AGY_AUTHORIZER_NAME?= WildRydes
# AGY_AUTHORIZER_PATCH_OPERATIONS?=
# AGY_AUTHORIZER_PROVIDER_ARNS?= arn:aws:cognito-idp:us-east-1:123456789012:userpool/us-east-1_TtaBMscKF ...
# AGY_AUTHORIZER_RESTAPI_ID?=
# AGY_AUTHORIZER_RESULT_TTL?=
# AGY_AUTHORIZER_TYPE?= COGNITO_USER_POOLS
# AGY_AUTHORIZER_URI?=
# AGY_AUTHORIZERS_SET_NAME?=

# Derived parameters
AGY_AUTHORIZER_RESTAPI_ID?= $(AGY_RESTAPI_ID)

# Option parameters
__AGY_AUTH_TYPE= $(if $(AGY_AUTHORIZER_AUTH_TYPE), --auth-type $(AGY_AUTHORIZER_AUTH_TYPE))
__AGY_AUTHORIZER_CREDENTIALS= $(if $(AGY_AUTHORIZER_CREDENTIALS), --authorizer-credentials $(AGY_AUTHORIZER_CREDENTIALS))
__AGY_AUTHORIZER_RESULT_TTL_IN_SECONDS= $(if $(AGY_AUTHORIZER_RESULT_TTL), --authorizer-result-ttl-in-seconds $(AGY_AUTHORIZER_RESULT_TTL))
__AGY_AUTHORIZER_URI= $(if $(AGY_AUTHORIZER_URI), --authorizer-uri $(AGY_AUTHORIZER_CREDENTIALS))
__AGY_AUTHORIZER_ID= $(if $(AGY_AUTHORIZER_ID), --authorizer-id $(AGY_AUTHORIZER_ID))
__AGY_IDENTIFY_SOURCE= $(if $(AGY_AUTHORIZER_IDENTITY_SOURCE), --identity-source $(AGY_AUTHORIZER_IDENTITY_SOURCE))
__AGY_IDENTIFY_VALIDATION_EXPRESSION= $(if $(AGY_AUTHORIZER_IDENTITY_VALIDATIONEXPRESSION), --identity-validation-expression $(AGY_AUTHORIZER_IDENTITY_VALIDATIONEXPRESSION))
__AGY_NAME__AUTHORIZER= $(if $(AGY_AUTHORIZER_NAME), --name $(AGY_AUTHORIZER_NAME))
__AGY_PATCH_OPERATIONS__AUTHORIZER= $(if $(AGY_AUTHORIZER_PATCH_OPERATIONS), --patch-operations $(AGY_AUTHORIZER_PATCH_OPERATIONS))
__AGY_PROVIDER_ARNS= $(if $(AGY_AUTHORIZER_PROVIDER_ARNS), --provider-arns $(AGY_AUTHORIZER_PROVIDER_ARNS))
__AGY_REST_API_ID__AUTHORIZER= $(if $(AGY_AUTHORIZER_RESTAPI_ID), --rest-api-id $(AGY_AUTHORIZER_RESTAPI_ID))
__AGY_TYPE__AUTHORIZER= $(if $(AGY_AUTHORIZER_TYPE), --type $(AGY_AUTHORIZER_TYPE))

# UI parameters
AGY_UI_VIEW_AUTHORIZERS_FIELDS?= .{authType:authType,Id:id,identitySource:identitySource,Name:name,type:type}
AGY_UI_VIEW_AUTHORIZERS_SET_FIELDS?= $(AGY_UI_VIEW_AUTHORIZERS_FIELDS)
AGY_UI_VIEW_AUTHORIZERS_SET_SLICE?=

#--- MACROS
_agy_get_authorizer_id= $(call _agy_get_authorizer_id_N, $(AGY_AUTHORIZER_NAME))
_agy_get_authorizer_id_N= $(call _agy_get_authorizer_id_NR, $(1), $(AGY_AUTHORIZER_RESTAPI_ID))
_agy_get_authorizer_id_NR= $(shell $(AWS) apigateway get-authorizers --rest-api-id $(2) --query "items[?name=='$(strip $(1))'].id" --output text)

#----------------------------------------------------------------------
# USAGE
#
_agy_view_framework_macros ::
	@echo 'AWS::ApiGatewaY::ApiKey ($(_AWS_APIGATEWAY_AUTHORIZER_MK_VERSION)) macros:'
	@echo '    _agy_get_authorizer_id_{|N|NR}            - Get the ID pf an authorizer (Name,RestAPI)'
	@echo

_agy_view_framework_parameters ::
	@echo 'AWS::ApiGatewaY::ApiKey ($(_AWS_APIGATEWAY_AUTHORIZER_MK_VERSION)) parameters:'
	@echo '    AGY_AUTHORIZER_AUTH_TYPE=$(AGY_AUTHORIZER_AUTH_TYPE)'
	@echo '    AGY_AUTHORIZER_CREDENTIALS=$(AGY_AUTHORIZER_CREDENTIALS)'
	@echo '    AGY_AUTHORIZER_ID=$(AGY_AUTHORIZER_ID)'
	@echo '    AGY_AUTHORIZER_IDENTITY_SOURCE=$(AGY_AUTHORIZER_IDENTITY_SOURCE)'
	@echo '    AGY_AUTHORIZER_IDENTITY_VALIDATIONEXPRESSION=$(AGY_AUTHORIZER_IDENTITY_VALIDATIONEXPRESSION)'
	@echo '    AGY_AUTHORIZER_NAME=$(AGY_AUTHORIZER_NAME)'
	@echo '    AGY_AUTHORIZER_PATCH_OPERATIONS=$(AGY_AUTHORIZER_PATCH_OPERATIONS)'
	@echo '    AGY_AUTHORIZER_PROVIDER_ARNS=$(AGY_AUTHORIZER_PROVIDER_ARNS)'
	@echo '    AGY_AUTHORIZER_RESTAPI_ID=$(AGY_AUTHORIZER_RESTAPI_ID)'
	@echo '    AGY_AUTHORIZER_RESULT_TTL=$(AGY_AUTHORIZER_RESULT_TTL)'
	@echo '    AGY_AUTHORIZER_TYPE=$(AGY_AUTHORIZER_TYPE)'
	@echo '    AGY_AUTHORIZER_URI=$(AGY_AUTHORIZER_URI)'
	@echo '    AGY_AUTHORIZERS_SET_NAME=$(AGY_AUTHORIZERS_SET_NAME)'
	@echo

_agy_view_framework_targets ::
	@echo 'AWS::ApiGatewaY::ApiKey ($(_AWS_APIGATEWAY_AUTHORIZER_MK_VERSION)) targets:'
	@echo '    _agy_create_authorizer                   - Create a new authorizer'
	@echo '    _agy_delete_authorizer                   - Delete an existing authorizer'
	@echo '    _agy_show_authorizer                     - Show everything related to an authorizer'
	@echo '    _agy_show_authorizer_description         - Show description of an authorizer'
	@echo '    _agy_update_authorizer                   - Update an authorizer'
	@echo '    _agy_view_authorizers                    - View authorizers'
	@echo '    _agy_view_authorizers_set                - View a set of authorizers'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_agy_create_authorizer:
	@$(INFO) '$(AWS_UI_LABEL)Creating authorizer "$(AGY_AUTHORIZER_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway create-authorizer $(__AGY_AUTH_TYPE) $(__AGY_AUTHORIZER_CREDENTIALS) $(__AGY_AUTHORIZER_RESULT_TTL_IN_SECONDS) $(__AGY_AUTHORIZER_URI) $(__AGY_IDENTITY_SOURCE) $(__AGY_IDENTITY_VALIDATION_EXPRESSION) $(__AGY_NAME__AUTHORIZER) $(__AGY_PROVIDER_ARNS) $(__AGY_REST_API_ID__AUTHORIZER) $(__AGY_TYPE__AUTHORIZER)

_agy_delete_authorizer:
	@$(INFO) '$(AWS_UI_LABEL)Deleting authorizer "$(AGY_AUTHORIZER_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway delete-authorizer $(__AGY_AUTHORIZER_ID) $(__AGY_REST_API_ID)

_agy_show_authorizer: _agy_show_authorizer_description

_agy_show_authorizer_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing authorizer "$(AGY_AUTHORIZER_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway get-authorizer $(__AGY_AUTHORIZER_ID) $(__AGY_REST_API_ID__AUTHORIZER)

_agy_update_authorizer:
	@$(INFO) '$(AWS_UI_LABEL)Updating authorizer "$(AGY_AUTHORIZER_NAME)" ...'; $(NORMAL)
	$(AWS) apigateway update-authorizer $(__AGY_AUTHORIZER_ID) $(__AGY_PATCH_OPERATIONS__AUTHORIZER) $(__AGY_REST_API_ID__AUTHORIZER)

_agy_view_authorizers:
	@$(INFO) '$(AWS_UI_LABEL)Viewing all authorizers ...'; $(NORMAL)
	$(AWS) apigateway get-authorizers $(__AGY_REST_API_ID__AUTHORIZER) --query "items[]$(AGY_UI_VIEW_AUTHORIZERS_FIELDS)"

_agy_view_authorizers_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing authorizers-set "$(AGY_AUTHORIZERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Authorizers are grouped based on the provided rest-api and slice'; $(NORMAL)
	$(AWS) apigateway get-authorizers $(__AGY_REST_API_ID) --query "items[$(AGY_UI_VIEW_AUTHORIZERS_SET_SLICE)]$(AGY_UI_VIEW_AUTHORIZERS_SET_FIELDS)"
