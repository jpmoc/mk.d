_ISTIOCTL_GRAFANA_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_GRAFANA_HOST?= localhost
# ICL_GRAFANA_IP?=
# ICL_GRAFANA_IP_OR_HOST?= localhost
ICL_GRAFANA_NAME?= istioctl-grafana
# ICL_GRAFANA_NAMESPACE_NAME?= istio-system
ICL_GRAFANA_PORT?= 3000
# ICL_GRAFANA_PORTFORWARD_PORTS?= 3000:3000
ICL_GRAFANA_PODS_SELECTOR?= app=grafana
# ICL_GRAFANA_PORTFORWARD_PORTS?= 3000:3000
# ICL_GRAFANA_URL?= http://localhost:34139

# Derived parameters
ICL_GRAFANA_IP_OR_HOST?= $(if $(ICL_GRAFANA_IP),$(ICL_GRAFANA_IP),$(ICL_GRAFANA_HOST))
ICL_GRAFANA_NAMESPACE_NAME?= $(ICL_ISTIO_NAMESPACE_NAME)
ICL_GRAFANA_PORTFORWARD_PORTS?= $(ICL_GRAFANA_PORT):$(ICL_GRAFANA_PORT)
ICL_GRAFANA_URL?= http://$(ICL_GRAFANA_IP_OR_HOST):$(ICL_GRAFANA_PORT)

# Option parameters
__ICL_NAMESPACE__GRAFANA= $(if $(ICL_GRAFANA_NAMESPACE_NAME),--namespace $(ICL_GRAFANA_NAMESPACE_NAME))
__ICL_SELECTOR__GRAFANA= $(if $(ICL_GRAFANA_PODS_SELECTOR),--selector $(ICL_GRAFANA_PODS_SELECTOR))

# UI parameters

#--- Utilities


#--- Macros
_icl_get_grafana_pods_names= $(call _icl_get_grafana_pods_names_S, $(ICL_GRAFANA_PODS_SELECTOR))
_icl_get_grafana_pods_names_S= $(call _icl_get_grafana_pods_names_SN, $(1), $(ICL_GRAFANA_NAMESPACE_NAME))
_icl_get_grafana_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@echo 'IstioCtL::Grafana ($(_ISTIOCTL_GRAFANA_MK_VERSION)) macros:'
	@echo '    _icl_get_grafana_pods_names_{|S|SN}  - Get the names of the grafana pods (Selector,Namespace)'
	@echo

_icl_list_parameters ::
	@echo 'IstioCtl::Grafana ($(_ISTIOCTL_GRAFANA_MK_VERSION)) variables:'
	@echo '    ICL_GRAFANA_HOST=$(ICL_GRAFANA_HOST)'
	@echo '    ICL_GRAFANA_IP=$(ICL_GRAFANA_IP)'
	@echo '    ICL_GRAFANA_IP_OR_HOST=$(ICL_GRAFANA_IP_OR_HOST)'
	@echo '    ICL_GRAFANA_NAME=$(ICL_GRAFANA_NAME)'
	@echo '    ICL_GRAFANA_NAMESPACE_NAME=$(ICL_GRAFANA_NAMESPACE_NAME)'
	@echo '    ICL_GRAFANA_POD_NAME=$(ICL_GRAFANA_POD_NAME)'
	@echo '    ICL_GRAFANA_PODS_NAMES=$(ICL_GRAFANA_PODS_NAMES)'
	@echo '    ICL_GRAFANA_PODS_SELECTOR=$(ICL_GRAFANA_PODS_SELECTOR)'
	@echo '    ICL_GRAFANA_PORT=$(ICL_GRAFANA_PORT)'
	@echo '    ICL_GRAFANA_PORTFORWARD_PORTS=$(ICL_GRAFANA_PORTFORWARD_PORTS)'
	@echo '    ICL_GRAFANA_URL=$(ICL_GRAFANA_URL)'
	@echo '    ICL_DASHBOARDS_SET_NAME=$(ICL_DASHBOARDS_SET_NAME)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::Grafana ($(_ISTIOCTL_GRAFANA_MK_VERSION)) targets:'
	@echo '    _icl_open_grafana                 - Open a grafana-dashboard'
	@echo '    _icl_show_grafana                 - Show everything related to a grafana-dahsboard'
	@echo '    _icl_show_grafana_description     - Show description of a grafana-dashboard'
	@echo '    _icl_show_grafana_pods            - Show pods related to a grafana-dashboard'
	@echo '    _icl_show_grafana_services        - Show services related to a grafana-dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_grafana:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_GRAFANA_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard grafana 

_icl_portforward_grafana:
	@$(INFO) '$(ICL_UI_LABEL)Port-forward to dashboard "$(ICL_GRAFANA_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__GRAFANA) $(ICL_GRAFANA_POD_NAME) $(ICL_GRAFANA_PORTFORWARD_PORTS)

_icl_show_grafana: _icl_show_grafana_pods _icl_show_grafana_service _icl_show_grafana_description

_icl_show_grafana_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_GRAFANA_NAME)" ...'; $(NORMAL)
	@echo 'ICL_GRAFANA_URL=$(ICL_GRAFANA_URL)'; $(NORMAL)

_icl_show_grafana_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pods of dashboard "$(ICL_GRAFANA_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__GRAFANA) $(__ICL_SELECTOR__GRAFANA)

_icl_show_grafana_service:
	@$(INFO) '$(ICL_UI_LABEL)Showing service of dashboard "$(ICL_GRAFANA_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get service $(__ICL_NAMESPACE__GRAFANA) $(_X__ICL_OUTPUT__GRAFANA) --output wide $(__ICL_SELECTOR__GRAFANA)
