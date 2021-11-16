_AWS_EC2_SECURITYGROUP_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_SECURITYGROUP_DESCRIPTION= "This is my security group descriprion"
# EC2_SECURITYGROUP_ID?= sg-12345678
# EC2_SECURITYGROUP_NAME?=
# EC2_SECURITYGROUP_OWNER?=
# EC2_SECURITYGROUP_VPC_ID?= vpc-12345678
# EC2_SECURITYGROUPS_FILTERS?= Name=string,Values=string,string ...
# EC2_SECURITYGROUPS_IDS?= sg-12345678 ...
# EC2_SECURITYGROUPS_SET_NAME?= my-security-groups-set

# Derived parameters
EC2_SECURITYGROUP_NAME?= $(EC2_SECURITYGROUP_ID)
EC2_SECURITYGROUP_VPC_ID?= $(EC2_VPC_ID)
EC2_SECURITYGROUPS_IDS?= $(EC2_SECURITYGROUP_ID)
EC2_SECURITYGROUPS_SET_NAME?= $(EC2_VPC_ID)


# Options
__EC2_DESCRIPTION__SECURITYGROUP= $(if $(EC2_SECURITYGROUP_DESCRIPTION),--description $(EC2_SECURITYGROUP_DESCRIPTION))
__EC2_FILTERS__SECURITYGROUPS= $(if $(EC2_SECURITYGROUPS_FILTERS),--filters $(EC2_SECURITYGROUPS_FILTERS))
__EC2_GROUP_ID__SECURITYGROUP= $(if $(EC2_SECURITYGROUP_ID),--group-id $(EC2_SECURITYGROUP_ID))
__EC2_GROUP_IDS__SECURITYGROUP= $(if $(EC2_SECURITYGROUP_ID),--group-ids $(EC2_SECURITYGROUP_ID))
__EC2_GROUP_IDS__SECURITYGROUPS= $(if $(EC2_SECURITYGROUP_IDS),--group-ids $(EC2_SECURITYGROUP_IDS))

# Customizations
_EC2_LIST_SECURITYGROUPS_FIELDS?= .{GroupId:GroupId,GroupName:GroupName,description:Description,vpcId:VpcId}
_EC2_LIST_SECURITYGROUPS_SET_FIELDS?= $(_EC2_LIST_SECURITYGROUPS_FIELDS)
_EC2_LIST_SECURITYGROUPS_SET_QUERYFILTER?=
_EC2_SHOW_SECURITYGROUP_EGRESSES_FIELDS?= .{FromPort:FromPort,ipProtocol:IpProtocol,ToPort:ToPort,ipRanges:IpRanges[*].CidrIp|join('  ',@),description:IpRanges[0].Description} 
_EC2_SHOW_SECURITYGROUP_INGRESSES_FIELDS?= .{FromPort:FromPort,ipProtocol:IpProtocol,ToPort:ToPort,ipRanges:IpRanges[*].CidrIp|join('  ',@),description:IpRanges[0].Description}

#--- Macros
_ec2_get_vpc_defaultsecuritygroup_id= $(call _ec2_get_vpc_defaultsecuritygroup_id_I, $(EC2_VPC_ID))
_ec2_get_vpc_defaultsecuritygroup_id_I= $(shell $(AWS) ec2 describe-security-groups --filters Name=vpc-id,Values=$(strip $(1)) --query "SecurityGroups[?GroupName=='default'].GroupId" --output text)

_ec2_get_securitygroup_id= $(call _ec2_get_securitygroup_id_N, $(EC2_SECURITYGROUP_NAME))
_ec2_get_securitygroup_id_N= $(shell $(AWS) ec2 describe-security-groups --filters "Name=group-name,Values=$(strip $(1))" --query 'SecurityGroups[].GroupId' --output text)

_ec2_get_securitygroup_ids= $(call _ec2_get_securitygroup_ids_I, $(EC2_VPC_ID))
_ec2_get_securitygroup_ids_I= $(shell $(AWS) ec2 describe-security-groups --filters "Name=vpc-id,Values=$(strip $(1))" --query 'SecurityGroups[].GroupId' --output text)

