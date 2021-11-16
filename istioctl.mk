_ISTIOCTL_MK_VERSION= 0.99.4

# ICL_INPUTS_DIRPATH?= ./in/
# ICL_OUTPUTS_DIRPATH?= ./out/
# ICL_ISTIOPILOT_HOST?= istio-pilot.istio-system.svc.cluster.local
ICL_ISTIOPILOT_PORT?= 8080
# ICL_ISTIOPROXY_PILOT_HOSTPORT?= istio-pilot.istio-system.svc.cluster.local:8080
ICL_UI_LABEL?= [istioctl] #
ISTIOCTL_ISTIO_NAMESPACE_NAME?= istio-system
# ISTIOCTL_KUBECONFIG_FILEPATH?=

# Derived parameters
ICL_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
ICL_ISTIO_NAMESPACE_NAME?= $(ISTIOCTL_ISTIO_NAMESPACE_NAME)
ICL_ISTIOPILOT_HOST?= istio-pilot.$(ICL_ISTIOPILOT_NAMESPACE_NAME).svc.cluster.local
ICL_ISTIOPILOT_HOSTPORT?= $(ICL_ISTIOPILOT_HOST):$(ICL_ISTIOPILOT_PORT)
ICL_ISTIOPILOT_NAMESPACE_NAME?= $(ISTIOCTL_ISTIO_NAMESPACE_NAME)
ICL_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)
ISTIOCTL_KUBECONFIG_FILEPATH?= $(KUBECTL_KUBECONFIG_FILEPATH)

# Options

# Customizations

#--- Utilities

__ISTIOCTL_OPTIONS+= $(if $(ISTIOCTL_ISTIO_NAMESPACE_NAME),--istioNamespace $(ISTIOCTL_ISTIO_NAMESPACE_NAME))
__ISTIOCTL_OPTIONS+= $(if $(ISTIOCTL_KUBECONFIG_FILEPATH),--kubeconfig $(ISTIOCTL_KUBECONFIG_FILEPATH))

ISTIOCTL_BIN?= istioctl
ISTIOCTL?= $(strip $(__ISTIOCTL_ENVIRONMENT) $(ISTIOCTL_ENVIRONMENT) $(ISTIOCTL_BIN) $(__ISTIOCTL_OPTIONS) $(ISTIOCTL_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _icl_list_macros
_icl_list_macros ::
	@#echo 'IstioCtL:: ($(_ISTIOCTL_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _icl_list_parameters
_icl_list_parameters ::
	@echo 'IstioCtL:: ($(_ISTIOCTL_MK_VERSION)) variables:'
	@echo '    ICL_INPUTS_DIRPATH=$(ICL_INPUTS_DIRPATH)'
	@echo '    ICL_ISTIO_NAMESPACE_NAME=$(ICL_ISTIO_NAMESPACE_NAME)'
	@echo '    ICL_ISTIOPILOT_HOST=$(ICL_ISTIOPILOT_HOST)'
	@echo '    ICL_ISTIOPILOT_HOSTPORT=$(ICL_ISTIOPILOT_HOSTPORT)'
	@echo '    ICL_ISTIOPILOT_NAMESPACE_NAME=$(ICL_ISTIOPILOT_NAMESPACE_NAME)'
	@echo '    ICL_ISTIOPILOT_PORT=$(ICL_ISTIOPILOT_PORT)'
	@echo '    ICL_OUTPUTS_DIRPATH=$(ICL_OUTPUTS_DIRPATH)'
	@echo '    ICL_UI_LABEL=$(ICL_UI_LABEL)'
	@echo '    ISTIOCTL=$(ISTIOCTL)'
	@# echo '    ISTIOCTL_ISTIO_NAMESPACE_NAME=$(ICL_ISTIO_NAMESPACE_NAME)'
	@# echo '    ISTIOCTL_KUBECONFIG_FILEPATH=$(ISTIOCTL_KUBECONFIG_FILEPATH)'
	@echo

_list_targets :: _icl_list_targets
_icl_list_targets ::
	@echo 'IstioCtL:: ($(_ISTIOCTL_MK_VERSION)) targets:'
	@echo '    _icl_install_dependencies       - Install dependencies'
	@echo '    _icl_show_version               - Show version of helm and tiller'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/istioctl_appmanifest.mk
-include $(MK_DIR)/istioctl_authenticationpolicy.mk
-include $(MK_DIR)/istioctl_destinationrule.mk
# -include $(MK_DIR)/istioctl_envoy.mk
-include $(MK_DIR)/istioctl_grafana.mk
-include $(MK_DIR)/istioctl_istiomanifest.mk
-include $(MK_DIR)/istioctl_istiorelease.mk
-include $(MK_DIR)/istioctl_istioprofile.mk
-include $(MK_DIR)/istioctl_istioproxy.mk
-include $(MK_DIR)/istioctl_jaeger.mk
-include $(MK_DIR)/istioctl_kiali.mk
-include $(MK_DIR)/istioctl_prometheus.mk
-include $(MK_DIR)/istioctl_zipkin.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _icl_install_dependencies
_icl_install_dependencies ::
	@$(INFO) '$(ICL_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://istio.io/docs/setup/kubernetes/download-release/'; $(NORMAL)
	# cd /tmp; curl --location https://git.io/getLatestIstio | sh -

_view_versions :: _icl_show_version
_icl_show_version:
	@$(INFO) '$(ICL_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	$(ISTIOCTL) version
