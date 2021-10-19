_AWS_EC2_NATGATEWAY_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_NATGATEWAY_ID?=
# EC2_NATGATEWAY_NAME?= my-name-gateway

# Derived parameters
EC2_NATGATEWAY_IDS?= $(EC2_NATGATEWAY_ID)

# Option parameters
__EC2_NAT_GATEWAY_IDS= $(if $(EC2_NATGATEWAY_IDS), --nat-gateway-ids $(EC2_NATGATEWAY_IDS))

# UI parameters
EC2_UI_VIEW_NATGATEWAYS_FIELDS?= .{NatGatewayId:NatGatewayId,_SubnetId:SubnetId,_VpcId:VpcId,_State:State,_PublicIp:NatGatewayAddresses[0].PublicIp,NameTag:Tags[?Key=='Name'] | [0].Value}

#--- MACROS
_ec2_get_natgateway_id=$(call _ec2_get_natgateway_id_N, $(EC2_NATGATEWAY_NAME))
_ec2_get_natgateway_id_N=$(shell $(AWS) ec2 describe-nat-gateways --filter "Name=tag:Name,Values=$(strip $(1))" --query "NatGateways[].NatGatewayId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_view_framework_macros ::
	@echo "AWS::EC2::NatGateway ($(_AWS_EC2_NATGATEWAY_MK_VERSION)) macros:"
	@echo "    _ec2_get_natgateway_id_{|N}        - Get a NAT gateway ID (Name)"
	@echo

_ec2_view_framework_targets ::
	@echo "AWS::EC2::NatGateway ($(_AWS_EC2_NATGATEWAY_MK_VERSION)) targets:"
	@echo "    _ec2_show_natgateways        - Show details of a NAT gateway"
	@echo "    _ec2_view_natgateways        - View existing NAT gateways"
	@echo 

_ec2_view_framework_parameters ::
	@echo "AWS::EC2::NatGateway ($(_AWS_EC2_NATGATEWAY_MK_VERSION)) parameters:"
	@echo "    EC2_NATGATEWAY_ID=$(EC2_NATGATEWAY_ID)"
	@echo "    EC2_NATGATEWAY_IDS=$(EC2_NATGATEWAY_IDS)"
	@echo "    EC2_NATGATEWAY_NAME=$(EC2_NATGATEWAY_NAME)"
	@echo


#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_show_natgateway:
	@$(INFO) "$(EC2_UI_LABEL)Showing details of NAT gateway '$(EC2_NATGATEWAY_NAME)' ..."; $(NORMAL)
	$(AWS) ec2 describe-nat-gateways $(___EC2_FILTER) --nat-gateway-ids $(EC2_NATGATEWAY_ID)

_ec2_view_natgateways:
	@$(INFO) "$(EC2_UI_LABEL)Viewing existing NAT gateways ..."; $(NORMAL)
	$(AWS) ec2 describe-nat-gateways $(___EC2_FILTER) $(__EC2_NAT_GATEWAY_IDS) --query "NatGateways[]$(EC2_UI_VIEW_NATGATEWAYS_FIELDS)"
