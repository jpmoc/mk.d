_GCLOUD_CONTAINER_GKE_CLUSTER_MK_VERSION= $(_GCLOUD_CONTAINER_GKE_MK_VERSION)

GKE_CLUSTER_ADDONS?= HorizontalPodAutoscaling HttpLoadBalancing KubernetesDashboard
GKE_CLUSTER_ASYNC_ENABLE?= false
GKE_CLUSTER_AUTOREPAIR_ENABLE?= true
GKE_CLUSTER_AUTOUPGRADE_ENABLE?= false
# GKE_CLUSTER_BASICAUTH_ENABLE?= false
# GKE_CLUSTER_CLOUDENDPOINTS_ENABLE?= false
GKE_CLUSTER_CLOUDLOGGING_ENABLE?= true
GKE_CLUSTER_CLOUDMONITORING_ENABLE?= true
GKE_CLUSTER_DISK_SIZE?= 100
GKE_CLUSTER_DISK_TYPE?= pd-standard
GKE_CLUSTER_IMAGE_TYPE?= COS
# GKE_CLUSTER_IPALIAS_ENABLE?= false
# GKE_CLUSTER_KUBERNETESALPHA_ENABLE?= false
# GKE_CLUSTER_LEGACYAUTHORIZATION_ENABLE?= false
GKE_CLUSTER_MACHINE_TYPE?= n1-standard-1
# GKE_CLUSTER_MASTERAUTHORIZEDNETWORKS_ENABLE?= false
# GKE_CLUSTER_NAME?= my-cluster
GKE_CLUSTER_NETWORK?= projects/nsx-sm/global/networks/default
# GKE_CLUSTER_NETWORKPOLICY_ENABLE?= false
GKE_CLUSTER_NODE_COUNT?= 3
# GKE_CLUSTER_REGION?= us-central1
GKE_CLUSTER_SCOPES?= "https://www.googleapis.com/auth/compute" "https://www.googleapis.com/auth/devstorage.read_only" "https://www.googleapis.com/auth/logging.write" "https://www.googleapis.com/auth/monitoring" "https://www.googleapis.com/auth/servicecontrol" "https://www.googleapis.com/auth/service.management.readonly" "https://www.googleapis.com/auth/trace.append"
GKE_CLUSTER_SUBNETWORK?= "projects/nsx-sm/regions/us-central1/subnetworks/default"
GKE_CLUSTER_USERNAME?= admin
GKE_CLUSTER_VERSION?= 1.9.7-gke.6
GKE_CLUSTER_ZONE?= us-central1-a

# Derived parameters

