_AWS_APPSYNC_APIKEY_MK_VERSION= $(_AWS_APPSYNC_MK_VERSION)

# ASC_APIKEY_DESCRIPTION?=
# ASC_APIKEY_EXPIRATION?=
# ASC_APIKEY_GRAPHQLAPI_ID?=
# ASC_APIKEY_ID?=
# ASC_APIKEY_NAME?=
# ASC_APIKEYS_SET_NAME?=

# Derived parameters
ASC_APIKEY_DESCRIPTION?= $(ASC_APIKEY_NAME)
ASC_APIKEY_GRAPHQLAPI_ID?= $(ASC_GRAPHQLAPI_ID)

# Option parameters
__ASC_API_ID__APIKEY= $(if $(ASC_APIKEY_GRAPHQLAPI_ID), --api-id $(ASC_APIKEY_GRAPHQLAPI_ID))
__ASC_DESCRIPTION__APIKEY= $(if $(ASC_APIKEY_DESCRIPTION), --description $(ASC_APIKEY_DESCRIPTION))
__ASC_EXPIRES= $(if $(ASC_APIKEY_EXPIRATION), --expires $(ASC_APIKEY_EXPIRATION))
__ASC_ID__APIKEY= $(if $(ASC_APIKEY_ID), --id $(ASC_APIKEY_ID))

# UI parameters
ASC_UI_VIEW_APIKEYS_FIELDS?=
ASC_UI_VIEW_APIKEYS_SET_FIELDS?= $(ASC_UI_VIEW_APIKEYS_FIELDS)
ASC_UI_VIEW_APIKEYS_SET_SLICE?= 0:10


#--- MACROS
_asc_get_apikey_id= $(call _asc_get_apikey_id_D, $(ASC_APIKEY_DESCRIPTION))
_asc_get_apikey_id_D= $(call _asc_get_apikey_id_DI, $(1), $(ASC_APIKEY_GRAPHQLAPI_ID))
# _asc_get_apikey_id_DI= $(shell $(AWS) appsync list-api-keys --api-id $(2) --query "apiKeys[?description=='$(strip $(1))'].id" --output text)
_asc_get_apikey_id_DI= $(shell $(AWS) appsync list-api-keys --api-id $(2) --query "apiKeys[?description=='$(strip $(shell echo -n $(1)))'].id" --output text)

#----------------------------------------------------------------------
# USAGE
#

_asc_view_framework_macros ::
	@echo 'AWS::AppSynC::ApiKey ($(_AWS_APPSYNC_APIKEY_MK_VERSION)) macros:'
	@echo '    _asc_get_apikey_id_{|D|DI}         - Get ID of GraphQL API (Description,apiId)'
	@echo

_asc_view_framework_parameters ::
	@echo 'AWS::AppSynC::ApiKey ($(_AWS_APPSYNC_APIKEY_MK_VERSION)) parameters:'
	@echo '    ASC_APIKEY_DESCRIPTION=$(ASC_APIKEY_DESCRIPTION)'
	@echo '    ASC_APIKEY_EXPIRATION=$(ASC_APIKEY_EXPIRATION)'
	@echo '    ASC_APIKEY_GRAPHQLAPI_ID=$(ASC_APIKEY_GRAPHQLAPI_ID)'
	@echo '    ASC_APIKEY_ID=$(ASC_APIKEY_ID)'
	@echo '    ASC_APIKEY_NAME=$(ASC_APIKEY_NAME)'
	@echo

_asc_view_framework_targets ::
	@echo 'AWS::AppSynC::ApiKey ($(_AWS_APPSYNC_APIKEY_MK_VERSION)) targets:'
	@echo '    _asc_create_apikey                 - Create a new api-key'
	@echo '    _asc_delete_apikey                 - Delete an existing api-key'
	@echo '    _asc_show_apikey                   - Show everything related to an api-key'
	@echo '    _asc_update_apikey                 - Update an api-key'
	@echo '    _asc_view_apikeys                  - View existing api-keys'
	@echo '    _asc_view_apikeys_set              - View a set of api-keys'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asc_create_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Creating api-key "$(ASC_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) appsync create-api-key  $(__ASC_API_ID__APIKEY) $(__ASC_DESCRIPTION__APIKEY) $(__ASC_EXPIRES) --query "apiKey"

_asc_delete_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Deleting api-key "$(ASC_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) appsync delete-api-key $(__ASC_API_ID__APIKEY) $(__ASC_ID__APIKEY)

_asc_show_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Showing api-key "$(ASC_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) appsync list-api-keys $(__ASC_API_ID__APIKEY) --query "apiKeys[?id=='$(ASC_APIKEY_ID)']"

_asc_update_apikey:
	@$(INFO) '$(AWS_UI_LABEL)Updating api-key "$(ASC_APIKEY_NAME)" ...'; $(NORMAL)
	$(AWS) appsync update-api-keys $(__ASC_API_ID__APIKEY) $(__ASC_DESCRIPTION__APIKEY) $(__ASC_EXPIRES) $(__ASC_ID__APIKEY)

_asc_view_apikeys:
	@$(INFO) '$(AWS_UI_LABEL)Viewing api-keys ...'; $(NORMAL)
	$(AWS) appsync list-api-keys $(__ASC_API_ID__APIKEY) --query "apiKeys[]$(ASC_UI_VIEW_APIKEYS_FIELDS)"

_asc_view_apikeys_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing api-keys-set "$(ASC_APIKEYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The API keys are grouped based on the provided slice'; $(NORMAL)
	$(AWS) appsync list-api-keys $(__ASC_API_ID__APIKEY) --query "apiKeys[$(ASC_UI_VIEW_APIKEYS_SET_SLICE)]$(ASC_UI_VIEW_APIKEYS_SET_FIELDS)"
