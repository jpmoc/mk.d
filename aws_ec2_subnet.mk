_AWS_EC2_SUBNET_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_SUBNET_AVAILABILITY_ZONE?= us-west-1a
# EC2_SUBNET_CIDR_BLOCK?=
# EC2_SUBNET_ID?= subnet-12345678
# EC2_SUBNET_IDS?= subnet-12345678 ...
# EC2_SUBNET_NAME?= my-subnet
# EC2_SUBNETS_FILTERS?= Name=vpc-id,Values=vps-12345678 
# EC2_SUBNETS_SET_NAME?= my-subnets-set
# EC2_SUBNETS_SUBNET_IDS?= subnet-12345678
# EC2_SUBNETS_VPC_ID?= vpc-12345678

# Derived parameters
EC2_SUBNET_AVAILABILITY_ZONE?= $(AWS_REGION)a
EC2_SUBNET_IDS?= $(EC2_SUBNET_ID)
EC2_SUBNET_NAME?= $(EC2_SUBNET_ID)
EC2_SUBNETS_VPC_ID?= $(EC2_VPC_ID)

# Options
__EC2_AVAILABILITY_ZONE= $(if $(EC2_SUBNET_AVAILABILITY_ZONE),--availibility-zone $(EC2_SUBNET_AVAILIBILITY_ZONE))
__EC2_CIDR_BLOCK_SUBNET= $(if $(EC2_SUBNET_CIDR_BLOCK),--cidr-block $(EC2_SUBNET_CIDR_BLOCK))
__EC2_DRY_RUN_SUBNET=
__EC2_FILTERS__SUBNETS?= $(if $(EC2_SUBNETS_FILTERS),--filters $(EC2_SUBNETS_FILTERS))
__EC2_IPV6_CIDR_BLOCK=
__EC2_SUBNET_ID= $(if $(EC2_SUBNET_ID),--subnet-id $(EC2_SUBNET_ID))
__EC2_SUBNET_IDS__SUBNET= $(if $(EC2_SUBNET_ID),--subnet-ids $(EC2_SUBNET_ID))
__EC2_SUBNET_IDS__SUBNETS= $(if $(EC2_SUBNETS_IDS),--subnet-ids $(EC2_SUBNETS_IDS))

# Customizations
_EC2_LIST_SUBNETS_FIELDS?= .{Name:Tags[?Key=='Name']|[0].Value||'',SubnetId:SubnetId,state:State,cidrBlock:CidrBlock,availabilityZone:AvailabilityZone,vpcId:VpcId} | sort_by(@, &vpcId)
_EC2_LIST_SUBNETS_SET_FIELDS?= $(_EC2_LIST_SUBNETS_FIELDS)
_EC2_LIST_SUBNETS_SET_QUERYFILTER?=

#--- MACROS

_ec2_get_defaultsubnet_id= $(call _ec2_get_defaultsubnet_id_Z, $(EC2_SUBNET_AVAILABILITY_ZONE))
_ec2_get_defaultsubnet_id_Z= $(shell $(AWS) ec2 describe-subnets --filters Name=default-for-az,Values=true Name=availability-zone,Values=$(strip $(1)) --query 'Subnets[].SubnetId' --output text)

# Get all the subnet from the given VPC, ordered based on the AZ
_ec2_get_subnet_ids= $(call _ec2_get_subnet_ids_V, $(EC2_VPC_ID))
_ec2_get_subnet_ids_V= $(call _ec2_get_subnet_ids_VF, $(1), vpc-id)
_ec2_get_subnet_ids_VF= $(call _ec2_get_subnet_ids_VFS, $(1), $(2), &AvailabilityZone)
_ec2_get_subnet_ids_VFS= $(strip $(shell $(AWS) ec2 describe-subnets --filters "Name=$(strip $(2)),Values=$(strip $(1))" "Name=state,Values=available" --query 'sort_by(Subnets[],$(3))[].SubnetId' --output text))

