_KUSTOMIZE_MK_VERSION= 0.99.4

# KZE_INPUTS_DIRPATH?= ./in/
# KZE_OUTPUTS_DIRPATH?= ./out/
KZE_UI_LABEL?= [kustomize] #

# Derived parameters
KZE_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
KZE_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Options

# Customizations

# Macros

# Utilities
# __KUSTOMIZE_OPTIONS+= $(if $(KUSTOMIZE_VMODULE),--vmodule=$(KUSTOMIZE_VMODULE))#

KUSTOMIZE_BIN?= kustomize
KUSTOMIZE?= $(strip $(__KUSTOMIZE_ENVIRONMENT) $(KUSTOMIZE_ENVIRONMENT) $(KUSTOMIZE_BIN) $(__KUSTOMIZE_OPTIONS) $(KUSTOMIZE_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _kze_list_macros
_kze_list_macros ::
	@#echo 'KustomiZE:: ($(_KUSTOMIZE_MK_VERSION)) macros:'
	@#echo

_list_parameters :: _kze_list_parameters
_kze_list_parameters ::
	@echo 'KustomiZE:: ($(_KUSTOMIZE_MK_VERSION)) parameters:'
	@echo '    KZE_INPUTS_DIRPATH=$(KZE_INPUTS_DIRPATH)'
	@echo '    KZE_OUTPUTS_DIRPATH=$(KZE_OUTPUTS_DIRPATH)'
	@echo '    KZE_UI_LABEL=$(KZE_UI_LABEL)'
	@echo '    KUSTOMIZE=$(KUSTOMIZE)'
	@echo

_list_targets :: _kze_list_targets
_kze_list_targets ::
	@echo 'KustomiZE:: ($(_KUSTOMIZE_MK_VERSION)) targets:'
	@echo '    _kze_install_dependencies              - Install dependencies'
	@echo '    _kze_show_versions                     - Show versions of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIRPATH?= ./
-include $(MK_DIRPATH)kustomize_kustomization.mk
-include $(MK_DIRPATH)kustomize_manifest.mk
-include $(MK_DIRPATH)kustomize_patch.mk
-include $(MK_DIRPATH)kustomize_resource.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_dependencies :: _kze_install_dependencies
_kze_install_dependencies ::
	@$(INFO) '$(KZE_UI_LABEL)Installaing dependencies...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://github.com/kubernetes-sigs/kustomize/blob/master/docs/INSTALL.md'; $(NORMAL)
	cd /tmp && curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh"  | bash
	$(SUDO) mv /tmp/kustomize /usr/local/bin
	which kustomize
	kustomize version

_view_versions :: _kze_show_versions
_kze_show_version:
	@$(INFO) '$(KZE_UI_LABEL)Showing versions of dependencies ...'; $(NORMAL)
	kustomize version
