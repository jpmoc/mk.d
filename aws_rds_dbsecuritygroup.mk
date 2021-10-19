_AWS_RDS_DBSECURITYGROUP_MK_VERSION= $(_AWS_RDS_MK_VERSION)

# RDS_DBSECURITYGROUP_CIDRIP?= 172.27.0.0/16
# RDS_DBSECURITYGROUP_DESCRIPTION?= "This is my description"
# RDS_DBSECURITYGROUP_EC2SECURITYGROUP_ID?=
# RDS_DBSECURITYGROUP_EC2SECURITYGROUP_NAME?=
# RDS_DBSECURITYGROUP_EC2SECURITYGROUP_OWERNID?=
# RDS_DBSECURITYGROUP_ID?= sg-367f8e4c
# RDS_DBSECURITYGROUP_NAME?= my-securitygroup-name
# RDS_DBSECURITYGROUP_NAMES?= my-securitygroup-name ...
# RDS_DBSECURITYGROUP_TAGS?= Key=string,Value=string ...

# Derived variables
RDS_DBSECURITYGROUP_NAMES?= $(RDS_DBSECURITYGROUP_NAME)

# Options variables
__RDS_CIDRIP= $(if $(RDS_DBSECURITYGROUP_CIDRIP), --cidrip $(RDS_DBSECURITYGROUP_CIDRIP))
__RDS_DB_SECURITY_GROUP_DESCRIPTION= $(if $(RDS_DBSECURITYGROUP_DESCRIPTION), --db-security-group-description $(RDS_DBSECURITYGROUP_DESCRIPTION))
__RDS_DB_SECURITY_GROUP_NAME= $(if $(RDS_DBSECURITYGROUP_NAME), --db-security-group-name $(RDS_DBSECURITYGROUP_NAME))
__RDS_EC2_SECURITY_GROUP_ID= $(if $(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_ID), --ec2-security-group-id $(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_ID))
__RDS_EC2_SECURITY_GROUP_NAME= $(if $(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_NAME), --ec2-security-group-name $(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_NAME))
__RDS_EC2_SECURITY_GROUP_OWNER_ID= $(if $(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_OWNERID), --ec2-security-group-owner-id $(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_OWNERID))
__RDS_TAGS_SECURITYGROUP= $(if $(RDS_DBSECURITYGROUP_TAGS), --tags $(RDS_DBSECURITYGROUP_TAGS))

# UI variables
RDS_UI_SHOW_DBSECURITYGROUP_FIELDS?=
RDS_UI_VIEW_DBSECURITYGROUPS_FIELDS?= .{DBSecurityGroupArn:DBSecurityGroupArn,dBSecurityGroupDescription:DBSecurityGroupDescription,DBSecurityGroupName:DBSecurityGroupName,ownerId:OwnerId}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_rds_view_makefile_macros ::
	@#echo 'AWS::RDS::DbSecurityGroup ($(_AWS_RDS_DBSECURITYGROUP_MK_VERSION)) macros:'
	@#echo

_rds_view_makefile_targets ::
	@echo 'AWS::RDS::DbSecurityGroup ($(_AWS_RDS_DBSECURITYGROUP_MK_VERSION)) targets:'
	@echo '    _rds_authorize_dbsecuritygroup_ingress           - Authorizing ingress for a db-security-group'
	@echo '    _rds_create_dbsecuritygroup                      - Create a db-security-group'
	@echo '    _rds_delete_dbsecuritygroup                      - Delete a db-security-group'
	@echo '    _rds_revoking_dbsecuritygroup_ingress            - Revoking ingress for a db-security-group'
	@echo '    _rds_show_dbsecuritygroup                        - Show a db-security-group'
	@echo '    _rds_view_dbsecuritygroups                       - View db-security-groups'
	@echo

