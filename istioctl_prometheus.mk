_ISTIOCTL_PROMETHEUS_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_PROMETHEUS_HOST?= localhost
# ICL_PROMETHEUS_IP?=
# ICL_PROMETHEUS_IP_OR_HOST?= localhost
ICL_PROMETHEUS_NAME?= istioctl-prometheus
# ICL_PROMETHEUS_NAMESPACE_NAME?= istio-system
ICL_PROMETHEUS_PORT?= 3000
# ICL_PROMETHEUS_PORTFORWARD_PORTS?= 3000:3000
ICL_PROMETHEUS_PODS_SELECTOR?= app=prometheus
# ICL_PROMETHEUS_PORTFORWARD_PORTS?= 3000:3000
# ICL_PROMETHEUS_URL?= http://localhost:34139

# Derived parameters
ICL_PROMETHEUS_IP_OR_HOST?= $(if $(ICL_PROMETHEUS_IP),$(ICL_PROMETHEUS_IP),$(ICL_PROMETHEUS_HOST))
ICL_PROMETHEUS_NAMESPACE_NAME?= $(ICL_ISTIO_NAMESPACE_NAME)
ICL_PROMETHEUS_PORTFORWARD_PORTS?= $(ICL_PROMETHEUS_PORT):$(ICL_PROMETHEUS_PORT)
ICL_PROMETHEUS_URL?= http://$(ICL_PROMETHEUS_IP_OR_HOST):$(ICL_PROMETHEUS_PORT)

# Option parameters
__ICL_NAMESPACE__PROMETHEUS= $(if $(ICL_PROMETHEUS_NAMESPACE_NAME),--namespace $(ICL_PROMETHEUS_NAMESPACE_NAME))
__ICL_SELECTOR__PROMETHEUS= $(if $(ICL_PROMETHEUS_PODS_SELECTOR),--selector $(ICL_PROMETHEUS_PODS_SELECTOR))

# UI parameters

#--- Utilities


#--- Macros
_icl_get_prometheus_pods_names= $(call _icl_get_prometheus_pods_names_S, $(ICL_PROMETHEUS_PODS_SELECTOR))
_icl_get_prometheus_pods_names_S= $(call _icl_get_prometheus_pods_names_SN, $(1), $(ICL_PROMETHEUS_NAMESPACE_NAME))
_icl_get_prometheus_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@echo 'IstioCtL::Prometheus ($(_ISTIOCTL_PROMETHEUS_MK_VERSION)) macros:'
	@echo '   _icl_get_prometheus_pods_names_{|S|SN}   - Get the names of the prometheus pods (Selector,Namespace)'
	@echo

_icl_list_parameters ::
	@echo 'IstioCtl::Prometheus ($(_ISTIOCTL_PROMETHEUS_MK_VERSION)) variables:'
	@echo '    ICL_PROMETHEUS_HOST=$(ICL_PROMETHEUS_HOST)'
	@echo '    ICL_PROMETHEUS_IP=$(ICL_PROMETHEUS_IP)'
	@echo '    ICL_PROMETHEUS_IP_OR_HOST=$(ICL_PROMETHEUS_IP_OR_HOST)'
	@echo '    ICL_PROMETHEUS_NAME=$(ICL_PROMETHEUS_NAME)'
	@echo '    ICL_PROMETHEUS_NAMESPACE_NAME=$(ICL_PROMETHEUS_NAMESPACE_NAME)'
	@echo '    ICL_PROMETHEUS_POD_NAME=$(ICL_PROMETHEUS_POD_NAME)'
	@echo '    ICL_PROMETHEUS_PODS_NAMES=$(ICL_PROMETHEUS_PODS_NAMES)'
	@echo '    ICL_PROMETHEUS_PODS_SELECTOR=$(ICL_PROMETHEUS_PODS_SELECTOR)'
	@echo '    ICL_PROMETHEUS_PORT=$(ICL_PROMETHEUS_PORT)'
	@echo '    ICL_PROMETHEUS_PORTFORWARD_PORTS=$(ICL_PROMETHEUS_PORTFORWARD_PORTS)'
	@echo '    ICL_PROMETHEUS_URL=$(ICL_PROMETHEUS_URL)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::Prometheus ($(_ISTIOCTL_PROMETHEUS_MK_VERSION)) targets:'
	@echo '    _icl_open_prometheus                 - Open a prometheus-dashboard'
	@echo '    _icl_show_prometheus                 - Show everything related to a prometheus-dahsboard'
	@echo '    _icl_show_prometheus_description     - Show description of a prometheus-dashboard'
	@echo '    _icl_show_prometheus_pods            - Show pods related to a prometheus-dashboard'
	@echo '    _icl_show_prometheus_services        - Show services related to a prometheus-dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_prometheus:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_PROMETHEUS_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard prometheus 

_icl_portforward_prometheus:
	@$(INFO) '$(ICL_UI_LABEL)Port-forward to dashboard "$(ICL_PROMETHEUS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__PROMETHEUS) $(ICL_PROMETHEUS_POD_NAME) $(ICL_PROMETHEUS_PORTFORWARD_PORTS)

_icl_show_prometheus: _icl_show_prometheus_pods _icl_show_prometheus_service _icl_show_prometheus_description

_icl_show_prometheus_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_PROMETHEUS_NAME)" ...'; $(NORMAL)
	@echo 'ICL_PROMETHEUS_URL=$(ICL_PROMETHEUS_URL)'; $(NORMAL)

_icl_show_prometheus_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pods of dashboard "$(ICL_PROMETHEUS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__PROMETHEUS) $(__ICL_SELECTOR__PROMETHEUS)

_icl_show_prometheus_service:
	@$(INFO) '$(ICL_UI_LABEL)Showing service of dashboard "$(ICL_PROMETHEUS_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get service $(__ICL_NAMESPACE__PROMETHEUS) $(_X__ICL_OUTPUT__PROMETHEUS) --output wide $(__ICL_SELECTOR__PROMETHEUS)
