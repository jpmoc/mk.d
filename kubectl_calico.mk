_KUBECTL_CALICO_MK_VERSION= 0.99.4

KCL_CALICO_NAMESPACE_NAME?= calico-system
KCL_CALICO_VERSION?= v3.17.1

# Derived parameters

# Options

# Customizations

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_list_macros ::
	@#echo 'KubeCtL::Calico ($(_KUBECTL_CALICO_MK_VERSION)) macros:'
	@#echo

_kcl_list_parameters ::
	@echo 'KubeCtL::Calico ($(_KUBECTL_CALICO_MK_VERSION)) parameters:'
	@echo '    KCL_CALICO_NAMESPACE_NAME=$(KCL_CALICO_NAMESPACE_NAME)'
	@echo '    KCL_CALICO_VERSION=$(KCL_CALICO_VERSION)'
	@echo

_list_targets :: _kcl_list_targets
_kcl_list_targets ::
	@echo 'KubeCtL::Calico ($(_KUBECTL_CALICO_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/kubectl_calico_globalnetworkpolicy.mk

#----------------------------------------------------------------------
# EXTENSIONS TARGETS
#

_kcl_show_cluster__header :: _kcl_show_cluster_globalnetworkpolicies

_kcl_show_cluster_globalnetworkpolicies:
	@$(INFO) '$(KCL_UI_LABEL)Showing calico-global-network-policies in cluster "$(KCL_CLUSTER_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get globalnetworkpolicies

_kcl_show_namespace__header :: # _kcl_show_namespace_authorizationpolicies

# _kcl_show_namespace_authorizationpolicies:
# 	@$(INFO) '$(KCL_UI_LABEL)Showing istio-authorization-policies in namespace "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
# 	$(KUBECTL) get authorizationpolicies $(__KCL_NAMESPACE__NAMESPACE)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
