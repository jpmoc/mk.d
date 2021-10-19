_GCLOUD_CONFIG_MK_VERSION= 0.99.1

# GCG_PARAMETER?= value

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gcd_view_framework_macros :: _gcg_view_framework_macros
_gcg_view_framework_macros ::
	@echo 'GClouD::ConfiG ($(_GCLOUD_CONFIG_MK_VERSION)) macros:'
	@echo


_gcd_view_framework_parameters :: _gcg_view_framework_parameters
_gcg_view_framework_parameters ::
	@echo 'GClouD::ConfiG ($(_GCLOUD_CONFIG_MK_VERSION)) parameters:'
	@echo

_gcd_view_framework_targets :: _gcg_view_framework_targets
_gcg_view_framework_targets ::
	@echo 'GClouD::ConfiG ($(_GCLOUD_CONFIG_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/gcloud_config_configuration.mk
-include $(MK_DIR)/gcloud_config_property.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
