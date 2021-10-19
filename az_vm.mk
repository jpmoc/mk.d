_AZ_VM_MK_VERSION= 0.99.0

# VM_LOCATION_ID?= westus2
# VM_OUTPUT_FORMAT?= table
# VM_RESOURCEGROUP_NAME?=
# VM_SUBSCRIPTION_NAME_OR_ID?=

# Derived parameters
VM_LOCATION_ID?= $(AZ_LOCATION_ID)
VM_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
VM_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
VM_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
VM_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)
VM_SUBSCRIPTION_NAME?= $(AZ_SUBSCRIPTION_NAME)

# Options parameters
__VM_OUTPUT= $(if $(VM_OUTPUT_FORMAT),--output $(VM_OUTPUT_FORMAT))
__VM_RESOURCE_GROUP= $(if $(VM_RESOURCEGROUP_NAME),--resource-group $(VM_RESOURCEGROUP_NAME))
__VM_SUBSCRIPTION= $(if $(VM_SUBSCRIPTION_ID_OR_NAME),--subscription $(VM_SUBSCRIPTION_ID_OR_NAME))

# UI parameters
VM_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _vm_view_framework_macros
_vm_view_framework_macros ::
	@#echo 'AZ::VM:: ($(_AZ_VM_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _vm_view_framework_parameters
_vm_view_framework_parameters ::
	@echo 'AZ::VM:: ($(_AZ_VM_MK_VERSION)) parameters:'
	@echo '    VM_LOCATION_ID=$(VM_LOCATION_ID)'
	@echo '    VM_OUTPUT_FORMAT=$(VM_OUTPUT_FORMAT)'
	@echo '    VM_RESOURCEGROUP_NAME=$(VM_RESOURCEGROUP_NAME)'
	@echo '    VM_SUBSCRIPTION_ID=$(VM_SUBSCRIPTION_ID)'
	@echo '    VM_SUBSCRIPTION_ID_OR_NAME=$(VM_SUBSCRIPTION_ID_OR_NAME)'
	@echo '    VM_SUBSCRIPTION_NAME=$(VM_SUBSCRIPTION_NAME)'
	@echo

_az_view_framework_targets :: _vm_view_framework_targets
_vm_view_framework_targets ::
	@echo 'AZ::VM:: ($(_AZ_VM_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_vm_instance.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
