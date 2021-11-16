_ISTIOCTL_JAEGER_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_JAEGER_HOST?= localhost
# ICL_JAEGER_IP?=
# ICL_JAEGER_IP_OR_HOST?= localhost
ICL_JAEGER_NAME?= istioctl-jaeger
# ICL_JAEGER_NAMESPACE_NAME?= istio-system
ICL_JAEGER_PORT?= 3000
# ICL_JAEGER_PORTFORWARD_PORTS?= 3000:3000
ICL_JAEGER_PODS_SELECTOR?= app=jaeger
# ICL_JAEGER_PORTFORWARD_PORTS?= 3000:3000
# ICL_JAEGER_URL?= http://localhost:34139

# Derived parameters
ICL_JAEGER_IP_OR_HOST?= $(if $(ICL_JAEGER_IP),$(ICL_JAEGER_IP),$(ICL_JAEGER_HOST))
ICL_JAEGER_NAMESPACE_NAME?= $(ICL_ISTIO_NAMESPACE_NAME)
ICL_JAEGER_PORTFORWARD_PORTS?= $(ICL_JAEGER_PORT):$(ICL_JAEGER_PORT)
ICL_JAEGER_URL?= http://$(ICL_JAEGER_IP_OR_HOST):$(ICL_JAEGER_PORT)

# Options
__ICL_NAMESPACE__JAEGER= $(if $(ICL_JAEGER_NAMESPACE_NAME),--namespace $(ICL_JAEGER_NAMESPACE_NAME))
__ICL_SELECTOR__JAEGER= $(if $(ICL_JAEGER_PODS_SELECTOR),--selector $(ICL_JAEGER_PODS_SELECTOR))

# Customizations

#--- Utilities


#--- Macros
_icl_get_jaeger_pods_names= $(call _icl_get_jaeger_pods_names_S, $(ICL_JAEGER_PODS_SELECTOR))
_icl_get_jaeger_pods_names_S= $(call _icl_get_jaeger_pods_names_SN, $(1), $(ICL_JAEGER_NAMESPACE_NAME))
_icl_get_jaeger_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@echo 'IstioCtL::Jaeger ($(_ISTIOCTL_JAEGER_MK_VERSION)) macros:'
	@echo '    _icl_get_jaeger_pods_names_{|S|SN}   - Get the names of the jaeger pods (Selector,namespace)'
	@echo

_icl_list_parameters ::
	@echo 'IstioCtl::Jaeger ($(_ISTIOCTL_JAEGER_MK_VERSION)) variables:'
	@echo '    ICL_JAEGER_HOST=$(ICL_JAEGER_HOST)'
	@echo '    ICL_JAEGER_IP=$(ICL_JAEGER_IP)'
	@echo '    ICL_JAEGER_IP_OR_HOST=$(ICL_JAEGER_IP_OR_HOST)'
	@echo '    ICL_JAEGER_NAME=$(ICL_JAEGER_NAME)'
	@echo '    ICL_JAEGER_NAMESPACE_NAME=$(ICL_JAEGER_NAMESPACE_NAME)'
	@echo '    ICL_JAEGER_POD_NAME=$(ICL_JAEGER_POD_NAME)'
	@echo '    ICL_JAEGER_PODS_NAMES=$(ICL_JAEGER_PODS_NAMES)'
	@echo '    ICL_JAEGER_PODS_SELECTOR=$(ICL_JAEGER_PODS_SELECTOR)'
	@echo '    ICL_JAEGER_PORT=$(ICL_JAEGER_PORT)'
	@echo '    ICL_JAEGER_PORTFORWARD_PORTS=$(ICL_JAEGER_PORTFORWARD_PORTS)'
	@echo '    ICL_JAEGER_URL=$(ICL_JAEGER_URL)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::Jaeger ($(_ISTIOCTL_JAEGER_MK_VERSION)) targets:'
	@echo '    _icl_open_jaeger                 - Open a jaeger-dashboard'
	@echo '    _icl_show_jaeger                 - Show everything related to a jaeger-dahsboard'
	@echo '    _icl_show_jaeger_description     - Show description of a jaeger-dashboard'
	@echo '    _icl_show_jaeger_pods            - Show pods related to a jaeger-dashboard'
	@echo '    _icl_show_jaeger_services        - Show services related to a jaeger-dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_jaeger:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_JAEGER_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard jaeger 

_icl_portforward_jaeger:
	@$(INFO) '$(ICL_UI_LABEL)Port-forward to dashboard "$(ICL_JAEGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__JAEGER) $(ICL_JAEGER_POD_NAME) $(ICL_JAEGER_PORTFORWARD_PORTS)

_icl_show_jaeger: _icl_show_jaeger_pods _icl_show_jaeger_service _icl_show_jaeger_description

_icl_show_jaeger_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_JAEGER_NAME)" ...'; $(NORMAL)
	@echo 'ICL_JAEGER_URL=$(ICL_JAEGER_URL)'; $(NORMAL)

_icl_show_jaeger_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pods of dashboard "$(ICL_JAEGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__JAEGER) $(__ICL_SELECTOR__JAEGER)

_icl_show_jaeger_service:
	@$(INFO) '$(ICL_UI_LABEL)Showing service of dashboard "$(ICL_JAEGER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get service $(__ICL_NAMESPACE__JAEGER) $(_X__ICL_OUTPUT__JAEGER) --output wide $(__ICL_SELECTOR__JAEGER)
