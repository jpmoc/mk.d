_AZ_NETWORK_MK_VERSION= 0.99.0

# NWK_LOCATION_ID?= westus2
# NWK_OUTPUT_FORMAT?= table
# NWK_RESOURCEGROUP_NAME?= MyResourceGrouop
# NWK_SUBSCRIPTION_ID?=
# NWK_SUBSCRIPTION_ID_OR_NAME?=

# Derived parameters
NWK_LOCATION_ID?= $(AZ_LOCATION_ID)
NWK_OUTPUT_FORMAT?= $(AZ_OUTPUT_FORMAT)
NWK_RESOURCEGROUP_NAME?= $(AZ_RESOURCEGROUP_NAME)
NWK_SUBSCRIPTION_ID?= $(AZ_SUBSCRIPTION_ID)
NWK_SUBSCRIPTION_ID_OR_NAME?= $(if $(NWK_SUBSCRIPTION_ID),$(NWK_SUBSCRIPTION_ID),$(NWK_SUBSCRIPTION_NAME))
NWK_SUBSCRIPTION_NAME?= $(AZ_SUBSCRIPTION_NAME)

# Options parameters
__NWK_OUTPUT?= $(if $(NWK_OUTPUT_FORMAT),--output $(NWK_OUTPUT_FORMAT))
__NWK_SUBSCRIPTION?= $(if $(NWK_SUBSCRIPTION_ID_OR_NAME),--subscription $(NWK_SUBSCRIPTION_ID_OR_NAME))

# UI parameters
NWK_UI_LABEL?= $(AZ_UI_LABEL)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_az_view_framework_macros :: _nwk_view_framework_macros
_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK ($(_AZ_NETWORK_MK_VERSION)) macros:'
	@#echo

_az_view_framework_parameters :: _nwk_view_framework_parameters
_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK ($(_AZ_NETWORK_MK_VERSION)) parameters:'
	@echo '    NWK_LOCATION_ID=$(NWK_LOCATION_ID)'
	@echo '    NWK_OUTPUT_FORMAT=$(NWK_OUTPUT_FORMAT)'
	@echo '    NWK_RESOURCEGROUP_NAME=$(NWK_RESOURCEGROUP_NAME)'
	@echo '    NWK_SUBSCRIPTION_ID=$(NWK_SUBSCRIPTION_ID)'
	@echo '    NWK_SUBSCRIPTION_ID_OR_NAME=$(NWK_SUBSCRIPTION_ID_OR_NAME)'
	@echo '    NWK_SUBSCRIPTION_NAME=$(NWK_SUBSCRIPTION_NAME)'
	@echo

_az_view_framework_targets :: _nwk_view_framework_targets
_nwk_view_framework_targets ::
	@echo 'AZ::NetWork ($(_AZ_NETWORK_MK_VERSION)) targets:'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/az_network_dnsrecord.mk
-include $(MK_DIR)/az_network_dnszone.mk
-include $(MK_DIR)/az_network_loadbalancer.mk
-include $(MK_DIR)/az_network_nic.mk
-include $(MK_DIR)/az_network_publicip.mk
-include $(MK_DIR)/az_network_securitygroup.mk
-include $(MK_DIR)/az_network_subnet.mk
-include $(MK_DIR)/az_network_vnet.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
