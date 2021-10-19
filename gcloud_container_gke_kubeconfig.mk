_GCP_CONTAINER_GKE_KUBECONFIG_MK_VERSION= $(_GCP_CONTAINER_GKE_MK_VERSION)

# GKE_KUBECONFIG_CLUSTER_NAME?= my-cluster
# GKE_KUBECONFIG_CLUSTER_REGION?= us-central1
# GKE_KUBECONFIG_CLUSTER_ZONE?= us-central1-a
# GKE_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config

# Derived parameters
GKE_KUBECONFIG_CLUSTER_NAME?= $(GKE_CLUSTER_NAME)
GKE_KUBECONFIG_CLUSTER_REGION?= $(GKE_CLUSTER_REGION)
GKE_KUBECONFIG_CLUSTER_ZONE?= $(GKE_CLUSTER_ZONE)
GKE_KUBECONFIG_FILEPATH?= $(HOME)/.kube/config

# Options parameters
__GKE_REGION__KUBECONFIG= $(if $(GKE_KUBECONFIG_CLUSTER_REGION),--region $(GKE_KUBECONFIG_CLUSTER_REGION))
__GKE_ZONE__KUBECONFIG= $(if $(GKE_KUBECONFIG_CLUSTER_ZONE),--zone $(GKE_KUBECONFIG_CLUSTER_ZONE))

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gke_view_framework_macros ::
	@echo 'GClouD::Container::GKE::Kubeconfig ($(_GCP_CONTAINER_GKE_KUBECONFIG_MK_VERSION)) targets:'
	@echo


_gke_view_framework_parameters ::
	@echo 'GClouD::Container::GKE::Kubeconfig ($(_GCP_CONTAINER_GKE_CLUSTER_MK_VERSION)) parameters:'
	@echo '    GKE_KUBECONFIG_CLUSTER_NAME=$(GKE_KUBECONFIG_CLUSTER_NAME)'
	@echo '    GKE_KUBECONFIG_CLUSTER_REGION=$(GKE_KUBECONFIG_CLUSTER_REGION)'
	@echo '    GKE_KUBECONFIG_CLUSTER_ZONE=$(GKE_KUBECONFIG_CLUSTER_ZONE)'
	@echo

_gke_view_framework_targets ::
	@echo 'GClouD::Container::GKE::Kubeconfig ($(_GCP_CONTAINER_GKE_CLUSTER_MK_VERSION)) targets:'
	@echo '    _gke_create_kubeconfig              - Create a kubeconfig'
	@echo '    _gke_refresh_kubeconfig             - Refresh credentials in a kubeconfig'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_gke_create_kubeconfig:
	@$(INFO) '$(GCD_UI_LABEL)Configuring kubeconfig for cluster "$(GKE_KUBECONFIG_CLUSTER_NAME)" ...'; $(NORMAL)
	KUBECONFIG=$(GKE_KUBECONFIG_FILEPATH) $(GCLOUD) container clusters get-credentials $(__GKE_REGION__KUBECONFIG) $(__GKE_ZONE__KUBECONFIG) $(GKE_KUBECONFIG_CLUSTER_NAME)

_gke_refresh_kubeconfig: _gke_create_kubeconfig
