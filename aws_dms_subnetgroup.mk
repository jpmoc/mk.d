_AWS_DMS_SUBNET_GROUP_MK_VERSION=$(_AWS_DMS_MK_VERSION)

# DMS_SUBNETGROUP_DESCRIPTION?= My group of subnets on a given vpc
# DMS_SUBNETGROUP_IDENTIFIER?= my-replication-subnet-group


# Derived variables
DMS_SUBNETGROUP_SUBNET_IDS?= $(EC2_SUBNET_IDS)

# Options
__DMS_FILTERS_SUBNETGROUP?=
__DMS_REPLICATION_SUBNET_GROUP_DESCRIPTION= $(if $(DMS_SUBNETGROUP_DESCRIPTION), --replication-subnet-group-description '$(DMS_SUBNETGROUP_DESCRIPTION)')
__DMS_REPLICATION_SUBNET_GROUP_IDENTIFIER= $(if $(DMS_SUBNETGROUP_IDENTIFIER), --replication-subnet-group-identifier $(DMS_SUBNETGROUP_IDENTIFIER))
__DMS_SUBNET_IDS?= $(if $(DMS_SUBNETGROUP_SUBNET_IDS), --subnet-ids $(DMS_SUBNETGROUP_SUBNET_IDS))

# UI variables
DMS_UI_SHOW_SUBNETGROUP_FIELDS?=
DMS_UI_VIEW_SUBNETGROUPS_FIELDS?= .{_VpcId:VpcId,_SubnetGroupStatus:SubnetGroupStatus,ReplicationSubnetGroupIdentifier:ReplicationSubnetGroupIdentifier,_Subnets:join(',',Subnets[].SubnetIdentifier)}#,_SubnetAvailabilityZones:join(',',Subnets[].SubnetAvailabilityZone.Name)}
# DMS_UI_VIEW_SUBNETGROUPS_FIELDS?= .{ReplicationSubnetGroupDescription:ReplicationSubnetGroupDescription,VpcId:VpcId,SubnetGroupStatus:SubnetGroupStatus,ReplicationSubnetGroupIdentifier:ReplicationSubnetGroupIdentifier,Subnets:join(',',Subnets[].SubnetIdentifier),AZ:join(',',Subnets[].SubnetAvailabilityZone.Name)}

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros::
	@echo "AWS::DMS::SubnetGroup ($(_AWS_DMS_SUBNET_GROUP_MK_VERSION)) macros:"
	@echo

_dms_view_makefile_targets::
	@echo "AWS::DMS::SubnetGroup ($(_AWS_DMS_SUBNET_GROUP_MK_VERSION)) targets:"
	@echo "    _dms_create_subnetgroup                - Create a replication subnet group"
	@echo "    _dms_delete_subnetgroup                - Delete a replication subnet group"
	@echo "    _dms_show_subnetgroup                  - Delete a replication subnet group"
	@echo "    _dms_view_subnetgroups                 - View replication subnet groups"
	@echo 

_dms_view_makefile_variables::
	@echo "AWS::DMS::SubnetGroup ($(_AWS_DMS_SUBNET_GROUP_MK_VERSION)) variables:"
	@echo "    DMS_SUBNETGROUP_DESCRIPTION=$(DMS_SUBNETGROUP_DESCRIPTION)"
	@echo "    DMS_SUBNETGROUP_IDENTIFIER=$(DMS_SUBNETGROUP_IDENTIFIER)"
	@echo "    DMS_SUBNETGROUP_SUBNET_IDS=$(DMS_SUBNETGROUP_SUBNET_IDS)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_create_subnetgroup:
	@$(INFO) "$(AWS_UI_LABEL)Creating a DMS replication subnet-group '$(DMS_SUBNETGROUP_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms create-replication-subnet-group $(__DMS_REPLICATION_SUBNET_GROUP_DESCRIPTION) $(__DMS_REPLICATION_SUBNET_GROUP_IDENTIFIER) $(__DMS_SUBNET_IDS) $(__DMS_TAGS_SUBNET_GROUP) 

_dms_delete_subnetgroup:
	@$(INFO) "$(AWS_UI_LABEL)Deleting a DMS replication subnet-group '$(DMS_SUBNETGROUP_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms delete-replication-subnet-group $(__DMS_REPLICATION_SUBNET_GROUP_IDENTIFIER)

_dms_show_subnetgroup:
	@$(INFO) "$(AWS_UI_LABEL)Showing DMS replication subnet-group '$(DMS_SUBNETGROUP_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms describe-replication-subnet-groups --filters Name=replication-subnet-group-id,Values=$(DMS_SUBNETGROUP_IDENTIFIER) --query "ReplicationSubnetGroups[]$(DMS_UI_SHOW_SUBNETGROUPS_FIELDS)"

_dms_view_subnetgroups:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS replication subnet-group ..."; $(NORMAL)
	$(AWS) dms describe-replication-subnet-groups $(__DMS_FILTERS_SUBNETGROUP) --query "ReplicationSubnetGroups[]$(DMS_UI_VIEW_SUBNETGROUPS_FIELDS)"
