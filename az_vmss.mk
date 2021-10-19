_AZ_VMSS_MK_VERSION= 0.99.0

# VMS_LOCATION_ID?= westus2
# VMS_OUTPUT_FORMAT?= table
# VMS_RESOURCEGROUP_NAME?=
# VMS_SUBSCRIPTION_NAME_OR_ID?=

# Derived parameters
VMS_LOCATION_ID?= $(AZ_LOCATION_ID)
VMS_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
VMS_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
VMS_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
VMS_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)
VMS_SUBSCRIPTION_NAME?= $(AZ_SUBSCRIPTION_NAME)

# Options parameters
__VMS_OUTPUT= $(if $(VMS_OUTPUT_FORMAT),--output $(VMS_OUTPUT_FORMAT))
__VMS_RESOURCE_GROUP= $(if $(VMS_RESOURCEGROUP_NAME),--resource-group $(VMS_RESOURCEGROUP_NAME))
__VMS_SUBSCRIPTION= $(if $(VMS_SUBSCRIPTION_ID_OR_NAME),--subscription $(VMS_SUBSCRIPTION_ID_OR_NAME))

# UI parameters
VMS_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _vm_view_framework_macros
_vm_view_framework_macros ::
	@#echo 'AZ::VMSS:: ($(_AZ_VMSS_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _vm_view_framework_parameters
_vm_view_framework_parameters ::
	@echo 'AZ::VMSS:: ($(_AZ_VMSS_MK_VERSION)) parameters:'
	@echo '    VMS_LOCATION_ID=$(VMS_LOCATION_ID)'
	@echo '    VMS_OUTPUT_FORMAT=$(VMS_OUTPUT_FORMAT)'
	@echo '    VMS_RESOURCEGROUP_NAME=$(VMS_RESOURCEGROUP_NAME)'
	@echo '    VMS_SUBSCRIPTION_ID=$(VMS_SUBSCRIPTION_ID)'
	@echo '    VMS_SUBSCRIPTION_ID_OR_NAME=$(VMS_SUBSCRIPTION_ID_OR_NAME)'
	@echo '    VMS_SUBSCRIPTION_NAME=$(VMS_SUBSCRIPTION_NAME)'
	@echo

_az_view_framework_targets :: _vm_view_framework_targets
_vm_view_framework_targets ::
	@echo 'AZ::VMSS:: ($(_AZ_VMSS_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_vmss_scaleset.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
