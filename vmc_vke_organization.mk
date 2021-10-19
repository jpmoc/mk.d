_VMC_VKE_ORGANIZATION_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_ORGANIZATION_ID?= 82c51815-bced-4b00-a49a-XXXXXXXXXXXXX
# VKE_ORGANIZATION_NAME?=

# Derived variables
VKE_ORGANIZATION_ID?= $(CSP_ORGANIZATION_ID)
VKE_ORGANIZATION_NAME?= $(CSP_ORGANIZATION_NAME)

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#


_vke_view_framework_macros ::
	@#echo 'VMC::VKE::Organization ($(_VMC_VKE_ORGANIZATION_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::Organization ($(_VMC_VKE_ORGANIZATION_MK_VERSION)) parameters:'
	@echo '    VKE_ORGANIZATION_ID=$(VKE_ORGANIZATION_ID)'
	@echo '    VKE_ORGANIZATION_NAME=$(VKE_ORGANIZATION_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::Organization ($(_VMC_VKE_ORGANIZATION_MK_VERSION)) targets:'
	@echo '    _vke_show_organization                 - Show everything related to an organization'
	@echo '    _vke_show_organization_accesspolicy    - Show access-policy of an organization'
	@echo '    _vke_show_organization_description     - Show description of an organization'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_show_organization: _vke_show_organization_accesspolicy _vke_show_organization_description

_vke_show_organization_accesspolicy:
	@$(INFO) '$(VKE_UI_LABEL)Showing access-policies of organization "$(VKE_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(VKE) organization iam show $(VKE_ORGANIZATION_ID)

_vke_show_organization_description:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of organization "$(VKE_ORGANIZATION_NAME)" ...'; $(NORMAL)
	$(VKE) organization show $(VKE_ORGANIZATION_ID)
