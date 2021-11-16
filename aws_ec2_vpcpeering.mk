_AWS_EC2_VPCPEERING_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_PEER_REGION?= us-east-1
# EC2_PEER_OWNER_ID?= 123456789012
# EC2_PEER_VPC_NAME?= my-remote-vpc
# EC2_PEER_VPC_ID?=
# EC2_VPCPEERING_ID?= pcx-accf9bc5
# EC2_VPCPEERING_IDS?= pcx-accf9bc5 ...
# EC2_VPCPEERING_NAME?= my-peering
# EC2_VPCPEERING_TAGS?= Key=Owner,Values=Bob ...

# Derived parameters
EC2_PEER_OWNER_ID?= $(AWS_ACCOUNT_ID)
EC2_PEER_REGION?= $(AWS_REGION)
EC2_VPCPEERING_TAGS+= $(if $(EC2_VPCPEERING_NAME), Key=Name$(COMMA)Value=$(EC2_VPCPEERING_NAME))

# Options
__EC2_VPC_PEERING_CONNECTION_ID= $(if $(EC2_VPCPEERING_ID), --vpc-peering-connection-id $(EC2_VPCPEERING_ID))
__EC2_VPC_PEERING_CONNECTION_IDS= $(if $(EC2_VPCPEERING_IDS), --vpc-peering-connection-ids $(EC2_VPCPEERING_IDS))
__EC2_PEER_OWNER_ID= $(if $(EC2_PEER_OWNER_ID), --peer-owner-id $(EC2_PEER_OWNER_ID))
__EC2_PEER_REGION= $(if $(EC2_PEER_REGION), --peer-region $(EC2_PEER_REGION))
__EC2_PEER_VPC_ID= $(if $(EC2_PEER_VPC_ID), --peer-vpc-id $(EC2_PEER_VPC_ID))
__EC2_TAGS_VPCPEERING= $(if $(EC2_VPCPEERING_TAGS), --tags $(EC2_VPCPEERING_TAGS))

# Customizations
_EC2_LIST_PEERINGS_FIELDS?= .{Name:Tags[?Key=='Name'].Value | [0],ConnectionId:VpcPeeringConnectionId,_RequesterVpc:RequesterVpcInfo.VpcId,_RequesterOwnerId:RequesterVpcInfo.OwnerId,_RequesterCidrBlock:RequesterVpcInfo.CidrBlock,_AccepterVpc:AccepterVpcInfo.VpcId,_AccepterOwnerId:AccepterVpcInfo.OwnerId,_Status:Status.Code}
# _EC2_LIST_PEERINGS_FIELDS?= .{Name:Tags[?Key=='Name'].Value | [0],VpcPeeringConnectionId:VpcPeeringConnectionId,_RequesterVpc:RequesterVpcInfo.VpcId,_RequesterOwnerId:RequesterVpcInfo.OwnerId,_RequesterCidrBlock:RequesterVpcInfo.CidrBlock,_AccepterVpc:AccepterVpcInfo.VpcId,_AccepterOwnerId:AccepterVpcInfo.OwnerId,_Status:Status.Code}

#--- MACROS

# Given 2 VPCs give me the ID of the peering connection
_ec2_get_vpcpeering_id=$(call _ec2_get_vpcpeering_id_A, $(EC2_PEER_VPC_ID))
_ec2_get_vpcpeering_id_A=$(call _ec2_get_vpcpeering_id_AR, $(1), $(EC2_VPC_ID))
_ec2_get_vpcpeering_id_AR=$(shell $(AWS) ec2 describe-vpc-peering-connections --filters Name=accepter-vpc-info.vpc-id,Values=$(strip $(1)) Name=requester-vpc-info.vpc-id,Values=$(strip $(2)) Name=status-code,Values=initiating-request,pending-acceptance,failed,provisioning,active,rejected --query  "VpcPeeringConnections[].VpcPeeringConnectionId" --output text)