_ec2_get_subnet_id= $(call _ec2_get_subnet_id_V, $(EC2_SUBNET_NAME))
_ec2_get_subnet_id_V= $(call _ec2_get_subnet_ids_VF, $(1), tag:Name)
_ec2_get_subnet_id_VF= $(shell $(AWS) ec2 describe-subnets --filters "Name=$(strip $(2)),Values=$(strip $(1))" "Name=state,Values=available" --query "Subnets[].SubnetId" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::Subnet ($(_AWS_EC2_SUBNET_MK_VERSION)) macros:'
	@echo '    _ec2_get_defaultsubnet_id_{|Z}           - Get the ID of the default subnet in a AZ (availabilityZone)'
	@echo '    _ec2_get_subnet_ids_{|V|VF|VFS}          - Get a list of subnet IDs (Value,Filter,Sort)'
	@echo '    _ec2_get_subnet_id_{|V|VF}               - Get a subnet ID (Value,Filter)'
	@echo

_ec2_list_parameters ::
	@echo 'AWS::EC2::Subnet ($(_AWS_EC2_SUBNET_MK_VERSION)) parameters:'
	@echo '    EC2_SUBNET_AVAILABILITY_ZONE=$(EC2_SUBNET_AVAILABILITY_ZONE)'
	@echo '    EC2_SUBNET_ID=$(EC2_SUBNET_ID)'
	@echo '    EC2_SUBNET_NAME=$(EC2_SUBNET_NAME)'
	@echo '    EC2_SUBNETS_FILTERS=$(EC2_SUBNETS_FILTERS)'
	@echo '    EC2_SUBNETS_IDS=$(EC2_SUBNETS_IDS)'
	@echo '    EC2_SUBNETS_SET_NAME=$(EC2_SUBNETS_SET_NAME)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::Subnet ($(_AWS_EC2_SUBNET_MK_VERSION)) targets:'
	@echo '    _ec2_create_subnet                       - Creata a subnet'
	@echo '    _ec2_delete_subnet                       - Delete a subnet'
	@echo '    _ec2_show_subnet                         - Show everything related to a subnet'
	@echo '    _ec2_show_subnet_description             - Show description of a subnet'
	@echo '    _ec2_show_subnet_networkinterfaces       - Show network-interfaces of a subnet'
	@echo '    _ec2_list_subnets                        - List all subnets'
	@echo '    _ec2_list_subnets_set                    - List a set of subnets-set'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_associate_subnet_cidrblock:

_ec2_create_subnet:
	@$(INFO) '$(EC2_UI_LABEL)Creating subnet "$(EC2_SUBNET_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 create-subnets $(__EC2_AVAILABILITY_ZONE) $(__EC2_CIDR_BLOCK_SUBNET) $(__EC2_DRY_RUN_SUBNET) $(__EC2_IPV6_CIDR_BLOCK) $(__EC2_VPC_ID_SUBNET)

_ec2_delete_subnet:
	@$(INFO) '$(EC2_UI_LABEL)Deleting subnet "$(EC2_SUBNET_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 delete-subnets $(__EC2_SUBNET_ID)

_ec2_list_subnets:
	@$(INFO) '$(EC2_UI_LABEL)Listing ALL subnets ...'; $(NORMAL)
	$(AWS) ec2 describe-subnets $(_X__EC2_FILTERS__SUBNETS) $(_X__EC2_SUBNET_IDS__SUBNETS) --query "Subnets[]$(_EC2_LIST_SUBNETS_FIELDS)" 

_ec2_list_subnets_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing subnets-set "$(EC2_SUBNETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Subnets are grouped based on the provided filters, ids, and optional query-filter'; $(NORMAL) 
	$(AWS) ec2 describe-subnets $(__EC2_FILTERS__SUBNETS) $(__EC2_SUBNET_IDS__SUBNETS) --query "Subnets[$(_EC2_LIST_SUBNETS_SET_QUERYFILTER)]$(_EC2_LIST_SUBNETS_SET_FIELDS)" 

_EC2_SHOW_SUBNET_TARGETS?= _ec2_show_subnet_networkinterfaces _ec2_show_subnet_description
_ec2_show_subnet: $(_EC2_SHOW_SUBNET_TARGETS)

_ec2_show_subnet_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of subnet "$(EC2_SUBNET_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-subnets $(__EC2_SUBNET_IDS__SUBNET)

_ec2_show_subnet_networkinterfaces::
	@$(INFO) '$(EC2_UI_LABEL)Showing network-interface of subnet "$(EC2_SUBNET_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-network-interfaces --filters Name=subnet-id,Values=$(EC2_SUBNET_ID) --query "NetworkInterfaces[].{NetworkInterfaceId:NetworkInterfaceId,privateIpAddress:PrivateIpAddress,status:Status,publicIp:Association.PublicIp,subnetId:SubnetId,Name:''}"

_ec2_unassociate_subnet_cidrblock:
