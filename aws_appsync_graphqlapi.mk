_AWS_APPSYNC_GRAPHQLAPI_MK_VERSION= $(_AWS_APPSYNC_MK_VERSION)

# ASC_GRAPHQLAPI_ARN?= arn:aws:appsync:us-east-1:123456789012:apis/6hd24t42afh4ngzfuwjw2bhkfy
# ASC_GRAPHQLAPI_AUTHENTICATION_TYPE?= API_KEY
# ASC_GRAPHQLAPI_ID?= 6hd24t42afh4ngzfuwjw2bhkfy
# ASC_GRAPHQLAPI_LOG_CONFIG?= fieldLogLevel=string,cloudWatchLogsRoleArn=string
# ASC_GRAPHQLAPI_NAME?= my-graphql-api
# ASC_GRAPHQLAPI_OPENIDCONNECT_CONFIG?= issuer=string,clientId=string,iatTTL=long,authTTL=long
# ASC_GRAPHQLAPI_USERPOOL_CONFIG?= userPoolId=string,awsRegion=string,defaultAction=string,appIdClientRegex=string
# ASC_GRAPHQLAPIS_SET_NAME?= my-graphql-apis-set

# Derived parameters

# Option parameters
__ASC_AUTHENTICATION_TYPE= $(if $(ASC_GRAPHQLAPI_AUTHENTICATION_TYPE), --authentication-type $(ASC_GRAPHQLAPI_AUTHENTICATION_TYPE))
__ASC_API_ID__GRAPHQLAPI= $(if $(ASC_GRAPHQLAPI_ID), --api-id $(ASC_GRAPHQLAPI_ID))
__ASC_LOG_CONFIG= $(if $(ASC_GRAPHQLAPI_LOG_CONFIG), --log-config $(ASC_GRAPHQLAPI_LOG_CONFIG))
__ASC_NAME__GRAPHQLAPI= $(if $(ASC_GRAPHQLAPI_NAME), --name $(ASC_GRAPHQLAPI_NAME))
__ASC_OPEN_ID_CONNECT_CONFIG= $(if $(ASC_GRAPHQLAPI_OPENIDCONNECT_CONFIG), --open-id-connect-config $(ASC_GRAPHQLAPI_OPENIDCONNECT_CONFIG))
__ASC_USER_POOL_CONFIG= $(if $(ASC_GRAPHQLAPI_USERPOOL_CONFIG), --user-pool-config $(ASC_GRAPHQLAPI_USERPOOL_CONFIG))

# UI parameters
ASC_UI_VIEW_GRAPHQLAPIS_FIELDS?= .{ApidId:apiId,Name:name,uris: uris.GRAPHQL,authType:authenticationType}
ASC_UI_VIEW_GRAPHQLAPIS_SET_FIELDS?= $(ASC_UI_VIEW_GRAPHQLAPIS_FIELDS)
ASC_UI_VIEW_GRAPHQLAPIS_SET_SLICE?=

#--- MACROS

_asc_get_graphqlapi_arn= $(call _asc_get_graphqlapi_arn_I, $(ASC_GRAPHQLAPI_ID))
_asc_get_graphqlapi_arn_I= $(shell $(AWS) appsync get-graphql-api --api-id $(1) --query "graphqlApi.arn" --output text)

