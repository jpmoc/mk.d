_KUSTOMIZE_MK_VERSION= 0.99.4

# KZE_INPUTS_DIRPATH?= ./in/
# KZE_OUTPUTS_DIRPATH?= ./out/

# Derived parameters
KZE_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
KZE_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
KZE_UI_LABEL?= [kustomize] #

#--- Utilities
# __KUSTOMIZE_OPTIONS+= $(if $(KUSTOMIZE_VMODULE),--vmodule=$(KUSTOMIZE_VMODULE))#

KUSTOMIZE_BIN?= kustomize
KUSTOMIZE?= $(strip $(__KUSTOMIZE_ENVIRONMENT) $(KUSTOMIZE_ENVIRONMENT) $(KUSTOMIZE_BIN) $(__KUSTOMIZE_OPTIONS) $(KUSTOMIZE_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _kze_view_framework_macros
_kze_view_framework_macros ::
	@#echo 'KustomiZE ($(_KUSTOMIZE_MK_VERSION)) macros:'
	@#echo

_view_framework_parameters :: _kze_view_framework_parameters
_kze_view_framework_parameters ::
	@echo 'KustomiZE ($(_KUSTOMIZE_MK_VERSION)) parameters:'
	@echo '    KZE_INPUTS_DIRPATH=$(KZE_INPUTS_DIRPATH)'
	@echo '    KZE_OUTPUTS_DIRPATH=$(KZE_OUTPUTS_DIRPATH)'
	@echo '    KUSTOMIZE=$(KUSTOMIZE)'
	@echo

_view_framework_targets :: _kze_view_framework_targets
_kze_view_framework_targets ::
	@echo 'KustomiZE ($(_KUSTOMIZE_MK_VERSION)) targets:'
	@echo '    _kze_install_dependencies              - Install dependencies'
	@echo '    _kze_view_versions                     - View versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kustomize_kustomization.mk
-include $(MK_DIR)/kustomize_manifest.mk
-include $(MK_DIR)/kustomize_patch.mk
-include $(MK_DIR)/kustomize_resource.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _kze_install_dependencies
_kze_install_dependencies ::
	@$(INFO) '$(KZE_UI_LABEL)Installaing dependencies...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://github.com/kubernetes-sigs/kustomize/blob/master/docs/INSTALL.md'; $(NORMAL)
	cd /tmp && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
	$(SUDO) mv /tmp/kustomize /usr/local/bin
	which kustomize
	kustomize version

_view_versions :: _kze_view_versions
_kze_view_versions:
	@$(INFO) '$(KZE_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	kustomize version
