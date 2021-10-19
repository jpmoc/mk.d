_GCLOUD_CONTAINER_GCR_MK_VERSION= 0.99.1

# GCR_PARAMETER?= value

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gcd_view_framework_macros :: _gcr_view_framework_macros
_gcr_view_framework_macros ::
	@echo 'GCLouD::Container::GCR ($(_GCLOUD_CONTAINER_GCR_MK_VERSION)) targets:'
	@echo


_gcd_view_framework_parameters :: _gcr_view_framework_parameters
_gcr_view_framework_parameters ::
	@echo 'GClouD::Container::GCR ($(_GCLOUD_CONTAINER_GCR_MK_VERSION)) parameters:'
	@echo

_gcd_view_framework_targets :: _gcr_view_framework_targets
_gcr_view_framework_targets ::
	@echo 'GClouD::Container::GCR ($(_GCLOUD_CONTAINER_GCR_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/gcloud_container_gcr_cluster.mk
-include $(MK_DIR)/gcloud_container_gcr_kubeconfig.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
