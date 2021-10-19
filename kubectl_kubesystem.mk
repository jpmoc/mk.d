_KUBECTL_KUBESYSTEM_MK_VERSION= $(_KUBECTL_MK_VERSION)

KCL_KUBESYSTEM_NAMESPACE_NAME?= kube-system
# KCL_KUBESYSTEM_POD_NAME?=

# Derived parameters

# Option parameters
__KCL_NAMESPACE__KUBESYSTEM= $(if $(KCL_KUBESYSTEM_NAMESPACE_NAME), --namespace $(KCL_KUBESYSTEM_NAMESPACE_NAME))

# UI parameters

#--- MACROS
_kcl_get_kubesystem_pod_names= $(shell $(KUBECTL) get pods --namespace kube-system --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::KubeSystem ($(_KUBECTL_KUBESYSTEM_MK_VERSION)) macros:'
	@echo '    _kcl_get_kubesystem_pod_names           - Get the pods in the kube-system namespace'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::KubeSystem ($(_KUBECTL_KUBESYSTEM_MK_VERSION)) parameters:'
	@echo '    KCL_KUBESYSTEM_NAMESPACE_NAME=$(KCL_KUBESYSTEM_NAMESPACE_NAME)'
	@echo '    KCL_KUBESYSTEM_POD_NAMES=$(KCL_KUBESYSTEM_POD_NAMES)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::KubeSystem ($(_KUBECTL_SYSTEM_MK_VERSION)) targets:'
	@echo '    _kcl_show_kubesystem                   - Show everything related to the kube-system namespace'
	@echo '    _kcl_show_kubesystem_description       - Show description of the kube-system namespace'
	@echo '    _kcl_show_kubesystem_deployments       - Show deployments in the kube-system namespace'
	@echo '    _kcl_show_kubesystem_pods              - Show pods in the kube-system namespace'
	@echo '    _kcl_show_kubesystem_replicasets       - Show replica-sets in the kube-system namespace'
	@echo '    _kcl_show_kubesystem_sercrets          - Show secrets in the kube-system namespace'
	@echo '    _kcl_show_kubesystem_services          - Show services in the kube-system namespace'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_show_kubesystem: _kcl_show_kubesystem_cronjobs _kcl_show_kubesystem_deployments _kcl_show_kubesystem_jobs _kcl_show_kubesystem_pods _kcl_show_kubesystem_replicasets _kcl_show_kubesystem_serviceaccounts _kcl_show_kubesystem_secrets _kcl_show_kubesystem_services _kcl_show_kubesystem_description

_kcl_show_kubesystem_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe namespace $(KCL_KUBESYSTEM_NAMESPACE_NAME)

_kcl_show_kubesystem_cronjobs:
	@$(INFO) '$(KCL_UI_LABEL)Showing cronjobs in namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get cronjobs $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_deployments:
	@$(INFO) '$(KCL_UI_LABEL)Showing deployments in namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get deployments $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_jobs:
	@$(INFO) '$(KCL_UI_LABEL)Showing jobs in namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get jobs $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_pods:
	@$(INFO) '$(KCL_UI_LABEL)Showing pods in namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_replicasets:
	@$(INFO) '$(KCL_UI_LABEL)Showing replica-sets in namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get replicasets $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_secrets:
	@$(INFO) '$(KCL_UI_LABEL)Showing secrets in namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get secrets $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_serviceaccounts:
	@$(INFO) '$(KCL_UI_LABEL)Showing service-accounts in the namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serviceaccounts $(__KCL_NAMESPACE__KUBESYSTEM)

_kcl_show_kubesystem_services:
	@$(INFO) '$(KCL_UI_LABEL)Showing services in the namespace "$(KCL_KUBESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get services $(__KCL_NAMESPACE__KUBESYSTEM)
