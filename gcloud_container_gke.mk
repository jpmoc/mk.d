_GCLOUD_CONTAINER_GKE_MK_VERSION= 0.99.1

# GKE_PARAMETER?= value

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gcd_view_framework_macros :: _gke_view_framework_macros
_gke_view_framework_macros ::
	@echo 'GCLouD::Container::GKE ($(_GCLOUD_CONTAINER_GKE_MK_VERSION)) targets:'
	@echo


_gcd_view_framework_parameters :: _gke_view_framework_parameters
_gke_view_framework_parameters ::
	@echo 'GClouD::Container::GKE ($(_GCLOUD_CONTAINER_GKE_MK_VERSION)) parameters:'
	@echo

_gcd_view_framework_targets :: _gke_view_framework_targets
_gke_view_framework_targets ::
	@echo 'GClouD::Container::GKE ($(_GCLOUD_CONTAINER_GKE_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/gcloud_container_gke_cluster.mk
-include $(MK_DIR)/gcloud_container_gke_kubeconfig.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
