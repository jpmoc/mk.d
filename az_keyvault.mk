_AZ_KEYVAULT_MK_VERSION= 0.99.0

# KVT_INPUTS_DIRPATH?= ./in/
# KVT_LOCATION_ID?= westus2
# KVT_OUTPUT_FORMAT?= table
# KVT_OUTPUTS_DIRPATH?= ./out/
# KVT_RESOURCEGROUP_NAME?=
# KVT_SUBSCRIPTION_NAME_OR_ID?=

# Derived parameters
KVT_INPUTS_DIRPATH?= $(AZ_INPUTS_DIRPATH)
KVT_LOCATION_ID?= $(AZ_LOCATION_ID)
KVT_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
KVT_OUTPUTS_DIRPATH?= $(AZ_OUTPUTS_DIRPATH)
KVT_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
KVT_SUBSCRIPTION_ID_OR_NAME?= $(AZ_SUBSCRIPTION_ID_OR_NAME)

# Options parameters
__KVT_LOCATION= $(if $(KVT_LOCATION_ID),--location $(KVT_LOCATION_ID))
__KVT_OUTPUT= $(if $(KVT_OUTPUT_FORMAT),--output $(KVT_OUTPUT_FORMAT))
__KVT_RESOURCE_GROUP= $(if $(KVT_RESOURCEGROUP_NAME),--resource-group $(KVT_RESOURCEGROUP_NAME))
__KVT_SUBSCRIPTION= $(if $(KVT_SUBSCRIPTION_ID_OR_NAME),--subscription $(KVT_SUBSCRIPTION_ID_OR_NAME))

# UI parameters
KVT_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _kvt_view_framework_macros
_kvt_view_framework_macros ::
	@#echo 'AZ::KeyVaulT ($(_AZ_KEYVAULT_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _kvt_view_framework_parameters
_kvt_view_framework_parameters ::
	@echo 'AZ::KeyVaulT ($(_AZ_KEYVAULT_MK_VERSION)) parameters:'
	@echo '    KVT_INPUTS_DIRPATH=$(KVT_INPUTS_DIRPATH)'
	@echo '    KVT_LOCATION_ID=$(KVT_LOCATION_ID)'
	@echo '    KVT_OUTPUT_FORMAT=$(KVT_OUTPUT_FORMAT)'
	@echo '    KVT_OUTPUTS_DIRPATH=$(KVT_OUTPUTS_DIRPATH)'
	@echo '    KVT_RESOURCEGROUP_NAME=$(KVT_RESOURCEGROUP_NAME)'
	@echo '    KVT_SUBSCRIPTION_ID_OR_NAME=$(KVT_SUBSCRIPTION_ID_OR_NAME)'
	@echo

_az_view_framework_targets :: _kvt_view_framework_targets
_kvt_view_framework_targets ::
	@echo 'AZ::KeyVaulT ($(_AZ_KEYVAULT_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_keyvault_accesspolicy.mk
-include $(MK_DIR)/az_keyvault_certificate.mk
-include $(MK_DIR)/az_keyvault_key.mk
-include $(MK_DIR)/az_keyvault_secret.mk
# -include $(MK_DIR)/az_keyvault_storage.mk
-include $(MK_DIR)/az_keyvault_vault.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
