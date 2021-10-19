_AWS_DMS_INSTANCE_MK_VERSION=$(_AWS_DMS_MK_VERSION)

# DMS_FAILOVER_FORCE?= false
# DMS_INSTANCE_ALLOCATED_STORAGE?= 5
# DMS_INSTANCE_ARN?=
# DMS_INSTANCE_AUTO_MINOR_UPGRADE?= true
# DMS_INSTANCE_IDENTIFIER?= my-replication-instance
# DMS_INSTANCE_ENGINE_VERSION?=
# DMS_INSTANCE_MAINTENANCE_WINDOW?= Tue:04:00-Tue:04:30
# DMS_INSTANCE_MULTI_AZ?= true
DMS_INSTANCE_PUBLICLY_ACCESSIBLE?= true
# DMS_INSTANCE_TAGS?= Key=string,Value=string ...


# Derived variables
DMS_RESOURCE_ARN?= $(DMS_INSTANCE_ARN)
DMS_RESOURCE_IDENTIFIER?= $(DMS_INSTANCE_IDENTIFIER)

# Options
__DMS_ALLOCATED_STORAGE= $(if $(DMS_INSTANCE_ALLOCATED_STORAGE), --allocated-storage $(DMS_INSTANCE_ALLOCATED_STORAGE))
__DMS_AUTO_MINOR_VERSION_UPGRADE= $(if $(filter true, $(DMS_INSTANCE_AUTO_MINOR_VERSION_UPGRADE)), --auto-minor-version-upgrade, --no-auto-minor-version-upgrade)
__DMS_ENGINE_VERSION= $(if $(DMS_INSTANCE_ENGINE_VERSION), --engine-version $(DMS_INSTANCE_ENGINE_VERSION))
__DMS_FORCE_FAILOVER?= $(if $(filter true, $(DMS_FAILOVER_FORCE)), --force-failover)
__DMS_FILTERS_INSTANCES?=
__DMS_MULTI_AZ?= $(if $(filter true, $(DMS_INSTANCE_MULTI_AZ)), --multi-az, --no-multi-az)
__DMS_PUBLICLY_ACCESSIBLE= $(if $(filter true, $(DMS_INSTANCE_PUBLICLY_ACCESSIBLE)), --publicly-accessible, --no-publicly-accessible)
__DMS_PREFERRED_MAINTENANCE_WINDOW= $(if $(DMS_INSTANCE_MAINTENANCE_WINDOW), --preferred-maintenance-window $(DMS_INSTANCE_MAINTENANCE_WINDOW))
__DMS_REPLICATION_INSTANCE_ARN= $(if $(DMS_INSTANCE_ARN), --replication-instance-arn $(DMS_INSTANCE_ARN))
__DMS_REPLICATION_INSTANCE_CLASS= $(if $(DMS_INSTANCE_CLASS), --replication-instance-class $(DMS_INSTANCE_CLASS))
__DMS_REPLICATION_INSTANCE_IDENTIFIER= $(if $(DMS_INSTANCE_IDENTIFIER), --replication-instance-identifier $(DMS_INSTANCE_IDENTIFIER))
__DMS_TAGS_INSTANCE?= $(if $(DMS_INSTANCE_TAGS), --tags $(DMS_INSTANCE_TAGS))

# UI variables
DMS_UI_VIEW_INSTANCE_TYPES_FIELDS?=
DMS_UI_VIEW_REPLICATION_INSTANCES_FIELDS?= .{ReplicationInstanceIdentifier:ReplicationInstanceIdentifier,_EngineVersion:EngineVersion,_AllocatedStorage:AllocatedStorage,_AvailabilityZone:AvailabilityZone,_ReplicationInstanceClass:ReplicationInstanceClass,_ReplicationInstanceStatus:ReplicationInstanceStatus}

#--- Utilities

#--- MACROS
_dms_get_instance_arn=$(call _dms_get_instance_arn_I, $(DMS_INSTANCE_IDENTIFIER))
_dms_get_instance_arn_I=$(shell $(AWS) dms describe-replication-instances --query "ReplicationInstances[?ReplicationInstanceIdentifier=='$(strip $(1))'].ReplicationInstanceArn" --output text)

#----------------------------------------------------------------------
# USAGE
#

_dms_view_makefile_macros::
	@echo "AWS::DMS::Instance ($(_AWS_DMS_INSTANCE_MK_VERSION)) macros:"
	@echo "    _dms_get_instance_arm_{|I}             - Get the ARN of an instance (Identifier)"
	@echo

_dms_view_makefile_targets::
	@echo "AWS::DMS::Instance ($(_AWS_DMS_INSTANCE_MK_VERSION)) targets:"
	@echo "    _dms_create_instance                   - Create a replication instance"
	@echo "    _dms_delete_instance                   - Delete a replication instance"
	@echo "    _dms_modify_instance                   - Modify a DMS replication instance"
	@echo "    _dms_reboot_instance                   - Reboot a DMS replication instance"
	@echo "    _dms_show_instance                     - Show details of a DMS replication instance"
	@echo "    _dms_view_instance_types               - View orderable replication instances"
	@echo 

