_AZ_ROLE_MK_VERSION= 0.99.0

# RLE_LOCATION_ID?= westus2
# RLE_OUTPUT_FORMAT?= table
# RLE_RESOURCEGROUP_NAME?=
# RLE_ROLE_NAME?= my-role
# RLE_SUBSCRIPTION_NAME_OR_ID?=

# Derived parameters
RLE_LOCATION_ID?= $(AZ_LOCATION_ID)
RLE_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
RLE_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
RLE_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)

# Options parameters
__RLE_LOCATION= $(if $(RLE_LOCATION_ID),--location $(RLE_LOCATION_ID))
__RLE_OUTPUT= $(if $(RLE_OUTPUT_FORMAT),--output $(RLE_OUTPUT_FORMAT))
__RLE_RESOURCE_GROUP= $(if $(RLE_RESOURCEGROUP_NAME),--resource-group $(RLE_RESOURCEGROUP_NAME))
__RLE_SUBSCRIPTION= $(if $(RLE_SUBSCRIPTION_ID_OR_NAME),--subscription $(RLE_SUBSCRIPTION_ID_OR_NAME))

# UI parameters
RLE_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _rle_view_framework_macros
_rle_view_framework_macros ::
	@#echo 'AZ::Role ($(_AZ_ROLE_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _rle_view_framework_parameters
_rle_view_framework_parameters ::
	@echo 'AZ::Role ($(_AZ_ROLE_MK_VERSION)) parameters:'
	@echo '    RLE_LOCATION_ID=$(RLE_LOCATION_ID)'
	@echo '    RLE_OUTPUT_FORMAT=$(RLE_OUTPUT_FORMAT)'
	@echo '    RLE_RESOURCEGROUP_NAME=$(RLE_RESOURCEGROUP_NAME)'
	@echo '    RLE_ROLE_NAME=$(RLE_ROLE_NAME)'
	@echo '    RLE_SUBSCRIPTION_ID_OR_NAME=$(RLE_SUBSCRIPTION_ID_OR_NAME)'
	@echo

_az_view_framework_targets :: _rle_view_framework_targets
_rle_view_framework_targets ::
	@echo 'AZ::Role ($(_AZ_ROLE_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_role_role.mk
-include $(MK_DIR)/az_role_roleassignment.mk
-include $(MK_DIR)/az_role_roledefinition.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
