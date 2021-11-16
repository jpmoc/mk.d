_HELM_MK_VERSION= 0.99.4

# HELM_HOME?= $(HOME)/.helm
# HELM_KUBECONFIG_CONTEXT?=
# HELM_KUBECONFIG_FILEPATH?=
# HELM_MODE_DEBUG?= false
# HELM_VERSION?= v3.5.0
# HLM_HOME?= $(HOME)/.helm
# HLM_HOME?= $(HOME)/.helm
# HLM_INPUTS_DIRPATH?= ./in/
# HLM_OUTPUTS_DIRPATH?= ./out/
HLM_UI_LABEL?= [helm] #

# Derived parameters
HELM_KUBECONFIG_FILEPATH?= $(KUBECTL_KUBECONFIG_FILEPATH)
HELM_MODE_DEBUG?= $(CMN_MODE_DEBUG)
HLM_CURL?= $(CURL)
HLM_DIG?= $(DIG)
HLM_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
HLM_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Options

# Customizations

#--- Utilities

# __HELM_ENVIRONMENT+= $(if $(HLM_HOME),HELM_HOME=$(HLM_HOME))

__HELM_OPTIONS+= $(if $(filter true, $(HELM_DEBUG)),--debug)
# __HELM_OPTIONS+= $(if $(HELM_HOME),--home $(HELM_HOME))
__HELM_OPTIONS+= $(if $(HELM_KUBECONFIG_CONTEXT),--kube-context $(HELM_KUBECONFIG_CONTEXT))
__HELM_OPTIONS+= $(if $(HELM_KUBECONFIG_FILEPATH),--kubeconfig=$(HELM_KUBECONFIG_FILEPATH))

HELM_BIN?= helm$(if $(HELM_VERSION),-$(HELM_VERSION))
HELM?= $(strip $(__HELM_ENVIRONMENT) $(HELM_ENVIRONMENT) $(HELM_BIN) $(__HELM_OPTIONS) $(HELM_OPTIONS))

#--- Macros
_hlm_get_helm_home= $(shell $(HELM) home)

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _hlm_list_macros
_hlm_list_macros ::
	@echo 'HeLM:: ($(_HELM_MK_VERSION)) macros:'
	@echo '    _hlm_get_helm_home               - Get the home pf the helm client'
	@echo

_list_parameters :: _hlm_list_parameters
_hlm_list_parameters ::
	@echo 'HeLM:: ($(_HELM_MK_VERSION)) variables:'
	@echo '    HELM=$(HELM)'
	@# echo '    HELM_HOME=$(HELM_HOME)'
	@echo '    HELM_KUBECONFIG_CONTEXT=$(HELM_KUBECONFIG_CONTEXT)'
	@echo '    HELM_KUBECONFIG_FILEPATH=$(HELM_KUBECONFIG_FILEPATH)'
	@echo '    HELM_MODE_DEBUG=$(HELM_MODE_DEBUG)'
	@echo '    HLM_INPUTS_DIRPATH=$(HLM_INPUTS_DIRPATH)'
	@echo '    HLM_OUTPUTS_DIRPATH=$(HLM_OUTPUTS_DIRPATH)'
	@echo '    HLM_UI_LABEL=$(HLM_UI_LABEL)'
	@echo

_list_targets :: _hlm_list_targets
_hlm_list_targets ::
	@echo 'HeLM:: ($(_HELM_MK_VERSION)) targets:'
	@echo '    _hlm_install_dependencies       - Install dependencies'
	@echo '    _hlm_show_configuration         - Show config of helm'
	@echo '    _hlm_view_versions              - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/helm_chart.mk
-include $(MK_DIR)/helm_chartdependency.mk
-include $(MK_DIR)/helm_chartpackage.mk
-include $(MK_DIR)/helm_chartsource.mk
-include $(MK_DIR)/helm_manifest.mk
-include $(MK_DIR)/helm_plugin.mk
-include $(MK_DIR)/helm_release.mk
-include $(MK_DIR)/helm_repository.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _hlm_install_dependencies
_hlm_install_dependencies ::
	@$(INFO) '$(HLM_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://docs.helm.sh/using_helm/#installing-helm'; $(NORMAL)
	@$(WARN) 'This operation installs the latest version of helm'; $(NORMAL)
	curl https://raw.githubusercontent.com/helm/helm/master/scripts/get | bash
	# mv /usr/local/bin/helm /usr/local/bin/helm-$(HELM_VERSION)

# _hlm_show_configuration:
# 	@$(INFO) '$(HLM_UI_LABEL)Showing helm-client configuration ...'; $(NORMAL)
# 	tree $(HLM_HOME)
# 

_view_versions :: _hlm_show_versions
_hlm_show_versions: # _hlm_show_version_client _hlm_show_version_server
	@$(INFO) '$(HLM_UI_LABEL)Showing version of dependencies...'; $(NORMAL)
	$(HELM) version
