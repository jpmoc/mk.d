_AZ_AKS_CLUSTER_MK_VERSION= $(_AZ_AKS_MK_VERSION)

AKS_CLUSTER_ADMIN_USERNAME?= azureuser
# AKS_CLUSTER_FQDN?= emayssat-c-emayssat-dev-f8b96e-5cb087a5.hcp.westus2.azmk8s.io
# AKS_CLUSTER_KUBERNETES_VERSION?= 1.14.7
# AKS_CLUSTER_LOCATION_ID?= westus2
AKS_CLUSTER_MAXPODS_COUNT?= 110
# AKS_CLUSTER_MODE_NOWAIT?= false
# AKS_CLUSTER_MODE_YES?= false
# AKS_CLUSTER_NAME?= Mycluster
AKS_CLUSTER_NODE_COUNT?= 3
AKS_CLUSTER_NODE_OSDISKSIZE?= 100
AKS_CLUSTER_NODE_SIZE?= Standard_DS2_v2
AKS_CLUSTER_NODEPOOL_NAME?= nodepool1
# AKS_CLUSTER_RESOURCEGROUP_NAME?= MyResourceGroup
# AKS_CLUSTER_SERVICEPRINCIPAL_ID?=  e6f19b53-4f30-42f2-b7f8-6a798bc6ed26# Used for roles
AKS_CLUSTER_SSHPUBLICKEY_FILEPATH?= $(HOME)/.ssh/id_rsa.pub
# AKS_CLUSTERS_SET_NAME?=

# Derived parameters
AKS_CLUSTER_LOCATION_ID?= $(AKS_LOCATION_ID)
AKS_CLUSTER_MODE_NOWAIT?= $(AKS_MODE_NOWAIT)
AKS_CLUSTER_MODE_YES?= $(AKS_MODE_YES)
AKS_CLUSTER_NODEPOOLS_NAMES?= $(AKS_CLUSTER_NODEPOOL_NAME)
AKS_CLUSTER_RESOURCEGROUP_NAME?= $(AKS_RESOURCEGROUP_NAME)

# Options parameters
__AKS_ADMIN_ENABLED=
__AKS_ADMIN_USERNAME= $(if $(AKS_CLUSTER_ADMIN_USERNAME),--admin-username $(AKS_CLUSTER_ADMIN_USERNAME))
__AKS_DEFAULT_ACTION=
__AKS_KUBERNETES_VERSION= $(if $(AKS_CLUSTER_KUBERNETES_VERSION),--kubernetes-version $(AKS_CLUSTER_KUBERNETES_VERSION))
__AKS_LOCATION__CLUSTER= $(if $(AKS_CLUSTER_LOCATION_ID),--location $(AKS_CLUSTER_LOCATION_ID))
__AKS_MAX_PODS= $(if $(AKS_CLUSTER_MAXPODS_COUNT),--max-pods $(AKS_CLUSTER_MAXPODS_COUNT))
__AKS_NAME__CLUSTER= $(if $(AKS_CLUSTER_NAME),--name $(AKS_CLUSTER_NAME))
__AKS_NO_WAIT__CLUSTER= $(if $(filter true, $(AKS_CLUSTER_MODE_NOWAIT)),--no-wait)
__AKS_NODE_COUNT__CLUSTER= $(if $(AKS_CLUSTER_NODE_COUNT),--node-count $(AKS_CLUSTER_NODE_COUNT))
__AKS_NODE_VM_SIZE= $(if $(AKS_CLUSTER_NODE_SIZE),--node-vm-size $(AKS_CLUSTER_NODE_SIZE))
__AKS_NODEPOOL_NAME__CLUSTER= $(if $(AKS_CLUSTER_NODEPOOL_NAME),--nodepool-name $(AKS_CLUSTER_NODEPOOL_NAME))
__AKS_OS_DISK_SIZE= $(if $(AKS_CLUSTER_NODE_OSDISKSIZE),--os-disk-size $(AKS_CLUSTER_NODE_OSDISKSIZE))
__AKS_RESOURCE_GROUP__CLUSTER= $(if $(AKS_CLUSTER_RESOURCEGROUP_NAME),--resource-group $(AKS_CLUSTER_RESOURCEGROUP_NAME))
__AKS_SSH_KEY_VALUE__CLUSTER= $(if $(AKS_CLUSTER_SSHPUBLICKEY_FILEPATH),--ssh-key-value $(AKS_CLUSTER_SSHPUBLICKEY_FILEPATH))
__AKS_TAGS__CLUSTER=
__AKS_VM_SET_TYPE=
__AKS_VNET_SUBNET_ID=
__AKS_WORKSPACE_RESOURCE_ID=
__AKS_YES__CLUSTER= $(if $(filter true, $(AKS_CLUSTER_MODE_YES)),--yes)

