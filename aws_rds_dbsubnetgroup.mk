_AWS_RDS_DBSUBNETGROUP_MK_VERSION= $(_AWS_RDS_MK_VERSION)

# RDS_DBSUBNETGROUP_DESCRIPTION?= "This is my subnet-group definition"
# RDS_DBSUBNETGROUP_NAME?= my-subnet-group
# RDS_DBSUBNETGROUP_SUBNET_IDS?= subnet-12345678 ...
# RDS_DBSUBNETGROUP_TAGS?= Key=string,Value=string ...
# RDS_DBSUBNETGROUPS_SET_NAME?= my-db-subnet-groups-set

# Derived variables
RDS_DBSUBNETGROUP_SUBNET_IDS?= $(EC2_SUBNET_IDS)

# Options variables
__RDS_DB_SUBNET_GROUP_DESCRIPTION= $(if $(RDS_DBSUBNETGROUP_DESCRIPTION), --db-subnet-group-description $(RDS_DBSUBNETGROUP_DESCRIPTION))
__RDS_DB_SUBNET_GROUP_NAME= $(if $(RDS_DBSUBNETGROUP_NAME), --db-subnet-group-name $(RDS_DBSUBNETGROUP_NAME))
__RDS_FILTERS_DBSUBNETGROUP=
__RDS_SUBNET_IDS= $(if $(RDS_DBSUBNETGROUP_SUBNET_IDS), --subnet-ids $(RDS_DBSUBNETGROUP_SUBNET_IDS))
__RDS_TAGS_DBSUBNETGROUP= $(if $(RDS_DBSUBNETGROUP_TAGS), --tags $(RDS_DBSUBNETGROUP_TAGS))

# UI variables
RDS_UI_VIEW_DBSUBNETGROUPS_FIELDS?= .{vpcId:VpcId,subnetGroupStatus:SubnetGroupStatus,DBSubnetGroupName:DBSubnetGroupName,subnets:Subnets[*].SubnetIdentifier|join(' ',@)}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_rds_view_makefile_macros ::
	@#echo 'AWS::RDS::DbSubnetGroup ($(_AWS_RDS_DBSUBNETGROUP_MK_VERSION)) macros:'
	@#echo

_rds_view_makefile_targets ::
	@echo 'AWS::RDS::DbSubnetGroup ($(_AWS_RDS_DBSUBNETGROUP_MK_VERSION)) targets:'
	@echo '    _rds_create_dbsubnetgroup                      - Create a subnet-group'
	@echo '    _rds_delete_dbsubnetgroup                      - Delete a subnet-group'
	@echo '    _rds_show_dbsubnetgroup                        - Show a subnet-group'
	@echo '    _rds_view_dbsubnetgroups                       - View db subnet-groups'
	@echo

_rds_view_makefile_variables ::
	@echo 'AWS::RDS::DbSubnetGroup ($(_AWS_RDS_DBSUBNETGROUP_MK_VERSION)) variables:'
	@echo '    RDS_DBSUBNETGROUP_DESCRIPTION=$(RDS_DBSUBNETGROUP_DESCRIPTION)'
	@echo '    RDS_DBSUBNETGROUP_NAME=$(RDS_DBSUBNETGROUP_NAME)'
	@echo '    RDS_DBSUBNETGROUP_SUBNET_IDS=$(RDS_DBSUBNETGROUP_SUBNET_IDS)'
	@echo '    RDS_DBSUBNETGROUP_TAGS=$(RDS_DBSUBNETGROUP_TAGS)'
	@echo '    RDS_DBSUBNETGROUPS_SET_NAME=$(RDS_DBSUBNETGROUPS_SET_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rds_create_dbsubnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB-subnet-group "$(RDS_DBSUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds create-db-subnet-group $(__RDS_DB_SUBNET_GROUP_DESCRIPTION) $(__RDS_DB_SUBNET_GROUP_NAME) $(__RDS_SUBNET_IDS) $(__RDS_TAGS_DBSUBNETGROUP)

_rds_delete_dbsubnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting DB-subnet-group "$(RDS_DBSUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds delete-db-subnet-group $(__RDS_DB_SUBNET_GROUP_NAME)

_rds_show_dbsubnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Showing DB-subnet-group "$(RDS_DBSUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) rds describe-db-subnet-groups $(__RDS_DB_SUBNET_GROUP_NAME) $(_X__RDS_FILTERS_DBSUBNETGROUP) --query "DBSubnetGroups[]"

_rds_view_dbsubnetgroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-subnet-groups ...'; $(NORMAL)
	$(AWS) rds describe-db-subnet-groups $(_X__RDS_DB_SUBNET_GROUP_NAME) $(_X__RDS_FILTERS_DBSUBNETGROUP) --query "DBSubnetGroups[]$(RDS_UI_VIEW_DBSUBNETGROUPS_FIELDS)"

_rds_view_dbsubnetgroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-subnet-groups set "$(RDS_DBSUBNETGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(ERROR) 'Not supported by API yet!'; $(NORMAL)
