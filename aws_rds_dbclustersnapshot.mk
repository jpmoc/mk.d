_AWS_RDS_DBCLUSTERSNAPSHOT_MK_VERSION= $(_AWS_RDS_MK_VERSION)

# RDS_DBCLUSTERSNAPSHOT_IDENTIFIER?= my-cluster-snapshot

# Derived variables

# Options variables
__RDS_DB_CLUSTER_IDENTIFIER_DBCLUSTERSNAPSHOT=
__RDS_DB_CLUSTER_SNAPSHOT_IDENTIFIER=
__RDS_FILTERS_DBCLUSTERSNAPSHOT=
__RDS_INCLUDE_PUBLIC=
__RDS_INCLUDE_SHARED=
__RDS_SNAPSHOT_TYPE=

# UI variables
RDS_UI_SHOW_DBCLUSTERSNAPSHOT_FIELDS?=
RDS_UI_VIEW_DBCLUSTERSNAPSHOTS_FIELDS?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_rds_view_makefile_macros ::
	@#echo 'AWS::RDS::DbClusterSnapshot ($(_AWS_RDS_DBCLUSTERSNAPSHOT_MK_VERSION)) macros:'
	@#echo

_rds_view_makefile_targets ::
	@echo 'AWS::RDS::DbClusterSnapshot ($(_AWS_RDS_DBCLUSTERSNAPSHOT_MK_VERSION)) targets:'
	@echo '    _rds_create_dbclustersnapshot                      - Create a db-cluster-snapshot'
	@echo '    _rds_delete_dbclustersnapshot                      - Delete a db-cluster-snapshot'
	@echo '    _rds_show_dbclustersnapshot                        - Show a db-cluster-snapshot'
	@echo '    _rds_view_dbclustersnapshots                       - View db-cluster-snapshots'
	@echo

_rds_view_makefile_variables ::
	@echo 'AWS::RDS::DbClusterSnapshot ($(_AWS_RDS_DBCLUSTERSNAPSHOT_MK_VERSION)) variables:'
	@echo '    RDS_DBCLUSTERSNAPSHOT_IDENTIFIER=$(RDS_DBCLUSTERSNAPSHOT_IDENTIFIER)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rds_create_dbclustersnapshot:

_rds_delete_dbclustersnapshot:

_rds_show_dbclustersnapshot:

_rds_view_dbclustersnapshots:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-cluster-snapshots ...'; $(NORMAL)
	$(AWS) rds describe-db-cluster-snapshots $(_X__RDS_DB_CLUSTER_IDENTIFIER) $(_X__RDS_DB_CLUSTER_SNAPSHOT_IDENTIFIER) $(__RDS_FILTERS_DBCLUSTERSNAPSHOT) $(__RDS_INCLUDE_PUBLIC) $(__RDS_INCLUDE_SHARED) $(__RDS_SNAPSHOT_TYPE)

_rds_view_dbclustersnapshots_set:
