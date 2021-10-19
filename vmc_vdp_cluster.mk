_VMC_VDP_CLUSTER_MK_VERSION= $(_VMC_VDP_MK_VERSION)

# VDP_CLUSTER_EXEC_COMMAND?= kubectl get ns --all-namespaces
# VDP_CLUSTER_LINK?= /vdp/orgs/my-organization/clusters/my-cluster
# VDP_CLUSTER_NAME?= my-cluster 
# VDP_CLUSTER_ORGANIZATION_LINK?= /vdp/orgs/my-organization
# VDP_CLUSTER_ORGANIZATION_NAME?=  my-organization

# Derived variables
VPD_CLUSTER_LINK?= $(VDP_CLUSTER_ORGANIZATION_LINK)/clusters/$(VDP_CLUSTER_NAME)


# Option variables

# UI variables
 
#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vdp_view_framework_macros ::
	@#echo 'VmwareClouD::VDP::Cluster ($(_VMC_VDP_CLUSTER_MK_VERSION)) macros:'
	@#echo

_vdp_view_framework_parameters ::
	@echo 'VmwareClouD::VDP::Cluster ($(_VMC_VDP_CLUSTER_MK_VERSION)) parameters:'
	@echo '    VDP_CLUSTER_EXEC_COMMAND=$(VDP_CLUSTER_EXEC_COMMAND)'
	@echo '    VDP_CLUSTER_LINK=$(VDP_CLUSTER_LINK)'
	@echo '    VDP_CLUSTER_NAME=$(VDP_CLUSTER_NAME)'
	@echo '    VDP_CLUSTER_ORGANIZATION_LINK=$(VDP_CLUSTER_ORGANIZATION_LINK)'
	@echo '    VDP_CLUSTER_ORGANIZATION_NAME=$(VDP_CLUSTER_ORGANIZATION_NAME)'
	@echo

_vdp_view_framework_targets ::
	@echo 'VmwareClouD::VDP::Cluster ($(_VMC_VDP_CLUSTER_MK_VERSION)) targets:'
	@echo '    _vdp_create_cluster                  - Create a new cluster'
	@echo '    _vdp_dashbaord_cluster               - Open dashboard of a cluster'
	@echo '    _vdp_delete_cluster                  - Delete an existing cluster'
	@echo '    _vdp_show_cluster                    - Show everything related to a cluster'
	@echo '    _vdp_view_clusters                   - View clusters'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vdp_create_cluster:
	@$(INFO) '$(VDP_UI_LABEL)Creating cluster "$(VDP_CLUSTER_NAME)" ...'; $(NORMAL)

_vdp_dashboard_cluster:
	@$(INFO) '$(VDP_UI_LABEL)Open daskboard of cluster "$(VDP_CLUSTER_NAME)" ...'; $(NORMAL)
	$(VDP) clsuter dashbaord $(VDP_CLUSTER_NAME)

_vdp_delete_cluster:
	@$(INFO) '$(VDP_UI_LABEL)Deleting cluster "$(VDP_CLUSTER_NAME)" ...'; $(NORMAL)

_vdp_exec_cluster:
	@$(INFO) '$(VDP_UI_LABEL)Executing command in cluster "$(VDP_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Execute a command in another context, without changing context!'; $(NORMAL)
	$(VDP) cluster exec $(VDP_CLUSTER_NAME) -- $(VDP_CLUSTER_EXEC_COMMAND)

_vdp_show_cluster:
	@$(INFO) '$(VDP_UI_LABEL)Showing cluster "$(VDP_CLUSTER_NAME)" ...'; $(NORMAL)

_vdp_view_clusters:
	@$(INFO) '$(VDP_UI_LABEL)Viewing available clusters ...'; $(NORMAL)
	$(VDP) cluster list
