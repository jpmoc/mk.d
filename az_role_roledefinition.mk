_AZ_ROLE_ROLEDEFINITION_MK_VERSION= $(_AZ_ROLE_MK_VERSION)

# RLE_ROLEDEFINITION_DOCUMENT?=
# RLE_ROLEDEFINITION_DOCUMENT_DIRPATH?=
# RLE_ROLEDEFINITION_DOCUMENT_FILENAME?=
# RLE_ROLEDEFINITION_DOCUMENT_FILEPATH?=
# RLE_ROLEDEFINITION_LOCATION_ID?= westus2
# RLE_ROLEDEFINITION_NAME?= my-role-definition
# RLE_ROLEDEFINITION_RESOURCEGROUP_NAME?=
# RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG?= false
# RLE_ROLEDEFINITIONS_SCOPE?=
# RLE_ROLEDEFINITIONS_SET_NAME?= my-role-definitions-set

# Derived parameters
RLE_ROLEDEFINITION_DOCUMENT?= $(if $(RLE_ROLEDEFINITION_DOCUMENT_FILEPATH),@$(RLE_ROLEDEFINITION_DOCUMENT_FILEPATH))
RLE_ROLEDEFINITION_DOCUMENT_DIRPATH?= $(RLE_INPUTS_DIRPATH)
RLE_ROLEDEFINITION_DOCUMENT_FILEPATH?= $(if $(RLE_ROLEDEFINITION_DOCUMENT_FILENAME),$(RLE_ROLEDEFINITION_DOCUMENT_DIRPATH)$(RLE_ROLEDEFINITION_DOCUMENT_FILENAME))
RLE_ROLEDEFINITION_LOCATION_ID?= $(RLE_LOCATION_ID)
RLE_ROLEDEFINITION_NAME?= $(RLE_ROLE_NAME)

# Options parameters
__RLE_CUSTOM_ROLE_ONLY= $(if $(RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG),--custom-role-only $(RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG))
__RLE_LOCATION= $(if $(RLE_ROLEDEFINITION_LOCATION_ID),--location $(RLE_ROLEDEFINITION_LOCATION_ID))
__RLE_NAME__ROLEDEFINITION= $(if $(RLE_ROLEDEFINITION_NAME),--name '$(RLE_ROLEDEFINITION_NAME)')
__RLE_RESOURCE_GROUP__ROLEDEFINITION= $(if $(RLE_ROLEDEFINITION_RESOURCEGROUP_NAME),--resource-group $(RLE_ROLEDEFINITION_RESOURCEGROUP_NAME))
__RLE_ROLE_DEFINITION= $(if $(RLE_ROLEDEFINITION_DOCUMENT),--role-definition $(RLE_ROLEDEFINITION_DOCUMENT))
__RLE_SCOPE__ROLEDEFINITIONS= $(if $(RLE_ROLEDEFINITIONS_SCOPE),--scope $(RLE_ROLEDEFINITIONS_SCOPE))
# __RLE_OUTPUT?=

# UI parameters
RLE_UI_VIEW_ROLEDEFINITIONS_FIELDS?= .{roleType:roleType,roleName:roleName}
RLE_UI_VIEW_ROLEDEFINITIONS_SET_FIELDS?= $(RLE_UI_VIEW_ROLEDEFINITIONS_FIELDS)
RLE_UI_VIEW_ROLEDEFINITIONS_SET_QUERYFILTER?=

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_rle_view_framework_macros ::
	@#echo 'AZ::RoLE::RoleDefinition ($(_AZ_ROLE_ROLEDEFINITION_MK_VERSION)) macros:'
	@#echo

_rle_view_framework_parameters ::
	@echo 'AZ::RoLE::RoleDefinition ($(_AZ_ROLE_ROLEDEFINITION_MK_VERSION)) parameters:'
	@echo '    RLE_ROLEDEFINITION_LOCATION_ID=$(RLE_ROLEDEFINITION_LOCATION_ID)'
	@echo '    RLE_ROLEDEFINITION_NAME=$(RLE_ROLEDEFINITION_NAME)'
	@echo '    RLE_ROLEDEFINITION_RESOURCEGROUP_NAME=$(RLE_ROLEDEFINITION_RESOURCEGROUP_NAME)'
	@echo '    RLE_ROLEDEFINITION_SCOPE=$(RLE_ROLEDEFINITION_SCOPE)'
	@echo '    RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG=$(RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG)'
	@echo '    RLE_ROLEDEFINITIONS_SCOPE=$(RLE_ROLEDEFINITIONS_SCOPE)'
	@echo '    RLE_ROLEDEFINITIONS_SET_NAME=$(RLE_ROLEDEFINITIONS_SET_NAME)'
	@echo

