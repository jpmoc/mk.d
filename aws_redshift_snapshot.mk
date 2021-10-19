_AWS_REDSHIFT_SNAPSHOT_MK_VERSION= $(_AWS_REDSHIFT_MK_VERSION)

# RST_SNAPSHOT_END_TIME?= 2012-07-16T18:00:00Z
# RST_SNAPSHOT_IDENTIFIER?= rs:examplecluster-2018-02-17-23-32-26
# RST_SNAPSHOT_ON_DELETE?= true
# RST_SNAPSHOT_OWNER?=
# RST_SNAPSHOT_START_TIME?= 2012-07-16T18:00:00Z
# RST_SNAPSHOT_TYPE?= automated
# RST_TAG_KEYS?=
# RST_TAG_VALUES?=

# Derived parameters

# Option parameters
__RST_CLUSTER_PARAMETER_GROUP_NAME= $(if $(RST_CLUSTER_PARAMETER_GROUP_NAME), --cluster-parameter-group-name $(RST_CLUSTER_PARAMETER_GROUP_NAME))
__RST_DURATION= $(if $(RST_EVENT_DURATION), --duration $(RST_EVENT_DURATION))
__RST_END_TIME= $(if $(RST_SNAPSHOT_END_TIME), --end-time $(RST_SNAPSHOT_END_TIME))
__RST_OWNER_ACCOUNT= $(if $(RST_SNAPSHOT_OWNER), --owner-account $(RST_SNAPSHOT_OWNER))
__RST_PARAMETER_GROUP_NAME= $(if $(RST_CLUSTER_PARAMETER_GROUP_NAME), --parameter-group-name $(RST_CLUSTER_PARAMETER_GROUP_NAME))
__RST_PORT= $(if $(RST_DATABASE_PORT), --port $(RST_DATABASE_PORT))
__RST_PREFERRED_MAINTENANCE_WINDOW= $(if $(RST_MAINTENANCE_WINDOW), --preferred-maintenance-window $(RST_MAINTENANCE_WINDOW))
__RST_RESOURCE_NAME=
__RST_RESOURCE_TYPE=
__RST_SOURCE= $(if $(RST_SOURCE), --source $(RST_SOURCE))
__RST_SOURCE_IDENTIFIER= $(if $(RST_SOURCE_IDENTIFIER), --source-identifier $(RST_SOURCE_IDENTIFIER))
__RST_SOURCE_TYPE= $(if $(RST_EVENT_SOURCE_TYPE), --source-type $(RST_EVENT_SOURCE_TYPE))
__RST_SKIP_FINAL_CLUSTER_SNAPSHOT= $(if $(filter true, $(RST_SNAPSHOT_ON_DELETE)), --no-skip-final-cluster-snapshot, --skip-final-cluster-snapshot)
__RST_SNAPSHOT_IDENTIFIER= $(if $(RST_SNAPSHOT_IDENTIFIER), --snapshot-identifier $(RST_SNAPSHOT_IDENTIFIER))
__RST_START_TIME= $(if $(RST_SNAPSHOT_START_TIME), --start-time $(RST_SNAPSHOT_START_TIME))
__RST_TAG_KEYS= $(if $(RST_TAG_KEYS), --tag-keys $(RST_TAG_KEYS))
__RST_TAG_VALUES= $(if $(RST_TAG_VALUES), --tag-values $(RST_TAG_VALUES))

# UI parameters
RST_UI_VIEW_CLUSTER_SNAPSHOTS_FIELDS?= .{SnapshotCreateTime:SnapshotCreateTime,ClusterIdentifier:ClusterIdentifier,SnapshotIdentifier:SnapshotIdentifier,SnapshotType:SnapshotType,Status:Status}

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _rst_view_framework_macros
_rst_view_framework_macros:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) macros:'
	@echo

_aws_view_framework_targets :: _rst_view_framework_targets
_rst_view_framework_targets:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) targets:'
	@echo '    _rst_show_cluster_snapshot          - Show details of a snapshot of a redshift cluster'
	@echo '    _rst_view_cluster_snapshots         - View snapshots of a cluster'
	@echo 

_aws_view_framework_parameters :: _rst_view_framework_parameters
_rst_view_framework_parameters:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) parameters:'
	@echo '    RST_SNAPSHOT_END_TIME=$(RST_SNAPSHOT_END_TIME)'
	@echo '    RST_SNAPSHOT_IDENTIFIER=$(RST_SNAPSHOT_IDENTIFIER)'
	@echo '    RST_SNAPSHOT_ON_DELETE=$(RST_SNAPSHOT_ON_DELETE)'
	@echo '    RST_SNAPSHOT_OWNER=$(RST_SNAPSHOT_OWNER)'
	@echo '    RST_SNAPSHOT_START_TIME=$(RST_SNAPSHOT_START_TIME)'
	@echo '    RST_SNAPSHOT_TYPE=$(RST_SNAPSHOT_TYPE)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rst_show_cluster_snapshot:
	@$(INFO) '$(AWS_UI_LABEL)Show details for snapshot "$(RST_SNAPSHOT_IDENTIFIER)" of cluster "$(RST_CLUSTER_IDENTIFIER)"  ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-snapshots $(_X__RST_CLUSTER_IDENTIFIER) $(__RST_END_TIME) $(__RST_OWNER_ACCOUNT) $(__RST_SNAPSHOT_IDENTIFIER) $(__RST_SNAPSHOT_TYPE) $(__RST_START_TIME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Snapshots[]$(RST_SHOW_CLUSTER_SNAPSHOT_FIELDS)"

_rst_view_cluster_snapshots:
	@$(INFO) '$(AWS_UI_LABEL)View cluster snapshots ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-snapshots $(__RST_CLUSTER_IDENTIFIER) $(__RST_END_TIME) $(__RST_OWNER_ACCOUNT) $(_X__RST_SNAPSHOT_IDENTIFIER) $(__RST_SNAPSHOT_TYPE) $(__RST_START_TIME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Snapshots[]$(RST_UI_VIEW_CLUSTER_SNAPSHOTS_FIELDS)"

_rst_show_snapshot_tags:
	@$(INFO) '$(AWS_UI_LABEL)View RedShift tags ...'; $(NORMAL)
	$(AWS) redshift describe-tags $(__RST_RESOURCE_NAME) $(__RST_RESOURCE_TYPE) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES)
