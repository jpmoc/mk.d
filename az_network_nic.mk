_AZ_NETWORK_NIC_MK_VERSION= $(_AZ_NETWORK_MK_VERSION)

# NWK_NIC_ID?= /subscriptions/59b066b1-4bd5-4a01-bbb1-14ee71d3d7fc/resourceGroups/LinuxGroup/providers/Microsoft.Network/networkInterfaces/LinuxBVMNic
# NWK_NIC_NAME?= LinuxBVMNic
# NWK_NIC_PUBLICIP_NAME?=
# NWK_NIC_RESOURCEGROUP_NAME?=
# NWK_NIC_SUBNET_NAME?=
# NWK_NIC_VNET_NAME?=
# NWK_NICS_IDS?=
# NWK_NICS_RESOURCEGROUP_NAME?=
# NWK_NICS_SET_NAME?= nics@resourcegroup

# Derived parameters
# NWK_NIC_ID?= /subscriptions/$(NWK_SUBSCRIPTION_ID)/resourceGroups/$(NWK_NIC_RESOURCEGROUP_NAME)/providers/Microsoft.Network/networkInterfaces/$(NWK_NIC_NAME)
NWK_NIC_PUBLICIP_NAME?= $(NWK_PUBLICIP_NAME)
NWK_NIC_RESOURCEGROUP_NAME?= $(NWK_RESOURCEGROUP_NAME)
NWK_NIC_SUBNET_NAME?= $(NWK_SUBNET_NAME)
NWK_NIC_VNET_NAME?= $(NWK_VNET_NAME)
NWK_NICS_RESOURCEGROUP_NAME?= $(NWK_NIC_RESOURCEGROUP_NAME)
NWK_NICS_SET_NAME?= nics@$(NWK_NICS_RESOURCEGROUP_NAME)

# Options parameters
__NWK_IDS__NIC= $(if $(NWK_NIC_ID),--ids $(NWK_NIC_ID))
__NWK_IDS__NICS= $(if $(NWK_NICS_IDS),--ids $(NWK_NICS_IDS))
__NWK_NAME__NIC= $(if $(NWK_NIC_NAME),--name $(NWK_NIC_NAME))
__NWK_NIC_NAME__NIC= $(if $(NWK_NIC_NAME),--nic-name $(NWK_NIC_NAME))
__NWK_RESOURCE_GROUP__NIC= $(if $(NWK_NIC_RESOURCEGROUP_NAME),--resource-group $(NWK_NIC_RESOURCEGROUP_NAME))
__NWK_RESOURCE_GROUP__NICS= $(if $(NWK_NICS_RESOURCEGROUP_NAME),--resource-group $(NWK_NICS_RESOURCEGROUP_NAME))

# UI parameters
NWK_UI_SHOW_NIC_FIELDS?= .{name:name,location:location,macAddress:macAddress,enableAcceleratedNetworking:enableAcceleratedNetworking,enableIpForwarding:enableIpForwarding,provisioningState:provisioningState,privateIpAddress:ipConfigurations[0].privateIpAddress}
NWK_UI_VIEW_NICS_FIELDS?= .{name:name,location:location,resourceGroup:resourceGroup,privateIpAddress:ipConfigurations[0].privateIpAddress}
NWK_UI_VIEW_NICS_SET_FIELDS?= $(NWK_UI_SHOW_NIC_FIELDS)

#--- Utilities

#--- MACRO

#----------------------------------------------------------------------
# USAGE
#

_nwk_view_framework_macros ::
	@#echo 'AZ::NetWorK ($(_AZ_NETWORK_MK_VERSION)) macros:'
	@#echo

_nwk_view_framework_parameters ::
	@echo 'AZ::NetWorK::NIC ($(_AZ_NETWORK_NIC_MK_VERSION)) parameters:'
	@echo '    NWK_NIC_ID=$(NWK_NIC_ID)'
	@echo '    NWK_NIC_NAME=$(NWK_NIC_NAME)'
	@echo '    NWK_NIC_PUBLICIP_NAME=$(NWK_NIC_PUBLICIP_NAME)'
	@echo '    NWK_NIC_RESOUCEGROUP_NAME=$(NWK_NIC_RESOURCEGROUP_NAME)'
	@echo '    NWK_NIC_SUBNET_NAME=$(NWK_NIC_SUBNET_NAME)'
	@echo '    NWK_NIC_VNET_NAME=$(NWK_NIC_VNET_NAME)'
	@echo '    NWK_NICS_IDS=$(NWK_NICS_IDS)'
	@echo '    NWK_NICS_RESOURCEGROUP_NAME=$(NWK_NICS_RESOURCEGROUP_NAME)'
	@echo '    NWK_NICS_SET_NAME=$(NWK_NICS_SET_NAME)'
	@echo