_asc_get_graphqlapi_id= $(call _asc_get_graphqlapi_id_N, $(ASC_GRAPHQLAPI_NAME))
_asc_get_graphqlapi_id_N= $(shell $(AWS) appsync list-graphql-apis --query "graphqlApis[?name=='$(strip $(1))'].apiId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_asc_view_framework_macros ::
	@echo 'AWS::AppSynC::GraphqlApi ($(_AWS_APPSYNC_GRAPHQLAPI_MK_VERSION)) macros:'
	@echo '    _asc_get_graphqlapi_arn_{|I}           - Get the ARN of a grpahql-api (Id)'
	@echo '    _asc_get_graphqlapi_id_{|N}            - Get the ID of a grpahql-api (Name)'
	@echo

_asc_view_framework_parameters ::
	@echo 'AWS::AppSynC::GraphqlApi ($(_AWS_APPSYNC_GRAPHQLAPI_MK_VERSION)) parameters:'
	@echo '    ASC_GRAPHQLAPI_ARN=$(ASC_GRAPHQLAPI_ARN)'
	@echo '    ASC_GRAPHQLAPI_AUTHENTICATION_TYPE=$(ASC_GRAPHQLAPI_AUTHENTICATION_TYPE)'
	@echo '    ASC_GRAPHQLAPI_ID=$(ASC_GRAPHQLAPI_ID)'
	@echo '    ASC_GRAPHQLAPI_LOG_CONFIG=$(ASC_GRAPHQLAPI_LOG_CONFIG)'
	@echo '    ASC_GRAPHQLAPI_NAME=$(ASC_GRAPHQLAPI_NAME)'
	@echo '    ASC_GRAPHQLAPI_OPENIDCONNECT_CONFIG=$(ASC_GRAPHQLAPI_OPENIDCONNECT_CONFIG)'
	@echo '    ASC_GRAPHQLAPI_USERPOOL_CONFIG=$(ASC_GRAPHQLAPI_USERPOOL_CONFIG)'
	@echo '    ASC_GRAPHQLAPIS_SET_NAME=$(ASC_GRAPHQLAPIS_SET_NAME)'
	@echo

_asc_view_framework_targets ::
	@echo 'AWS::AppSynC::GraphqlApi ($(_AWS_APPSYNC_GRAPHQLAPI_MK_VERSION)) targets:'
	@echo '    _asc_create_graphqlapi                 - Create a new graphql-api'
	@echo '    _asc_delete_graphqlapi                 - Delete an existing graphql-api'
	@echo '    _asc_show_graphqlapi                   - Show everything related to an graphql-api'
	@echo '    _asc_update_graphqlapi                 - Update an graphql-api'
	@echo '    _asc_view_graphqlapis                  - View existing graphql-apis'
	@echo '    _asc_view_graphqlapis_set              - View a set of graphql-apis'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asc_create_graphqlapi:
	@$(INFO) '$(AWS_UI_LABEL)Creating graphql-api "$(ASC_GRAPHQLAPI_NAME)" ...'; $(NORMAL)
	$(AWS) appsync create-graphql-api $(__ASC_AUTHENTICATION_TYPE) $(__ASC_LOG_CONFIG) $(__ASC_NAME__GRAPHQLAPI) $(__ASC_OPEN_ID_CONNECT_CONFIG) $(__ASC_USER_POOL_CONFIG)

_asc_delete_graphqlapi:
	@$(INFO) '$(AWS_UI_LABEL)Deleting graphql-api "$(ASC_GRAPHQLAPI_NAME)" ...'; $(NORMAL)
	$(AWS) appsync delete-graphql-api $(__ASC_API_ID__GRAPHQLAPI)

_asc_show_graphqlapi:
	@$(INFO) '$(AWS_UI_LABEL)Showing graphql-api "$(ASC_GRAPHQLAPI_NAME)" ...'; $(NORMAL)
	$(AWS) appsync get-graphql-api $(__ASC_API_ID__GRAPHQLAPI) --query "graphqlApi"

_asc_update_graphqlapi:
	@$(INFO) '$(AWS_UI_LABEL)Updating graphql-api "$(ASC_GRAPHQLAPI_NAME)" ...'; $(NORMAL)
	$(AWS) appsync update-graphql-api $(__ASC_API_ID__GRAPHQLAPI) $(__ASC_AUTHENTICATION_TYPE)$(__ASC_LOG_CONFIG) $(__ASC_NAME__GRAPHQLAPI) $(__ASC_OPEN_ID_CONNECT_CONFIG) $(__ASC_USER_POOL_CONFIG)

_asc_view_graphqlapis:
	@$(INFO) '$(AWS_UI_LABEL)Viewing graphql-apis ...'; $(NORMAL)
	$(AWS) appsync list-graphql-apis  --query "graphqlApis[]$(ASC_UI_VIEW_GRAPHQLAPIS_FIELDS)"

_asc_view_graphqlapis_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing graphql-apis-set "$(ASC_GRAPHQLAPIS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'GraphQL APIs are grouped based on the provided slice'; $(NORMAL)
	$(AWS) appsync list-graphql-apis  --query "graphqlApis[$(ASC_UI_VIEW_GRAPHQLAPIS_SET_SLICE)]$(ASC_UI_VIEW_GRAPHQLAPIS_SET_FIELDS)"