_rle_view_framework_targets ::
	@echo 'AZ::RoLE::RoleDefinition ($(_AZ_ROLE_ROLEDEFINITION_MK_VERSION)) targets:'
	@echo '    _rle_create_roledefinition             - Create a role-definition'
	@echo '    _rle_delete_roledefinition             - Delete a role-definition'
	@echo '    _rle_show_roledefinition               - Show everything related to a role-definition'
	@echo '    _rle_show_roledefinition_description   - Show description of a role-definition'
	@echo '    _rle_show_roledefinition_object        - Show object of a role-definition'
	@echo '    _rle_view_roledefinitions              - View role-definitions'
	@echo '    _rle_view_roledefinitions_set          - View set of role-definitions'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rle_create_roledefinition:
	@$(INFO) '$(RLE_UI_LABEL)Creating role-definition "$(RLE_ROLEDEFINITION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a role-definition only if its name is not already used'; $(NORMAL)
	$(AZ) role definition create $(__RLE_LOCATION) $(__RLE_ROLE_DEFINITION) $(__RLE_OUTPUT) $(__RLE_SUBSCRIPTION)

_rle_delete_roledefinition:
	@$(INFO) '$(RLE_UI_LABEL)Deleting role-definition "$(RLE_ROLEDEFINITION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation identifies in the subscription the to-be-deleted role-definition based on its name'; $(NORMAL)
	$(AZ) role definition delete $(_X__RLE_CUSTOM_ROLE_ONLY) $(__RLE_NAME__ROLEDEFINITION) $(__RLE_OUTPUT) $(__RLE_SCOPE__ROLEDEFINITION) $(__RLE_SUBSCRIPTION)

_rle_show_roledefinition: _rle_show_roledefinition_object _rle_show_roledefinition_description

_rle_show_roledefinition_description:
	@$(INFO) '$(RLE_UI_LABEL)Showing description of role-definition "$(RLE_ROLEDEFINITION_NAME)" ...'; $(NORMAL)
	$(AZ) role definition list $(_X__RLE_CUSTOM_ROLE_ONLY) $(__RLE_NAME__ROLEDEFINITION) $(__RLE_OUTPUT) $(_X__RLE_SCOPE__ROLEDEFINITION) $(__RLE_SUBSCRIPTION)

_rle_show_roledefinition_object:
	@$(INFO) '$(RLE_UI_LABEL)Showing object of role-definition "$(RLE_ROLEDEFINITION_NAME)" ...'; $(NORMAL)
	$(AZ) role definition list $(_X__RLE_CUSTOM_ROLE_ONLY) $(__RLE_NAME__ROLEDEFINITION) $(_X__RLE_OUTPUT) $(_X__RLE_SCOPE__ROLEDEFINITION) $(__RLE_SUBSCRIPTION) --output json

_rle_view_roledefinitions:
	@$(INFO) '$(RLE_UI_LABEL)Viewing role-definitions ...'; $(NORMAL)
	$(AZ) role definition list $(_X__RLE_CUSTOM_ROLE_ONLY) $(_X__RLE_NAME) $(__RLE_OUTPUT) $(_X__RLE_SCOPE__ROLEDEFINITIONS) $(__RLE_SUBSCRIPTION) --query "[]$(RLE_UI_VIEW_ROLEDEFINITIONS_FIELDS)"

_rle_view_roledefinitions_set:
	@$(INFO) '$(RLE_UI_LABEL)Viewing role-definitions-set "$(RLE_ROLEDEFINITIONS_SET_NAME) ...'; $(NORMAL)
	@$(WARN) 'Role-definitions are grouped based on custom/builtin, scope, and query-filter'; $(NORMAL)
	$(AZ) role definition list $(__RLE_CUSTOM_ROLE_ONLY) $(_X__RLE_NAME) $(__RLE_OUTPUT) $(__RLE_SCOPE__ROLEDEFINITIONS) $(__RLE_SUBSCRIPTION) --query "[$(RLE_UI_VIEW_ROLEDEFINITIONS_SET_QUERYFILTER)]$(RLE_UI_VIEW_ROLEDEFINITIONS_SET_FIELDS)"
