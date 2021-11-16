_ISTIOCTL_ZIPKIN_MK_VERSION= $(_ISTIOCTL_MK_VERSION)

ICL_ZIPKIN_HOST?= localhost
# ICL_ZIPKIN_IP?=
# ICL_ZIPKIN_IP_OR_HOST?= localhost
ICL_ZIPKIN_NAME?= istioctl-zipkin
# ICL_ZIPKIN_NAMESPACE_NAME?= istio-system
ICL_ZIPKIN_PORT?= 3000
# ICL_ZIPKIN_PORTFORWARD_PORTS?= 3000:3000
ICL_ZIPKIN_PODS_SELECTOR?= app=zipkin
# ICL_ZIPKIN_PORTFORWARD_PORTS?= 3000:3000
# ICL_ZIPKIN_URL?= http://localhost:34139

# Derived parameters
ICL_ZIPKIN_IP_OR_HOST?= $(if $(ICL_ZIPKIN_IP),$(ICL_ZIPKIN_IP),$(ICL_ZIPKIN_HOST))
ICL_ZIPKIN_NAMESPACE_NAME?= $(ICL_ISTIO_NAMESPACE_NAME)
ICL_ZIPKIN_PORTFORWARD_PORTS?= $(ICL_ZIPKIN_PORT):$(ICL_ZIPKIN_PORT)
ICL_ZIPKIN_URL?= http://$(ICL_ZIPKIN_IP_OR_HOST):$(ICL_ZIPKIN_PORT)

# Options
__ICL_NAMESPACE__ZIPKIN= $(if $(ICL_ZIPKIN_NAMESPACE_NAME),--namespace $(ICL_ZIPKIN_NAMESPACE_NAME))
__ICL_SELECTOR__ZIPKIN= $(if $(ICL_ZIPKIN_PODS_SELECTOR),--selector $(ICL_ZIPKIN_PODS_SELECTOR))

# Customizations

#--- Utilities


#--- Macros
_icl_get_zipkin_pods_names= $(call _icl_get_zipkin_pods_names_S, $(ICL_ZIPKIN_PODS_SELECTOR))
_icl_get_zipkin_pods_names_S= $(call _icl_get_zipkin_pods_names_SN, $(1), $(ICL_ZIPKIN_NAMESPACE_NAME))
_icl_get_zipkin_pods_names_SN= $(shell $(KUBECTL) get pods --namespace $(2) --output name --selector $(1) | sed 's.pod/..' )

#----------------------------------------------------------------------
# USAGE
#

_icl_list_macros ::
	@#echo 'IstioCtL::Zipkin ($(_ISTIOCTL_ZIPKIN_MK_VERSION)) macros:'
	@#echo

_icl_list_parameters ::
	@echo 'IstioCtl::Zipkin ($(_ISTIOCTL_ZIPKIN_MK_VERSION)) variables:'
	@echo '    ICL_ZIPKIN_HOST=$(ICL_ZIPKIN_HOST)'
	@echo '    ICL_ZIPKIN_IP=$(ICL_ZIPKIN_IP)'
	@echo '    ICL_ZIPKIN_IP_OR_HOST=$(ICL_ZIPKIN_IP_OR_HOST)'
	@echo '    ICL_ZIPKIN_NAME=$(ICL_ZIPKIN_NAME)'
	@echo '    ICL_ZIPKIN_NAMESPACE_NAME=$(ICL_ZIPKIN_NAMESPACE_NAME)'
	@echo '    ICL_ZIPKIN_POD_NAME=$(ICL_ZIPKIN_POD_NAME)'
	@echo '    ICL_ZIPKIN_PODS_NAMES=$(ICL_ZIPKIN_PODS_NAMES)'
	@echo '    ICL_ZIPKIN_PODS_SELECTOR=$(ICL_ZIPKIN_PODS_SELECTOR)'
	@echo '    ICL_ZIPKIN_PORT=$(ICL_ZIPKIN_PORT)'
	@echo '    ICL_ZIPKIN_PORTFORWARD_PORTS=$(ICL_ZIPKIN_PORTFORWARD_PORTS)'
	@echo '    ICL_ZIPKIN_URL=$(ICL_ZIPKIN_URL)'
	@echo

_icl_list_targets ::
	@echo 'IstioCtl::Zipkin ($(_ISTIOCTL_ZIPKIN_MK_VERSION)) targets:'
	@echo '    _icl_open_zipkin                 - Open a zipkin-dashboard'
	@echo '    _icl_show_zipkin                 - Show everything related to a zipkin-dahsboard'
	@echo '    _icl_show_zipkin_description     - Show description of a zipkin-dashboard'
	@echo '    _icl_show_zipkin_pods            - Show pods related to a zipkin-dashboard'
	@echo '    _icl_show_zipkin_services        - Show services related to a zipkin-dashboard'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_icl_open_zipkin:
	@$(INFO) '$(ICL_UI_LABEL)Opening dashboard "$(ICL_ZIPKIN_NAME)" ...'; $(NORMAL)
	$(ISTIOCTL) dashboard zipkin 

_icl_portforward_zipkin:
	@$(INFO) '$(ICL_UI_LABEL)Port-forward to dashboard "$(ICL_ZIPKIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL) port-forward $(__ICL_NAMESPACE__ZIPKIN) $(ICL_ZIPKIN_POD_NAME) $(ICL_ZIPKIN_PORTFORWARD_PORTS)

_icl_show_zipkin: _icl_show_zipkin_pods _icl_show_zipkin_service _icl_show_zipkin_description

_icl_show_zipkin_description:
	@$(INFO) '$(ICL_UI_LABEL)Showing description of dashboard "$(ICL_ZIPKIN_NAME)" ...'; $(NORMAL)
	@echo 'ICL_ZIPKIN_URL=$(ICL_ZIPKIN_URL)'; $(NORMAL)

_icl_show_zipkin_pods:
	@$(INFO) '$(ICL_UI_LABEL)Showing pods of dashboard "$(ICL_ZIPKIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pod $(__ICL_NAMESPACE__ZIPKIN) $(__ICL_SELECTOR__ZIPKIN)

_icl_show_zipkin_service:
	@$(INFO) '$(ICL_UI_LABEL)Showing service of dashboard "$(ICL_ZIPKIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get service $(__ICL_NAMESPACE__ZIPKIN) $(_X__ICL_OUTPUT__ZIPKIN) --output wide $(__ICL_SELECTOR__ZIPKIN)
