_ISTIOCTL_GRAFANA_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_KIALI_HOST?= localhost
# ICL_KIALI_IP?= localhost
# ICL_KIALI_IP_OR_HOST?= localhost
ICL_KIALI_NAME?= istioctl-kiali
# ICL_KIALI_NAMESPACE_NAME?= istio-system
ICL_KIALI_PODS_SELECTOR?= app=kiali
ICL_KIALI_PORT?= 20001
# ICL_KIALI_PORTFORWARD_PORTS?= 20001:20001
# ICL_KIALI_URL?= http://localhost:34629/kiali

# Derived parameters
ICL_KIALI_IP_OR_HOST?= $(if $(ICL_KIALI_IP),$(ICL_KIALI_IP),$(ICL_KIALI_HOST))
ICL_KIALI_NAMESPACE_NAME?= $(ICL_ISTIO_NAMESPACE_NAME)
ICL_KIALI_PORTFORWARD_PORTS?= $(ICL_KIALI_PORT):$(ICL_KIALI_PORT)
# ICL_KIALI_URL?= http://$(ICL_KIALI_IP_OR_HOST):$(ICL_KIALI_PORT)/kiali

# Options
__ICL_NAMESPACE__KIALI= $(if $(ICL_KIALI_NAMESPACE_NAME),--namespace $(ICL_KIALI_NAMESPACE_NAME))
__ICL_SELECTOR__KIALI= $(if $(ICL_KIALI_PODS_SELECTOR),--selector $(ICL_KIALI_PODS_SELECTOR))

# Customizations

#--- Utilities

#--- Macros
_icl_get_kiali_pods_names= $(call _icl_get_kiali_pods_names_S, $(ICL_KIALI_PODS_SELECTOR))
_icl_get_kiali_pods_names_S= $(call _icl_get_kiali_pods_names_SN, $(1), $(ICL_KIALI_NAMESPACE_NAME))
_icl_get_kiali_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@echo 'IstioCtL::Kiali ($(_ISTIOCTL_KIALI_MK_VERSION)) macros:'
	@echo '    _icl_get_kiali_pods_names_{|S|SN}     - Get the names of the kiali pods (Selector,Namespace)'
	@echo

_icl_list_parameters ::
	@echo 'IstioCtl::Kiali ($(_ISTIOCTL_KIALI_MK_VERSION)) variables:'
	@echo '    ICL_KIALI_HOST=$(ICL_KIALI_HOST)'
	@echo '    ICL_KIALI_IP=$(ICL_KIALI_IP)'
	@echo '    ICL_KIALI_IP_OR_HOST=$(ICL_KIALI_IP_OR_HOST)'
	@echo '    ICL_KIALI_NAME=$(ICL_KIALI_NAME)'
	@echo '    ICL_KIALI_POD_NAME=$(ICL_KIALI_POD_NAME)'
	@echo '    ICL_KIALI_PODS_NAMES=$(ICL_KIALI_PODS_NAMES)'
	@echo '    ICL_KIALI_PODS_SELECTOR=$(ICL_KIALI_PODS_SELECTOR)'
	@echo '    ICL_KIALI_PORT=$(ICL_KIALI_PORT)'
	@echo '    ICL_KIALI_PORTFORWARD_PORTS=$(ICL_KIALI_PORTFORWARD_PORTS)'
	@echo '    ICL_KIALI_URL=$(ICL_KIALI_URL)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::Kiali ($(_ISTIOCTL_KIALI_MK_VERSION)) targets:'
	@echo '    _icl_open_kiali                 - Open the kiali-dashboard'
	@echo '    _icl_portforward_kiali          - Port-forward to the kiali-dashboard'
	@echo '    _icl_show_kiali                 - Show everything related to a dashboard'
	@echo '    _icl_show_kiali_description     - Show description of a dashboard'
	@echo '    _icl_show_kiali_pods            - Show pods related to a dashboard'
	@echo '    _icl_show_kiali_services        - Show services related to a dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_kiali:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_KIALI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation port-forwards on a random port to one of the kiali pods'; $(NORMAL)
	$(ISTIOCTL) dashboard kiali

_icl_portforward_kiali:
	@$(INFO) '$(ICL_UI_LABEL)Port-forwarding to dashboard "$(ICL_KIALI_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__KIALI) $(ICL_KIALI_POD_NAME) $(ICL_KIALI_PORTFORWARD_PORTS)

_icl_show_kiali: _icl_show_kiali_pods _icl_show_kiali_secrets _icl_show_kiali_service _icl_show_kiali_description

_icl_show_kiali_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_KIALI_NAME)" ...'; $(NORMAL)
	@echo 'ICL_KIALI_URL=$(ICL_KIALI_URL)'; $(NORMAL)

_icl_show_kiali_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pods of dashboard "$(ICL_KIALI_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__KIALI) $(__ICL_SELECTOR__KIALI)

_icl_show_kiali_secrets:
	@$(INFO) '$(ICL_UI_LABEL)Showing secrets of dashboard "$(ICL_KIALI_NAME)" ...'; $(NORMAL)
	@$(WARN) 'At the minimum, this operation returns the secret with the kiali-dashboard credentials'; $(NORMAL)
	$(KUBECTL) get secrets $(__ICL_NAMESPACE__KIALI) $(__ICL_SELECTOR__KIALI)

_icl_show_kiali_service:
	@$(INFO) '$(ICL_UI_LABEL)Showing service of dashboard "$(ICL_KIALI_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get service $(__ICL_NAMESPACE__KIALI) $(__ICL_SELECTOR__KIALI)
