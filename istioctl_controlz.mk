_ISTIOCTL_CONTROLZ_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

# ICL_CONTROLZ_NAME?= controlz-<my-pod>
# ICL_CONTROLZ_NAMESPACE_NAME?= istio-system
# ICL_CONTROLZ_POD_NAME?=
# ICL_CONTROLZ_PODS_NAMES?=
# ICL_CONTROLZ_PODS_SELECTOR?= app=something
# ICL_CONTROLZ_PORT?= 15000
# ICL_CONTROLZ_PORTFORWARD_PORTS?= 15000:15000
# ICL_CONTROLZ_URL?= http://localhost:15000

# Derived parameters
ICL_CONTROLZ_NAME?= controlz$(if $(ICL_CONTROLZ_POD_NAME),-$(ICL_CONTROLZ_POD_NAME))-dashboard
ICL_CONTROLZ_NAMESPACE_NAME?= $(ICL_APPMANIFEST_NAMESPACE_NAME)
ICL_CONTROLZ_URL?= http://$(ICL_CONTROLZ_IP_OR_HOST):$(ICL_CONTROLZ_PORT)

# Options
__ICL_NAMESPACE__CONTROLZ= $(if $(ICL_CONTROLZ_NAMESPACE_NAME),--namespace $(ICL_CONTROLZ_NAMESPACE_NAME))
__ICL_SELECTOR__CONTROLZ= $(if $(ICL_CONTROLZ_PODS_SELECTOR),--selector $(ICL_CONTROLZ_PODS_SELECTOR))

# Customizations

#--- Macros
_icl_get_controlz_pods_names= $(call _icl_get_controlz_pods_names_S, $(ICL_CONTROLZ_PODS_SELECTOR))
_icl_get_controlz_pods_names_S= $(call _icl_get_controlz_pods_names_SN, $(1), $(ICL_CONTROLZ_NAMESPACE_NAME))
_icl_get_controlz_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@echo 'IstioCtL::Envoy ($(_ISTIOCTL_CONTROLZ_MK_VERSION)) macros:'
	@echo '    _icl_get_controlz_pods_names_{|S|SN}   - Get the names of the controlz pods (Selector,Namespace)'
	@echo

_icl_list_parameters ::
	@echo 'IstioCtl::Envoy ($(_ISTIOCTL_CONTROLZ_MK_VERSION)) variables:'
	@echo '    ICL_CONTROLZ_NAME=$(ICL_CONTROLZ_NAME)'
	@echo '    ICL_CONTROLZ_NAMESPACE_NAME=$(ICL_CONTROLZ_NAMESPACE_NAME)'
	@echo '    ICL_CONTROLZ_POD_NAME=$(ICL_CONTROLZ_POD_NAME)'
	@echo '    ICL_CONTROLZ_PODS_NAMES=$(ICL_CONTROLZ_PODS_NAMES)'
	@echo '    ICL_CONTROLZ_PODS_SELECTOR=$(ICL_CONTROLZ_PODS_SELECTOR)'
	@echo '    ICL_CONTROLZ_PORT=$(ICL_CONTROLZ_PORT)'
	@echo '    ICL_CONTROLZ_PORTFORWARD_PORTS=$(ICL_CONTROLZ_PORTFORWARD_PORTS)'
	@echo '    ICL_CONTROLZ_URL=$(ICL_CONTROLZ_URL)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::Envoy ($(_ISTIOCTL_CONTROLZ_MK_VERSION)) targets:'
	@echo '    _icl_open_controlz                 - Open an controlz-dashboard'
	@echo '    _icl_portfoward_controlz           - Port-forward to an controlz-dashboard'
	@echo '    _icl_show_controlz                 - Show everything related to an controlz-dahsboard'
	@echo '    _icl_show_controlz_description     - Show description of a controlz-dashboard'
	@echo '    _icl_show_controlz_pods            - Show pods related to a controlz-dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_controlz:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_CONTROLZ_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard controlz $(__ICL_NAMESPACE__CONTROLZ) $(ICL_CONTROLZ_POD_NAME)

_icl_portfoward_controlz:
	@$(INFO) '$(ICL_UI_LABEL)Port-forwarding to dashboard "$(ICL_CONTROLZ_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__CONTROLZ) $(ICL_CONTROLZ_POD_NAME) $(ICL_CONTROLZ_PORTFORWARD_PORTS)

_icl_show_controlz: _icl_show_controlz_pod _icl_show_controlz_description

_icl_show_controlz_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_CONTROLZ_NAME)" ...'; $(NORMAL)
	@echo 'ICL_CONTROLZ_URL=$(ICL_CONTROLZ_URL)'; $(NORMAL)

_icl_show_controlz_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pod of dashboard "$(ICL_CONTROLZ_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__CONTROLZ) $(ICL_EVNOY_POD_NAME)
