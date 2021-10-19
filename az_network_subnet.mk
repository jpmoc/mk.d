_AZ_NETWORK_SUBNET_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_SUBNET_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Network/networkInterfaces/LinuxBVMNic
# NWK_SUBNET_NAME?= LinuxBVMNic
# NWK_SUBNET_RESOURCEGROUP_NAME?=
# NWK_SUBNET_VNET_NAME?=
# NWK_SUBNETS_IDS?=
# NWK_SUBNETS_RESOURCEGROUP_NAME?=
# NWK_SUBNETS_SET_NAME?= subnets@resourcegroup
# NWK_SUBNETS_VNET_NAME?=

# Derived parameters
NWK_SUBNET_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_SUBNET_VNET_NAME?= $(NWK_VNET_NAME)
NWK_SUBNETS_RESOURCEGROUP_NAME?= $(NWK_SUBNET_RESOURCEGROUP_NAME)
NWK_SUBNETS_SET_NAME?= subnets@$(NWK_SUBNETS_VNET_NAME)@$(NWK_SUBNETS_RESOURCEGROUP_NAME)
NWK_SUBNETS_VNET_NAME?= $(NWK_SUBNET_VNET_NAME)

# Options parameters
__NWK_IDS__SUBNET= $(if $(NWK_SUBNET_ID),--ids $(NWK_SUBNET_ID))
__NWK_IDS__SUBNETS= $(if $(NWK_SUBNETS_IDS),--ids $(NWK_SUBNETS_IDS))
__NWK_NAME__SUBNET= $(if $(NWK_SUBNET_NAME),--name $(NWK_SUBNET_NAME))
__NWK_RESOURCE_GROUP__SUBNET= $(if $(NWK_SUBNET_RESOURCEGROUP_NAME),--resource-group $(NWK_SUBNET_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__SUBNETS= $(if $(NWK_SUBNETS_RESOURCEGROUP_NAME),--resource-group $(NWK_SUBNETS_RESOURCEGROUP_NAME))
__NWK_VNET_NAME__SUBNET= $(if $(NWK_SUBNET_VNET_NAME),--vnet-name $(NWK_SUBNET_VNET_NAME))
__NWK_VNET_NAME__SUBNETS= $(if $(NWK_SUBNETS_VNET_NAME),--vnet-name $(NWK_SUBNETS_VNET_NAME))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK::Subnet ($(_AZ_NETWORK_SUBNET_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::Subnet ($(_AZ_NETWORK_SUBNET_MK_VERSION)) parameters:'
	@echo '    NWK_SUBNET_ID=$(NWK_SUBNET_ID)'
	@echo '    NWK_SUBNET_NAME=$(NWK_SUBNET_NAME)'
	@echo '    NWK_SUBNET_RESOUCEGROUP_NAME=$(NWK_SUBNET_RESOURCEGROUP_NAME)'
	@echo '    NWK_SUBNET_VNET_NAME=$(NWK_SUBNET_VNET_NAME)'
	@echo '    NWK_SUBNETS_IDS=$(NWK_SUBNETS_IDS)'
	@echo '    NWK_SUBNETS_RESOURCEGROUP_NAME=$(NWK_SUBNETS_RESOURCEGROUP_NAME)'
	@echo '    NWK_SUBNETS_SET_NAME=$(NWK_SUBNETS_SET_NAME)'
	@echo '    NWK_SUBNETS_VNET_NAME=$(NWK_SUBNET_VNET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::Subnet ($(_AZ_NETWORK_SUBNET_MK_VERSION)) targets:'
	@echo '    _nwk_create_subnet               - Create a subnet'
	@echo '    _nwk_delete_subnet               - Delete a subnet'
	@echo '    _nwk_show_subnet                 - Show everything related to a subnet'
	@echo '    _nwk_show_subnet_description     - Show description of a subnet'
	@echo '    _nwk_show_subnet_nics            - Show NICs attached to a subnet'
	@echo '    _nwk_show_subnet_object          - Show object of a subnet'
	@echo '    _nwk_show_subnet_vnet            - Show virtual-network of a subnet'
	@echo '    _nwk_view_subnets                - View subnets'
	@echo '    _nwk_view_subnets_set            - View set of subnets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_nwk_create_subnet:
	@$(INFO) '$(NWK_UI_LABEL)Creating virtual-network "$(NWK_SUBNET_NAME)" ...'; $(NORMAL)

_nwk_delete_subnet:
	@$(INFO) '$(NWK_UI_LABEL)Deleting virtual-network "$(NWK_SUBNET_NAME)" ...'; $(NORMAL)

_nwk_show_subnet :: _nwk_show_subnet_nics _nwk_show_subnet_object _nwk_show_subnet_vnet _nwk_show_subnet_description

_nwk_show_subnet_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of virtual-network "$(NWK_SUBNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet subnet show $(__NWK_EXPAND) $(__NWK_IDS__SUBNET) $(__NWK_NAME__SUBNET) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SUBNET) $(__NWK_SUBSCRIPTION)

_nwk_show_subnet_nics:
	@$(INFO) '$(NWK_UI_LABEL)Showing network-interfaces attached to virtual-network "$(NWK_SUBNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet subnet show  $(__NWK_NAME__SUBNET) $(__NWK_RESOURCE_GROUP__SUBNET) $(__NWK_SUBSCRIPTION) --query "@.subnets[].ipConfigurations[].id" --output tsv | sed -e 's/.*Microsoft.Network//'

_nwk_show_subnet_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of virtual-network "$(NWK_SUBNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet subnet show $(__NWK_EXPAND) $(__NWK_IDS__SUBNET) $(__NWK_NAME__SUBNET) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__SUBNET) $(__NWK_SUBSCRIPTION)

_nwk_show_subnet_vnet:
	@$(INFO) '$(NWK_UI_LABEL)Showing subnets in virtual-network "$(NWK_SUBNET_NAME)" ...'; $(NORMAL)
	# $(AZ) network vnet show $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SUBNET) $(__NWK_VNET_NAME__SUBNET) $(__NWK_SUBSCRIPTION)

_nwk_view_subnets:
	@$(INFO) '$(NWK_UI_LABEL)View network-interfaces ...'; $(NORMAL)
	$(AZ) network vnet subnet list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SUBNETS) $(__NWK_SUBSCRIPTION) $(__NWK_VNET_NAME__SUBNET)

_nwk_view_subnets_set:
	@$(INFO) '$(NWK_UI_LABEL)View network-interfaces-set "$(NWK_SUBNETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subnets are grouped based on the provided resource-group, virtual-network'; $(NORMAL)
	$(AZ) network vnet subnet list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__SUBNETS) $(__NWK_SUBSCRIPTION) $(__NWK_VNET_NAME__SUBNET)