# Options parameters
__GKE_ADDONS?= $(if $(GKE_CLUSTER_ADDONS),--addons $(subst $(SPACE),$(COMMA),$(GKE_CLUSTER_ADDONS)))
__GKE_ASYNC?= $(if $(filter true, $(GKE_CLUSTER_ASYNC_ENABLE)),--async)
__GKE_CLUSTER_VERSION= $(if $(GKE_CLUSTER_VERSION),--cluster-version $(GKE_CLUSTER_VERSION))
__GKE_DISK_SIZE= $(if $(GKE_CLUSTER_DISK_SIZE),--disk-size $(GKE_CLUSTER_DISK_SIZE))
__GKE_DISK_TYPE= $(if $(GKE_CLUSTER_DISK_TYPE),--disk-type $(GKE_CLUSTER_DISK_TYPE))
__GKE_ENABLE_AUTOREPAIR?= $(if $(filter true, $(GKE_CLUSTER_AUTOREPAIR_ENABLE)),--enable-autorepair)
__GKE_ENABLE_AUTOUPGRADE?= $(if $(filter true, $(GKE_CLUSTER_AUTOUPGRADE_ENABLE)),--enable-autoupgrade)
__GKE_ENABLE_BASIC_AUTH?= $(if $(filter true, $(GKE_CLUSTER_BASICAUTH_ENABLE)),--enable-basic-auth)
__GKE_ENABLE_CLOUD_ENDPOINTS?= $(if $(filter true, $(GKE_CLUSTER_CLOUDENDPOINTS_ENABLE)),--enable-cloud-endpoints)
__GKE_ENABLE_CLOUD_LOGGING?= $(if $(filter true, $(GKE_CLUSTER_CLOUDLOGGING_ENABLE)),--enable-cloud-logging)
__GKE_ENABLE_CLOUD_MONITORING?= $(if $(filter true, $(GKE_CLUSTER_CLOUDMONITORING_ENABLE)),--enable-cloud-monitoring)
__GKE_ENABLE_IP_ALIAS?= $(if $(filter true, $(GKE_CLUSTER_IPALIAS_ENABLE)),--enable-ip-alias)
__GKE_ENABLE_KUBERNETES_ALPHA?= $(if $(filter true, $(GKE_CLUSTER_KUBERNETESALPHA_ENABLE)),--enable-kubernetes-alpha)
__GKE_ENABLE_LEGACY_AUTHORIZATION?= $(if $(filter true, $(GKE_CLUSTER_LEGACYAUTHORIZATION_ENABLE)),--enable-legacy-authorization)
__GKE_ENABLE_MASTER_AUTHORIZED_NETWORKS?= $(if $(filter true, $(GKE_CLUSTER_MASTERAUTHORIZEDNETWORKS_ENABLE)),--enable-master-authorized-networks)
__GKE_ENABLE_NETWORK_POLICY?= $(if $(filter true, $(GKE_CLUSTER_NETWORKPOLICY_ENABLE)),--enable-network-policy)
__GKE_IMAGE_TYPE= $(if $(GKE_CLUSTER_IMAGE_TYPE),--image-type $(GKE_CLUSTER_IMAGE_TYPE))
__GKE_MACHINE_TYPE= $(if $(GKE_CLUSTER_MACHINE_TYPE),--machine-type $(GKE_CLUSTER_MACHINE_TYPE))
__GKE_NETWORK= $(if $(GKE_CLUSTER_NETWORK),--network $(GKE_CLUSTER_NETWORK))
__GKE_NUM_NODES= $(if $(GKE_CLUSTER_NODE_COUNT),--num-nodes $(GKE_CLUSTER_NODE_COUNT))
__GKE_REGION__CLUSTER= $(if $(GKE_CLUSTER_REGION),--region $(GKE_CLUSTER_REGION))
__GKE_SCOPES= $(if $(GKE_CLUSTER_SCOPES),--scopes $(subst $(SPACE),$(COMMA),$(GKE_CLUSTER_SCOPES)))
__GKE_SUBNETWORK= $(if $(GKE_CLUSTER_SUBNETWORK),--subnetwork $(GKE_CLUSTER_SUBNETWORK))
__GKE_USERNAME= $(if $(GKE_CLUSTER_USERNAME),--username $(GKE_CLUSTER_USERNAME))
__GKE_ZONE__CLUSTER= $(if $(GKE_CLUSTER_ZONE),--zone $(GKE_CLUSTER_ZONE))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_gke_view_framework_macros ::
	@echo 'GCLouD::Container::GKE::Cluster ($(_GCLOUD_CONTAINER_GKE_CLUSTER_MK_VERSION)) targets:'
	@echo

