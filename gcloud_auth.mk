_GCLOUD_AUTH_MK_VERSION= 0.99.1

# GAH_PARAMETER?= value

# Derived parameters

# Options parameters

# UI parameters

#--- Utilities

#--- MACROS


#----------------------------------------------------------------------
# USAGE
#

_gcd_view_framework_macros :: _gah_view_framework_macros
_gah_view_framework_macros ::
	@echo 'GClouD::AutH ($(_GCLOUD_AUTH_MK_VERSION)) macros:'
	@echo


_gcd_view_framework_parameters :: _gah_view_framework_parameters
_gah_view_framework_parameters ::
	@echo 'GClouD::AutH ($(_GCLOUD_AUTH_MK_VERSION)) parameters:'
	@echo

_gcd_view_framework_targets :: _gah_view_framework_targets
_gah_view_framework_targets ::
	@echo 'GClouD::AutH ($(_GCLOUD_AUTH_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/gcloud_auth_applicationdefault.mk
-include $(MK_DIR)/gcloud_auth_credentialedaccount.mk
-include $(MK_DIR)/gcloud_auth_serviceaccount.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