_nwk_view_framework_targets ::
	@echo 'AZ::NetWork::NIC ($(_AZ_NETWORK_NIC_MK_VERSION)) targets:'
	@echo '    _nwk_create_nic               - Create a nic'
	@echo '    _nwk_delete_nic               - Delete a nic'
	@echo '    _nwk_show_nic                 - Show everything related to a nic'
	@echo '    _nwk_show_nic_description     - Show description of a nic'
	@echo '    _nwk_show_nic_ipconfig        - Show ip-config of a nic'
	@echo '    _nwk_show_nic_object          - Show object of a nic'
	@echo '    _nwk_show_nic_publicip        - Show public-ip of a nic'
	@echo '    _nwk_show_nic_routetable      - Show route-table of a nic'
	@echo '    _nwk_show_nic_subnet          - Show subnet of a nic'
	@echo '    _nwk_show_nic_vnet            - Show vnet of a nic'
	@echo '    _nwk_view_nics                - View nics'
	@echo '    _nwk_view_nics_set            - View set of nics'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#


_nwk_create_nic:
	@$(INFO) '$(NWK_UI_LABEL)Creating network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)

_nwk_delete_nic:
	@$(INFO) '$(NWK_UI_LABEL)Deleting network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)

_nwk_show_nic :: _nwk_show_nic_ipconfig _nwk_show_nic_object _nwk_show_nic_publicip _nwk_show_nic_routetable _nwk_show_nic_subnet _nwk_show_nic_vnet _nwk_show_nic_description

_nwk_show_nic_description:
	@$(INFO) '$(NWK_UI_LABEL)Showing description of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(AZ) network nic show $(__NWK_EXPAND) $(__NWK_IDS__NIC) $(__NWK_NAME__NIC) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION) --query "@$(NWK_UI_SHOW_NIC_FIELDS)"

_nwk_show_nic_ipconfig:
	@$(INFO) '$(NWK_UI_LABEL)Showing ip-config of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(AZ) network nic ip-config list $(__NWK_NIC_NAME__NIC) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION)

_nwk_show_nic_object:
	@$(INFO) '$(NWK_UI_LABEL)Showing object of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(AZ) network nic show $(__NWK_EXPAND) $(__NWK_IDS__NIC) $(__NWK_NAME__NIC) $(_X__NWK_OUTPUT) --output json $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION)

_nwk_show_nic_publicip:
	@$(INFO) '$(NWK_UI_LABEL)Showing public-ip of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(if $(NWK_NIC_PUBLICIP_NAME), \
		$(AZ) network public-ip show --name $(NWK_NIC_PUBLICIP_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION) \
	, @\
		echo 'NWK_NIC_PUBLICIP_NAME not set'; \
	)

_nwk_show_nic_routetable:
	@$(INFO) '$(NWK_UI_LABEL)Showing route-table of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(AZ) network nic show-effective-route-table $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION)

_nwk_show_nic_subnet:
	@$(INFO) '$(NWK_UI_LABEL)Showing subnet of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(if $(NWK_NIC_SUBNET_NAME), \
		$(AZ) network vnet subnet show --name $(NWK_NIC_SUBNET_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION) --vnet-name $(NWK_NIC_VNET_NAME) \
	, @\
		echo 'NWK_NIC_SUBNET_NAME not set'; \
	)

_nwk_show_nic_vnet:
	@$(INFO) '$(NWK_UI_LABEL)Showing virtual-network of network-interface "$(NWK_NIC_NAME)" ...'; $(NORMAL)
	$(if $(NWK_NIC_VNET_NAME), \
		$(AZ) network vnet show --name $(NWK_NIC_VNET_NAME) $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NIC) $(__NWK_SUBSCRIPTION) \
	, @\
		echo 'NWK_NIC_VNET_NAME not set'; \
	)

_nwk_view_nics:
	@$(INFO) '$(NWK_UI_LABEL)View network-interfaces ...'; $(NORMAL)
	$(AZ) network nic list $(__NWK_OUTPUT) $(_X__NWK_RESOURCE_GROUP__NICS) $(__NWK_SUBSCRIPTION) --query "@[]$(NWK_UI_VIEW_NICS_FIELDS)"

_nwk_view_nics_set:
	@$(INFO) '$(NWK_UI_LABEL)View network-interfaces-set "$(NWK_NICS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Network interfaces are grouped based on the resource-group'; $(NORMAL)
	$(AZ) network nic list $(__NWK_OUTPUT) $(__NWK_RESOURCE_GROUP__NICS) $(__NWK_SUBSCRIPTION) --query "@[]$(NWK_UI_VIEW_NICS_SET_FIELDS)"
