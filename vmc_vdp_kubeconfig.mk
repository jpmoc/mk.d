_VMC_VDP_KUBECONFIG_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_KUBECONFIG_CLUSTER_NAME?= my_cluster 
# VDP_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config
# VDP_KUBECONFIG_MERGE_ENABLE?= true
# VDP_KUBECONFIG_NAME?= my-config
# VDP_KUBECONFIG_NAMESPACE_K8SNAME?= my-config
# VDP_KUBECONFIG_ORGANIZATION_NAME?= my-config

# Derived variablesA
VDP_KUBECONFIG_CLUSTER_NAME?= $(VDP_CLUSTER_NAME)
VDP_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config.$(VDP_CLUSTER_NAME)
VDP_KUBECONFIG_NAME?= $(VDP_KUBECONFIG_CLUSTER_NAME)
VDP_KUBECONFIG_NAMESPACE_K8SNAME?= $(VDP_NAMESPACE_K8SNAME)
VDP_KUBECONFIG_ORGANIZATION_NAME?= $(VDP_ORGANIZATION_NAME)
VDP_KUBECONFIG_PROFILE_NAME?= $(VDP_PROFILE_NAME)

# Option variables
__VDP_DEFAULT_NAMESPACE= $(if $(VDP_KUBECONFIG_NAMESPACE_K8SNAME),--default-namespace $(VDP_KUBECONFIG_NAMESPACE_K8SNAME))
__VDP_MERGE= $(if $(filter true,$(VDP_KUBECONFIG_MERGE_ENABLE)),--merge)
__VDP_ORG__KUBECONFIG= $(if $(VDP_KUBECONFIG_ORGANIZATION_NAME),--org $(VDP_KUBECONFIG_ORGANIZATION_NAME))
__VDP_PROFILE__KUBECONFIG= $(if $(VDP_KUBECONFIG_PROFILE_NAME),--profile $(VDP_KUBECONFIG_PROFILE_NAME))

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@#echo 'VmwareClouD::VDP::Kubeconfig ($(_VMC_VDP_KUBECONFIG_MK_VERSION)) macros:'
	@#echo

_vdp_view_framework_parameters ::
	@echo 'VmwareClouD::VDP::Kubeconfig ($(_VMC_VDP_KUBECONFIG_MK_VERSION)) parameters:'
	@echo '    VDP_KUBECONFIG_CLUSTER_NAME=$(VDP_KUBECONFIG_CLUSTER_NAME)'
	@echo '    VDP_KUBECONFIG_FILEPATH=$(VDP_KUBECONFIG_FILEPATH)'
	@echo '    VDP_KUBECONFIG_MERGE_ENABLE=$(VDP_KUBECONFIG_MERGE_ENABLE)'
	@echo '    VDP_KUBECONFIG_NAME=$(VDP_KUBECONFIG_NAME)'
	@echo '    VDP_KUBECONFIG_NAMESPACE_K8SNAME=$(VDP_KUBECONFIG_NAMESPACE_K8SNAME)'
	@echo '    VDP_KUBECONFIG_ORGANIZATION_NAME=$(VDP_KUBECONFIG_ORGANIZATION_NAME)'
	@echo '    VDP_KUBECONFIG_PROFILE_NAME=$(VDP_KUBECONFIG_PROFILE_NAME)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VmwareClouD::VDP::Kubeconfig ($(_VMC_VDP_KUBECONFIG_MK_VERSION)) targets:'
	@echo '    _vdp_create_kubeconfig                  - Create a new kubeconfig'
	@echo '    _vdp_delete_kubeconfig                  - Delete an existing kubeconfig'
	@echo '    _vdp_show_kubeconfig                    - Show everything related to a kubeconfig'
	@echo '    _vdp_view_kubeconfigs                   - View kubeconfigs'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_create_kubeconfig:
	@$(INFO) '$(VDP_UI_LABEL)Creating kubeconfig "$(VDP_KUBECONFIG_NAME)" ...'; $(NORMAL)
	KUBECONFIG=$(VDP_KUBECONFIG_FILEPATH) $(VDP) cluster kubeconfig $(__VDP_DEFAULT_NAMESPACE) $(__VDP_MERGE) $(__VDP_ORG__KUBECONFIG) $(__VDP_PROFILE__KUBECONFIG) $(VDP_KUBECONFIG_CLUSTER_NAME)

_vdp_delete_kubeconfig:
	@$(INFO) '$(VDP_UI_LABEL)Deleting kubeconfig "$(VDP_KUBECONFIG_NAME)" ...'; $(NORMAL)

_vdp_show_kubeconfig:
	@$(INFO) '$(VDP_UI_LABEL)Showing kubeconfig "$(VDP_KUBECONFIG_NAME)" ...'; $(NORMAL)
	cat $(VDP_KUBECONFIG_FILEPATH)

_vdp_view_kubeconfigs:
	@$(INFO) '$(VDP_UI_LABEL)Viewing available kubeconfigs ...'; $(NORMAL)