_rds_view_makefile_variables ::
	@echo 'AWS::RDS::DbSecurityGroup ($(_AWS_RDS_DBSECURITYGROUP_MK_VERSION)) variables:'
	@echo '    RDS_DBSECURITYGROUP_CIDRIP=$(RDS_DBSECURITYGROUP_CIDRIP)'
	@echo '    RDS_DBSECURITYGROUP_DESCRIPTION=$(RDS_DBSECURITYGROUP_DESCRIPTION)'
	@echo '    RDS_DBSECURITYGROUP_EC2SECURITYGROUP_ID=$(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_ID)'
	@echo '    RDS_DBSECURITYGROUP_EC2SECURITYGROUP_NAME=$(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_NAME)'
	@echo '    RDS_DBSECURITYGROUP_EC2SECURITYGROUP_OWNERID=$(RDS_DBSECURITYGROUP_EC2SECURITYGROUP_OWNERID)'
	@echo '    RDS_DBSECURITYGROUP_ID=$(RDS_DBSECURITYGROUP_ID)'
	@echo '    RDS_DBSECURITYGROUP_NAME=$(RDS_DBSECURITYGROUP_NAME)'
	@echo '    RDS_DBSECURITYGROUP_NAMES=$(RDS_DBSECURITYGROUP_NAMES)'
	@echo '    RDS_DBSECURITYGROUP_TAGS=$(RDS_DBSECURITYGROUP_TAGS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rds_authorize_dbsecuritygroup_ingress:
	@$(INFO) '$(AWS_UI_LABEL)Authorizing ingress for DB-security-group "$(RDS_DBSECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'EC2SecurityGroups: Instance that have this security-group are authorized to access the DB'; $(NORMAL)
	@$(WARN) 'IPRanges: If the source IP is in the CIDR range, then you can have access to the DB'; $(NORMAL)
	$(AWS) rds authorize-db-security-group-ingress $(__RDS_CIDRIP) $(__RDS_DB_SECURITY_GROUP_NAME) $(__RDS_EC2_SECURITY_GROUP_NAME) $(__RDS_EC2_SECURITY_GROUP_ID) $(__RDS_EC2_SECURITY_GROUP_OWNER_ID)


_rds_create_dbsecuritygroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB-security-group "$(RDS_DBSECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds create-db-security-group $(__RDS_DB_SECURITY_GROUP_DESCRIPTION) $(__RDS_DB_SECURITY_GROUP_NAME) $(__RDS_TAGS_SECURITYGROUP)

_rds_delete_dbsecuritygroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting DB-security-group "$(RDS_DBSECURITYGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds delete-db-security-group $(__RDS_DB_SECURITY_GROUP_NAME)

_rds_revoke_dbsecuritygroup_ingress:
	@$(INFO) '$(AWS_UI_LABEL)Revoking ingress for DB-security-group "$(RDS_DBSECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'EC2SecurityGroups: DB access from instances that have this security-group will be blocked'; $(NORMAL)
	@$(WARN) 'IPRanges: DB access from instances in the CIDR range will be blocked'; $(NORMAL)
	$(AWS) rds revoke-db-security-group-ingress $(__RDS_CIDRIP) $(__RDS_DB_SECURITY_GROUP_NAME) $(__RDS_EC2_SECURITY_GROUP_NAME) $(__RDS_EC2_SECURITY_GROUP_ID) $(__RDS_EC2_SECURITY_GROUP_OWNER_ID)

_rds_show_dbsecuritygroup:
	@$(INFO) '$(AWS_UI_LABEL)Showing DB-security-group "$(RDS_DBSECURITYGROUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'EC2SecurityGroups: Instance that have this security-group are authorized to access the DB'; $(NORMAL)
	@$(WARN) 'IPRanges: If the source IP is in the CIDR range, then you can have access to the DB'; $(NORMAL)
	@$(WARN) 'BEWARE: No port is to be provided to access the DB, because the port is known!'; $(NORMAL)
	$(AWS) rds describe-db-security-groups $(__RDS_DB_SECURITY_GROUP_NAME) $(_X__RDS_FILTERS_SECURITYGROUP) --query "DBSecurityGroups[]$(RDS_UI_SHOW_SECURITYGROUP_FIELDS)"

_rds_view_dbsecuritygroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-security-groups ...'; $(NORMAL)
	$(AWS) rds describe-db-security-groups $(_X__RDS_DB_SECURITY_GROUP_NAME) $(_X__RDS_FILTERS_SECURITYGROUP) --query "DBSecurityGroups[]$(RDS_UI_VIEW_DBSECURITYGROUPS_FIELDS)"

_rds_view_dbsecuritygroups_set:
