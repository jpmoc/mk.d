_AWS_NEPTUNE_DBSUBNETGROUP_MK_VERSION= $(_AWS_NEPTUNE_MK_VERSION)

# NTE_DBSUBNETGROUP_DESCRIPTION?= "This is my subnet-group definition"
# NTE_DBSUBNETGROUP_NAME?= my-subnet-group
# NTE_DBSUBNETGROUP_SUBNET_IDS?= subnet-12345678 ...
# NTE_DBSUBNETGROUP_TAGS?= Key=string,Value=string ...
# NTE_DBSUBNETGROUPS_SET_NAME?= my-db-subnet-groups-set

# Derived parameters
NTE_DBSUBNETGROUP_SUBNET_IDS?= $(EC2_SUBNET_IDS)

# Options parameters
__NTE_DB_SUBNET_GROUP_DESCRIPTION= $(if $(NTE_DBSUBNETGROUP_DESCRIPTION), --db-subnet-group-description $(NTE_DBSUBNETGROUP_DESCRIPTION))
__NTE_DB_SUBNET_GROUP_NAME= $(if $(NTE_DBSUBNETGROUP_NAME), --db-subnet-group-name $(NTE_DBSUBNETGROUP_NAME))
__NTE_FILTERS_DBSUBNETGROUP=
__NTE_SUBNET_IDS= $(if $(NTE_DBSUBNETGROUP_SUBNET_IDS), --subnet-ids $(NTE_DBSUBNETGROUP_SUBNET_IDS))
__NTE_TAGS_DBSUBNETGROUP= $(if $(NTE_DBSUBNETGROUP_TAGS), --tags $(NTE_DBSUBNETGROUP_TAGS))

# UI parameters
NTE_UI_VIEW_DBSUBNETGROUPS_FIELDS?= .{vpcId:VpcId,subnetGroupStatus:SubnetGroupStatus,DBSubnetGroupName:DBSubnetGroupName,subnets:Subnets[*].SubnetIdentifier|join(' ',@)}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_nte_view_framework_macros ::
	@#echo 'AWS::NepTunE::DbSubnetGroup ($(_AWS_NEPTUNE_DBSUBNETGROUP_MK_VERSION)) macros:'
	@#echo

_nte_view_framework_targets ::
	@echo 'AWS::NepTunE::DbSubnetGroup ($(_AWS_NEPTUNE_DBSUBNETGROUP_MK_VERSION)) targets:'
	@echo '    _nte_create_dbsubnetgroup                      - Create a subnet-group'
	@echo '    _nte_delete_dbsubnetgroup                      - Delete a subnet-group'
	@echo '    _nte_show_dbsubnetgroup                        - Show a subnet-group'
	@echo '    _nte_view_dbsubnetgroups                       - View db subnet-groups'
	@echo

_nte_view_framework_parameters ::
	@echo 'AWS::NepTunE::DbSubnetGroup ($(_AWS_NEPTUNE_DBSUBNETGROUP_MK_VERSION)) parameters:'
	@echo '    NTE_DBSUBNETGROUP_DESCRIPTION=$(NTE_DBSUBNETGROUP_DESCRIPTION)'
	@echo '    NTE_DBSUBNETGROUP_NAME=$(NTE_DBSUBNETGROUP_NAME)'
	@echo '    NTE_DBSUBNETGROUP_SUBNET_IDS=$(NTE_DBSUBNETGROUP_SUBNET_IDS)'
	@echo '    NTE_DBSUBNETGROUP_TAGS=$(NTE_DBSUBNETGROUP_TAGS)'
	@echo '    NTE_DBSUBNETGROUPS_SET_NAME=$(NTE_DBSUBNETGROUPS_SET_NAME)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_nte_create_dbsubnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB-subnet-group "$(NTE_DBSUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune create-db-subnet-group $(__NTE_DB_SUBNET_GROUP_DESCRIPTION) $(__NTE_DB_SUBNET_GROUP_NAME) $(__NTE_SUBNET_IDS) $(__NTE_TAGS_DBSUBNETGROUP)

_nte_delete_dbsubnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Deleting DB-subnet-group "$(NTE_DBSUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune delete-db-subnet-group $(__NTE_DB_SUBNET_GROUP_NAME)

_nte_show_dbsubnetgroup:
	@$(INFO) '$(AWS_UI_LABEL)Showing DB-subnet-group "$(NTE_DBSUBNETGROUP_NAME)" ...'; $(NORMAL)
	$(AWS) neptune describe-db-subnet-groups $(__NTE_DB_SUBNET_GROUP_NAME) $(_X__NTE_FILTERS_DBSUBNETGROUP) --query "DBSubnetGroups[]"

_nte_view_dbsubnetgroups:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-subnet-groups ...'; $(NORMAL)
	$(AWS) neptune describe-db-subnet-groups $(_X__NTE_DB_SUBNET_GROUP_NAME) $(_X__NTE_FILTERS_DBSUBNETGROUP) --query "DBSubnetGroups[]$(NTE_UI_VIEW_DBSUBNETGROUPS_FIELDS)"

_nte_view_dbsubnetgroups_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-subnet-groups set "$(NTE_DBSUBNETGROUPS_SET_NAME)" ...'; $(NORMAL)
	@$(ERROR) 'Not supported by API yet!'; $(NORMAL)
