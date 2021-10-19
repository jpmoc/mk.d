_AWS_DIRECTCONNECT_BGPPEER_MK_VERSION = $(_AWS_DIRECTCONNECT_MK_VERSION)

# DCT_BGPPEER_ASN?=
# DCT_BGPPEER_CUSTOMER_ADDRESS?=
# DCT_BGPPEER_NAME?=
# DCT_BGPPEER_NEWBGPPEER?= asn=integer,authKey=string,addressFamily=string,amazonAddress=string,customerAddress=string
# DCT_BGPPEER_NEWBGPPEER_FILEPATH?= ./bgppeer-config.json
# DCT_BGPPEER_VIRTUALINTERFACE_ID?=

# Derived parameters
DCT_BGPPEER_NEWBGPPEER?= $(if $(DCT_BGPPEER_NEWBGPPEER_FILEPATH),file://$(DCT_BGPPEER_NEWBGPPEER_FILEPATH))

# Option parameters

__DCT_ASN= $(if $(DCT_BGPPEER_ASN), --asn $(DCT_BGPPEER_ASN))
__DCT_CUSTOMER_ADDRESS= $(if $(DCT_BGPPEER_CUSTOMER_ADDRESS), --customer-address $(DCT_BGPPEER_CUSTOMER_ADDRESS))
__DCT_NEW_BGP_PEER= $(if $(DCT_BGPPEER_NEWBGPPEER), --new-bgp-peer $(DCT_BGPPEER_NEWBGPPEER))
__DCT_VIRTUAL_INTERFACE_ID__BGPPEER= $(if $(DCT_BGPPEER_VIRTUALINTERFACE_ID), --virtual-interface-id $(DCT_BGPPEER_VIRTUALINTERFACE_ID))

# UI parameters

#--- MACRO
_dct_get_bgppeer_id=

#----------------------------------------------------------------------
# USAGE
#

_dct_view_framework_macros ::
	@echo 'AWS::DirectConnecT::BgpPeer ($(_AWS_DIRECTCONNECT_BGPPEER_MK_VERSION)) macros:'
	@echo '    _dct_get_bgppeer_id_                      - Get the ID of a BGPPEER'
	@echo

_dct_view_framework_parameters ::
	@echo 'AWS::DirectConnecT::BgpPeer ($(_AWS_DIRECTCONNECT_BGPPEER_MK_VERSION)) parameters:'
	@echo '    DCT_BGPPEER_ASN=$(DCT_BGPPEER_ASN)'
	@echo '    DCT_BGPPEER_CUSTOMER_ADDRESS=$(DCT_BGPPEER_CUSTOMER_ADDRESS)'
	@echo '    DCT_BGPPEER_NAME=$(DCT_BGPPEER_NAME)'
	@echo '    DCT_BGPPEER_NEWBGPPEER=$(DCT_BGPPEER_NEWBGPPEER)'
	@echo '    DCT_BGPPEER_NEWBGPPEER_FILEPATH=$(DCT_BGPPEER_NEWBGPPEER_FILEPATH)'
	@echo '    DCT_BGPPEER_VIRTUALINTERFACE_ID=$(DCT_BGPPEER_VIRTUALINTERFACE_ID)'
	@echo

_dct_view_framework_targets ::
	@echo 'AWS::DirectConnecT::BgpPeer ($(_AWS_DIRECTCONNECT_BGPPEER_MK_VERSION)) targets:'
	@echo '    _dct_create_bgppeer                       - Create a bgp-peer'
	@echo '    _dct_delete_bgppeer                       - Delete a bgp-peer'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_dct_create_bgppeer:
	@$(INFO) '$(AWS_UI_LABEL)Creating bgp-peer "$(DCT_BGPPEER_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect create-bgp-peer $(__DCT_NEW_BGP_PEER) $(__DCT_VIRTUAL_INTERFACE_ID__BGPPEER)

_dct_delete_bgppeer:
	@$(INFO) '$(AWS_UI_LABEL)Deleting bgp-peer "$(DCT_BGPPEER_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect delete-bgppeer $(__DCT_ASN) $(__DCT_CUSTOMER_ADDRESS) $(__DCT_VIRTUAL_INTERFACE_ID__BGPPEER)
