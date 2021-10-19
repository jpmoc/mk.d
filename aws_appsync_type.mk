_AWS_APPSYNC_TYPE_MK_VERSION= $(_AWS_APPSYNC_MK_VERSION)

# ASC_TYPE_DESCRIPTION?= "This is my-type"
# ASC_TYPE_FORMAT?= my-type
# ASC_TYPE_GRAPHQLAPI_ID?= 6hd24t42afh4ngzfuwjw2bhkfy
# ASC_TYPE_NAME?= my-type
# ASC_TYPES_SET_NAME?= my-types-set

# Derived parameters
ASC_TYPE_GRAPHQLAPI_ID?= $(ASC_GRAPHQLAPI_ID)

# Option parameters
__ASC_API_ID__TYPE= $(if $(ASC_TYPE_GRAPHQLAPI_ID), --api-id $(ASC_TYPE_GRAPHQLAPI_ID))
__ASC_DESCRIPTION__TYPE= $(if $(ASC_TYPE_DESCRIPTION), --description $(ASC_TYPE_DESCRIPTION))
__ASC_FORMAT= $(if $(ASC_TYPE_FORMAT), --format $(ASC_TYPE_FORMAT))

# UI parameters
ASC_UI_VIEW_TYPES_FIELDS?=
ASC_UI_VIEW_TYPES_SET_FIELDS?= $(ASC_UI_VIEW_TYPES_FIELDS)
ASC_UI_VIEW_TYPES_SET_SLICE?=

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_asc_view_framework_macros ::
	@echo 'AWS::AppSynC::Type ($(_AWS_APPSYNC_TYPE_MK_VERSION)) macros:'
	@echo

_asc_view_framework_parameters ::
	@echo 'AWS::AppSynC::Type ($(_AWS_APPSYNC_TYPE_MK_VERSION)) parameters:'
	@echo '    ASC_TYPE_DESCRIPTION=$(ASC_TYPE_DESCRIPTION)'
	@echo '    ASC_TYPE_FORMAT=$(ASC_TYPE_FORMAT)'
	@echo '    ASC_TYPE_GRAPHQLAPI_ID=$(ASC_TYPE_GRAPHQLAPI_ID)'
	@echo '    ASC_TYPE_NAME=$(ASC_TYPE_NAME)'
	@echo '    ASC_TYPES_SET_NAME=$(ASC_TYPES_SET_NAME)'
	@echo

_asc_view_framework_targets ::
	@echo 'AWS::AppSynC::Type ($(_AWS_APPSYNC_TYPE_MK_VERSION)) targets:'
	@echo '    _asc_create_type                 - Create a new type'
	@echo '    _asc_delete_type                 - Delete an existing type'
	@echo '    _asc_show_type                   - Show everything related to an type'
	@echo '    _asc_update_type                 - Update an type'
	@echo '    _asc_view_types                  - View existing types'
	@echo '    _asc_view_types_set              - View a set of types'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGET
#
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_asc_create_type:
	@$(INFO) '$(AWS_UI_LABEL)Creating type "$(ASC_TYPE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync create-type $(__ASC_API_ID__TYPE) $(__ASC_DESCRIPTION__TYPE) $(__ASC_FORMAT)

_asc_delete_type:
	@$(INFO) '$(AWS_UI_LABEL)Deleting type "$(ASC_TYPE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync delete-type $(__ASC_API_ID__TYPE) $(__ASC_TYPE_NAME__TYPE)

_asc_show_type:
	@$(INFO) '$(AWS_UI_LABEL)Showing type "$(ASC_TYPE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync get-type $(__ASC_API_ID__TYPE) $(__ASC_FORMAT) $(__ASC_TYPE_NAME__TYPE)#--query "graphqlApi"

_asc_update_type:
	@$(INFO) '$(AWS_UI_LABEL)Updating type "$(ASC_TYPE_NAME)" ...'; $(NORMAL)
	$(AWS) appsync update-type $(__ASC_API_ID__TYPE) $(__ASC_DESCRIPTION__TYPE) $(__ASC_FORMAT) $(__ASC_TYPE_NAME__TYPE)

_asc_view_types:
	@$(INFO) '$(AWS_UI_LABEL)Viewing types ...'; $(NORMAL)
	$(AWS) appsync list-types $(__ASC_API_ID__TYPE) $(__ASC_FORMAT) # --query "graphqlApis[]$(ASC_UI_VIEW_TYPES_FIELDS)"

_asc_view_types_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing types-set "$(ASC_TYPES_SET_NAME)" ...'; $(NORMAL)
	$(AWS) appsync list-types $(__ASC_API_ID__TYPE) $(__ASC_FORMAT) # --query "graphqlApis[$(ASC_UI_VIEW_TYPES_SET_SLICE)]$(ASC_UI_VIEW_TYPES_SET_FIELDS)"
