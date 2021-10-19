_ISTIOCTL_ENVOY_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_ENVOY_NAME?= envoy-<my-pod>
# ICL_ENVOY_NAMESPACE_NAME?= istio-system
# ICL_ENVOY_POD_NAME?=
# ICL_ENVOY_PODS_NAMES?=
# ICL_ENVOY_PODS_SELECTOR?= app=something
# ICL_ENVOY_PORT?= 15000
# ICL_ENVOY_PORTFORWARD_PORTS?= 15000:15000
# ICL_ENVOY_URL?= http://localhost:15000

# Derived parameters
ICL_ENVOY_NAME?= envoy$(if $(ICL_ENVOY_POD_NAME),-$(ICL_ENVOY_POD_NAME))-dashboard
ICL_ENVOY_NAMESPACE_NAME?= $(ICL_APPMANIFEST_NAMESPACE_NAME)
ICL_ENVOY_URL?= http://$(ICL_ENVOY_IP_OR_HOST):$(ICL_ENVOY_PORT)

# Option parameters
__ICL_NAMESPACE__ENVOY= $(if $(ICL_ENVOY_NAMESPACE_NAME),--namespace $(ICL_ENVOY_NAMESPACE_NAME))
__ICL_SELECTOR__ENVOY= $(if $(ICL_ENVOY_PODS_SELECTOR),--selector $(ICL_ENVOY_PODS_SELECTOR))

# UI parameters

#--- Utilities


#--- Macros
_icl_get_envoy_pods_names= $(call _icl_get_envoy_pods_names_S, $(ICL_ENVOY_PODS_SELECTOR))
_icl_get_envoy_pods_names_S= $(call _icl_get_envoy_pods_names_SN, $(1), $(ICL_ENVOY_NAMESPACE_NAME))
_icl_get_envoy_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_view_framework_macros ::
	@echo 'IstioCtL::Envoy ($(_ISTIOCTL_ENVOY_MK_VERSION)) macros:'
	@echo

_icl_view_framework_parameters ::
	@echo 'IstioCtl::Envoy ($(_ISTIOCTL_ENVOY_MK_VERSION)) variables:'
	@echo '    ICL_ENVOY_NAME=$(ICL_ENVOY_NAME)'
	@echo '    ICL_ENVOY_NAMESPACE_NAME=$(ICL_ENVOY_NAMESPACE_NAME)'
	@echo '    ICL_ENVOY_POD_NAME=$(ICL_ENVOY_POD_NAME)'
	@echo '    ICL_ENVOY_PODS_NAMES=$(ICL_ENVOY_PODS_NAMES)'
	@echo '    ICL_ENVOY_PODS_SELECTOR=$(ICL_ENVOY_PODS_SELECTOR)'
	@echo '    ICL_ENVOY_PORT=$(ICL_ENVOY_PORT)'
	@echo '    ICL_ENVOY_PORTFORWARD_PORTS=$(ICL_ENVOY_PORTFORWARD_PORTS)'
	@echo '    ICL_ENVOY_URL=$(ICL_ENVOY_URL)'
	@echo

_icl_view_framework_targets ::
	@echo 'IstioCtl::Envoy ($(_ISTIOCTL_ENVOY_MK_VERSION)) targets:'
	@echo '    _icl_open_envoy                 - Open an envoy-dashboard'
	@echo '    _icl_portfoward_envoy           - Port-forward to an envoy-dashboard'
	@echo '    _icl_show_envoy                 - Show everything related to an envoy-dahsboard'
	@echo '    _icl_show_envoy_description     - Show description of a envoy-dashboard'
	@echo '    _icl_show_envoy_pods            - Show pods related to a envoy-dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_envoy:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_ENVOY_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard envoy $(__ICL_NAMESPACE__ENVOY) $(ICL_ENVOY_POD_NAME)

_icl_portfoward_envoy:
	@$(INFO) '$(ICL_UI_LABEL)Port-forwarding to dashboard "$(ICL_ENVOY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__ENVOY) $(ICL_ENVOY_POD_NAME) $(ICL_ENVOY_PORTFORWARD_PORTS)

_icl_show_envoy: _icl_show_envoy_pod _icl_show_envoy_description

_icl_show_envoy_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_ENVOY_NAME)" ...'; $(NORMAL)
	@echo 'ICL_ENVOY_URL=$(ICL_ENVOY_URL)'; $(NORMAL)

_icl_show_envoy_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pod of dashboard "$(ICL_ENVOY_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__ENVOY) $(ICL_EVNOY_POD_NAME)
