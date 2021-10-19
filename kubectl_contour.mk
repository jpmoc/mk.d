_KUBECTL_XER_MK_VERSION= 0.99.4

KCL_XER_NAMESPACE_NAME?= cert-manager
# KCL_XER_POD_NAME?= cert-manager
KCL_XER_POD_SELECTOR?= app.kubernetes.io/name=cert-manager

# Derived parameters

# Option parameters
__KCL_FOLLOW__XER?= --follow
__KCL_NAMESPACE__XER?= $(if $(KCL_XER_NAMESPACE_NAME),--namespace $(KCL_XER_NAMESPACE_NAME))
__KCL_SELECTOR__XER?= $(if $(KCL_XER_POD_SELECTOR),--selector $(KCL_XER_POD_SELECTOR))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager ($(_KUBECTL_XER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager ($(_KUBECTL_XER_MK_VERSION)) parameters:'
	@echo '    KCL_XER_NAMESPACE_NAME=$(KCL_XER_NAMESPACE_NAME)'
	@echo '    KCL_XER_POD_SELECTOR=$(KCL_XER_POD_SELECTOR)'
	@echo

_view_framework_targets :: _kcl_view_framework_targets
_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager ($(_KUBECTL_XER_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_contour_extensionservice.mk
-include $(MK_DIR)/kubectl_contour_httpproxy.mk
-include $(MK_DIR)/kubectl_contour_tlscertificatedelegation.mk

#----------------------------------------------------------------------
# EXTENSIONS TARGETS
#

_kcl_show_cluster__header :: 

_kcl_show_namespace__header :: _kcl_show_namespace_extensionservices _kcl_show_namespace_httpproxies _kcl_show_namespace_tlscertificatedelegations

_kcl_show_namespace_extensionservices:
	@$(INFO) '$(KCL_UI_LABEL)Showing extension-services in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get extensionservices $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_httpproxies:
	@$(INFO) '$(KCL_UI_LABEL)Showing http-proxies in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get httpproxies $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_tlscertificatedelegations:
	@$(INFO) '$(KCL_UI_LABEL)Showing tls-certification-delegations in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get tlscertificatedelegations $(__KCL_NAMESPACE__NAMESPACE)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
