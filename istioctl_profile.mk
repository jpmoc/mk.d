_ISTIOCTL_PROFILE_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_PROFILE_NAME?= default

# Derived parameters

# Option parameters
__ICL_CONFIG_PATH=

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_view_framework_macros ::
	@echo 'IstioCtL::Profile ($(_ISTIOCTL_PROFILE_MK_VERSION)) macros:'
	@echo

_icl_view_framework_parameters ::
	@echo 'IstioCtl::Profile ($(_ISTIOCTL_PROFILE_MK_VERSION)) variables:'
	@echo '    ICL_PROFILE_NAME=$(ICL_PROFILE_NAME)'
	@echo

_icl_view_framework_targets ::
	@echo 'IstioCtl::Profile ($(_ISTIOCTL_PROFILE_MK_VERSION)) targets:'
	@echo '    _icl_view_profiles          - View profiles'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_create_profile:

_icl_delete_profile:

_icl_show_profile: _icl_show_profile_description

_icl_show_profile_description:
	@$(INFO) '$(ICL_UI_LABEL)Show profile "$(ICL_PROFILE_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) profile dump $(__ICL_CONFIG_PATH) $(ICL_PROFILE_NAME)

_icl_view_profiles:
	@$(INFO) '$(ICL_UI_LABEL)Viewing profiles ...'; $(NORMAL)
	$(ISTIOCTL) profile list 
