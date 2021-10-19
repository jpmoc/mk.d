_VMC_VDP_PROFILE_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_PROFILE_ACCESS_TOKEN?=i eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InNpZ25pbmdfMiJ9.eyJzdWIiOiJ2bXdh...
# VDP_PROFILE_ENDPOINT_URL?= https://api.vdp-stg.vmware.com
# VDP_PROFILE_NAME?= my-profile 
# VDP_PROFILE_REFRESH_TOKEN?= 2e84fd35-f106-4918-b915-76d354a5c59c

# Derived variables
VDP_PROFILE_REFRESH_TOKEN?= $(CSP_REFRESH_TOKEN)

# Option variables
__VDP_ENDPOINT= $(if $(VDP_PROFILE_ENDPOINT_URL),--endpoint $(VDP_PROFILE_ENDPOINT_URL))
__VDP_TOKEN= $(if $(VDP_PROFILE_REFRESH_TOKEN),--token $(VDP_PROFILE_REFRESH_TOKEN))

# UI variables
 
#--- Utilities

#--- MACROS

_vpd_get_profile_access_token=$(shell $(VDP) profile token | tail -1)

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@echo 'VMwareCloud::VDP::Profile ($(_VMC_VDP_PROFILE_MK_VERSION)) macros:'
	@echo '    _vdp_get_profile_access_token       - Get a CSP access token using the VDP CLI'
	@echo

_vdp_view_framework_parameters ::
	@echo 'VmwareClouD::VDP::Profile ($(_VMC_VDP_PROFILE_MK_VERSION)) parameters:'
	@echo '    VDP_PROFILE_ACCESS_TOKEN=$(VDP_PROFILE_ACCESS_TOKEN)'
	@echo '    VDP_PROFILE_ENDPOINT_URL=$(VDP_PROFILE_ENDPOINT_URL)'
	@echo '    VDP_PROFILE_NAME=$(VDP_PROFILE_NAME)'
	@echo '    VDP_PROFILE_REFRESH_TOKEN=$(VDP_PROFILE_REFRESH_TOKEN)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VmwareClouD::VDP::Profile ($(_VMC_VDP_PROFILE_MK_VERSION)) targets:'
	@echo '    _vdp_activate_profile                - Activate a profile'
	@echo '    _vdp_create_profile                  - Create a new profile'
	@echo '    _vdp_delete_profile                  - Delete an existing profile'
	@echo '    _vdp_show_profile                    - Show everything related to a profile'
	@echo '    _vdp_show_profile_description        - Show description of a profile'
	@echo '    _vdp_show_profile_token              - Show token used by profile'
	@echo '    _vdp_validate_profile                - Validate profile'
	@echo '    _vdp_view_profiles                   - View profiles'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_activate_profile:
	@$(INFO) '$(VDP_UI_LABEL)Activating profile "$(VDP_PROFILE_NAME)" ...'; $(NORMAL)
	$(VDP) profile activate $(VDP_PROFILE_NAME)

_vdp_create_profile:
	@$(INFO) '$(VDP_UI_LABEL)Creating profile "$(VDP_PROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation validates the token at the provided endpoint'; $(NORMAL)
	$(VDP) profile set $(__VDP_ENDPOINT) $(__VDP_TOKEN) $(VDP_PROFILE_NAME)

_vdp_delete_profile:
	@$(INFO) '$(VDP_UI_LABEL)Deleting profile "$(VDP_PROFILE_NAME)" ...'; $(NORMAL)
	$(VDP) profile delete $(VDP_PROFILE_NAME)

_vdp_show_profile: _vdp_show_profile_token _vdp_show_profile_description

_vdp_show_profile_description:
	@$(INFO) '$(VDP_UI_LABEL)Showing profile "$(VDP_PROFILE_NAME)" ...'; $(NORMAL)

_vdp_show_profile_token:
	@$(INFO) '$(VDP_UI_LABEL)Showing token of profile "$(VDP_PROFILE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The context name MUST be the org that is used to connect to the cluster'; $(WARN)
	$(VDP) profile token -ojson

_vdp_validate_profile:
	@$(INFO) '$(VDP_UI_LABEL)Validating profile "$(VDP_PROFILE_NAME)" ...'; $(NORMAL)
	$(VDP) profile set $(__VDP_ENDPOINT) $(__VDP_TOKEN) $(VDP_PROFILE_NAME)

_vdp_view_profiles:
	@$(INFO) '$(VDP_UI_LABEL)Viewing available profiles ...'; $(NORMAL)
	$(VDP) profile list
