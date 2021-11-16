_AWS_EC2_VPC_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_VPC_FILTERS?= Name=state,Values=available ...
# EC2_VPC_ID?= vpc-9fe180f7
# EC2_VPC_INSTANCE_TENANCY?= default
# EC2_VPC_NAME?= my-vpc
# EC2_VPC_SUBNET_IDS?= subnet-a4233fff ...
# EC2_VPC_TAGS?= Key=string,Value=string ...
# EC2_VPCS_IDS?= vpc-9fe180f7 ...
# EC2_VPCS_SET_NAME?= my-vpcs-set

# Derived parameters
EC2_VPC_IDS?= $(EC2_VPC_ID)

# Options
__EC2_AMAZON_PROVIDED_IPV6_CIDR_BLOCK=
__EC2_DRY_RUN=
__EC2_CIDR_BLOCK= $(if $(EC2_VPC_CIDR_BLOCK), --cidr-block $(EC2_VPC_CIDR_BLOCK))
__EC2_INSTANCE_TENANCY= $(if $(EC2_VPC_INSTANCE_TENANCY), --instance-tenancy $(EC2_VPC_INSTANCE_TENANCY))
__EC2_FILTERS_VPC= $(if $(EC2_VPC_FILTERS), --filter $(EC2_VPC_FILTERS))
__EC2_RESOURCES_VPC= $(if $(EC2_VPC_ID), --resources $(EC2_VPC_ID))
__EC2_TAGS_VPC= $(if $(EC2_VPC_TAGS), --tags $(EC2_VPC_TAGS))
__EC2_VPC_ID= $(if $(EC2_VPC_ID), --vpc-id $(EC2_VPC_ID))
__EC2_VPC_IDS= $(if $(EC2_VPCS_IDS), --vpc-ids $(EC2_VPCS_IDS))

# Customizations
_EC2_SHOW_VPC_FIELDS?=
# _EC2_LIST_VPCS_FIELDS?= .[Tags[?Key=='Name']|[0].Value,VpcId,State,CidrBlock,IsDefault]
_EC2_LIST_VPCS_FIELDS?= .{Name:Tags[?Key=='Name']|[0].Value || '',VpcId:VpcId,state:State,cidrBlock:CidrBlock,isDefault:IsDefault}
_EC2_LIST_VPCS_SET_FIELDS?= $(_EC2_LIST_VPCS_FIELDS)
_EC2_LIST_VPCS_SET_QUERYFILTER?=

#--- MACROS
_ec2_get_defaultvpc_id= $(shell $(AWS) ec2 describe-vpcs  --query "Vpcs[?IsDefault==\`true\`].VpcId" --output text)

_ec2_get_vpc_id= $(call _ec2_get_vpc_id_N, $(EC2_VPC_NAME))
_ec2_get_vpc_id_N= $(call _ec2_get_vpc_id_VF, $(1), tag:Name)

_ec2_get_vpc_id_VF= $(shell $(AWS) ec2 describe-vpcs --filters "Name=$(strip $(2)),Values=$(strip $(1))" --query "Vpcs[].VpcId" --output text)

_ec2_get_vpc_ids_V= $(call _ec2_get_vpc_ids_VF, $(1), tag:Name)
_ec2_get_vpc_ids_VF= $(call _ec2_get_vpc_ids_VFS, $(1), $(2), &VpcId)
_ec2_get_vpc_ids_VFS= $(shell $(AWS) ec2 describe-vpcs --filters "Name=$(strip $(1)),Values=$(strip $(2))" "Name=state,Values=available" --query 'sort_by(Vpcs[],$(3))[].VpcId' --output text)

_ec2_get_vpc_name= $(call _ec2_get_vpc_name_I, $(EC2_VPC_ID))
_ec2_get_vpc_name_I= $(shell $(AWS) ec2 describe-tags --filters Name=resource-id,Values=$(strip $(1)) --query "Tags[?Key=='Name'].Value" --output text)

_ec2_get_vpc_subnet_ids= $(call _ec2_get_vpc_subnet_ids_I, $(EC2_VPC_ID))
_ec2_get_vpc_subnet_ids_I= $(strip $(shell $(AWS) ec2 describe-subnets --filters Name=vpc-id,Values=$(strip $(1)) --query "Subnets[].SubnetId" --output text))

#--- Utilities

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::Vpc ($(_AWS_EC2_VPC_MK_VERSION)) macros:'
	@echo '    _ec2_get_defaultvpc_id                  - Get the ID of the default-VPC'
	@echo '    _ec2_get_vpc_id_{|N|VF}                 - Get the ID of a VPC (Name/Value,Field)'
	@echo '    _ec2_get_vpc_ids_{V|VF|VFS}             - Get VPC IDs (Value,Field,Sort)'
	@echo '    _ec2_get_vpc_name_{|I}                  - Get the name of a VPC (Id)'
	@echo '    _ec2_get_vpc_subnet_ids_{|I}            - Get the subnet IDs in a VPC (Id)'
	@echo

