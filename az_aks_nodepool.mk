_AZ_AKS_NODEPOOL_MK_VERSION= $(_AZ_AKS_MK_VERSION)

# AKS_NODEPOOL_CLUSTER_NAME?= nodepool1
# AKS_NODEPOOL_MODE_NOWAIT_FLAG?= false
# AKS_NODEPOOL_NODE_COUNT?= 3
# AKS_NODEPOOL_RESOURCEGROUP_NAME?= MyResourceGroup
# AKS_NODEPOOLS_SET_NAME?=

# Derived parameters
AKS_NODEPOOL_CLUSTER_NAME?= $(AKS_CLUSTER_NAME)
# AKS_NODEPOOL_LOCATION_ID?= $(AKS_LOCATION_ID)
AKS_NODEPOOL_MODE_NOWAIT?= $(AKS_MODE_NOWAIT)
# AKS_NODEPOOL_MODE_YES?= $(AKS_MODE_YES)
AKS_NODEPOOL_RESOURCEGROUP_NAME?= $(AKS_CLUSTER_RESOURCEGROUP_NAME)

# Options parameters
__AKS_CLUSTER_NAME__NODEPOOL= $(if $(AKS_NODEPOOL_CLUSTER_NAME),--cluster-name $(AKS_NODEPOOL_CLUSTER_NAME))
__AKS_CLUSTER_NAME__NODEPOOLS= $(if $(AKS_NODEPOOL_CLUSTER_NAME),--cluster-name $(AKS_NODEPOOL_CLUSTER_NAME))
__AKS_NAME__NODEPOOL= $(if $(AKS_NODEPOOL_CLUSTER_NAME),--name $(AKS_NODEPOOL_CLUSTER_NAME))
__AKS_NODEPOOL_NAME__NODEPOOL= $(if $(AKS_NODEPOOL_NAME),--nodepool-name $(AKS_NODEPOOL_NAME))
__AKS_NO_WAIT__NODEPOOL= $(if $(filter true,$(AKS_NODEPOOL_MODE_NOWAIT)),--no-wait)
__AKS_NODE_COUNT__NODEPOOL= $(if $(AKS_NODEPOOL_NODE_COUNT),--node-count $(AKS_NODEPOOL_NODE_COUNT))
__AKS_RESOURCE_GROUP__NODEPOOL= $(if $(AKS_NODEPOOL_RESOURCEGROUP_NAME),--resource-group $(AKS_NODEPOOL_RESOURCEGROUP_NAME))
__AKS_RESOURCE_GROUP__NODEPOOLS= $(if $(AKS_NODEPOOL_RESOURCEGROUP_NAME),--resource-group $(AKS_NODEPOOL_RESOURCEGROUP_NAME))

# UI parameters

#--- Utilities

#--- MAKSO

#----------------------------------------------------------------------
# USAGE
#

_aks_view_framework_maksos ::
	@echo 'AZ::AKS::NodePool ($(_AZ_AKS_NODEPOOL_MK_VERSION)) maksos:'
	@echo

_aks_view_framework_parameters ::
	@echo 'AZ::AKS::NodePool ($(_AZ_AKS_NODEPOOL_MK_VERSION)) parameters:'
	@echo '    AKS_NODEPOOL_CLUSTER_NAME=$(AKS_NODEPOOL_CLUSTER_NAME)'
	@echo '    AKS_NODEPOOL_MODE_NOWAIT=$(AKS_NODEPOOL_MODE_NOWAIT)'
	@#echo '    AKS_NODEPOOL_MODE_YES=$(AKS_NODEPOOL_MODE_YES)'
	@echo '    AKS_NODEPOOL_NAME=$(AKS_NODEPOOL_NAME)'
	@echo '    AKS_NODEPOOL_NODE_COUNT=$(AKS_NODEPOOL_NODE_COUNT)'
	@echo '    AKS_NODEPOOL_RESOURCEGROUP_NAME=$(AKS_NODEPOOL_RESOURCEGROUP_NAME)'
	@echo '    AKS_NODEPOOLS_SET_NAME=$(AKS_NODEPOOLS_SET_NAME)'
	@echo

_aks_view_framework_targets ::
	@echo 'AZ::AKS::NodePool ($(_AZ_AKS_NODEPOOL_MK_VERSION)) targets:'
	@echo '    _aks_create_nodepool                - Create a node-pool'
	@echo '    _aks_delete_nodepool                - Delete a node-pool'
	@echo '    _aks_show_nodepool                  - Show everything related to a node-pool'
	@echo '    _aks_show_nodepool_description      - Show description of a node-pool'
	@echo '    _aks_view_nodepools                 - View node-pools'
	@echo '    _aks_view_nodepools_set             - View a set of node-pools'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aks_create_nodepool:
	@$(INFO) '$(AKS_UI_LABEL)Creating node-pool "$(AKS_NODEPOOL_NAME)" ...'; $(NORMAL)
	#$(AZ) aks create

_aks_delete_nodepool:
	@$(INFO) '$(AKS_UI_LABEL)Deleting node-pool "$(AKS_NODEPOOL_NAME)" ...'; $(NORMAL)
	#$(AZ) aks delete $(__AKS_NAME__NODEPOOL) $(__AKS_NO_WAIT__NODEPOOL) $(__AKS_RESOURCE_GROUP__NODEPOOL) $(__AKS_SUBSCRIPTION) $(__AKS_YES__NODEPOOL)

_aks_scale_nodepool:
	@$(INFO) '$(AKS_UI_LABEL)Scaling node-pool "$(AKS_NODEPOOL_NAME)" ...'; $(NORMAL)
	$(AZ) aks scale $(__AKS_NAME__NODEPOOL) $(__AKS_NO_WAIT__NODEPOOL) $(__AKS_NODE_COUNT__NODEPOOL) $(__AKS_RESOURCE_GROUP__NODEPOOL) $(__AKS_SUSBCRIPTION)

_aks_show_nodepool :: _aks_show_nodepool_description

_aks_show_nodepool_description:
	@$(INFO) '$(AKS_UI_LABEL)Showing description of node-pool "$(AKS_NODEPOOL_NAME)" ...'; $(NORMAL)
	#$(AZ) aks show $(__AKS_NAME__NODEPOOL) $(__AKS_OUTPUT) $(__AKS_RESOURCE_GROUP__NODEPOOL) $(__AKS_SUBSCRIPTION) 

_aks_view_nodepools:
	@$(INFO) '$(AKS_UI_LABEL)Viewing node-pools ...'; $(NORMAL)
	$(AZ) aks nodepool list $(__AKS_CLUSTER_NAME__NODEPOOLS) $(__AKS_OUTPUT) $(__AKS_RESOURCE_GROUP__NODEPOOLS) $(__AKS_SUBSCRIPTION)

_aks_view_nodepools_set:
	@$(INFO) '$(AKS_UI_LABEL)Viewing node-pools-set "$(AKS_NODEPOOLS_SET_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'Registries are grouped based on resource-group and query-filter'; $(NORMAL)
	#$(AZ) aks list $(__AKS_OUTPUT) $(__AKS_RESOURCE_GROUP) $(__AKS_SUBSCRIPTION)
