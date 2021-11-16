_TKN_MK_VERSION= 0.99.4

# TKN_CONTEXT_NAME?= tekton-cluster
# TKN_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# TKN_NAMESPACE_NAME?= default
TKN_SHOWLOG_FLAG?= false
TKN_UI_LABEL?= [tkn] #

# Derived parameters
TKN_CONTEXT_NAME?= $(KUBECTL_CONTEXT_NAME)
TKN_KUBECONFIG_FILEPATH?= $(KUBECTL_KUBECONFIG_FILEPATH)

# Options

# Customizations

#--- Utilities

__TKN_OPTIONS+= $(if $(TKN_CONTEXT_NAME),--context=$(TKN_CONTEXT_NAME))#
__TKN_OPTIONS+= $(if $(TKN_KUBECONFIG_FILEPATH),--kubeconfig=$(TKN_KUBECONFIG_FILEPATH))#
TKN_BIN?= tkn
TKN?= $(strip $(__TKN_ENVIRONMENT) $(TKN_ENVIRONMENT) $(TKN_BIN) $(__TKN_OPTIONS) $(TKN_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _tkn_list_macros
_tkn_list_macros ::
	@#echo 'TKN ($(_TKN_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _kn_list_parameters
_tkn_list_parameters ::
	@echo 'TKN ($(_TKN_MK_VERSION)) parameters:'
	@echo '    TKN_CONTEXT_NAME=$(TKN_CONTEXT_NAME)'
	@echo '    TKN_KUBECONFIG_FILEPATH=$(TKN_KUBECONFIG_FILEPATH)'
	@echo '    TKN_NAMESPACE_NAME=$(TKN_NAMESPACE_NAME)'
	@echo '    TKN_SHOWLOG_FLAG=$(TKN_SHOWLOG_FLAG)'
	@echo

_list_targets :: _tkn_list_targets
_tkn_list_targets ::
	@echo 'TKN ($(_TKN_MK_VERSION)) targets:'
	@echo '    _tkn_install_dependencies              - Install dependencies'
	@echo '    _tkn_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/tkn_pipeline.mk
-include $(MK_DIR)/tkn_pipelinerun.mk
-include $(MK_DIR)/tkn_task.mk
-include $(MK_DIR)/tkn_taskrun.mk
-include $(MK_DIR)/tkn_workspace.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _tkn_install_dependencies
_tkn_install_dependencies ::
	@$(INFO) '$(TKN_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://tekton.dev/docs/getting-started/'; $(NORMAL)
	which tkn
	tkn version

_view_versions :: _tkn_view_versions
_tkn_view_versions ::
	@$(INFO) '$(TKN_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	tkn version