# Given the name of a VPC peering connection, give me its ID
# BEWARE: Peering connections are not named at creation time
# _ec2_get_vpcpeering_id=$(call _ec2_get_vpcpeering_id_V, $(EC2_VPCPEERING_NAME))
_ec2_get_vpcpeering_id_V=$(call _ec2_get_vpcpeering_id_VF, $(1), tag:Name)
_ec2_get_vpcpeering_id_VF=$(shell $(AWS) ec2 describe-vpc-peering-connections --filter Name=$(strip $(2)),Values=$(strip $(1)) --query "VpcPeeringConnections[].VpcPeeringConnectionId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::VpcPeering ($(_AWS_EC2_VPCPEERING_MK_VERSION)) macros:'
	@echo '    _ec2_get_vpcpeering_id_{|A|AR}         - Get the ID of a peering connection (Accepter,Requested)'
	@echo '    _ec2_get_vpcpeering_id_{V|VF}          - Get the ID of a peering connection (Value,Filter)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::VpcPeering ($(_AWS_EC2_VPCPEERING_MK_VERSION)) targets:'
	@echo '    _ec2_accept_vpcpeering                     - Accept VPC-peering connection'
	@echo '    _ec2_create_vpcpeering                     - Initiate a VPC-peering'
	@echo '    _ec2_delete_vpcpeering                     - Delete a VPC-peering'
	@echo '    _ec2_list_vpcpeerings                      - List all VPC-peerings'
	@echo '    _ec2_list_vpcpeerings_set                  - List a set of VPC-peerings'
	@echo '    _ec2_reject_vpcpeering                     - Reject a VPC-peering connection'
	@echo '    _ec2_show_vpcpeering                       - Show everything related to a VPC-peering'
	@echo '    _ec2_show_vpcpeering_description           - Show description of a VPC-peering'
	@echo '    _ec2_show_vpcpeering_peers                 - Show the peers in a VPC-peering'
	@echo '    _ec2_tag_vpcpeering                        - Tag a VPC-peering'
	@echo '    _ec2_untag_vpcpeering                      - Un-tag a VPC-peering'
	@echo 

_ec2_list_parameters ::
	@echo 'AWS::EC2::VpcPeering ($(_AWS_EC2_VPCPEERING_MK_VERSION)) parameters:'
	@echo '    EC2_PEER_REGION=$(EC2_PEER_REGION)'
	@echo '    EC2_PEER_OWNER_ID=$(EC2_PEER_OWNER_ID)'
	@echo '    EC2_PEER_VPC_ID=$(EC2_PEER_VPC_ID)'
	@echo '    EC2_PEER_VPC_NAME=$(EC2_PEER_VPC_NAME)'
	@echo '    EC2_VPCPEERING_ID=$(EC2_VPCPEERING_ID)'
	@echo '    EC2_VPCPEERING_IDS=$(EC2_VPCPEERING_IDS)'
	@echo '    EC2_VPCPEERING_NAME=$(EC2_VPCPEERING_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

__ec2_create_peering:
	@$(INFO) '$(EC2_UI_LABEL)Creating VPC-peering connection '$(EC2_VPCPEERING_NAME)' ...'; $(NORMAL)
	$(AWS) ec2 create-vpc-peering-connection $(__EC2_PEER_OWNER_ID) $(__EC2_PEER_REGION) $(__EC2_PEER_VPC_ID) $(__EC2_VPC_ID)

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_accept_vpcpeering:
	@$(INFO) '$(EC2_UI_LABEL)Accepting VPC-peering connection "$(EC2_VPCPEERING_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 accept-vpc-peering-connection $(__EC2_VPC_PEERING_CONNECTION_ID)

_ec2_create_vpcpeering: __ec2_create_vpcpeering _ec2_tag_vpcpeering
	@# If implemented the normal way, the tag_peering cannot get the resource that wasn't yet created!

_ec2_delete_vpcpeering:
	@$(INFO) '$(EC2_UI_LABEL)Deleting VPC-peering connection "$(EC2_VPCPEERING_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 delete-vpc-peering-connection $(__EC2_VPC_PEERING_CONNECTION_ID)

_ec2_list_vpcpeerings:
	@$(INFO) '$(EC2_UI_LABEL)Listing VPC-peering connections ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-peering-connections $(__EC2_VPC_PEERING_CONNECTION_IDS) --query "VpcPeeringConnections[]$(_EC2_LIST_PEERINGS_FIELDS)"

_ec2_list_vpcpeerings_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing VPC-peering-set "$(EC2_VPCPEERINGS_SET_NAME)" ...'; $(NORMAL)

_ec2_reject_vpcpeering:
	@$(INFO) '$(EC2_UI_LABEL)Rejecting VPC-peering connection "$(EC2_VPCPEERING_NAME)" ...'; $(NORMAL)
	@$(WARN) 'You cannot reject active VPC-peering connection. Delete them instead!'; $(NORMAL)
	$(AWS) ec2 reject-vpc-peering-connection $(__EC2_VPC_PEERING_CONNECTION_ID)

_EC2_SHOW_VPCPEERING_TARGETS?= _ec2_show_vpcpeering_peers _ec2_show_vpcpeering_description
_ec2_show_vpcpeering: $(_EC2_SHOW_VPCPEERING_TARGETS)

_ec2_show_vpcpeering_description:
	@$(INFO) '$(EC2_UI_LABEL)Show description of VPC-peering "$(EC2_VPCPEERING_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-vpc-peering-connections --filters Name=vpc-peering-connection-id,Values=pcx-accf9bc5

_ec2_show_vpcpeering_peers:
	@$(INFO) '$(EC2_UI_LABEL)Show peers of VPC-peering "$(EC2_VPCPEERING_NAME)" ...'; $(NORMAL)

_ec2_tag_vpcpeering:
	@$(INFO) '$(EC2_UI_LABEL)Tagging VPC-peering connection "$(EC2_VPCPEERING_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 create-tags $(_X__EC2_RESOURCES) $(__EC2_TAGS_VPCPEERING) --resources $(call _ec2_get_vpc_peering_id)
