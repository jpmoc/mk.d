_AZ_ACR_MK_VERSION= 0.99.0

# ACR_LOCATION_ID?= westus2
# ACR_OUTPUT_FORMAT?= table
# ACR_RESOURCEGROUP_NAME?=
# ACR_SUBSCRIPTION_NAME_OR_ID?=

# Derived parameters
ACR_LOCATION_ID?= $(AZ_LOCATION_ID)
ACR_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
ACR_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
ACR_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)

# Options parameters
__ACR_OUTPUT?= $(if $(ACR_OUTPUT_FORMAT),--output $(ACR_OUTPUT_FORMAT))
__ACR_SUBSCRIPTION?= $(if $(ACR_SUBSCRIPTION_ID_OR_NAME),--subscription $(ACR_SUBSCRIPTION_ID_OR_NAME))

___ACR_GLOBALS?= $(__ACR_OUTPUT) $(__ACR_SUBSCRIPTION)

# UI parameters
ACR_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _acr_view_framework_macros
_acr_view_framework_macros ::
	@#echo 'AZ::ACR ($(_AZ_ACR_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _acr_view_framework_parameters
_acr_view_framework_parameters ::
	@echo 'AZ::ACR ($(_AZ_ACR_MK_VERSION)) parameters:'
	@echo '    ACR_LOCATION_ID=$(ACR_LOCATION_ID)'
	@echo '    ACR_OUTPUT_FORMAT=$(ACR_OUTPUT_FORMAT)'
	@echo '    ACR_RESOURCEGROUP_NAME=$(ACR_RESOURCEGROUP_NAME)'
	@echo '    ACR_SUBSCRIPTION_ID_OR_NAME=$(ACR_SUBSCRIPTION_ID_OR_NAME)'
	@echo

_az_view_framework_targets :: _acr_view_framework_targets
_acr_view_framework_targets ::
	@echo 'AZ::ACR ($(_AZ_ACR_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_acr_registry.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
