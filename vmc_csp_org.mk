_VMC_VKE_NAMESPACE_MK_VERSION= $(_VMC_VKE_MK_VERSION)

# VKE_NAMESPACE_CLUSTER_NAME?= my-cluster
# VKE_NAMESPACE_FOLDER_NAME?= SharedFolder
# VKE_NAMESPACE_NAME?= kube-system
# VKE_NAMESPACE_PROJECT_NAME?= SharedProject

# Derived variables
VKE_NAMESPACE_CLUSTER_NAME?= $(VKE_CLUSTER_NAME)
VKE_NAMESPACE_FOLDER_NAME?= $(VKE_CLUSTER_FOLDER_NAME)
VKE_NAMESPACE_PROJECT_NAME?= $(VKE_CLUSTER_PROJECT_NAME)

# Option variables
__VKE_FOLDER__NAMESPACE= $(if $(VKE_NAMESPACE_FOLDER_NAME), --folder $(VKE_NAMESPACE_FOLDER_NAME))
__VKE_PROJECT__NAMESPACE= $(if $(VKE_NAMESPACE_PROJECT_NAME), --project $(VKE_NAMESPACE_PROJECT_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vke_view_framework_macros ::
	@#echo 'VmwareClouD::VKE::Namespace ($(_VMC_VKE_NAMESPACE_MK_VERSION)) macros:'
	@#echo

_vke_view_framework_parameters ::
	@echo 'VmwareClouD::VKE::Namespace ($(_VMC_VKE_NAMESPACE_MK_VERSION)) parameters:'
	@echo '    VKE_NAMESPACE_CLUSTER_NAME=$(VKE_NAMESPACE_CLUSTER_NAME)'
	@echo '    VKE_NAMESPACE_FOLDER_NAME=$(VKE_NAMESPACE_FOLDER_NAME)'
	@echo '    VKE_NAMESPACE_NAME=$(VKE_NAMESPACE_NAME)'
	@echo '    VKE_NAMESPACE_PROJECT_NAME=$(VKE_NAMESPACE_PROJECT_NAME)'
	@echo

_vke_view_framework_targets ::
	@echo 'VmwareClouD::VKE::Namespace ($(_VMC_VKE_NAMESPACE_MK_VERSION)) targets:'
	@echo '    _vke_create_namespace                  - Create a new namespace'
	@echo '    _vke_delete_namespace                  - Delete an existing namespace'
	@echo '    _vke_show_namespace                    - Show everything related to a namespace'
	@echo '    _vke_show_namespace_desription         - Show description of a namespace'
	@echo '    _vke_show_namespace_accesspolicies     - Show access-policies of a namespace'
	@echo '    _vke_view_namespaces                   - View namespaces'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vke_create_namespace:
	@$(INFO) '$(VKE_UI_LABEL)Creating namespace "$(VKE_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(VKE) cluster namespace create $(__VKE_FOLDER__NAMESPACE) $(__VKE_PROJECT__NAMESPACE) $(VKE_NAMESPACE_CLUSTER_NAME) $(VKE_NAMESPACE_NAME)

_vke_delete_namespace:
	@$(INFO) '$(VKE_UI_LABEL)Deleting namespace "$(VKE_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(VKE) cluster namespace delete $(__VKE_FOLDER__NAMESPACE) $(__VKE_PROJECT__NAMESPACE) $(VKE_CLUSTER_NAME) $(VKE_NAMESPACE_NAME)

_vke_show_namespace: _vke_show_namespace_accesspolicies _vke_show_namespace_description

_vke_show_namespace_accesspolicies:
	@$(INFO) '$(VKE_UI_LABEL)Showing access-policies of namespace "$(VKE_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(VKE) cluster namespace iam show $(__VKE_FOLDER__NAMESPACE) $(__VKE_PROJECT__NAMESPACE) $(VKE_CLUSTER_NAME) $(VKE_NAMESPACE_NAME)

_vke_show_namespace_description:
	@$(INFO) '$(VKE_UI_LABEL)Showing description of namespace "$(VKE_NAMESPACE_NAME)" ...'; $(NORMAL)
	$(VKE) cluster namespace show $(__VKE_FOLDER__NAMESPACE) $(__VKE_PROJECT__NAMESPACE) $(VKE_CLUSTER_NAME) $(VKE_NAMESPACE_NAME)

_vke_view_namespaces:
	@$(INFO) '$(VKE_UI_LABEL)Viewing namespaces in cluster "$(VKE_NAMESPACE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VKE) cluster namespace list $(__VKE_FOLDER__NAMESPACE) $(__VKE_PROJECT__NAMESPACE) $(VKE_NAMESPACE_CLUSTER_NAME)
