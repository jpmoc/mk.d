_AWS_EC2_NATGATEWAY_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_NATGATEWAY_ID?=
# EC2_NATGATEWAY_NAME?= my-name-gateway
# EC2_NATGATEWAYS_IDS?=

# Derived parameters
EC2_NATGATEWAYS_IDS?= $(EC2_NATGATEWAY_ID)

# Options
__EC2_NAT_GATEWAY_IDS= $(if $(EC2_NATGATEWAYS_IDS), --nat-gateway-ids $(EC2_NATGATEWAYS_IDS))

# Customizations
_EC2_LIST_NATGATEWAYS_FIELDS?= .{NatGatewayId:NatGatewayId,_SubnetId:SubnetId,_VpcId:VpcId,_State:State,_PublicIp:NatGatewayAddresses[0].PublicIp,NameTag:Tags[?Key=='Name'] | [0].Value}

# Macros
_ec2_get_natgateway_id=$(call _ec2_get_natgateway_id_N, $(EC2_NATGATEWAY_NAME))
_ec2_get_natgateway_id_N=$(shell $(AWS) ec2 describe-nat-gateways --filter "Name=tag:Name,Values=$(strip $(1))" --query "NatGateways[].NatGatewayId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::NatGateway ($(_AWS_EC2_NATGATEWAY_MK_VERSION)) macros:'
	@echo '    _ec2_get_natgateway_id_{|N}        - Get a NAT gateway ID (Name)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::NatGateway ($(_AWS_EC2_NATGATEWAY_MK_VERSION)) targets:'
	@echo '    _ec2_list_natgateways              - List all NAT gateways'
	@echo '    _ec2_list_natgateways_set          - List a set of NAT gateways'
	@echo '    _ec2_show_natgateway               - Show everything related to a NAT gateway'
	@echo '    _ec2_show_natgateway_description   - Show description of a NAT gateway'
	@echo 

_ec2_list_parameters ::
	@echo 'AWS::EC2::NatGateway ($(_AWS_EC2_NATGATEWAY_MK_VERSION)) parameters:'
	@echo '    EC2_NATGATEWAY_ID=$(EC2_NATGATEWAY_ID)'
	@echo '    EC2_NATGATEWAY_NAME=$(EC2_NATGATEWAY_NAME)'
	@echo '    EC2_NATGATEWAYS_IDS=$(EC2_NATGATEWAYS_IDS)'
	@echo


#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_list_natgateways:
	@$(INFO) '$(EC2_UI_LABEL)Listing all NAT gateways ...'; $(NORMAL)
	$(AWS) ec2 describe-nat-gateways $(___EC2_FILTER) $(__EC2_NAT_GATEWAY_IDS) --query "NatGateways[]$(_EC2_LIST_NATGATEWAYS_FIELDS)"

_ec2_list_natgateways_set:

_EC2_SHOW_NATGATEWAY_TARGERS?= _ec2_show_natgateway_description
_ec2_show_natgateway: $(_EC2_SHOW_NATGATEWAY_TARGETS)

_ec2_show_natgateway_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of NAT gateway "$(EC2_NATGATEWAY_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-nat-gateways $(___EC2_FILTER) --nat-gateway-ids $(EC2_NATGATEWAY_ID)
