_KUBECTL_ARGOCD_MK_VERSION= 0.99.4

KCL_ARGOCD_NAMESPACE_NAME?= argocd

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::ArgoCD ($(_KUBECTL_ARGOCD_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::ArgoCD ($(_KUBECTL_ArgocCD_MK_VERSION)) parameters:'
	@echo '    KCL_ARGOCD_NAMESPACE_NAME=$(KCL_ARGOCD_NAMESPACE_NAME)'
	@echo '    KCL_ARGOCD_VERSION=$(KCL_ARGOCD_VERSION)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::ArgoCD ($(_KUBECTL_ARGOCD_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_argocd_application.mk
-include $(MK_DIR)/kubectl_argocd_appproject.mk

#----------------------------------------------------------------------
# EXTENSIONS TARGETS
#

_kcl_show_cluster__header ::

_kcl_show_namespace__header :: _kcl_show_namespace_application _kcl_show_namespace_appproject

_kcl_show_namespace_application:
	@$(INFO) '$(KCL_UI_LABEL)Showing application in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get applications $(__KCL_NAMESPACE__NAMESPACE)

_kcl_show_namespace_appprojects:
	@$(INFO) '$(KCL_UI_LABEL)Showing app-projects in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get appprojects $(__KCL_NAMESPACE__NAMESPACE)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
