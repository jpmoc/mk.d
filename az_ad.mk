_AZ_AD_MK_VERSION= 0.99.1

# AD_INPUTS_DIRPATH?=
# AD_LOCATION_ID?=
# AD_OUTPUT_FORMAT?= table
# AD_OUTPUTS_DIRPATH?=
# AD_SUBSCRIPTION_ID?=
# AD_SUBSCRIPTION_ID_OR_NAME?=

# Derived parameters
AD_INPUTS_DIRPATH?= $(AZ_INPUTS_DIRPATH)
AD_LOCATION_ID?= $(AZ_LOCATION_ID)
AD_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
AD_OUTPUTS_DIRPATH?= $(AZ_OUTPUTS_DIRPATH)
AD_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
AD_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)

# Options parameters
__AD_OUTPUT?= $(if $(AD_OUTPUT_FORMAT),--output $(AD_OUTPUT_FORMAT))
__AD_SUBSCRIPTION?= $(if $(AD_SUBSCRIPTION_ID_OR_NAME),--subscription $(AD_SUBSCRIPTION_ID_OR_NAME))

# UI parameters
AD_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _ad_view_framework_macros
_ad_view_framework_macros ::
	@#echo 'AZ::AD ($(_AZ_AD_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _ad_view_framework_parameters
_ad_view_framework_parameters ::
	@echo 'AZ::AD ($(_AZ_AD_MK_VERSION)) parameters:'
	@echo '    AD_INPUTS_DIRPATH=$(AD_INPUTS_DIRPATH)'
	@echo '    AD_LOCATION_ID=$(AD_LOCATION_ID)'
	@echo '    AD_OUTPUT_FORMAT=$(AD_OUTPUT_FORMAT)'
	@echo '    AD_OUTPUTS_DIRPATH=$(AD_OUTPUTS_DIRPATH)'
	@echo '    AD_SUBSCRIPTION_ID=$(AD_SUBSCRIPTION_ID)'
	@echo '    AD_SUBSCRIPTION_ID_OR_NAME=$(AD_SUBSCRIPTION_ID_OR_NAME)'
	@echo

_az_view_framework_targets :: _ad_view_framework_targets
_ad_view_framework_targets ::
	@echo 'AZ::AD ($(_AZ_AD_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_ad_application.mk
-include $(MK_DIR)/az_ad_group.mk
-include $(MK_DIR)/az_ad_serviceprincipal.mk
-include $(MK_DIR)/az_ad_user.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
