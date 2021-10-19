_VMC_VSM_PROFILE_MK_VERSION= $(_VMC_VSM_MK_VERSION)

# VSM_PROFILE_ORGANIZATION_ID?=
# VSM_PROFILE_ORGANIZATION_NAME?=
# VSM_PROFILE_REFRESH_TOKEN?=

# Derived variables

# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vsm_view_framework_macros ::
	@echo 'VmwareCloud::VSM::Profile ($(_VMC_VSM_PROFILE_MK_VERSION)) macros:'
	@echo

_vsm_view_framework_parameters ::
	@echo 'VmwareCloud::VSM::Profile ($(_VMC_VSM_PROFILE_MK_VERSION)) parameters:'
	@echo '    VSM_PROFILE_ORGANIZATION_ID=$(VSM_PROFILE_ORGANIZATION_ID)'
	@echo '    VSM_PROFILE_ORGANIZATION_NAME=$(VSM_PROFILE_ORGANIZATION_NAME)'
	@echo '    VSM_PROFILE_REFRESH_TOKEN=$(VSM_PROFILE_REFRESH_TOKEN)'
	@echo

_vsm_view_framework_targets ::
	@echo 'VmwareCloud::VSM::Profile ($(_VMC_VSM_PROFILE_MK_VERSION)) targets:'
	@echo '    _vsm_set_org              - Set the CSP org'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vsm_update_profile_organization:
	@$(INFO) '$(VSM_UI_LABEL)Reconfiguring profile with org ...'; $(NORMAL)
	$(VSM) csp set orgid $(VSM_PROFILE_ORGANIZATION_ID)

_vsm_update_profile_vkeconfig:
	@$(INFO) '$(VSM_UI_LABEL)Login in the VKE ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the corresponding org/token are not production ones'; $(NORMAL)
	$(VSM) csp get access token $(VSM_PROFILE_REFRESH_TOKEN) --vke
