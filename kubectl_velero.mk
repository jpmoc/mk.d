_KUBECTL_VELERO_MK_VERSION= 0.99.4

KCL_VELERO_NAMESPACE_NAME?= velero
# KCL_VELERO_VERSION?=

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@#echo 'KubeCtL::Velero ($(_KUBECTL_VELERO_MK_VERSION)) macros:'
	@#echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Velero ($(_KUBECTL_VELERO_MK_VERSION)) parameters:'
	@echo '    KCL_ISTIO_NAMESPACE_NAME=$(KCL_ISTIO_NAMESPACE_NAME)'
	@echo '    KCL_ISTIO_VERSION=$(KCL_ISTIO_VERSION)'
	@echo

_view_framework_targets :: _kcl_view_framework_targets
_kcl_view_framework_targets ::
	@echo 'KubeCtL::Velero ($(_KUBECTL_VELERO_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_velero_backupstoragelocation.mk
-include $(MK_DIR)/kubectl_velero_backup.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
