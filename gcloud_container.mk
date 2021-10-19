_GCLOUD_CONTAINER_MK_VERSION= $(_GCLOUD_MK_VERSION)

# GCD_PARAMETER?= value

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gcd_view_framework_macros ::
	@echo 'GCLouD::Container ($(_GCLOUD_CONTAINER_MK_VERSION)) targets:'
	@echo


_gcd_view_framework_parameters ::
	@echo 'GClouD::Container ($(_GCLOUD_CONTAINER_MK_VERSION)) parameters:'
	@echo

_gcd_view_framework_targets ::
	@echo 'GClouD::Container ($(_GCLOUD_CONTAINER_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/gcloud_container_gcr.mk
-include $(MK_DIR)/gcloud_container_gke.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