# UI parameters

#--- Utilities

#--- MACROS
_aks_get_cluster_fqdn= $(call _aks_get_cluster_fqdn_N, $(AKS_CLUSTER_NAME))
_aks_get_cluster_fqdn_N= $(call _aks_get_cluster_fqdn_NG, $(1), $(AKS_CLUSTER_RESOURCEGROUP_NAME))
_aks_get_cluster_fqdn_NG= $(call _aks_get_cluster_fqdn_NGS, $(1), $(2), $(AKS_SUBSCRIPTION_ID_OR_NAME))
_aks_get_cluster_fqdn_NGS= $(shell $(AZ) aks show --name $(1) --resource-group $(2) --subscription $(3) --query "fqdn" --output tsv)

_aks_get_cluster_nodepools_names= $(call _aks_get_cluster_nodepools_names_N, $(AKS_CLUSTER_NAME))
_aks_get_cluster_nodepools_names_N= $(call _aks_get_cluster_nodepools_names_NG, $(1), $(AKS_CLUSTER_RESOURCEGROUP_NAME))
_aks_get_cluster_nodepools_names_NG= $(call _aks_get_cluster_nodepools_names_NGS, $(1), $(2), $(AKS_CLUSTER_SUBSCRIPTION_IR_OR_NAME))
_aks_get_cluster_nodepools_names_NGS= $(shell $(AZ)aks show --name $(1) --resource-group $(2) --subscription $(3) --query "agentPoolProfiles[].name" --output tsv)

_aks_get_cluster_serviceprincipal_id= $(call _aks_get_cluster_serviceprincipal_id_N, $(AKS_CLUSTER_NAME))
_aks_get_cluster_serviceprincipal_id_N= $(call _aks_get_cluster_serviceprincipal_id_NG, $(1), $(AKS_CLUSTER_RESOURCEGROUP_NAME))
_aks_get_cluster_serviceprincipal_id_NG= $(call _aks_get_cluster_serviceprincipal_id_NGS, $(1), $(2), $(AKS_SUBSCRIPTION_ID_OR_NAME))
_aks_get_cluster_serviceprincipal_id_NGS= $(shell $(AZ) aks show --name $(1) --resource-group $(2) --subscription $(3) --query "servicePrincipalProfile.clientId" --output tsv)

#----------------------------------------------------------------------
# USAGE
#

_aks_view_framework_macros ::
	@echo 'AZ::AKS::Cluster ($(_AZ_AKS_CLUSTER_MK_VERSION)) macros:'
	@echo '    _aks_get_cluster_fqdn_{|N|NG|NGS}                - Get the FQDN of a cluster (Name,resourceGroup,Subscription)'
	@echo '    _aks_get_cluster_nodepools_names_{|N|NG|NGS}     - Get the nodepool-names of a cluster (Name,resourceGroup,Subscription)'
	@echo '    _aks_get_cluster_serviceprincipal_id_{|N|NG|NGS} - Get the service-principal a cluster (Name,resourceGroup,Subscription)'
	@echo

