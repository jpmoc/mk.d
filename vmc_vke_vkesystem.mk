_VMC_VKE_VKESYSTEM_MK_VERSION= $(_VMC_VKE_MK_VERSION)

VKE_VKESYSTEM_NAMESPACE_NAME?= vke-system
# VKE_VKESYSTEM_POD_NAME?=

# Derived parameters

# Option parameters
__VKE_NAMESPACE__VKESYSTEM= $(if $(VKE_VKESYSTEM_NAMESPACE_NAME), --namespace $(VKE_VKESYSTEM_NAMESPACE_NAME))

# UI parameters

#--- MACROS
_vke_get_vkesystem_pod_names= $(shell $(KUBECTL) get pods --namespace vke-system --output jsonpath="{.items[*].metadata.name}")

#----------------------------------------------------------------------
# USAGE
#

_vke_view_framework_macros ::
	@echo 'VMC::VKE::VkeSystem ($(_VMC_VKE_VKESYSTEM_MK_VERSION)) macros:'
	@echo '    _vke_get_vkesystem_pod_names          - Get the pods in the vke-system namespace'
	@echo

_vke_view_framework_parameters ::
	@echo 'VMC::VKE::VkeSystem ($(_VMC_VKE_VKESYSTEM_MK_VERSION)) parameters:'
	@echo '    VKE_VKESYSTEM_NAMESPACE_NAME=$(VKE_VKESYSTEM_NAMESPACE_NAME)'
	@echo '    VKE_VKESYSTEM_POD_NAMES=$(VKE_VKESYSTEM_POD_NAMES)'
	@echo

_vke_view_framework_targets ::
	@echo 'VMC::VKE::VkeSystem ($(_VMC_VKE_SYSTEM_MK_VERSION)) targets:'
	@echo '    _vke_show_vkesystem                   - Show everything related to the vke-system namespace'
	@echo '    _vke_show_vkesystem_description       - Show description of the vke-system namespace'
	@echo '    _vke_show_vkesystem_deployments       - Show deployments in the vke-system namespace'
	@echo '    _vke_show_vkesystem_pods              - Show pods in the vke-system namespace'
	@echo '    _vke_show_vkesystem_replicasets       - Show replica-sets in the vke-system namespace'
	@echo '    _vke_show_vkesystem_sercrets          - Show secrets in the vke-system namespace'
	@echo '    _vke_show_vkesystem_services          - Show services in the vke-system namespace'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_show_vkesystem: _vke_show_vkesystem_cronjobs _vke_show_vkesystem_deployments _vke_show_vkesystem_jobs _vke_show_vkesystem_pods _vke_show_vkesystem_replicasets _vke_show_vkesystem_serviceaccounts _vke_show_vkesystem_secrets _vke_show_vkesystem_services _vke_show_vkesystem_description

_vke_show_vkesystem_description:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) describe namespace $(VKE_VKESYSTEM_NAMESPACE_NAME)

_vke_show_vkesystem_cronjobs:
	@$(INFO) '$(VKE_UI_LABEL)Showing cronjobs in namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get cronjobs $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_deployments:
	@$(INFO) '$(VKE_UI_LABEL)Showing deployments in namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get deployments $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_jobs:
	@$(INFO) '$(VKE_UI_LABEL)Showing jobs in namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get jobs $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_pods:
	@$(INFO) '$(VKE_UI_LABEL)Showing pods in namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get pods $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_replicasets:
	@$(INFO) '$(VKE_UI_LABEL)Showing replica-sets in namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get replicasets $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_secrets:
	@$(INFO) '$(VKE_UI_LABEL)Showing secrets in namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get secrets $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_serviceaccounts:
	@$(INFO) '$(VKE_UI_LABEL)Showing service-accounts in the namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get serviceaccounts $(__VKE_NAMESPACE__VKESYSTEM)

_vke_show_vkesystem_services:
	@$(INFO) '$(VKE_UI_LABEL)Showing services in the namespace "$(VKE_VKESYSTEM_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(KUBECTL) get services $(__VKE_NAMESPACE__VKESYSTEM)
