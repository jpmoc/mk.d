_KIND_MK_VERSION= 0.99.0

# KND_PARAMETER?= value

# Derived parameters
KND_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
KND_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Option parameters

# UI parameters
KND_UI_LABEL?= [kind] #
 
#--- Utilities
KIND_BIN?= kind
KIND?= $(strip $(__KIND_ENVIRONMENT) $(KIND_ENVIRONMENT) $(KIND_BIN) $(__KIND_OPTIONS) $(KIND_OPTIONS))
KIND_VERSION?= v0.7.0

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _knd_view_framework_macros
_knd_view_framework_macros ::
	@#echo 'KiND ($(_KIND_MK_VERSION)) targets:'
	@#echo

_view_framework_parameters :: _knd_view_framework_parameters
_knd_view_framework_parameters ::
	@echo 'KiND ($(_KIND_MK_VERSION)) parameters:'
	@echo '    KIND=$(KIND)'
	@echo

_view_framework_targets :: _knd_view_framework_targets
_knd_view_framework_targets ::
	@echo 'KiND ($(_KIND_MK_VERSION)) targets:'
	@echo '    _knd_install_dependencies        - Install depedencies'
	@echo '    _knd_view_versions               - View versions'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kind_apiversion.mk
-include $(MK_DIR)/kind_cluster.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS

_install_framework_dependencies :: _knd_install_depedencies
_knd_install_dependencies:
	@$(INFO) '$(MKE_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs @ https://kind.sigs.k8s.io/docs/user/quick-start/#installation'; $(NORMAL)
	curl --location --output ./kind https://kind.sigs.k8s.io/dl/$(KIND_VERSION)/kind-Linux-amd64
	chmod +x ./kind
	$(SUDO) mv ./kind /usr/local/bin/kind
	which kind
	kind version

_view_versions :: _knd_view_versions
_knd_view_versions:
	@$(INFO) '$(MKE_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	kind version
