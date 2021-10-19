_AWS_DIRECTCONNECT_PRIVATEVIRTUALINTERFACE_MK_VERSION = $(_AWS_DIRECTCONNECT_MK_VERSION)

# DCT_PRIVATEVIRTUALINTERFACE_CONFIG?= virtualInterfaceName=PrivateVirtualInterface,vlan=101,asn=65000,authKey=asdf34example,amazonAddress=192.168.1.1/30,customerAddress=192.168.1.2/30,virtualGatewayId=vgw-aba37db6
# DCT_PRIVATEVIRTUALINTERFACE_CONFIG_FILEPATH?= ./privatevirtualinterface-config.json
# DCT_PRIVATEVIRTUALINTERFACE_CONNECTION_ID?= dxcon-fh7u7if4
# DCT_PRIVATEVIRTUALINTERFACE_ID?=
# DCT_PRIVATEVIRTUALINTERFACE_NAME?=
# DCT_PRIVATEVIRTUALINTERFACE_SET_NAME?= my-privatevirtualinterface-set

# Derived parameters
DCT_PRIVATEVIRTUALINTERFACE_CONFIG?= $(if $(DCT_PRIVATEVIRTUALINTERFACE_CONFIG_FILEPATH),file://$(DCT_PRIVATEVIRTUALINTERFACE_CONFIG_FILEPATH))
DCT_PRIVATEVIRTUALINTERFACE_CONNECTION_ID?= $(DCT_CONNECTION_ID)

# Option parameters
__DCT_CONNECTION_ID__PRIVATEVIRTUALINTERFACE= $(if $(DCT_PRIVATEVIRTUALINTERFACE_CONNECTION_ID), --privatevirtualinterface-id $(DCT_PRIVATEVIRTUALINTERFACE_CONNECTION_ID))
__DCT_NEW_PRIVATE_VIRTUAL_INTERFACE= $(if $(DCT_PRIVATEVIRTUALINTERFACE_CONFIG), --new-private-virtual-interface $(DCT_PRIVATEVIRTUALINTERFACE_CONFIG))
__DCT_VIRTUAL_INTERFACE_ID__PRIVATEVIRTUALINTERFACE= $(if $(DCT_PRIVATEVIRTUALINTERFACE_ID), --virtual-interface-id $(DCT_PRIVATEVIRTUALINTERFACE_ID))

# UI parameters
DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_FIELDS?= .{vlan:vlan,type:virtualInterfaceType,VirtualInterfaceName:virtualInterfaceName,connectionId:connectionId,VirtualInterfaceId:virtualInterfaceId,virtualInterfaceState:virtualInterfaceState}
DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_SET_FIELDS?= $(DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_FIELDS)
DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_SET_SLICE?=

#--- MACRO
_dct_get_privatevirtualinterface_id= $(call _dct_get_privatevirtualinterface_id_N, $(DCT_PRIVATEVIRTUALINTERFACE_NAME))
_dct_get_privatevirtualinterface_id_N= $(shell $(AWS) directconnect describe-virtual-interfaces --query "virtualInterfaces[?virtualInterfaceType=='private']| @[?virtualInterfaceName=='$(strip $(1))'].virtualInterfaceId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_dct_view_framework_macros ::
	@echo 'AWS::DirectConnecT::PrivateVirtualInterface ($(_AWS_DIRECTCONNECT_PRIVATEVIRTUALINTERFACE_MK_VERSION)) macros:'
	@echo '    _dct_get_privatevirtualinterface_id_{|N}                   - Get the ID of a private-virtual-interface (Name)'
	@echo

_dct_view_framework_parameters ::
	@echo 'AWS::DirectConnecT::PrivateVirtualInterface ($(_AWS_DIRECTCONNECT_PRIVATEVIRTUALINTERFACE_MK_VERSION)) parameters:'
	@echo '    DCT_PRIVATEVIRTUALINTERFACE_CONFIG=$(DCT_PRIVATEVIRTUALINTERFACE_CONFIG)'
	@echo '    DCT_PRIVATEVIRTUALINTERFACE_CONFIG_FILEPATH=$(DCT_PRIVATEVIRTUALINTERFACE_CONFIG_FILEPATH)'
	@echo '    DCT_PRIVATEVIRTUALINTERFACE_CONNECTION_ID=$(DCT_PRIVATEVIRTUALINTERFACE_CONNECTION_ID)'
	@echo '    DCT_PRIVATEVIRTUALINTERFACE_ID=$(DCT_PRIVATEVIRTUALINTERFACE_ID)'
	@echo '    DCT_PRIVATEVIRTUALINTERFACE_NAME=$(DCT_PRIVATEVIRTUALINTERFACE_NAME)'
	@echo '    DCT_PRIVATEVIRTUALINTERFACE_SET_NAME=$(DCT_PRIVATEVIRTUALINTERFACE_SET_NAME)'
	@echo

_dct_view_framework_targets ::
	@echo 'AWS::DirectConnecT::PrivateVirtualInterface ($(_AWS_DIRECTCONNECT_PRIVATEVIRTUALINTERFACE_MK_VERSION)) targets:'
	@echo '    _dct_create_privatevirtualinterface                       - Create a private-virtual-interface'
	@echo '    _dct_delete_privatevirtualinterface                       - Delete a private-virtual-interface'
	@echo '    _dct_show_privatevirtualinterface                         - Show everything related to a private-virtual-interface'
	@echo '    _dct_view_privatevirtualinterfaces                        - View existing private-virtual-interface'
	@echo '    _dct_view_privatevirtualinterfaces_set                    - View a set of private-virtual-interface'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_dct_create_privatevirtualinterface:
	@$(INFO) '$(AWS_UI_LABEL)Creating private-virtual-interface "$(DCT_PRIVATEVIRTUALINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect create-private-virtual-interface $(__DCT_CONNECTION_ID__PRIVATEVIRTUALINTERFACE) $(__DCT_NEW_PRIVATE_VIRTUAL_INTERFACE)

_dct_delete_privatevirtualinterface:
	@$(INFO) '$(AWS_UI_LABEL)Deleting private-virtual-interface "$(DCT_PRIVATEVIRTUALINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect delete-virtual-interface $(__DCT_PRIVATEVIRTUALINTERFACE_ID)

_dct_show_privatevirtualinterface: _dct_show_privatevirtualinterface_bgppeers _dct_show_privatevirtualinterface_routerconfig _dct_show_privatevirtualinterface_description

_dct_show_privatevirtualinterface_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of private-virtual-interface "$(DCT_PRIVATEVIRTUALINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-virtual-interfaces $(__DCT_VIRTUAL_INTERFACE_ID__PRIVATEVIRTUALINTERFACE) --query "virtualInterfaces[?virtualInterfaceType=='private'].{virtualInterfaceState: virtualInterfaceState,authKey:authKey,asn:asn,vlan:vlan,customerAddress:customerAddress,ownerAccount:ownerAccount,connectionId:connectionId,addressFamily:addressFamily,virtualGatewayId:virtualGatewayId,VirtualInterfaceId:virtualInterfaceId,amazonSideAsn:amazonSideAsn,routeFilterPrefixes:routeFilterPrefixes,location:location,directConnectGatewayId:directorConnectGatewayId,amazonAddress:amazonAddress,virtualInterfaceType:virtualInterfaceType,VirtualInterfaceName:virtualInterfaceName}"

_dct_show_privatevirtualinterface_bgppeers:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of private-virtual-interface "$(DCT_PRIVATEVIRTUALINTERFACE_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-virtual-interfaces $(__DCT_VIRTUAL_INTERFACE_ID__PRIVATEVIRTUALINTERFACE) --query "virtualInterfaces[?virtualInterfaceType=='private'].bgpPeers[]"

_dct_show_privatevirtualinterface_routerconfig:
	@$(INFO) '$(AWS_UI_LABEL)Showing router-config of private-virtual-interface "$(DCT_PRIVATEVIRTUALINTERFACE_NAME)" ...'; $(NORMAL)
	$(CYAN); $(AWS) directconnect describe-virtual-interfaces $(__DCT_VIRTUAL_INTERFACE_ID__PRIVATEVIRTUALINTERFACE) --query "virtualInterfaces[?virtualInterfaceType=='private'].customerRouterConfig" --output text; $(NORMAL)

_dct_view_privatevirtualinterfaces:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL private-virtual-interfaces ...'; $(NORMAL)
	$(AWS) directconnect describe-virtual-interfaces $(_X__DCT_PRIVATEVIRTUALINTERFACE_ID) --query "virtualInterfaces[?virtualInterfaceType=='private']$(DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_FIELDS)"

_dct_view_privatevirtualinterfaces_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing private-virtual-interfaces-set "$(DCT_PRIVATEVIRTUALINTERFACE_SET_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-virtual-interfaces $(_X__DCT_PRIVATEVIRTUALINTERFACE_ID) --query "virtualInterfaces[?virtualInterfaceType=='private'] | @[$(DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_SET_SLICE)]$(DCT_UI_VIEW_PRIVATEVIRTUALINTERFACES_SET_FIELDS)"

