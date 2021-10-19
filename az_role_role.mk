_AZ_ROLE_ROLE_MK_VERSION= $(_AZ_ROLE_MK_VERSION)

# RLE_ROLE_NAME?= my-role
# RLE_ROLE_RESOURCEGROUP_NAME?=
# RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG?= false
# RLE_ROLEDEFINITIONS_SCOPE?=
# RLE_ROLEDEFINITIONS_SET_NAME?= my-role-definitions-set

# Derived parameters
# RLE_ROLE_DEFINITIONDOCUMENT?= $(if $(RLE_ROLE_DEFINITIONDOCUMENT_FILEPATH),@$(RLE_ROLE_DEFINITIONDOCUMENT_FILEPATH))
# RLE_ROLE_DEFINITIONDOCUMENT_DIRPATH?= $(RLE_INPUTS_DIRPATH)
# RLE_ROLE_DEFINITIONDOCUMENT_FILEPATH?= $(if $(RLE_ROLE_DEFINITIONDOCUMENT_FILENAME),$(RLE_ROLE_DEFINITIONDOCUMENT_DIRPATH)$(RLE_ROLE_DEFINITIONDOCUMENT_FILENAME))
RLE_ROLE_LOCATION_ID?= $(RLE_LOCATION_ID)
RLE_ROLE_RESOURCEGROUP_NAME?= $(RLE_RESOURCEGROUP_NAME)

# Options parameters
# __RLE_CUSTOM_ROLE_ONLY= $(if $(RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG),--custom-role-only $(RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG))
__RLE_LOCATION= $(if $(RLE_ROLE_LOCATION_ID),--location $(RLE_ROLE_LOCATION_ID))
__RLE_NAME__ROLE= $(if $(RLE_ROLE_NAME),--name '$(RLE_ROLE_NAME)')
__RLE_RESOURCE_GROUP__ROLE= $(if $(RLE_ROLE_RESOURCEGROUP_NAME),--resource-group $(RLE_ROLE_RESOURCEGROUP_NAME))
# __RLE_ROLE_DEFINITION= $(if $(RLE_ROLEDEFINITION_DOCUMENT),--role-definition $(RLE_ROLEDEFINITION_DOCUMENT))
# __RLE_SCOPE__ROLEDEFINITIONS= $(if $(RLE_ROLEDEFINITIONS_SCOPE),--scope $(RLE_ROLEDEFINITIONS_SCOPE))
# __RLE_OUTPUT?=

# UI parameters
RLE_UI_SHOW_ROLE_ASSIGNMENTS_FIELDS?= .{name:name,principalName:principalName,resourceGroup:resourceGroup,roleDefinitionName:roleDefinitionName}
RLE_UI_SHOW_ROLE_ASSIGNMENTS_QUERYFILTER?= ?roleDefinitionName=='$(RLE_ROLE_NAME)' 
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
	@echo '    RLE_ROLE_LOCATION_ID=$(RLE_ROLE_LOCATION_ID)'
	@echo '    RLE_ROLE_NAME=$(RLE_ROLE_NAME)'
	@echo '    RLE_ROLE_RESOURCEGROUP_NAME=$(RLE_ROLE_RESOURCEGROUP_NAME)'
	@#echo '    RLE_ROLEDEFINITION_SCOPE=$(RLE_ROLEDEFINITION_SCOPE)'
	@#echo '    RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG=$(RLE_ROLEDEFINITIONS_CUSTOMONLY_FLAG)'
	@#echo '    RLE_ROLEDEFINITIONS_SCOPE=$(RLE_ROLEDEFINITIONS_SCOPE)'
	@echo '    RLE_ROLES_SET_NAME=$(RLE_ROLES_SET_NAME)'
	@echo

_rle_view_framework_targets ::
	@echo 'AZ::RoLE::RoleDefinition ($(_AZ_ROLE_ROLEDEFINITION_MK_VERSION)) targets:'
	@echo '    _rle_assign_role                       - Assign an existing role'
	@echo '    _rle_create_role                       - Create a role'
	@echo '    _rle_delete_role                       - Delete a role'
	@echo '    _rle_show_role                         - Show everything related to a role'
	@echo '    _rle_show_role_assignments             - Show assignments of a role'
	@echo '    _rle_show_role_description             - Show description of a role'
	@echo '    _rle_show_role_object                  - Show object of a role'
	@echo '    _rle_unassign_role                     - Unassign a role from a principal'
	@echo '    _rle_view_roles                        - View roles'
	@echo '    _rle_view_roles_set                    - View a set of roles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rle_assign_role: _rle_create_roleassignment