_ec2_list_parameters ::
	@echo 'AWS::EC2::Vpc ($(_AWS_EC2_VPC_MK_VERSION)) parameters:'
	@echo '    EC2_VPC_CIDR_BLOCK=$(EC2_VPC_CIDR_BLOCK)'
	@echo '    EC2_VPC_FILTERS=$(EC2_VPC_FILTERS)'
	@echo '    EC2_VPC_ID=$(EC2_VPC_ID)'
	@echo '    EC2_VPC_INSTANCE_TENANCY=$(EC2_VPC_INSTANCE_TENANCY)'
	@echo '    EC2_VPC_NAME=$(EC2_VPC_NAME)'
	@echo '    EC2_VPC_SUBNET_IDS=$(EC2_VPC_SUBNET_IDS)'
	@echo '    EC2_VPC_TAGS=$(EC2_VPC_TAGS)'
	@echo '    EC2_VPCS_IDS=$(EC2_VPCS_IDS)'
	@echo '    EC2_VPCS_SET_NAME=$(EC2_VPCS_SET_NAME)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::Vpc ($(_AWS_EC2_VPC_MK_VERSION)) targets:'
	@echo '    _ec2_create_vpc                        - Create a new VPC'
	@echo '    _ec2_delete_vpc                        - Delete an existing VPC'
	@echo '    _ec2_list_vpcs                         - List all VPCs'
	@echo '    _ec2_list_vpcs_set                     - List a set of VPCs'
	@echo '    _ec2_show_vpc                          - Show everything related to a VPC'
	@echo '    _ec2_show_vpc_description              - Show description of a VPC'
	@echo '    _ec2_show_vpc_secutirygroups           - Show security-groups of a VPC'
	@echo '    _ec2_show_vpc_subnets                  - Show subnets of a VPC'
	@echo '    _ec2_show_vpc_tags                     - Show tags of a VPC'
	@echo '    _ec2_tag_vpc                           - Tag of a VPC'
	@echo '    _ec2_untag_vpc                         - Untag of a VPC'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_vpc:
	@$(INFO) '$(EC2_UI_LABEL)Creating VPC "$(EC2_VPC_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 create-vpc $(__EC2_AMAZON_PROVIDED_IPV6_CIDR_BLOCK) $(__EC2_CIDR_BLOCK) $(__EC2_DRY_RUN) $(__EC2_INSTANCE_TENANCY)

_ec2_delete_vpc:
	@$(INFO) '$(EC2_UI_LABEL)Deleting VPC "$(EC2_VPC_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 delete-vpc $(__EC2_DRY_RUN) $(__EC2_VPC_ID)

_ec2_list_vpcs:
	@$(INFO) '$(EC2_UI_LABEL)Listing existing VPCs ...'; $(NORMAL)
	$(AWS) ec2 describe-vpcs $(_X__EC2_FILTERS_VPC) $(_X__EC2_VPC_IDS) --query "Vpcs[]$(_EC2_LIST_VPCS_FIELDS)"

_ec2_list_vpcs_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing a VPCs-set "$(EC2_VPCS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'VPCs are grouped based on the provided IDs, filters, and/or slice'; $(NORMAL)
	$(AWS) ec2 describe-vpcs $(__EC2_FILTERS_VPC) $(__EC2_VPC_IDS) --query "Vpcs[$(_EC2_LIST_VPCS_SET_QUERYFILTER)]$(_EC2_LIST_VPCS_SET_FIELDS)"

_EC2_SHOW_VPC_TARGETS?= _ec2_show_vpc_networkinterfaces _ec2_show_vpc_securitygroups _ec2_show_vpc_subnets _ec2_show_vpc_tags _ec2_show_vpc_description
_ec2_show_vpc: $(_EC2_SHOW_VPC_TARGETS)

_ec2_show_vpc_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of VPC "$(EC2_VPC_NAME)"...'; $(NORMAL)
	$(AWS) ec2 describe-vpcs --filters Name=vpc-id,Values=$(EC2_VPC_ID) $(_X__EC2_VPC_IDS) --query "Vpcs[]$(_EC2_SHOW_VPC_FIELDS)"

_ec2_show_vpc_networkinterfaces:
	@$(INFO) '$(EC2_UI_LABEL)Showing network-interfaces of VPC "$(EC2_VPC_NAME)"...'; $(NORMAL)
	$(AWS) ec2 describe-network-interfaces --filters Name=vpc-id,Values=$(EC2_VPC_ID) --query "NetworkInterfaces[].{NetworkInterfaceId:NetworkInterfaceId,privateIpAddress:PrivateIpAddress,status:Status,publicIp:Association.PublicIp,subnetId:SubnetId,Name:''}"

_ec2_show_vpc_securitygroups:
	@$(INFO) '$(EC2_UI_LABEL)Showing security-groups of VPC "$(EC2_VPC_NAME)"...'; $(NORMAL)
	$(AWS) ec2 describe-security-groups --filters Name=vpc-id,Values=$(EC2_VPC_ID) --query 'SecurityGroups[].{GroupId:GroupId,GroupName:GroupName,description:Description}'

_ec2_show_vpc_subnets:
	@$(INFO) '$(EC2_UI_LABEL)Showing subnets of VPC "$(EC2_VPC_NAME)"...'; $(NORMAL)
	$(AWS) ec2 describe-subnets --filters Name=vpc-id,Values=$(EC2_VPC_ID) --query 'Subnets[].{SubnetId:SubnetId,cidrBlock:CidrBlock,availabilityZone:AvailabilityZone,state:State,defaultForAz:DefaultForAz}'

_ec2_show_vpc_tags:
	@$(INFO) '$(EC2_UI_LABEL)Showing tags of VPC "$(EC2_VPC_NAME)"...'; $(NORMAL)
	$(AWS) ec2 describe-tags --filters Name=resource-id,Values=$(EC2_VPC_ID) --query 'Tags[]'

_ec2_tag_vpc:
	@$(INFO) '$(EC2_UI_LABEL)Tagging VPC "$(EC2_VPC_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 create-tags $(__EC2_DRY_RUN) $(__EC2_RESOURCES_VPC) $(__EC2_TAGS_VPC)

_ec2_untag_vpc:
	@$(INFO) '$(EC2_UI_LABEL)Un-tagging VPC "$(EC2_VPC_NAME)" ...'; $(NORMAL)
