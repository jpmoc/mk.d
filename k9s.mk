_K9S_MK_VERSION= 0.99.4

# KCL_INPUTS_DIRPATH?= ./out/
# KCL_OUTPUTS_DIRPATH?= ./out/
# K9S_CONTEXT_NAME?= k1.emayssat-c2.k8s.local
K9S_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config

# Derived parameters
K9S_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
K9S_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
K9S_UI_LABEL?= [k9s] #

#--- Utilities
__K9S_OPTIONS+= $(if $(KUBECTL_KUBECONFIG_FILEPATH),--kubeconfig=$(KUBECTL_KUBECONFIG_FILEPATH))#

K9S_BIN?= k9s
K9S?= $(strip $(__K9S_ENVIRONMENT) $(K9S_ENVIRONMENT) $(K9S_BIN) $(__K9S_OPTIONS) $(K9S_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _k9s_view_framework_macros
_k9s_view_framework_macros ::
	@#echo 'K9S ($(_K9S_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _k9s_view_framework_parameters
_k9s_view_framework_parameters ::
	@echo 'K9S ($(_K9S_MK_VERSION)) parameters:'
	@echo '    K9S_OUTPUTS_DIRPATH=$(K9S_OUTPUTS_DIRPATH)'
	@echo '    K9S_OUTPUTS_DIRPATH=$(K9S_OUTPUTS_DIRPATH)'
	@echo '    K9S=$(K9S)'
	@echo

_view_framework_targets :: _k9s_view_framework_targets
_k9s_view_framework_targets ::
	@echo 'K9S ($(_K9S_MK_VERSION)) targets:'
	@echo '    _k9s_install_dependencies              - Install dependencies'
	@echo '    _k9s_start_tui                         - Start the TUI'
	@echo '    _k9s_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
# -include $(MK_DIR)/kubectl_api.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _k9s_install_dependencies
_k9s_install_dependencies:
	@$(INFO) '$(KCL_UI_LABEL)Installing dependencies...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://k9scli.io/topics/install/'; $(NORMAL)
	# wget https://github.com/derailed/k9s/releases/download/v0.18.1/k9s_Linux_x86_64.tar.gz
	which k9s
	k9s version

_k9s_start_tui:
	@$(INFO) '$(KCL_UI_LABEL)Starting TUI ...'; $(NORMAL)
	$(K9S)

_view_versions :: _k9s_view_versions
_k9s_view_versions:
	@$(INFO) '$(KCL_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(K9S_BIN) version
