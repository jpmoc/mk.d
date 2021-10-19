_AWS_EC2_SECURITYGROUPEGRESS_MK_VERSION= $(_AWS_EC2_MK_VERSION)

# EC2_SECURITYGROUPEGRESS_DESCRIPTION= "This is my security-group-egress descriprion"
# EC2_SECURITYGROUPEGRESS_RULE_CIDR?= 203.0.113.0/24
# EC2_SECURITYGROUPEGRESS_RULE_PORT?= 80
# EC2_SECURITYGROUPEGRESS_RULE_PORTRANGE?= 80-443
# EC2_SECURITYGROUPEGRESS_RULE_PROTOCOL?= tcp
# EC2_SECURITYGROUPEGRESS_RULES_CONFIGS?= [{'IpProtocol': 'icmp', 'FromPort': 3, 'ToPort': 4, 'IpRanges': [{'CidrIp': '0.0.0.0/0'}]}] ...
# EC2_SECURITYGROUPEGRESS_RULES_DIRPATH?= ./in/
# EC2_SECURITYGROUPEGRESS_RULES_FILENAME?= rules.json
# EC2_SECURITYGROUPEGRESS_RULES_FILEPATH?= ./in/rules.json
# EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID?= sg-12345678
# EC2_SECURITYGROUPEGRESS_SECURITYGROUP_NAME?=
# EC2_SECURITYGROUPEGRESSES_SECURITYGROUP_ID?= sg-12345678
# EC2_SECURITYGROUPEGRESSES_SECURITYGROUP_NAME?=
# EC2_SECURITYGROUPEGRESSES_SET_NAME?= my-security-groups-set

# Derived parameters
EC2_SECURITYGROUPEGRESS_NAME?= egress@$(EC2_SECURITYGROUPEGRESS_SECURITYGROUPEGRESS_ID)@
EC2_SECURITYGROUPEGRESS_RULES_FILEPATH?= $(if $(EC2_SECURITYGROUPEGRESS_RULES_FILENAME),$(EC2_SECURITYGROUPEGRESS_RULES_DIRPATH)$(EC2_SECURITYGROUPEGRESS_RULES_FILENAME))
EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID?= $(EC2_SECURITYGROUP_ID)
EC2_SECURITYGROUPEGRESS_SECURITYGROUP_NAME?= $(EC2_SECURITYGROUP_NAME)
EC2_SECURITYGROUPEGRESSES_SET_NAME?= $(EC2_VPC_ID)


