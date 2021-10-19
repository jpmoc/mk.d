_AWS_DIRECTCONNECT_GATEWAY_MK_VERSION = $(_AWS_DIRECTCONNECT_MK_VERSION)

# DCT_GATEWAY_AMAZON_ASN?=
# DCT_GATEWAY_ID?= dxcon-fh7u7if4
# DCT_GATEWAY_NAME?= my-gateway
# DCT_GATEWAY_SET_NAME?= my-gateways-set

# Derived parameters
DCT_GATEWAY_NAMES?= $(DCT_GATEWAY_NAME)

# Option parameters
__DCT_AMAZON_SIDE_ASN= $(if $(DCT_GATEWAY_AMAZON_ASN), --amazon-side-asn $(DCT_GATEWAY_AMAZON_ASN))
__DCT_DIRECT_CONNECT_GATEWAY_ID= $(if $(DCT_GATEWAY_ID), --direct-connect-gateway-id $(DCT_GATEWAY_ID))
__DCT_DIRECT_CONNECT_GATEWAY_NAME= $(if $(DCT_GATEWAY_NAME), --direct-connect-gateway-name $(DCT_GATEWAY_NAME))

# UI parameters
DCT_UI_VIEW_GATEWAYS_FIELDS?=
DCT_UI_VIEW_GATEWAYS_SET_FIELDS?= $(DCT_UI_VIEW_GATEWAY_FIELDS)
DCT_UI_VIEW_GATEWAYS_SET_SLICE?=

#--- MACRO
_dct_get_gateway_id= $(call _dct_get_gateway_id_N, $(DCT_GATEWAY_NAME))
_dct_get_gateway_id_N= $(shell $(AWS) directconnect describe-gateways  --query "gateways[?gatewayName=='$(strip $(1))'].gatewayId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_dct_view_framework_macros ::
	@echo 'AWS::DirectConnecT::Gateway ($(_AWS_DIRECTCONNECT_GATEWAY_MK_VERSION)) macros:'
	@echo '    _dct_get_gateway_id_{|N}                   - Get the ID of a gateway (Name)'
	@echo

_dct_view_framework_parameters ::
	@echo 'AWS::DirectConnecT::Gateway ($(_AWS_DIRECTCONNECT_GATEWAY_MK_VERSION)) parameters:'
	@echo '    DCT_GATEWAY_AMAZON_ASN=$(DCT_GATEWAY_AMAZON_ASN)'
	@echo '    DCT_GATEWAY_ID=$(DCT_GATEWAY_ID)'
	@echo '    DCT_GATEWAY_NAME=$(DCT_GATEWAY_NAME)'
	@echo '    DCT_GATEWAYS_SET_NAME=$(DCT_GATEWAYS_SET_NAME)'
	@echo

_dct_view_framework_targets ::
	@echo 'AWS::DirectConnecT::Gateway ($(_AWS_DIRECTCONNECT_GATEWAY_MK_VERSION)) targets:'
	@echo '    _dct_create_gateway                       - Create a gateway'
	@echo '    _dct_delete_gateway                       - Delete a gateway'
	@echo '    _dct_show_gateway                         - Show everything related to a gateway'
	@echo '    _dct_view_gateways                        - View existing gateways'
	@echo '    _dct_view_gateways_set                    - View a set of gateways'
	@echo

#----------------------------------------------------------------------
# Private targets
#

#----------------------------------------------------------------------
# Public targets
#

_dct_create_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Creating gateway "$(DCT_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect create-direct-connect-gateway $(__DCT_AMAZON_SIDE_ASN) $(__DCT_GATEWAY_NAME)

_dct_delete_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Deleting gateway "$(DCT_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect delete-direct-connect-gateway $(__DCT_DIRECT_CONNECT_GATEWAY_ID)

_dct_show_gateway:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of gateway "$(DCT_GATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-direct-connect-gateways $(__DCT_DIRECT_CONNECT_GATEWAY_ID) # --query "gateways[]"

_dct_view_gateways:
	@$(INFO) '$(AWS_UI_LABEL)Viewing ALL gateways ...'; $(NORMAL)
	$(AWS) directconnect describe-direct-connect-gateways $(_X__DCT_GATEWAY_ID) # --query "gateways[]$(DCT_UI_VIEW_GATEWAY_FIELDS)"

_dct_view_gateways_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing gateways-set "$(DCT_GATEWAY_SET_NAME)" ...'; $(NORMAL)
	$(AWS) directconnect describe-direct-connect-gateways $(_X__DCT_GATEWAY_ID) # --query "gateways[$(DCT_UI_VIEW_GATEWAY_SET_SLICE)]$(DCT_UI_VIEW_GATEWAY_FIELDS)"

