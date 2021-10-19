_VELERO_MK_VERSION= 0.99.4

# VLO_KUBECONFIG_CONTEXT_NAME?=
# VLO_KUBECONFIG_FILEPATH?=
VLO_SHOWLABELS_ENABLE?= false
VLO_VERSION?= v1.1.0

# Derived parameters
VLO_KUBECONFIG_FILEPATH?= $(KCL_KUBECONFIG_FILEPATH)
VLO_NAMESPACE_NAME?= velero

# Option parameters

# UI parameters
VLO_UI_LABEL?= [velero] #

#--- Utilities

__VELERO_ENVIRONMENT+=

__VELERO_OPTIONS+= $(if $(VLO_KUBECONFIG_FILEPATH),--kubeconfig $(VLO_KUBECONFIG_FILEPATH))
__VELERO_OPTIONS+= $(if $(VLO_KUBECONFIG_CONTEXT_NAME),--kubecontext $(VLO_KUBECONFIG_CONTEXT_NAME))

VELERO_BIN?= velero
VELERO?= $(strip $(__VELERO_ENVIRONMENT) $(VELERO_ENVIRONMENT) $(VELERO_BIN) $(__VELERO_OPTIONS) $(VELERO_OPTIONS))

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _vlo_view_framework_macros
_vlo_view_framework_macros ::
	@echo 'VeLerO:: ($(_VELERO_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _vlo_view_framework_parameters
_vlo_view_framework_parameters ::
	@echo 'VeLerO:: ($(_VELERO_MK_VERSION)) parameters:'
	@echo '    VLO_KUBECONFIG_CONTEXT_NAME=$(VLO_KUBECONFIG_CONTEXT_NAME)'
	@echo '    VLO_KUBECONFIG_FILEPATH=$(VLO_KUBECONFIG_FILEPATH)'
	@echo '    VLO_NAMESPACE_NAME=$(VLO_NAMESPACE_NAME)'
	@echo '    VLO_SHOWLABELS_ENABLE=$(VLO_SHOWLABELS_ENABLE)'
	@echo '    VLO_VERSION=$(VLO_VERSION)'
	@echo '    VELERO=$(VELERO)'
	@echo

_view_framework_targets :: _vlo_view_framework_targets
_vlo_view_framework_targets ::
	@echo 'VeLerO:: ($(_VELERO_MK_VERSION)) targets:'
	@echo '    _vlo_install_dependencies          - Install the dependencies'
	@echo '    _vlo_show_version                  - Show version of the dependency'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/velero_backup.mk
-include $(MK_DIR)/velero_backuplocation.mk
-include $(MK_DIR)/velero_plugin.mk
-include $(MK_DIR)/velero_restore.mk
-include $(MK_DIR)/velero_snapshotlocation.mk
-include $(MK_DIR)/velero_schedule.mk
-include $(MK_DIR)/velero_server.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_install_framework_dependencies :: _vlo_install_dependencies
_vlo_install_dependencies ::
	@$(INFO) '$(VLO_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@# Install docs at https://velero.io/docs/v1.0.0/install-overview/
	@# Source @ https://github.com/heptio/velero/tags
	curl --silent --location "https://github.com/heptio/velero/releases/download/$(VLO_VERSION)/velero-$(VLO_VERSION)-linux-amd64.tar.gz" | tar xz -C /tmp
	sudo mv -f /tmp/velero-$(VLO_VERSION)-linux-amd64/velero /usr/local/bin
	which velero
	velero version --client-only

_view_versions :: _vlo_show_version
_vlo_show_version:
	@$(INFO) '$(VLO_UI_LABEL)Showing version of dependencies ...'; $(NORMAL)
	$(VELERO) version --client-only



