_AWS_APPSYNC_RESOLVER_MK_VERSION= $(_AWS_APPSYNC_MK_VERSION)

# ASC_RESOLVER_GRAPHQLAPI_ID?= 6hd24t42afh4ngzfuwjw2bhkfy
# ASC_RESOLVER_NAME?= my-resolver
# ASC_RESOLVER_FIELD_NAME?=
# ASC_RESOLVER_TYPE_NAME?=

# Derived parameters
ASC_RESOLVER_GRAPHQLAPI_ID?= $(ASC_GRAPHQLAPI_ID)

# Option parameters
__ASC_API_ID__RESOLVER= $(if $(ASC_RESOLVER_GRAPHQLAPI_ID), --api-id $(ASC_RESOLVER_GRAPHQLAPI_ID))
__ASC_DATA_SOURCE_NAME=
__ASC_FIELD_NAME=
__ASC_REQUEST_MAPPING_TEMPLATE=
__ASC_RESPONSE_MAPPING_TEMPLATE=
__ASC_TYPE_NAME__RESOLVER= $(if $(ASC_RESOLVER_TYPE_NAME), --type-name $(ASC_RESOLVER_TYPE_NAME))

# UI parameters
ASC_UI_VIEW_RESOLVERS_FIELDS?=
ASC_UI_VIEW_RESOLVERS_SET_FIELDS?= $(ASC_UI_VIEW_RESOLVERS_FIELDS)
ASC_UI_VIEW_RESOLVERS_SET_SLICE?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asc_view_framework_macros ::
	@echo 'AWS::AppSynC::Resolver ($(_AWS_APPSYNC_RESOLVER_MK_VERSION)) macros:'
	@echo

_asc_view_framework_parameters ::
	@echo 'AWS::AppSynC::Resolver ($(_AWS_APPSYNC_RESOLVER_MK_VERSION)) parameters:'
	@echo '    ASC_RESOLVER_GRAPHQLAPI_ID=$(ASC_RESOLVER_GRAPHQLAPI_ID)'
	@echo '    ASC_RESOLVER_FIELD_NAME=$(ASC_RESOLVER_FIELD_NAME)'
	@echo '    ASC_RESOLVER_NAME=$(ASC_RESOLVER_NAME)'
	@echo '    ASC_RESOLVER_TYPE_NAME=$(ASC_RESOLVER_TYPE_NAME)'
	@echo '    ASC_RESOLVERS_SET_NAME=$(ASC_RESOLVERS_SET_NAME)'
	@echo

_asc_view_framework_targets ::
	@echo 'AWS::AppSynC::Resolver ($(_AWS_APPSYNC_RESOLVER_MK_VERSION)) targets:'
	@echo '    _asc_create_resolver                 - Create a new resolver'
	@echo '    _asc_delete_resolver                 - Delete an existing resolver'
	@echo '    _asc_show_resolver                   - Show everything related to an resolver'
	@echo '    _asc_update_resolver                 - Update an resolver'
	@echo '    _asc_view_resolvers                  - View existing resolvers'
	@echo '    _asc_view_resolvers_set              - View a set of resolvers'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asc_create_resolver:
	@$(INFO) '$(AWS_UI_LABEL)Creating resolver "$(ASC_RESOLVER_NAME)" ...'; $(NORMAL)
	$(AWS) appsync create-resolver $(__ASC_API_ID__RESOLVER) $(__ASC_DATA_SOURCE_NAME) $(__ASC_FIELD_NAME) $(__ASC_REQUEST_MAPPING_TEMPLATE) $(__ASC_RESPONSE_MAPPING_TEMPLATE) $(__ASC_TYPE_NAME__RESOLVER)

_asc_delete_resolver:
	@$(INFO) '$(AWS_UI_LABEL)Deleting resolver "$(ASC_RESOLVER_NAME)" ...'; $(NORMAL)
	$(AWS) appsync delete-resolver $(__ASC_API_ID__RESOLVER) $(__ASC_FIELD_NAME) $(__ASC_TYPE_NAME__RESOLVER)

_asc_show_resolver:
	@$(INFO) '$(AWS_UI_LABEL)Showing resolver "$(ASC_RESOLVER_NAME)" ...'; $(NORMAL)
	$(AWS) appsync get-resolver $(__ASC_API_ID__RESOLVER) $(__ASC_FIELD_NAME) $(__ASC_TYPE_NAME__RESOLVER)#--query "graphqlApi"

_asc_update_resolver:
	@$(INFO) '$(AWS_UI_LABEL)Updating resolver "$(ASC_RESOLVER_NAME)" ...'; $(NORMAL)
	$(AWS) appsync update-resolver $(__ASC_API_ID__RESOLVER) $(__ASC_DATA_SOURCE_NAME) $(__ASC_FIELD_NAME) $(__ASC_REQUEST_MAPPING_TEMPLATE) $(__ASC_RESPONSE_MAPPING_TEMPLATE) $(__ASC_TYPE_NAME__RESOLVER)

_asc_view_resolvers:
	@$(INFO) '$(AWS_UI_LABEL)Viewing resolvers ...'; $(NORMAL)
	$(AWS) appsync list-resolvers $(__ASC_API_ID__RESOLVER) $(__ASC_TYPE_NAME__RESOLVER) # --query "graphqlApis[]$(ASC_UI_VIEW_RESOLVERS_FIELDS)"

_asc_view_resolvers_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing resolvers-set "$(ASC_RESOLVERS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) appsync list-resolvers $(__ASC_API_ID__RESOLVER) $(__ASC_TYPE_NAME__RESOLVER) # --query "graphqlApis[$(ASC_UI_VIEW_RESOLVERS_SET_SLICE)]$(ASC_UI_VIEW_RESOLVERS_SET_FIELDS)"