# Options parameters
__EC2_CIDR__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_RULE_CIDR),--cidr $(EC2_SECURITYGROUPEGRESS_RULE_CIDR))
__EC2_DESCRIPTION__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_DESCRIPTION),--description $(EC2_SECURITYGROUPEGRESS_DESCRIPTION))
__EC2_GROUP_ID__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID),--group-ids $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID))
__EC2_GROUP_IDS__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID),--group-ids $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID))
__EC2_GROUP_IDS__SECURITYGROUPEGRESSES= $(if $(EC2_SECURITYGROUPEGRESS_IDS),--group-ids $(EC2_SECURITYGROUPEGRESS_IDS))
__EC2_GROUP_NAME__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_NAME),--group-name $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_NAME))
__EC2_GROUP_OWNER__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_OWNER),--group-owner $(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_OWNER))
__EC2_IP_PERMISSIONS__SECURITYGROUPEGRESSES+= $(if $(EC2_SECURITYGROUPEGRESS_RULES_CONFIGS),--ip-permissions $(EC2_SECURITYGROUPEGRESS_RULES_CONFIGS))
__EC2_IP_PERMISSIONS__SECURITYGROUPEGRESSES+= $(if $(EC2_SECURITYGROUPEGRESS_RULES_FILEPATH),--ip-permissions file://$(EC2_SECURITYGROUPEGRESS_RULES_FILEPATH))
__EC2_PORT__SECURITYGROUPEGRESS+= $(if $(EC2_SECURITYGROUPEGRESS_RULE_PORT),--port $(EC2_SECURITYGROUPEGRESS_RULE_PORT))
__EC2_PORT__SECURITYGROUPEGRESS+= $(if $(EC2_SECURITYGROUPEGRESS_RULE_PORTRANGE),--port $(EC2_SECURITYGROUPEGRESS_RULE_PORTRANGE))
__EC2_PROTOCOL__SECURITYGROUPEGRESS= $(if $(EC2_SECURITYGROUPEGRESS_RULE_PROTOCOL),--protocol $(EC2_SECURITYGROUPEGRESS_RULE_PROTOCOL))

# UI parameters
EC2_UI_SHOW_SECURITYGROUPEGRESS_FIELDS?= # .{FromPort:FromPort,ipProtocol:IpProtocol,ToPort:ToPort,ipRanges:IpRanges[*].CidrIp|join('  ',@),description:IpRanges[0].Description}
EC2_UI_VIEW_SECURITYGROUPEGRESSES_FIELDS?= # .{GroupId:GroupId,GroupName:GroupName,description:Description,vpcId:VpcId}
EC2_UI_VIEW_SECURITYGROUPEGRESSES_SET_FIELDS?= $(EC2_UI_VIEW_SECURITYGROUPEGRESSES_FIELDS)
EC2_UI_VIEW_SECURITYGROUPEGRESSES_SET_QUERYFILTER?=

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ec2_view_framework_macros ::
	@echo 'AWS::EC2::SecurityGroupEgress ($(_AWS_EC2_SECURITYGROUPEGRESS_MK_VERSION)) macros:'
	@echo

_ec2_view_framework_parameters ::
	@echo 'AWS::EC2::SecurityGroupEgress ($(_AWS_EC2_SECURITYGROUPEGRESS_MK_VERSION)) parameters:'
	@echo '    EC2_SECURITYGROUPEGRESS_DESCRIPTION=$(EC2_SECURITYGROUPEGRESS_DESCRIPTION)'
	@echo '    EC2_SECURITYGROUPEGRESS_NAME=$(EC2_SECURITYGROUPEGRESS_NAME)'
	@echo '    EC2_SECURITYGROUPEGRESS_RULE_CIDR=$(EC2_SECURITYGROUPEGRESS_RULE_CIDR)'
	@echo '    EC2_SECURITYGROUPEGRESS_RULE_PORT=$(EC2_SECURITYGROUPEGRESS_RULE_PORT)'
	@echo '    EC2_SECURITYGROUPEGRESS_RULE_PORTS=$(EC2_SECURITYGROUPEGRESS_RULE_PORTS)'
	@echo '    EC2_SECURITYGROUPEGRESS_RULE_SOURCE_GROUP=$(EC2_SECURITYGROUPEGRESS_RULE_SOURCE_GROUP)'
	@echo '    EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID=$(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_ID)'
	@echo '    EC2_SECURITYGROUPEGRESS_SECURITYGROUP_NAME=$(EC2_SECURITYGROUPEGRESS_SECURITYGROUP_NAME)'
	@echo '    EC2_SECURITYGROUPEGRESSES_RULES_CONFIGS=$(EC2_SECURITYGROUPEGRESSES_RULES_CONFIGS)'
	@echo '    EC2_SECURITYGROUPEGRESSES_RULES_DIRPATH=$(EC2_SECURITYGROUPEGRESSES_RULES_DIRPATH)'
	@echo '    EC2_SECURITYGROUPEGRESSES_RULES_FILENAME=$(EC2_SECURITYGROUPEGRESSES_RULES_FILENAME)'
	@echo '    EC2_SECURITYGROUPEGRESSES_RULES_FILEPATH=$(EC2_SECURITYGROUPEGRESSES_RULES_FILEPATH)'
	@echo '    EC2_SECURITYGROUPEGRESSES_SECURITYGROUP_ID=$(EC2_SECURITYGROUPEGRESSES_SECURITYGROUP_ID)'
	@echo '    EC2_SECURITYGROUPEGRESSES_SECURITYGROUP_NAME=$(EC2_SECURITYGROUPEGRESSES_SECURITYGROUP_NAME)'
	@echo '    EC2_SECURITYGROUPEGRESSES_SET_NAME=$(EC2_SECURITYGROUPEGRESSES_SET_NAME)'
	@echo

_ec2_view_framework_targets ::
	@echo 'AWS::EC2::SecurityGroupEgress ($(_AWS_EC2_SECURITYGROUPEGRESS_MK_VERSION)) targets:'
	@echo '    _ec2_create_securitygroupegress              - Create a security-group-egress'
	@echo '    _ec2_create_securitygroupegresses            - Create a set of security-group-egresses'
	@echo '    _ec2_delete_securitygroupegress              - Delete a security-group-egress'
	@echo '    _ec2_delete_securitygroupegressies           - Delete a set of security-group-egresses'
	@echo '    _ec2_show_securitygroupegress                - Show everything related to a security-group-egress'
	@echo '    _ec2_show_securitygroupegress_description    - Show description for a security-group-egress'
	@echo '    _ec2_show_securitygroupegress_securitygroup  - Show egress-rules for a security-group'
	@echo '    _ec2_view_securitygroupegresses              - View all security-group-egresses'
	@echo '    _ec2_view_securitygroupegresses_set          - View a set of security-group-egresses'
	@echo '    _ec2_watch_securitygroupegresses             - Watch all security-group-egresses'
	@echo '    _ec2_watch_securitygroupegresses_set         - Watch a set of security-group-egresses'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ec2_create_securitygroupegress:
	@$(INFO) '$(EC2_UI_LABEL)Creating security-group-egress "$(EC2_SECURITYGROUPEGRESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the same rule already exists!'; $(NORMAL)
	$(AWS) ec2 authorize-security-group-egress $(__EC2_CIDR__SECURITYGROUPEGRESS) $(__EC2_GROUP_ID__SECURITYGROUPEGRESS) $(_X__EC2_GROUPEGRESS_NAME__SECURITYGROUPEGRESS) $(__EC2_GROUP_OWNER__SECURITYGROUPEGRESS) $(_X__EC2_IP_PERMISSIONS) $(__EC2_PORT__SECURITYGROUPEGRESS) $(__EC2_PROTOCOL__SECURITYGROUPEGRESS) $(__EC2_SOURCE_GROUP__SECURITYGROUPEGRESS)

_ec2_create_securitygroupegresses:
	@$(INFO) '$(EC2_UI_LABEL)Creating security-group-egress "$(EC2_SECURITYGROUPEGRESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the same rule already exists!'; $(NORMAL)
	$(AWS) ec2 authorize-security-group-egress $(_X__EC2_CIDR__SECURITYGROUPEGRESS) $(__EC2_GROUP_ID__SECURITYGROUPEGRESS) $(_X__EC2_GROUPEGRESS_NAME__SECURITYGROUPEGRESS) $(__EC2_GROUP_OWNER__SECURITYGROUPEGRESS) $(_X__EC2_IP_PERMISSIONS) $(__EC2_PORT__SECURITYGROUPEGRESS) $(__EC2_PROTOCOL__SECURITYGROUPEGRESS) $(__EC2_SOURCE_GROUP__SECURITYGROUPEGRESS)

_ec2_delete_securitygroupegress:
	@$(INFO) '$(EC2_UI_LABEL)Deleting security-group-egress "$(EC2_SECURITYGROUPEGRESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'You can revoke rules that do not exist!'; $(NORMAL)
	$(AWS) ec2 revoke-security-group-egress $(__EC2_CIDR) $(__EC2_GROUPEGRESS_ID) $(_X__EC2_GROUPEGRESS_NAME) $(__EC2_GROUP_OWNER) $(__EC2_IP_PERMISSIONS) $(__EC2_PORT) $(__EC2_PROTOCOL) $(__EC2_SOURCE_GROUP)

_ec2_show_securitygroupegress: _ec2_show_securitygroupegress_securitygroup _ec2_show_securitygroupegress_description

_ec2_show_securitygroupegress_description:
	@$(INFO) '$(EC2_UI_LABEL)Showing description of security-group-egress "$(EC2_SECURITYGROUPEGRESS_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If IpProtocol is set to -1, all destination ports are allowed'; $(NORMAL)
	@$(WARN) 'If IpRange is set to 0.0.0.0/0, the rule is applicable for all source IP addresses'; $(NORMAL)
	@$(WARN) 'If UserIdGroupPairs is set, the rule applies to hosts in the UserId AWS account that belong to the GroupId security group'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(__EC2_GROUPS_IDS__SECURITYGROUPEGRESS) --query "SecurityGroups[].IpPermissions[]$(EC2_UI_SHOW_SECURITYGROUPEGRESS_EGRESS_FIELDS)"

_ec2_show_securitygroupegress_securitygroup:
	@$(INFO) '$(EC2_UI_LABEL)Showing security-group of security-group-egress "$(EC2_SECURITYGROUPEGRESS_NAME)" ...'; $(NORMAL)
	$(AWS) ec2 describe-security-groups $(__EC2_GROUPS_IDS__SECURITYGROUPEGRESS)

_ec2_view_securitygroupegresses:
	@$(INFO) '$(EC2_UI_LABEL)Viewing ALL security-group-egresses ...'; $(NORMAL)

_ec2_view_securitygroupegresses_set:
	@$(INFO) '$(EC2_UI_LABEL)Viewing security-group-egresses-set "$(EC2_SECURITYGROUPEGRESSES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Security-group-egresses are grouped based on the provided security-group and query-filter'; $(NORMAL)

_ec2_watch_securitygroupegresses:
	@$(INFO) '$(EC2_UI_LABEL)Watching ALL security-group-egresses ...'; $(NORMAL)

_ec2_watch_securitygroupegresses_set:
	@$(INFO) '$(EC2_UI_LABEL)Watching security-group-egresses-set "$(EC2_SECURITYGROUPEGRESSES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Security-group-egresses are grouped based on the provided security-group and query-filter'; $(NORMAL)
