_KUBECTL_CERTMANAGER_MK_VERSION= 0.99.4

KCL_CERTMANAGER_NAMESPACE_NAME?= cert-manager
# KCL_CERTMANAGER_POD_NAME?= cert-manager
KCL_CERTMANAGER_POD_SELECTOR?= app.kubernetes.io/name=cert-manager

# Derived parameters

# Option parameters
__KCL_FOLLOW__CERTMANAGER?= --follow
__KCL_NAMESPACE__CERTMANAGER?= $(if $(KCL_CERTMANAGER_NAMESPACE_NAME),--namespace $(KCL_CERTMANAGER_NAMESPACE_NAME))
__KCL_SELECTOR__CERTMANAGER?= $(if $(KCL_CERTMANAGER_POD_SELECTOR),--selector $(KCL_CERTMANAGER_POD_SELECTOR))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::CertManager ($(_KUBECTL_CERTMANAGER_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::CertManager ($(_KUBECTL_CERTMANAGER_MK_VERSION)) parameters:'
	@echo '    KCL_CERTMANAGER_NAMESPACE_NAME=$(KCL_CERTMANAGER_NAMESPACE_NAME)'
	@echo '    KCL_CERTMANAGER_POD_SELECTOR=$(KCL_CERTMANAGER_POD_SELECTOR)'
	@echo

_view_framework_targets :: _kcl_view_framework_targets
_kcl_view_framework_targets ::
	@echo 'KubeCtL::CertManager ($(_KUBECTL_CERTMANAGER_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_certmanager_certificate.mk
-include $(MK_DIR)/kubectl_certmanager_certificaterequest.mk
-include $(MK_DIR)/kubectl_certmanager_challenge.mk
-include $(MK_DIR)/kubectl_certmanager_clusterissuer.mk
-include $(MK_DIR)/kubectl_certmanager_issuer.mk
-include $(MK_DIR)/kubectl_certmanager_order.mk

#----------------------------------------------------------------------
# EXTENSIONS TARGETS
#

_kcl_show_cluster__header :: 

_kcl_show_namespace__header :: _kcl_show_namespace_certificates _kcl_show_namespace_issuers

_kcl_show_namespace_certificates:
	@$(INFO) '$(KCL_UI_LABEL)Showing certificates in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get certificates $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_issuers:
	@$(INFO) '$(KCL_UI_LABEL)Showing issuers in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get issuers $(__KCL_NAMESPACE__NAMESPACE)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_tail_certmanager:
	@$(INFO) '$(KCL_UI_LABEL)Tailing certificate-manager ...'; $(NORMAL)
	$(KUBECTL) logs $(__KCL_FOLLOW__CERTMANAGER) $(__KCL_NAMESPACE__CERTMANAGER) $(__KCL_SELECTOR__CERTMANAGER)