_aks_view_framework_parameters ::
	@echo 'AZ::AKS::Cluster ($(_AZ_AKS_CLUSTER_MK_VERSION)) parameters:'
	@echo '    AKS_CLUSTER_ADMIN_USERNAME=$(AKS_CLUSTER_ADMIN_USERNAME)'
	@echo '    AKS_CLUSTER_FQDN=$(AKS_CLUSTER_FQDN)'
	@echo '    AKS_CLUSTER_ID=$(AKS_CLUSTER_ID)'
	@echo '    AKS_CLUSTER_KUBERNETES_VERSION=$(AKS_CLUSTER_KUBERNETES_VERSION)'
	@echo '    AKS_CLUSTER_LOCATION_ID=$(AKS_CLUSTER_LOCATION_ID)'
	@echo '    AKS_CLUSTER_MAXPODS_COUNT=$(AKS_CLUSTER_MAXPODS_COUNT)'
	@echo '    AKS_CLUSTER_MODE_NOWAIT=$(AKS_CLUSTER_MODE_NOWAIT)'
	@echo '    AKS_CLUSTER_MODE_YES=$(AKS_CLUSTER_MODE_YES)'
	@echo '    AKS_CLUSTER_NAME=$(AKS_CLUSTER_NAME)'
	@echo '    AKS_CLUSTER_NODE_COUNT=$(AKS_CLUSTER_NODE_COUNT)'
	@echo '    AKS_CLUSTER_NODE_OSDISKSIZE=$(AKS_CLUSTER_NODE_OSDISKSIZE)'
	@echo '    AKS_CLUSTER_NODE_SIZE=$(AKS_CLUSTER_NODE_SIZE)'
	@echo '    AKS_CLUSTER_NODEPOOL_NAME=$(AKS_CLUSTER_NODEPOOL_NAME)'
	@echo '    AKS_CLUSTER_SERVICEPRINCIPAL_ID=$(AKS_CLUSTER_SERVICEPRINCIPAL_ID)'
	@echo '    AKS_CLUSTER_SSHPUBLICKEY_FILEPATH=$(AKS_CLUSTER_SSHPUBLICKEY_FILEPATH)'
	@echo '    AKS_CLUSTERS_IDS=$(AKS_CLUSTERS_IDS)'
	@echo '    AKS_CLUSTERS_SET_NAME=$(AKS_CLUSTERS_SET_NAME)'
	@echo

_aks_view_framework_targets ::
	@echo 'AZ::AKS::Cluster ($(_AZ_AKS_CLUSTER_MK_VERSION)) targets:'
	@echo '    _aks_create_cluster                - Create a cluster'
	@echo '    _aks_delete_cluster                - Delete a cluster'
	@echo '    _aks_scale_cluster                 - Scale a cluster up and down'
	@echo '    _aks_show_cluster                  - Show everything related to a cluster'
	@echo '    _aks_show_cluster_description      - Show description of a cluster'
	@echo '    _aks_view_clusters                 - View clusters'
	@echo '    _aks_view_clusters_set             - View a set of clusters'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_aks_create_cluster:
	@$(INFO) '$(AKS_UI_LABEL)Creating cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation fails if a cluster with the same name already exists'; $(NORMAL)
	$(AZ) aks create $(strip $(__AKS_AAD_CLIENT_APP_ID) $(__AKS_AAD_SERVER_APP_ID) $(__AKS_AAD_SERVER_APP_SECRET) $(__AKS_AAD_TENANT_ID) $(__AKS_ADMIN_USERNAME) $(__AKS_ATTACH_ACR) $(__AKS_CLIENT_SECRET) $(__AKS_DISABLE_RBAC) $(__AKS_DNS_NAME_PREFIX) $(__AKS_DNS_SERVICE_IP) $(__AKS_DOCKER_BRIDGE_ADDRESS) $(__AKS_ENABLE_ADDONS) $(__AKS_ENABLE_RBAC) $(__AKS_GENERATE_SSH_KEYS) $(__AKS_KUBERNETES_VERSION) $(__AKS_LOAD_BALANCER_MANAGED_OUTBOUND_IP_COUNT) $(__AKS_LOAD_BALANCER_OUTBOUND_IP_PREFIXES) $(__AKS_LOAD_BALANCER_OUTBOUND_IPS) $(__AKS_LOAD_BALANCER_SKU) $(__AKS_LOCATION__CLUSTER) $(__AKS_MAX_PODS) $(__AKS_NAME__CLUSTER) $(__AKS_NETWORK_PLUGIN) $(__AKS_NETWORK_POLICY) $(__AKS_NO_SSH_KEY) $(__AKS_NO_WAIT__CLUSTER) $(__AKS_NODE_COUNT__CLUSTER) $(__AKS_NODE_OSDISK_SIZE) $(__AKS_NODE_VM_SIZE) $(__AKS_NODEPOOL_NAME__CLUSTER) $(__AKS_POD_CIDR) $(__AKS_RESOURCE_GROUP__CLUSTER) $(__AKS_SERVICE_CIDR) $(__AKS_SERVICE_PRINCIPAL) $(__AKS_SKIP_SUBNET_ROLE_ASSIGNMENT) $(__AKS_SSH_KEY_VALUE__CLUSTER) $(__AKS_SUBSCRIPTION) $(__AKS_TAGS__CLUSTER) $(__AKS_VM_SET_TYPE) $(__AKS_VNET_SUBNET_ID) $(__AKS_WORKSPACE_RESOURCE_ID) )

