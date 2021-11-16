_ISTIOCTL_ISTIORELEASE_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_ISTIORELEASE_NAME?= istio-1.4.3
# ICL_ISTIORELEASE_NAMESPACE_NAME?= istio-system

# Derived parameters
ICL_ISTIORELEASE_NAMESPACE_NAME?= $(ICL_ISTIO_NAMESPACE_NAME)

# Options
__ICL_NAMESPACE__ISTIORELEASE?= $(if $(ICL_ISTIORELEASE_NAMESPACE_NAME),--namespace $(ICL_ISTIORELEASE_NAMESPACE_NAME))

# Customizations

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@#echo 'IstioCtL::IstioRelease ($(_ISTIOCTL_ISTIORELEASE_MK_VERSION)) macros:'
	@#echo

_icl_list_parameters ::
	@echo 'IstioCtl::IstioRelease ($(_ISTIOCTL_ISTIORELEASE_MK_VERSION)) variables:'
	@echo '    ICL_ISTIORELEASE_CONFIG_FILEPATH=$(ICL_ISTIORELEASE_CONFIG_FILEPATH)'
	@echo '    ICL_ISTIORELEASE_NAME=$(ICL_ISTIORELEASE_NAME)'
	@echo '    ICL_ISTIORELEASE_NAMESPACE_NAME=$(ICL_ISTIORELEASE_NAMESPACE_NAME)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::IstioRelease ($(_ISTIOCTL_ISTIORELEASE_MK_VERSION)) targets:'
	@echo '    _icl_downgrade_istiorelease          - Downgrade istio-release'
	@echo '    _icl_list_istioreleases              - List all istio-releases'
	@echo '    _icl_show_istiorelease               - Show everything related to an istio-release'
	@echo '    _icl_show_istiorelease_description   - Show description of an istio-release'
	@echo '    _icl_show_istiorelease_proxy-status  - Show the proxy-status of an istio-release'
	@echo '    _icl_upgrade_istiorelease            - Upgrade istio-release'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_create_istiorelease:

_icl_delete_istiorelease:

_icl_downgrade_istiorelease:
	@$(INFO) '$(ICL_UI_LABEL)Downgrade istio-release "$(ICL_ISTIORELEASE_NAME)" ...'; $(NORMAL)
	# $(ISTIOCTL) experimental upgrade -f CONFIG

_icl_list_istioreleases:
	@$(INFO) '$(ICL_UI_LABEL)Listing ALL istio-releases ...'; $(NORMAL)

_ICL_SHOW_ISTIORELEASE_TARGETS?= _icl_show_istiorelease_pods _icl_show_istiorelease_proxystatus _icl_show_istiorelease_description
_icl_show_istiorelease: $(_ICL_SHOW_ISTIORELEASE_TARGETS)

_icl_show_istiorelease_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing istio-release "$(ICL_ISTIORELEASE_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) version

_icl_show_istiorelease_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pods of istio-release "$(ICL_ISTIORELEASE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(__ICL_NAMESPACE__ISTIORELEASE)

_icl_show_istiorelease_proxystatus:
	@$(INFO) '$(ICL_UI_LABEL)Showing the proxy-status of istio-release "$(ICL_ISTIORELEASE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'CDS = Cluster Discovery Service ~ Group of hosts/ports over which to load balance traffici ==> advisory, eventually consistent'
	@$(WARN) 'EDS = Endpoint Discovery Service ~ IP, Port available within a cluster ==> periodic polls, advisory, eventually consistent'
	@$(WARN) 'LDS = Listener Discovery Service ~ Ports to the outside world into which app can connect'
	@$(WARN) 'RDS = Routing Discovery Service ~ Routes as data and not configuration'; $(NORMAL)
	$(ISTIOCTL) proxy-status

_icl_upgrade_istiorelease:
	@$(INFO) '$(ICL_UI_LABEL)Upgrading istio-release "$(ICL_ISTIORELEASE_NAME)" ...'; $(NORMAL)
	# $(ISTIOCTL) experimental upgrade -f COFNIG
