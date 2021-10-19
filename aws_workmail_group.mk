_AWS_WORKMAIL_GROUP_MK_VERSION= $(_AWS_WORKMAIL_MK_VERSION)

# WML_GROUP_ID?=
# WML_GROUP_NAME?=
# WML_GROUP_ORGANIZATION_ID?= m-637f623935dc457e91720e5036eefb62
# WML_GROUPS_SET_NAME?=

# Derived parameters
WML_GROUP_ORGANIZATION_ID?= $(WML_ORGANIZATION_ID)

# Option parameters
__WML_ENTITY_ID__GROUP= $(if $(WML_GROUP_ID), --entity-id $(WML_GROUP_ID))
__WML_GROUP_ID= $(if $(WML_GROUP_ID), --group-id $(WML_GROUP_ID))
__WML_NAME__GROUP= $(if $(WML_GROUP_NAME), --name $(WML_GROUP_NAME))
__WML_ORGANIZATION_ID__GROUP= $(if $(WML_GROUP_ORGANIZATION_ID), --organization-id $(WML_GROUP_ORGANIZATION_ID))

# UI parameters
WML_UI_VIEW_GROUPS_FIELDS?=
WML_UI_VIEW_GROUPS_SET_FIELDS?= $(WML_UI_VIEW_GROUPS_FIELDS)
WML_UI_VIEW_GROUPS_SET_SLICE?=

#--- Utilities

#--- MACROS

_wml_get_group_id= $(call _wml_get_group_id_N, $(WML_GROUP_NAME))
_wml_get_group_id_N= $(call _wml_get_group_id_NO, $(1), $(WML_GROUP_ORGANIZATION_ID))
_wml_get_group_id_NO= "$(shell $(AWS) workmail list-groups --organization-id $(2) --query "Groups[?Name=='$(strip $(1))'].Id" --output text)"

#----------------------------------------------------------------------
# USAGE
#

_wml_view_framework_macros ::
	@echo 'AWS::WorkMaiL::Group ($(_AWS_WORKMAIL_GROUP_MK_VERSION)) macros:'
	@echo '    _wml_get_group_id_{|N|NO}                     - Get the ID of a group (Name,OrganizationId)'
	@echo

_wml_view_framework_parameters ::
	@echo 'AWS::WorkMaiL::Group ($(_AWS_WORKMAIL_GROUP_MK_VERSION)) parameters:'
	@echo '    WML_GROUP_ID=$(WML_GROUP_ID)'
	@echo '    WML_GROUP_IDS=$(WML_GROUP_IDS)'
	@echo '    WML_GROUP_NAME=$(WML_GROUP_NAME)'
	@echo '    WML_GROUP_ORGANIZATION_ID=$(WML_GROUP_ORGANIZATION_ID)'
	@echo '    WML_GROUPS_SET_NAME=$(WML_GROUPS_SET_NAME)'
	@echo

_wml_view_framework_targets ::
	@echo 'AWS::WorkMaiL::Group ($(_AWS_WORKMAIL_GROUP_MK_VERSION)) targets:'
	@echo '    _wml_create_group                           - Create a new group'
	@echo '    _wml_delete_group                           - Delete an existing group'
	@echo '    _wml_show_group                             - Show everything related to a group'
	@echo '    _wml_view_groups                            - View groups'
	@echo '    _wml_view_groups_set                        - View a set of groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_wml_create_group:
	@$(INFO) '$(AWS_UI_LABEL)Creating group "$(WML_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) workmail create-group $(__WML_NAME__GROUP) $(__WML_ORGANIZATION_ID__GROUP)

_wml_delete_group:
	@$(INFO) '$(AWS_UI_LABEL)Deleting group "$(WML_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) workmail delete-group $(__WML_ORGANIZATION_ID) $(__WML_GROUP_ID)

_wml_disable_group:
	@$(INFO) '$(AWS_UI_LABEL)Disabling group "$(WML_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) workmail deregister-from-work-mail $(__WML_ENTITY_ID__GROUP) $(__WML_ORGANIZATION_ID)

_wml_enable_group:
	@$(INFO) '$(AWS_UI_LABEL)Enabling group "$(WML_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) workmail register-to-work-mail $(_X__WML_EMAIL) $(__WML_ENTITY_ID__GROUP) $(__WML_ORGANIZATION_ID)

_wml_show_group:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of group "$(WML_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) workmail describe-group $(__WML_ORGANIZATION_ID__GROUP) $(__WML_GROUP_ID) # --query "Users[]"

_wml_view_groups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing groups ...'; $(NORMAL)
	$(AWS) workmail list-groups $(__WML_ORGANIZATION_ID__GROUP) --query "Groups[]$(WML_UI_VIEW_GROUPS_FIELDS)"

_wml_view_groups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing groups-set "$(WML_GROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Groups are grouped based on the provided organization-id and slice'; $(NORMAL)
	$(AWS) workmail list-groups $(__WML_ORGANIZATION_ID__GROUP)  --query "Groups[$(WML_UI_VIEW_GROUPS_SET_SLICE)]$(WML_UI_VIEW_GROUPS_SET_FIELDS)"