_aks_delete_cluster:
	@$(INFO) '$(AKS_UI_LABEL)Deleting cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AZ) aks delete $(__AKS_NAME__CLUSTER) $(__AKS_NO_WAIT__CLUSTER) $(__AKS_RESOURCE_GROUP__CLUSTER) $(__AKS_SUBSCRIPTION) $(__AKS_YES__CLUSTER)

_aks_scale_cluster:
	@$(INFO) '$(AKS_UI_LABEL)Scaling cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AZ) aks scale $(__AKS_NAME__CLUSTER) $(__AKS_NO_WAIT__CLUSTER) $(__AKS_NODE_COUNT__CLUSTER) $(__AKS_NODEPOOL_NAME__CLUSTER) $(__AKS_RESOURCE_GROUP__CLUSTER) $(__AKS_SUBSCRIPTION)

_aks_show_cluster :: _aks_show_cluster_fqdn _aks_show_cluster_nodepools _aks_show_cluster_object _aks_show_cluster_description

_aks_show_cluster_description:
	@$(INFO) '$(AKS_UI_LABEL)Showing description of cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AZ) aks show $(__AKS_NAME__CLUSTER) $(__AKS_OUTPUT) $(__AKS_RESOURCE_GROUP__CLUSTER) $(__AKS_SUBSCRIPTION) 

_aks_show_cluster_fqdn:
	@$(INFO) '$(AKS_UI_LABEL)Showing FQDN of cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(if $(AKS_CLUSTER_FQDN), dig $(AKS_CLUSTER_FQDN))

_aks_show_cluster_nodepools:
	@$(INFO) '$(AKS_UI_LABEL)Showing nodepools of cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AZ) aks show $(__AKS_NAME__CLUSTER) $(__AKS_OUTPUT) $(__AKS_RESOURCE_GROUP__CLUSTER) $(__AKS_SUBSCRIPTION) --query "agentPoolProfiles"

_aks_show_cluster_object:
	@$(INFO) '$(AKS_UI_LABEL)Showing object of cluster "$(AKS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AZ) aks show $(__AKS_NAME__CLUSTER) $(_X__AKS_OUTPUT) --output json $(__AKS_RESOURCE_GROUP__CLUSTER) $(__AKS_SUBSCRIPTION) 

_aks_view_clusters:
	@$(INFO) '$(AKS_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(AZ) aks list $(__AKS_OUTPUT) $(__AKS_SUBSCRIPTION)

_aks_view_clusters_set:
	@$(INFO) '$(AKS_UI_LABEL)Viewing clusters-set "$(AKS_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Registries are grouped based on resource-group and query-filter'; $(NORMAL)
	$(AZ) aks list $(__AKS_OUTPUT) $(__AKS_RESOURCE_GROUP) $(__AKS_SUBSCRIPTION)
