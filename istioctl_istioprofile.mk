_ISTIOCTL_ISTIOPROFILE_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_ISTIOPROFILE_NAME?= default

# Derived parameters

# Options
__ICL_CONFIG_PATH=

# Customizations

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@#echo 'IstioCtL::IstioProfile ($(_ISTIOCTL_ISTIOPROFILE_MK_VERSION)) macros:'
	@#echo

_icl_list_parameters ::
	@echo 'IstioCtl::IstioProfile ($(_ISTIOCTL_ISTIOPROFILE_MK_VERSION)) variables:'
	@echo '    ICL_ISTIOPROFILE_NAME=$(ICL_ISTIOPROFILE_NAME)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::IstioProfile ($(_ISTIOCTL_ISTIOPROFILE_MK_VERSION)) targets:'
	@echo '    _icl_create_istioprofile             - Create an istio-profile'
	@echo '    _icl_delete_istioprofile             - Delete an existing istio-profile'
	@echo '    _icl_list_istioprofiles              - List all istio-profiles'
	@echo '    _icl_show_istioprofile               - Show everything related to an istio-profile'
	@echo '    _icl_show_istioprofile_config        - Show config of an istio-profile'
	@echo '    _icl_show_istioprofile_description   - Show description of an istio-profile'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_create_istioprofile:
	@$(INFO) '$(ICL_UI_LABEL)Creating istio-profile "$(ICL_ISTIOPROFILE_NAME)" ...'; $(NORMAL)

_icl_delete_istioprofile:
	@$(INFO) '$(ICL_UI_LABEL)Deleting istio-profile "$(ICL_ISTIOPROFILE_NAME)" ...'; $(NORMAL)

_icl_list_istioprofiles:
	@$(INFO) '$(ICL_UI_LABEL)Listing ALL istio-profiles ...'; $(NORMAL)
	@$(WARN) 'Active profile is: $(ICL_ISTIOPROFILE_NAME)'; $(NORMAL)
	@$(WARN) 'Profile doc @ https://istio.io/docs/setup/additional-setup/config-profiles/'; $(NORMAL)
	$(ISTIOCTL) profile list 

_icl_show_istioprofile: _icl_show_istioprofile_config _icl_show_istioprofile_description

_icl_show_istioprofile_config:
	@$(INFO) '$(ICL_UI_LABEL)Showing config of istio-profile "$(ICL_ISTIOPROFILE_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) profile dump $(__ICL_CONFIG_PATH) $(ICL_ISTIOPROFILE_NAME)

_icl_show_istioprofile_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of istio-profile "$(ICL_ISTIOPROFILE_NAME)" ...'; $(NORMAL)
