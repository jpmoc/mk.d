_ARGOCD_MK_VERSION= 0.99.4

# ACD_ARGOCD_NAMESPACE_NAME?= argocd
# ACD_INPUTS_DIRPATH?= ./in/
# ACD_OUTPUTS_DIRPATH?= ./out/

# Derived parameters
ACD_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
ACD_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
ACD_UI_LABEL?= [argocd] #

#--- Utilities
ARGOCD_BIN?= argocd
ARGOCD?= $(strip $(__ARGOCD_ENVIRONMENT) $(ARGOCD_ENVIRONMENT) $(ARGOCD_BIN) $(__ARGOCD_OPTIONS) $(ARGOCD_OPTIONS))
ARGOCD_VERSION?= v1.5.1

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _acd_view_framework_macros
_acd_view_framework_macros ::
	@#echo 'ArgoCD ($(_ARGOCD_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _acd_view_framework_parameters
_acd_view_framework_parameters ::
	@echo 'ArgoCD ($(_ARGOCD_MK_VERSION)) parameters:'
	@echo '    ACD_ARGOCD_NAMESPACE_NAME=$(ACD_ARGOCD_NAMESPACE_NAME)'
	@echo '    ACD_INPUTS_DIRPATH=$(ACD_INPUTS_DIRPATH)'
	@echo '    ACD_OUTPUTS_DIRPATH=$(ACD_OUTPUTS_DIRPATH)'
	@echo '    ARGOCD=$(ARGOCD)'
	@echo

_view_framework_targets :: _kcl_view_framework_targets
_kcl_view_framework_targets ::
	@echo 'ArgoCD ($(_ARGOCD_MK_VERSION)) targets:'
	@echo '    _acd_install_dependencies              - Install dependencies'
	@echo '    _acd_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/argocd_application.mk
-include $(MK_DIR)/argocd_cluster.mk
-include $(MK_DIR)/argocd_config.mk
-include $(MK_DIR)/argocd_policy.mk
-include $(MK_DIR)/argocd_project.mk
-include $(MK_DIR)/argocd_repository.mk
-include $(MK_DIR)/argocd_role.mk
-include $(MK_DIR)/argocd_server.mk
-include $(MK_DIR)/argocd_token.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _acd_install_dependencies
_acd_install_dependencies ::
	@$(INFO) '$(KCL_UI_LABEL)Installaing dependencies...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://argoproj.github.io/'; $(NORMAL)
	$(SUDO) curl --location --output /usr/local/bin/argocd --show-error --silent https://github.com/argoproj/argo-cd/releases/download/$(ARGOCD_VERSION)/argocd-linux-amd64
	$(SUDO) chmod +x /usr/local/bin/argocd
	which argocd

_view_versions :: _acd_view_versions
_acd_view_versions:
	@$(INFO) '$(KCL_UI_LABEL)View versions of dependencies ...'; $(NORMAL)
	# argocd version