_gke_view_framework_parameters ::
	@echo 'GClouD::Container::GKE::Cluster ($(_GCLOUD_CONTAINER_GKE_CLUSTER_MK_VERSION)) parameters:'
	@echo '    GKE_CLUSTER_ADDONS=$(GKE_CLUSTER_ADDONS)'
	@echo '    GKE_CLUSTER_ASYNC_ENABLE=$(GKE_CLUSTER_ASYNC_ENABLE)'
	@echo '    GKE_CLUSTER_AUTOREPAIR_ENABLE=$(GKE_CLUSTER_AUTOREPAIR_ENABLE)'
	@echo '    GKE_CLUSTER_AUTOUPGRADE_ENABLE=$(GKE_CLUSTER_AUTOUPGRADE_ENABLE)'
	@echo '    GKE_CLUSTER_CLOUDENDPOINTS_ENABLE=$(GKE_CLUSTER_CLOUDENDPOINTS_ENABLE)'
	@echo '    GKE_CLUSTER_CLOUDLOGGING_ENABLE=$(GKE_CLUSTER_CLOUDLOGGING_ENABLE)'
	@echo '    GKE_CLUSTER_CLOUDMONITORING_ENABLE=$(GKE_CLUSTER_CLOUDMONITORING_ENABLE)'
	@echo '    GKE_CLUSTER_DISK_SIZE=$(GKE_CLUSTER_DISK_SIZE)'
	@echo '    GKE_CLUSTER_DISK_TYPE=$(GKE_CLUSTER_DISK_TYPE)'
	@echo '    GKE_CLUSTER_IMAGE_TYPE=$(GKE_CLUSTER_IMAGE_TYPE)'
	@echo '    GKE_CLUSTER_IPALIAS_ENABLE=$(GKE_CLUSTER_IPALIAS_ENABLE)'
	@echo '    GKE_CLUSTER_KUBERNETESALPHA_ENABLE=$(GKE_CLUSTER_KUBERNETESALPHA_ENABLE)'
	@echo '    GKE_CLUSTER_LEGACYAUTHORIZATION_ENABLE=$(GKE_CLUSTER_LEGACYAUTHORIZATION_ENABLE)'
	@echo '    GKE_CLUSTER_MACHINE_TYPE=$(GKE_CLUSTER_MACHINE_TYPE)'
	@echo '    GKE_CLUSTER_MASTERAUTHORIZEDNETWORKS_ENABLE=$(GKE_CLUSTER_MASTERAUTHORIZEDNETWORKS_ENABLE)'
	@echo '    GKE_CLUSTER_NAME=$(GKE_CLUSTER_NAME)'
	@echo '    GKE_CLUSTER_NETWORK=$(GKE_CLUSTER_NETWORK)'
	@echo '    GKE_CLUSTER_NETWORKPOLICY_ENABLE=$(GKE_CLUSTER_NETWORKPOLICY_ENABLE)'
	@echo '    GKE_CLUSTER_NODE_COUNT=$(GKE_CLUSTER_NODE_COUNT)'
	@echo '    GKE_CLUSTER_SCOPES=$(GKE_CLUSTER_SCOPES)'
	@echo '    GKE_CLUSTER_SUBNETWORK=$(GKE_CLUSTER_SUBNETWORK)'
	@echo '    GKE_CLUSTER_USERNAME=$(GKE_CLUSTER_USERNAME)'
	@echo '    GKE_CLUSTER_VERSION=$(GKE_CLUSTER_VERSION)'
	@echo '    GKE_CLUSTER_ZONE=$(GKE_CLUSTER_ZONE)'
	@echo

_gke_view_framework_targets ::
	@echo 'GClouD::Container::GKE::Cluster ($(_GCLOUD_CONTAINER_GKE_CLUSTER_MK_VERSION)) targets:'
	@echo '    _gke_create_cluster                 - Create a cluster'
	@echo '    _gke_delete_cluster                 - Delete a cluster'
	@echo '    _gke_show_cluster                   - Show everything related to a cluster'
	@echo '    _gke_view_clusters                  - View clusters'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gke_create_cluster:
	@$(INFO) '$(GCD_UI_LABEL)Creating cluster "$(GKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(GCLOUD) container clusters create $(__GKE_ADDONS) $(__GKE_CLUSTER_VERSION) $(__GKE_DISK_SIZE) $(__GKE_DISK_TYPE) $(__GKE_ENABLE_AUTOREPAIR) $(__GKE_ENABLE_AUTOUPGRADE) $(__GKE_ENABLE_CLOUD_ENDPOINTS) $(__GKE_ENABLE_CLOUD_LOGGING) $(__GKE_ENABLE_CLOUD_MONITORING) $(__GKE_ENABLE_IP_ALIAS) $(__GKE_ENABLE_KUBERNETES_ALPHA) $(__GKE_ENABLE_LEGACY_AUTHORIZATION) $(__GKE_ENABLE_MASTER_AUTHORIZED_NETWORKS) $(__GKE_ENABLE_NETWORK_POLICY) $(__GKE_IMAGE_TYPE) $(__GKE_MACHINE_TYPE) $(__GKE_NETWORK) $(__GKE_NUM_NODES) $(__GKE_SCOPES) $(__GKE_SUBNETWORK) $(__GKE_USERNAME) $(__GKE_ZONE__CLUSTER) $(GKE_CLUSTER_NAME)

_gke_delete_cluster:
	@$(INFO) '$(GCD_UI_LABEL)Deleting cluster "$(GKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(GCLOUD)  container clusters delete $(__GKE_ASYNC) $(__GKE_REGION__CLUSTER) $(__GKE_ZONE__CLUSTER) $(GKE_CLUSTER_NAME)

_gke_show_cluster:
	@$(INFO) '$(GCD_UI_LABEL)Showing cluster "$(GKE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(GCLOUD) container clusters describe $(GKE_CLUSTER_NAME)

_gke_view_clusters:
	@$(INFO) '$(GCD_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(GCLOUD) container clusters list
