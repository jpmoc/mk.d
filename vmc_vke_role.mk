_VMC_VKE_ROLE_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_ROLE_NAME?= emayssat@vmware.com

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Role ($(_VMC_VKE_ROLE_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Role ($(_VMC_VKE_ROLE_MK_VERSION)) parameters:'
	@echo '    VKE_ROLE_NAME=$(VKE_ROLE_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Role ($(_VMC_VKE_ROLE_MK_VERSION)) targets:'A
	@echo '    _vke_view_roles                - View existing roles'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_view_roles:
	@$(INFO) '$(VKE_UI_LABEL)Viewing all roles ...'; $(NORMAL)
	$(VKE) iam role list
