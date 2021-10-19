_AZ_NETWORK_VNET_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_VNET_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Network/networkInterfaces/LinuxBVMNic
# NWK_VNET_NAME?= LinuxBVMNic
# NWK_VNET_RESOURCEGROUP_NAME?=
# NWK_VNETS_IDS?=
# NWK_VNETS_RESOURCEGROUP_NAME?=
# NWK_VNETS_SET_NAME?= vnets@resourcegroup

# Derived parameters
NWK_VNET_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_VNETS_RESOURCEGROUP_NAME?= $(NWK_VNET_RESOURCEGROUP_NAME)
NWK_VNETS_SET_NAME?= vnets@$(NWK_VNETS_RESOURCEGROUP_NAME)

# Options parameters
__NWK_IDS__VNET= $(if $(NWK_VNET_ID),--ids $(NWK_VNET_ID))
__NWK_IDS__VNETS= $(if $(NWK_VNETS_IDS),--ids $(NWK_VNETS_IDS))
__NWK_NAME__VNET= $(if $(NWK_VNET_NAME),--name $(NWK_VNET_NAME))
__NWK_RESOURCE_GROUP__VNET= $(if $(NWK_VNET_RESOURCEGROUP_NAME),--resource-group $(NWK_VNET_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__VNETS= $(if $(NWK_VNETS_RESOURCEGROUP_NAME),--resource-group $(NWK_VNETS_RESOURCEGROUP_NAME))
__NWK_VNET_NAME__VNET= $(if $(NWK_VNET_NAME),--vnet-name $(NWK_VNET_NAME))

# UI parameters

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK::VirtualNetwork ($(_AZ_NETWORK_VNET_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::VirtualNetwork ($(_AZ_NETWORK_VNET_MK_VERSION)) parameters:'
	@echo '    NWK_VNET_ID=$(NWK_VNET_ID)'
	@echo '    NWK_VNET_NAME=$(NWK_VNET_NAME)'
	@echo '    NWK_VNET_RESOUCEGROUP_NAME=$(NWK_VNET_RESOURCEGROUP_NAME)'
	@echo '    NWK_VNETS_IDS=$(NWK_VNETS_IDS)'
	@echo '    NWK_VNETS_RESOURCEGROUP_NAME=$(NWK_VNETS_RESOURCEGROUP_NAME)'
	@echo '    NWK_VNETS_SET_NAME=$(NWK_VNETS_SET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::VirtualNetwork ($(_AZ_NETWORK_VNET_MK_VERSION)) targets:'
	@echo '    _nwk_create_vnet               - Create a virtual-network'
	@echo '    _nwk_delete_vnet               - Delete a virtual-network'
	@echo '    _nwk_show_vnet                 - Show everything related to a virtual-network'
	@echo '    _nwk_show_vnet_description     - Show description of a virtual-network'
	@echo '    _nwk_show_vnet_nics            - Show NICs attached to a virtual-network'
	@echo '    _nwk_show_vnet_object          - Show object of a virtual-network'
	@echo '    _nwk_show_vnet_peerings        - Show peerings of a virtual-network'
	@echo '    _nwk_show_vnet_subnets         - Show subnets of a virtual-network'
	@echo '    _nwk_view_vnets                - View virtual-networks'
	@echo '    _nwk_view_vnets_set            - View set of virtual-networks'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_nwk_create_vnet:
	@$(INFO) '$(NWK_UI_LABEL)Creating virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)

_nwk_delete_vnet:
	@$(INFO) '$(NWK_UI_LABEL)Deleting virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)

_nwk_show_vnet :: _nwk_show_vnet_nics _nwk_show_vnet_object _nwk_show_vnet_peerings _nwk_show_vnet_subnets _nwk_show_vnet_description

_nwk_show_vnet_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet show $(__NWK_EXPAND) $(__NWK_IDS__VNET) $(__NWK_NAME__VNET) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__VNET) $(__NWK_SUBSCRIPTION)

_nwk_show_vnet_nics:
	@$(INFO) '$(NWK_UI_LABEL)Showing network-interfaces attached to virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet show  $(__NWK_NAME__VNET) $(__NWK_RESOURCE_GROUP__VNET) $(__NWK_SUBSCRIPTION) --query "@.subnets[].ipConfigurations[].id" --output tsv | sed -e 's/.*Microsoft.Network//'

_nwk_show_vnet_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet show $(__NWK_EXPAND) $(__NWK_IDS__VNET) $(__NWK_NAME__VNET) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__VNET) $(__NWK_SUBSCRIPTION)

_nwk_show_vnet_peerings:
	@$(INFO) '$(NWK_UI_LABEL)Showing peering-connection of virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet peering list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__VNET) $(__NWK_VNET_NAME__VNET) $(__NWK_SUBSCRIPTION)

_nwk_show_vnet_subnets:
	@$(INFO) '$(NWK_UI_LABEL)Showing subnets in virtual-network "$(NWK_VNET_NAME)" ...'; $(NORMAL)
	$(AZ) network vnet subnet list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__VNET) $(__NWK_VNET_NAME__VNET) $(__NWK_SUBSCRIPTION)

_nwk_view_vnets:
	@$(INFO) '$(NWK_UI_LABEL)View virtual-networks ...'; $(NORMAL)
	$(AZ) network vnet list $(__NWK_OUTPUT) $(_X__NWK_RESOURCE_GROUP__VNETS) $(__NWK_SUBSCRIPTION)

_nwk_view_vnets_set:
	@$(INFO) '$(NWK_UI_LABEL)View virtual-networks-set "$(NWK_VNETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Network interfaces are grouped based on the resource-group'; $(NORMAL)
	$(AZ) network vnet list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__VNETS) $(__NWK_SUBSCRIPTION)