_rle_create_role: RLE_ROLEDEFINITION_DOCUMENT=$(RLE_ROLE_DEFINITIONDOCUMENT)
_rle_create_role: RLE_ROLEDEFINITION_DOCUMENT_DIRPATH=$(RLE_ROLE_DEFINITIONDOCUMENT_DIRPATH)
_rle_create_role: RLE_ROLEDEFINITION_DOCUMENT_FILENAME=$(RLE_ROLE_DEFINITIONDOCUMENT_FILENAME)
_rle_create_role: RLE_ROLEDEFINITION_DOCUMENT_FILEPATH=$(RLE_ROLE_DEFINITIONDOCUMENT_FILEPATH)
_rle_create_role: RLE_ROLEDEFINITION_NAME=$(RLE_ROLE_NAME)
_rle_create_role: _rle_create_roledefinition

_rle_delete_role: RLE_ROLEDEFINITION_NAME=$(RLE_ROLE_NAME)
_rle_delete_role: _rle_delete_roledefinition

_rle_show_role :: _rle_show_role_assignment _rle_show_role_definition _rle_show_role_definitionobject _rle_show_role_description

_rle_show_role_description: _rle_show_role_definition

_rle_show_role_assignment:
	@$(INFO) '$(RLE_UI_LABEL)Showing assignments of role "$(RLE_ROLE_NAME)" ...'; $(NORMAL)
	$(AZ) role assignment list $(_X__RLE_ALL) --all $(__RLE_OUTPUT) $(__RLE_SUBSCRIPTION) --query "[$(RLE_UI_SHOW_ROLE_ASSIGNMENTS_QUERYFILTER)]$(RLE_UI_SHOW_ROLE_ASSIGNMENTS_FIELDS)"

_rle_show_role_definition:
	@$(INFO) '$(RLE_UI_LABEL)Showing role-definition of role "$(RLE_ROLE_NAME)" ...'; $(NORMAL)
	$(AZ) role definition list $(_X__RLE_CUSTOM_ROLE_ONLY) $(__RLE_NAME__ROLE) $(__RLE_OUTPUT) $(_X__RLE_SCOPE__ROLE) $(__RLE_SUBSCRIPTION)

_rle_show_role_definitionobject:
	@$(INFO) '$(RLE_UI_LABEL)Showing role-definition-object of role "$(RLE_ROLE_NAME)" ...'; $(NORMAL)
	$(AZ) role definition list $(_X__RLE_CUSTOM_ROLE_ONLY) $(__RLE_NAME__ROLE) $(_X__RLE_OUTPUT) $(_X__RLE_SCOPE__ROLE) $(__RLE_SUBSCRIPTION) --output json

_rle_unassign_role: _rle_delete_roleassignment

_rle_view_roles:
	@$(INFO) '$(RLE_UI_LABEL)Viewing roles ...'; $(NORMAL)
	#$(AZ) role definition list $(_X__RLE_CUSTOM_ROLE_ONLY) $(_X__RLE_NAME) $(__RLE_OUTPUT) $(_X__RLE_SCOPE__ROLEDEFINITIONS) $(__RLE_SUBSCRIPTION) --query "[]$(RLE_UI_VIEW_ROLEDEFINITIONS_FIELDS)"

_rle_view_roles_set:
	@$(INFO) '$(RLE_UI_LABEL)Viewing roles-set "$(RLE_ROLEDEFINITIONS_SET_NAME) ...'; $(NORMAL)
	@#$(WARN) 'Roles are grouped based on custom/builtin, scope, and query-filter'; $(NORMAL)
	#$(AZ) role definition list $(__RLE_CUSTOM_ROLE_ONLY) $(_X__RLE_NAME) $(__RLE_OUTPUT) $(__RLE_SCOPE__ROLEDEFINITIONS) $(__RLE_SUBSCRIPTION) --query "[$(RLE_UI_VIEW_ROLEDEFINITIONS_SET_QUERYFILTER)]$(RLE_UI_VIEW_ROLEDEFINITIONS_SET_FIELDS)"