_dms_view_makefile_variables::
	@echo "AWS::DMS::Instance ($(_AWS_DMS_INSTANCE_MK_VERSION)) variables:"
	@echo "    DMS_FAILOVER_FORCE=$(DMS_FAILOVER_FORCE)"
	@echo "    DMS_INSTANCE_ALLOCATED_STORAGE=$(DMS_INSTANCE_ALLOCATED_STORAGE)"
	@echo "    DMS_INSTANCE_ARN=$(DMS_INSTANCE_ARN)"
	@echo "    DMS_INSTANCE_AUTO_MINOR_UPGRADE=$(DMS_INSTANCE_AUTO_MINOR_UPGRADE)"
	@echo "    DMS_INSTANCE_CLASS=$(DMS_INSTANCE_CLASS)"
	@echo "    DMS_INSTANCE_ENGINE_VERSION=$(DMS_INSTANCE_ENGINE_VERSION)"
	@echo "    DMS_INSTANCE_IDENTIFIER=$(DMS_INSTANCE_IDENTIFIER)"
	@echo "    DMS_INSTANCE_MAINTENANCE_WINDOW=$(DMS_INSTANCE_MAINTENANCE_WINDOW)"
	@echo "    DMS_INSTANCE_MULTI_AZ=$(DMS_INSTANCE_MULTI_AZ)"
	@echo "    DMS_INSTANCE_PUBLICLY_ACCESSIBLE=$(DMS_INSTANCE_PUBLICLY_ACCESSIBLE)"
	@echo "    DMS_INSTANCE_TAGS=$(DMS_INSTANCE_TAGS)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dms_create_instance:
	@$(INFO) "$(AWS_UI_LABEL)Creating a DMS replication instance '$(DMS_INSTANCE_IDENTIFIER)' ..."; $(NORMAL)
	@$(WARN) "Identifiers of running instances must be unique"; $(NORMAL)
	$(AWS) dms create-replication-instance $(__DMS_ALLOCATED_STORAGE) $(__DMS_AUTO_MINOR_VERSION_UPGRADE) $(__DMS_AVAILABILITY_ZONE) $(__DMS_ENGINE_VERSION) $(__DMS_KMS_KEY_ID) $(__DMS_MULTI_AZ) $(__DMS_PREFERRED_MAINTENANCE_WINDOW) $(__DMS_PUBLICLY_ACCESSIBLE) $(__DMS_REPLICATION_INSTANCE_CLASS) $(__DMS_REPLICATION_INSTANCE_IDENTIFIER) $(__DMS_REPLICATION_SUBNET_GROUP_IDENTIFER) $(__DMS_TAGS_INSTANCE) $(__DMS_VPC_SECURITY_GROUP_IDS)

_dms_delete_instance:
	@$(INFO) "$(AWS_UI_LABEL)Deleting DMS replication instance '$(DMS_INSTANCE_IDENTIFIER)' ..."; $(NORMAL)
	@$(WARN) "Tasks running on this instance need to be deleted first!"; $(NORMAL)
	$(AWS) dms delete-replication-instance $(__DMS_REPLICATION_INSTANCE_ARN)

_dms_modify_instance:
	@$(INFO) "$(AWS_UI_LABEL)Modifying DMS replication instance '$(DMS_INSTANCE_IDENTIFER)' ..."; $(NORMAL)
	$(AWS) dms modify-replication-instance $(__DMS_ENGINE_VERSION) $(__DMS_PREFERRED_MAINTENANCE_WINDOW) $(__DMS_REPLICATION_INSTANCE_ARN) $(__DMS_REPLICATION_INSTANCE_IDENTIFER)

_dms_reboot_instance:
	@$(INFO) "$(AWS_UI_LABEL)Rebooting a DMS replication instance '$(DMS_INSTANCE_IDENTIFER)' ..."; $(NORMAL)
	$(AWS) dms reboot-replication-instance $(__DMS_FORCE_FAILOVER) $(__DMS_REPLICATION_INSTANCE_ARN)

_dms_show_instance:
	@$(INFO) "$(AWS_UI_LABEL)Showing details for DMS replication instance '$(DMS_INSTANCE_IDENTIFIER)' ..."; $(NORMAL)
	$(AWS) dms describe-replication-instances $(_X__DMS_FILTERS_INSTANCES) --query "ReplicationInstances[?ReplicationInstanceIdentifier=='$(DMS_INSTANCE_IDENTIFIER)']"

_dms_show_instance_tags: DMS_RESOURCE_ARN=$(DMS_INSTANCE_ARN)
_dms_show_instance_tags: DMS_RESOURCE_IDENTIFIER=$(DMS_INSTANCE_IDENTIFIER)
_dms_show_instance_tags: _dms_show_resource_tags

_dms_view_instance_types:
	@$(INFO) "$(AWS_UI_LABEL)Viewing orderable DMS replication instances ..."; $(NORMAL)
	$(AWS) dms describe-orderable-replication-instances --query "OrderableReplicationInstances[*]$(DMS_UI_VIEW_INSTANCE_TYPES_FIELDS)"

_dms_view_instances:
	@$(INFO) "$(AWS_UI_LABEL)Viewing DMS replication instances ..."; $(NORMAL)
	$(AWS) dms describe-replication-instances $(__DMS_FILTERS_INSTANCES) --query "ReplicationInstances[]$(DMS_UI_VIEW_REPLICATION_INSTANCES_FIELDS)"
