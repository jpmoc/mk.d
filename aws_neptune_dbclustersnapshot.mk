_AWS_NEPTUNE_DBCLUSTERSNAPSHOT_MK_VERSION= $(_AWS_NEPTUNE_MK_VERSION)

# NTE_DBCLUSTERSNAPSHOT_IDENTIFIER?= my-cluster-snapshot

# Derived parameters

# Options parameters
__NTE_DB_CLUSTER_IDENTIFIER__DBCLUSTERSNAPSHOT=
__NTE_DB_CLUSTER_SNAPSHOT_IDENTIFIER=
__NTE_FILTERS__DBCLUSTERSNAPSHOT=
__NTE_INCLUDE_PUBLIC=
__NTE_INCLUDE_SHARED=
__NTE_SNAPSHOT_TYPE=

# UI parameters
NTE_UI_SHOW_DBCLUSTERSNAPSHOT_FIELDS?=
NTE_UI_VIEW_DBCLUSTERSNAPSHOTS_FIELDS?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_nte_view_framework_macros ::
	@#echo 'AWS::NepTunE::DbClusterSnapshot ($(_AWS_NEPTUNE_DBCLUSTERSNAPSHOT_MK_VERSION)) macros:'
	@#echo

_nte_view_framework_targets ::
	@echo 'AWS::NepTunE::DbClusterSnapshot ($(_AWS_NEPTUNE_DBCLUSTERSNAPSHOT_MK_VERSION)) targets:'
	@echo '    _nte_create_dbclustersnapshot                      - Create a db-cluster-snapshot'
	@echo '    _nte_delete_dbclustersnapshot                      - Delete a db-cluster-snapshot'
	@echo '    _nte_show_dbclustersnapshot                        - Show a db-cluster-snapshot'
	@echo '    _nte_view_dbclustersnapshots                       - View db-cluster-snapshots'
	@echo

_nte_view_framework_parameters ::
	@echo 'AWS::NepTunE::DbClusterSnapshot ($(_AWS_NEPTUNE_DBCLUSTERSNAPSHOT_MK_VERSION)) parameters:'
	@echo '    NTE_DBCLUSTERSNAPSHOT_IDENTIFIER=$(NTE_DBCLUSTERSNAPSHOT_IDENTIFIER)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_nte_create_dbclustersnapshot:

_nte_delete_dbclustersnapshot:

_nte_show_dbclustersnapshot:

_nte_view_dbclustersnapshots:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-cluster-snapshots ...'; $(NORMAL)
	$(AWS) neptune describe-db-cluster-snapshots $(_X__NTE_DB_CLUSTER_IDENTIFIER__DBCLUSTERSNAPSHOT) $(_X__NTE_DB_CLUSTER_SNAPSHOT_IDENTIFIER) $(__NTE_FILTERS__DBCLUSTERSNAPSHOT) $(__NTE_INCLUDE_PUBLIC) $(__NTE_INCLUDE_SHARED) $(__NTE_SNAPSHOT_TYPE)

_nte_view_dbclustersnapshots_set:
