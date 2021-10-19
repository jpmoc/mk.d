_VMC_VKE_USER_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_USER_NAME?= emayssat@vmware.com

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::User ($(_VMC_VKE_USER_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::User ($(_VMC_VKE_USER_MK_VERSION)) parameters:'
	@echo '    VKE_USER_NAME=$(VKE_USER_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::User ($(_VMC_VKE_USER_MK_VERSION)) targets:'A
	@echo '    _vke_show_user                 - Show everything related to a user'
	@echo '    _vke_view_users                - View existing users'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_show_user:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of user "$(VKE_USER_NAME)" ...'; $(NORMAL)
	$(VKE) iam user show $(VKE_USER_NAME)

_vke_view_users:
	@$(INFO) '$(VKE_UI_LABEL)Viewing all users in current organization ...'; $(NORMAL)
	$(VKE) iam user list
