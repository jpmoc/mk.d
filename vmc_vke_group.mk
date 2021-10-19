_VMC_VKE_GROUP_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_GROUP_DESCRIPTION?= 'This is my group description'
# VKE_GROUP_NAME?= VKEServiceUsers
# VKE_GROUP_MEMBER_NAME?= emayssat@vmware.com

# Derived variables
VKE_GROUP_MEMBER_NAME?= $(VKE_USER_NAME)

# Option variables
__VKE_DESCRIPTION__GROUP= $(if $(VKE_GROUP_DESRIPTION), --desription $(VKE_GROUP_DESCRIPTION))
__VKE_MEMBER_NAME= $(if $(VKE_GROUP_MEMBER_NAME), --member-name $(VKE_GROUP_MEMBER_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Group ($(_VMC_VKE_GROUP_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Group ($(_VMC_VKE_GROUP_MK_VERSION)) parameters:'
	@echo '    VKE_GROUP_NAME=$(VKE_GROUP_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Group ($(_VMC_VKE_GROUP_MK_VERSION)) targets:'
	@echo '    _vke_create_group               - Create a new group'
	@echo '    _vke_delete_group               - Delete an existing group'
	@echo '    _vke_show_group                 - Show everything related to a group'
	@echo '    _vke_show_group_desription      - Show description of a group'
	@echo '    _vke_show_group_members         - Show members of a group'
	@echo '    _vke_view_groups                - View existing groups'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_add_group_member:
	@$(INFO) '$(VKE_UI_LABEL)Adding user "$(VKE_GROUP_MEMBER_NAME)" to group "$(VKE_GROUP_NAME)" ...'; $(NORMAL)
	$(VKE) iam group member add $(__VKE_MEMBER_NAME) $(VKE_GROUP_NAME)

_vke_create_group:
	@$(INFO) '$(VKE_UI_LABEL)Creating group "$(VKE_GROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation will fail if the group already exist! or you do NOT have group.create right'; $(NORMAL)
	$(VKE) iam group create $(__VKE_DESCRIPTION__GROUP) $(VKE_GROUP_NAME)

_vke_delete_group:
	@$(INFO) '$(VKE_UI_LABEL)Deleting group "$(VKE_GROUP_NAME)" ...'; $(NORMAL)
	$(VKE) iam group delete $(VKE_GROUP_NAME)

_vke_remove_group_member:
	@$(INFO) '$(VKE_UI_LABEL)Removing user "$(VKE_GROUP_MEMBER_NAME)" from group "$(VKE_GROUP_NAME)" ...'; $(NORMAL)
	$(VKE) iam group member remove $(__VKE_MEMBER_NAME) $(VKE_GROUP_NAME)

_vke_show_group: _vke_show_group_members _vke_show_group_description

_vke_show_group_description:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of group "$(VKE_GROUP_NAME)" ...'; $(NORMAL)
	$(VKE) iam group show $(VKE_GROUP_NAME)

_vke_show_group_members:
	@$(INFO) '$(VKE_UI_LABEL)Showing members of group "$(VKE_GROUP_NAME)" ...'; $(NORMAL)
	$(VKE) iam group member list $(VKE_GROUP_NAME)

_vke_view_groups:
	@$(INFO) '$(VKE_UI_LABEL)Viewing all groups ...'; $(NORMAL)
	$(VKE) iam group list