_ec2_get_securitygroup_name= $(call _ec2_get_securitygroup_name_I, $(EC2_SECURITYGROUP_ID))
_ec2_get_securitygroup_name_I= $(shell $(AWS) ec2 describe-security-groups --group-ids $(1) --query "SecurityGroups[].GroupName" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ec2_list_macros ::
	@echo 'AWS::EC2::SecurityGroup ($(_AWS_EC2_SECURITYGROUP_MK_VERSION)) macros:'
	@echo '    _ec2_get_securitygroup_id_{|N}                  - Get a security-group ID (Name)'
	@echo '    _ec2_get_securitygroup_ids_{|I}                 - Get security-group IDs of a VPC (vpcId)'
	@echo '    _ec2_get_securitygroup_name_{|I}                - Get a security-group name (Id)'
	@echo '    _ec2_get_vpc_defaultsecuritygroup_id_{|I}       - Get the ID of the default-security-group of a VPC (vpcId)'
	@echo

_ec2_list_parameters ::
	@echo 'AWS::EC2::SecurityGroup ($(_AWS_EC2_SECURITYGROUP_MK_VERSION)) parameters:'
	@echo '    EC2_SECURITYGROUP_DESCRIPTION=$(EC2_SECURITYGROUP_DESCRIPTION)'
	@echo '    EC2_SECURITYGROUP_ID=$(EC2_SECURITYGROUP_ID)'
	@echo '    EC2_SECURITYGROUP_NAME=$(EC2_SECURITYGROUP_NAME)'
	@echo '    EC2_SECURITYGROUP_OWNER=$(EC2_SECURITYGROUP_OWNER)'
	@echo '    EC2_SECURITYGROUP_RULE_CIDR=$(EC2_SECURITYGROUP_RULE_CIDR)'
	@echo '    EC2_SECURITYGROUP_RULE_PORT=$(EC2_SECURITYGROUP_RULE_PORT)'
	@echo '    EC2_SECURITYGROUP_RULE_PORTS=$(EC2_SECURITYGROUP_RULE_PORTS)'
	@echo '    EC2_SECURITYGROUP_RULE_SOURCE_GROUP=$(EC2_SECURITYGROUP_RULE_SOURCE_GROUP)'
	@echo '    EC2_SECURITYGROUP_RULES_DIRPATH=$(EC2_SECURITYGROUP_RULES_DIRPATH)'
	@echo '    EC2_SECURITYGROUP_RULES_FILENAME=$(EC2_SECURITYGROUP_RULES_FILENAME)'
	@echo '    EC2_SECURITYGROUP_RULES_FILEPATH=$(EC2_SECURITYGROUP_RULES_FILEPATH)'
	@echo '    EC2_SECURITYGROUP_RULES=$(EC2_SECURITYGROUP_RULES)'
	@echo '    EC2_SECURITYGROUPS_FILTERS=$(EC2_SECURITYGROUPS_FILTERS)'
	@echo '    EC2_SECURITYGROUPS_IDS=$(EC2_SECURITYGROUPS_IDS)'
	@echo '    EC2_SECURITYGROUPS_SET_NAME=$(EC2_SECURITYGROUPS_SET_NAME)'
	@echo

_ec2_list_targets ::
	@echo 'AWS::EC2::SecurityGroup ($(_AWS_EC2_SECURITYGROUP_MK_VERSION)) targets:'
	@echo '    _ec2_create_securitygroup                  - Create a security-group'
	@echo '    _ec2_delete_securitygroup                  - Delete a security-group'
	@echo '    _ec2_show_securitygroup                    - Show everything related to a security-group'
	@echo '    _ec2_show_securitygroup_description        - Show description for a security-group'
	@echo '    _ec2_show_securitygroup_egresses           - Show egress-rules for a security-group'
	@echo '    _ec2_show_securitygroup_ingresses          - Show ingress-rules for a security-group'
	@echo '    _ec2_list_securitygroups                   - List all security-groups'
	@echo '    _ec2_list_securitygroups_set               - List a set of security-groups'
	@echo '    _ec2_watch_securitygroups                  - Watch all security-groups'
	@echo '    _ec2_watch_securitygroups_set              - Watch a set of security-groups'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_securitygroup:
	@$(INFO) '$(EC2_UI_LABEL)Creating security-group "$(EC2_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The security-group name must be unique!'; $(NORMAL)
	$(AWS) ec2 create-security-group $(__EC2_DESCRIPTION__SECURITYGROUP) $(__EC2_GROUP_NAME__SECURITYGROUP) $(__EC2_VPC_ID__SECURITYGROUP)

_ec2_delete_securitygroup:
	@$(INFO) '$(EC2_UI_LABEL)Deleting security-group "$(EC2_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 delete-security-group $(__EC2_GROUP_ID__SECURITYGROUP) $(_X__EC2_GROUP_NAME__SECURITYGROUP)

_ec2_list_securitygroups:
	@$(INFO) '$(EC2_UI_LABEL)Listing ALL security-groups ...'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(_X__EC2_FILTERS__SECURITYGROUP) --query "SecurityGroups[]$(_EC2_LIST_SECURITYGROUPS_FIELDS) | sort_by(@,&GroupName)" 

_ec2_list_securitygroups_set:
	@$(INFO) '$(EC2_UI_LABEL)Listing security-groups-set "$(EC2_SECURITYGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Security-groups are grouped based on the provided filter and optional query-filter'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(__EC2_FILTERS__SECURITYGROUPS) --query "SecurityGroups[$(_EC2_LIST_SECURITYGROUPS_SET_QUERYFILTER)]$(_EC2_LIST_SECURITYGROUPS_SET_FIELDS) | sort_by(@,&GroupName)" 

_EC2_SHOW_SECURITYGROUP_TARGETS?= _ec2_show_securitygroup_egresses _ec2_show_securitygroup_ingresses _ec2_show_securitygroup_description
_ec2_show_securitygroup: $(_EC2_SHOW_SECURITYGROUP_TARGETS)

_ec2_show_securitygroup_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of security-group "$(EC2_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(__EC2_GROUP_IDS__SECURITYGROUP)

_ec2_show_securitygroup_egresses:
	@$(INFO) '$(EC2_UI_LABEL)Showing egress-rules of security-group "$(EC2_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If IpProtocol is set to -1, all destination ports are allowed'; $(NORMAL)
	@$(WARN) 'If IpRange is set to 0.0.0.0/0, the rule is applicable for all destination IP addresses'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(__EC2_GROUP_IDS__SECURITYGROUP) --query "SecurityGroups[].IpPermissionsEgress[]$(_EC2_SHOW_SECURITYGROUP_EGRESSES_FIELDS)"

_ec2_show_securitygroup_ingresses:
	@$(INFO) '$(EC2_UI_LABEL)Showing ingress-rules for security-group "$(EC2_SECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If IpProtocol is set to -1, all destination ports are allowed'; $(NORMAL)
	@$(WARN) 'If IpRange is set to 0.0.0.0/0, the rule is applicable for all source IP addresses'; $(NORMAL)
	@$(WARN) 'If UserIdGroupPairs is set, the rule applies to hosts in the UserId AWS account that belong to the GroupId security group'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(__EC2_GROUP_IDS__SECURITYGROUP) --query "SecurityGroups[].IpPermissions[]$(_EC2_SHOW_SECURITYGROUP_INGRESSES_FIELDS)"

_ec2_watch_securitygroups:
	@$(INFO) '$(EC2_UI_LABEL)Watching ALL security-groups ...'; $(NORMAL)

_ec2_watch_securitygroups_set:
	@$(INFO) '$(EC2_UI_LABEL)Watching security-groups-set "$(EC2_SECURITYGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Security-groups are grouped based on the provided filter and optional query-filter'; $(NORMAL)
