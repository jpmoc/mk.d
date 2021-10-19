_AWS_NEPTUNE_DBCLUSTER_MK_VERSION= $(_AWS_NEPTUNE_MK_VERSION)


# NTE_DBCLUSTER_AVAILABILITY_ZONES?=
NTE_DBCLUSTER_BACKUP_RETENTION?= 1
# NTE_DBCLUSTER_BACKUP_WINDOW?= 07:23-07:53
# NTE_DBCLUSTER_CHARACTERSET_NAME?=
# NTE_DBCLUSTER_DATABASE_ENGINE?= neptune
# NTE_DBCLUSTER_DATABASE_PORT?= 3306
# NTE_DBCLUSTER_DATABASE_VERSION?=
# NTE_DBCLUSTER_DBCLUSTERPARAMETERGROUP_NAME?= my-db-cluster-parameter-group
# NTE_DBCLUSTER_DBSUBNETGROUP_NAME?= my-neptune-db-subnet-group
# NTE_DBCLUSTER_ENDPOINT_RO?=
# NTE_DBCLUSTER_ENDPOINT_RW?=
# NTE_DBCLUSTER_FINALSNAPSHOT_IDENTIFIER?= my-final-snapshot
NTE_DBCLUSTER_FINALSNAPSHOT_SKIP?= false
NTE_DBCLUSTER_IAM_AUTHENTICATION?= false
# NTE_DBCLUSTER_IDENTIFIER?= my-neptune-db-cluster
# NTE_DBCLUSTER_KMSKEY_ID?=
# NTE_DBCLUSTER_MAINTENANCE_WINDOW?= fri:10:21-fri:10:51
# NTE_DBCLUSTER_SOURCE_REGION?=
NTE_DBCLUSTER_STORAGE_ENCRYPTED?= false
# NTE_DBCLUSTER_TAGS?= Key=string,Value=string ...
# NTE_DBCLUSTER_VPCSECURITYGROUP_IDS?=
# NTE_DBCLUSTERS_FILTERS?= Name=string,Values=string,string ...

# Derived parameters
NTE_DBCLUSTER_DBCLUSTERPARAMETERGROUP_NAME?= $(NTE_DBCLUSTERPARAMETERGROUP_NAME)
NTE_DBCLUSTER_DBSUBNETGROUP_NAME?= $(NTE_DBSUBNETGROUP_NAME)
NTE_DBCLUSTER_VPCSECURITYGROUP_IDS?= $(EC2_SECURITYGROUP_IDS)

# Options parameters
__NTE_AVAILABILITY_ZONES= $(if $(NTE_DBCLUSTER_AVAILABILITY_ZONES), --availability-zone $(NTE_DBCLUSTER_AVAILABILITY_ZONES))
__NTE_BACKUP_RETENTION_PERIOD__DBCLUSTER= $(if $(NTE_DBCLUSTER_BACKUP_RETENTION), --backup-retention-period $(NTE_DBCLUSTER_BACKUP_RETENTION))
__NTE_CHARACTER_SET_NAME__DBCLUSTER= $(if $(NTE_DBCLUSTER_CHARACTERSET_NAME), --character-set-name $(NTE_DBCLUSTER_CHARACTER_SET))
__NTE_DATABASE_NAME__DBCLUSTER= $(if $(NTE_DBCLUSTER_DATABASE_NAME), --database-name $(NTE_DBCLUSTER_DATABASE_NAME))
__NTE_DB_CLUSTER_IDENTIFIER= $(if $(NTE_DBCLUSTER_IDENTIFIER), --db-cluster-identifier $(NTE_DBCLUSTER_IDENTIFIER))
__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME= $(if $(NTE_DBCLUSTER_DBCLUSTERPARAMETERGROUP_NAME), --db-cluster-parameter-group-name $(NTE_DBCLUSTER_DBCLUSTERPARAMETERGROUP_NAME))
__NTE_DB_SUBNET_GROUP_NAME__DBCLUSTER= $(if $(NTE_DBCLUSTER_DBSUBNETGROUP_NAME), --db-subnet-group-name $(NTE_DBCLUSTER_DBSUBNETGROUP_NAME))
__NTE_ENABLE_IAM_DATABASE_AUTHENTICATION= $(if $(filter true, $(NTE_DBCLUSTER_IAM_AUTHENTICATION)), --enable-iam-data-authentication, --no-enable-iam-data-authentication)
__NTE_ENGINE__DBCLUSTER= $(if $(NTE_DBCLUSTER_DATABASE_ENGINE), --engine $(NTE_DBCLUSTER_DATABASE_ENGINE))
__NTE_ENGINE_VERSION__DBCLUSTER= $(if $(NTE_DBCLUSTER_DATABASE_VERSION), --engine-version $(NTE_DBCLUSTER_DATABASE_VERSION))
__NTE_FILTERS__DBCLUSTERS= $(if $(NTE_DBCLUSTERS_FILTERS), --filters $(NTE_DBCLUSTERS_FILTERS))
__NTE_FINAL_DB_SNAPSHOT_IDENTIFIER= $(if $(NTE_FINALSNAPSHOT_IDENTIFIER), --final-db-snapshot-identifier $(NTE_FINALSANPSHOT_IDENTIFIER))
__NTE_KMS_KEY_ID__DBCLUSTER= $(if $(NTE_DBCLUSTER_KMSKEY_ID), --kms-key-id $(NTE_DBCLUSTER_KMSKEY_ID))
__NTE_MASTER_USER_PASSWORD__DBCLUSTER= $(if $(NTE_DBCLUSTER_MASTER_PASSWORD), --master-user-password $(NTE_DBCLUSTER_MASTER_PASSWORD))
__NTE_MASTER_USERNAME__DBCLUSTER= $(if $(NTE_DBCLUSTER_MASTER_USERNAME), --master-username $(NTE_DBCLUSTER_MASTER_USERNAME))
__NTE_OPTION_GROUP_NAME=
__NTE_PORT__DBCLUSTER= $(if $(NTE_DBCLUSTER_DATABASE_PORT), --port $(NTE_DBCLUSTER_DATABASE_PORT))
__NTE_PRE_SIGNED_URL=
__NTE_PREFERRED_BACKUP_WINDOW__DBCLUSTER= $(if $(NTE_DBCLUSTER_BACKUP_WINDOW), --backup-window $(NTE_DBCLUSTER_BACKUP_WINDOW))
__NTE_PREFERRED_MAINTENANCE_WINDOW__DBCLUSTER= $(if $(NTE_DBCLUSTER_MAINTENANCE_WINDOW), --preferred-maintenance-window $(NTE_DBCLUSTER_MAINTENANCE_WINDOW))
__NTE_REPLICATION_SOURCE_IDENTIFIER=
__NTE_SKIP_FINAL_SNAPSHOT= $(if $(filter true, $(NTE_DBCLUSTER_FINALSNAPSHOT_SKIP)), --skip-final-snapshot, --no-skip-final-snapshot)
__NTE_SOURCE_REGION= $(if $(NTE_DBCLUSTER_SOURCE_REGION), --source-region $(NTE_DBCLUSTER_SOURCE_REGION))
__NTE_STORAGE_ENCRYPTED= $(if $(filter true, $(NTE_DBCLUSTER_STORAGE_ENCRYPTED)), --storage-encrypted, --no-storage-encrypted)
__NTE_TAGS__DBCLUSTER= $(if $(NTE_DBCLUSTER_TAGS), --tags $(NTE_DBCLUSTER_TAGS))
__NTE_VPC_SECURITY_GROUP_IDS__DBCLUSTER= $(if $(NTE_DBCLUSTER_VPCSECURITYGROUP_IDS), --vpc-security-group-ids $(NTE_DBCLUSTER_VPCSECURITYGROUP_IDS), T)

# UI parameters
NTE_UI_SHOW_DBCLUSTER_INSTANCES_FIELDS?= $(NTE_UI_VIEW_INSTANCES_FIELDS)
NTE_UI_VIEW_DBCLUSTERS_FIELDS?= .{DBClusterIdentifier:DBClusterIdentifier,dBClusterParameterGroup:DBClusterParameterGroup,dBSubnetGroup:DBSubnetGroup,DbClusterResourceId:DbClusterResourceId,engine:Engine}

#--- Utilities

#--- MACROS
_nte_get_dbcluster_endpoint_ro= $(call _nte_get_dbcluster_endpoint_ro_I, $(NTE_DBCLUSTER_IDENTIFIER))
_nte_get_dbcluster_endpoint_ro_I= $(shell $(AWS) neptune describe-db-clusters  --db-cluster-identifier $(1)  --query "DBClusters[].ReaderEndpoint"  --output text)

_nte_get_dbcluster_endpoint_rw= $(call _nte_get_dbcluster_endpoint_rw_I, $(NTE_DBCLUSTER_IDENTIFIER))
_nte_get_dbcluster_endpoint_rw_I= $(shell $(AWS) neptune describe-db-clusters  --db-cluster-identifier $(1)  --query "DBClusters[].Endpoint"  --output text)

_nte_get_dbcluster_dbsubnetgroup_name= $(call _nte_get_dbcluster_dbsubnetgroup_name_I, $(NTE_DBCLUSTER_IDENTIFIER))
_nte_get_dbcluster_dbsubnetgroup_name_I= $(shell $(AWS) neptune describe-db-clusters  --db-cluster-identifier $(1)  --query "DBClusters[].DBSubnetGroup"  --output text)

_nte_get_dbcluster_dbclusterparametergroup_name= $(call _nte_get_dbcluster_dbclusterparametergroup_name_I, $(NTE_DBCLUSTER_IDENTIFIER))
_nte_get_dbcluster_dbclusterparametergroup_name_I= $(shell $(AWS) neptune describe-db-clusters  --db-cluster-identifier $(1)  --query "DBClusters[].DBClusterParameterGroup"  --output text)

#----------------------------------------------------------------------
# USAGE
#

_nte_view_framework_macros ::
	@echo 'AWS::NepTunE::DbCluster ($(_AWS_NEPTUNE_DBCLUSTER_MK_VERSION)) macros:'
	@echo '    _nte_get_dbcluster_dbclusterparametergroup_name_{|I}  - Get the db-cluster-parameter-group-name of a DB-cluster (Identifier)'
	@echo '    _nte_get_dbcluster_dbsubnetgroup_name_{|I}            - Get the db-subnet-group-name of a DB-cluster (Identifier)'
	@echo '    _nte_get_dbcluster_endpoint_ro_{|I}                   - Get the reader-endpoint for a DB-cluster (Identifier)'
	@echo '    _nte_get_dbcluster_endpoint_rw_{|I}                   - Get the rw-endpoint for a DB-cluster (Identifier)'
	@echo

_nte_view_framework_parameters ::
	@echo 'AWS::NepTunE::DbCluster ($(_AWS_NEPTUNE_DBCLUSTER_MK_VERSION)) parameters:'
	@echo '    NTE_DBCLUSTER_VPCSECURITYGROUP_IDS=$(NTE_DBCLUSTER_VPCSECURITYGROUP_IDS)'
	@echo '    NTE_DBCLUSTER_AVAILABILITY_ZONES=$(NTE_DBCLUSTER_AVAILABILITY_ZONES)'
	@echo '    NTE_DBCLUSTER_BACKUP_RETENTION=$(NTE_DBCLUSTER_BACKUP_RETENTION)'
	@echo '    NTE_DBCLUSTER_CHARACTERSET_NAME=$(NTE_DBCLUSTER_CHARACTERSET_NAME)'
	@echo '    NTE_DBCLUSTER_DATABASE_ENGINE=$(NTE_DBCLUSTER_DATABASE_ENGINE)'
	@echo '    NTE_DBCLUSTER_DATABASE_NAME=$(NTE_DBCLUSTER_DATABASE_NAME)'
	@echo '    NTE_DBCLUSTER_DATABASE_PORT=$(NTE_DBCLUSTER_DATABASE_PORT)'
	@echo '    NTE_DBCLUSTER_DATABASE_VERSION=$(NTE_DBCLUSTER_DATABASE_VERSION)'
	@echo '    NTE_DBCLUSTER_DBCLUSTERPARAMETERGROUP_NAME=$(NTE_DBCLUSTER_DBCLUSTERPARAMETERGROUP_NAME)'
	@echo '    NTE_DBCLUSTER_DBSUBNETGROUP_NAME=$(NTE_DBCLUSTER_DBSUBNETGROUP_NAME)'
	@echo '    NTE_DBCLUSTER_ENDPOINT_RO=$(NTE_DBCLUSTER_ENDPOINT_RO)'
	@echo '    NTE_DBCLUSTER_ENDPOINT_RW=$(NTE_DBCLUSTER_ENDPOINT_RW)'
	@echo '    NTE_DBCLUSTER_FINALSNAPSHOT_IDENTIFIER=$(NTE_FINALSNAPSHOT_IDENTIFIER)'
	@echo '    NTE_DBCLUSTER_FINALSNAPSHOT_SKIP=$(NTE_DBCLUSTER_FINALSNAPSHOT_SKIP)'
	@echo '    NTE_DBCLUSTER_IAM_AUTHENTICATION=$(NTE_DBCLUSTER_IAM_AUTHENTICATION)'
	@echo '    NTE_DBCLUSTER_IDENTIFIER=$(NTE_DBCLUSTER_IDENTIFIER)'
	@echo '    NTE_DBCLUSTER_KMSKEY_ID=$(NTE_DBCLUSTER_KMSKEY_ID)'
	@echo '    NTE_DBCLUSTER_KMSKEY_ID=$(NTE_DBCLUSTER_KMSKEY_ID)'
	@echo '    NTE_DBCLUSTER_MAINTENANCE_WINDOW=$(NTE_DBCLUSTER_MAINTENANCE_WINDOW)'
	@echo '    NTE_DBCLUSTER_MASTER_PASSWORD=$(NTE_DBCLUSTER_MASTER_PASSWORD)'
	@echo '    NTE_DBCLUSTER_MASTER_USERNAME=$(NTE_DBCLUSTER_MASTER_USERNAME)'
	@echo '    NTE_DBCLUSTER_SOURCE_REGION=$(NTE_DBCLUSTER_SOURCE_REGION)'
	@echo '    NTE_DBCLUSTER_STORAGE_ENCRYPTED=$(NTE_DBCLUSTER_STORAGE_ENCRYPTED)'
	@echo '    NTE_DBCLUSTER_TAGS=$(NTE_DBCLUSTER_TAGS)'
	@echo '    NTE_DBCLUSTER_VPCSECURITYGROUP_IDS=$(NTE_DBCLUSTER_VPCSECURITYGROUP_IDS)'
	@echo '    NTE_DBCLUSTERS_FILTERS=$(NTE_DBCLUSTERS_FILTERS)'
	@echo

_nte_view_framework_targets ::
	@echo 'AWS::NepTunE::DbCluster ($(_AWS_NEPTUNE_DBCLUSTER_MK_VERSION)) targets:'
	@echo '    _nte_create_dbcluster                  - Create a db-cluster'
	@echo '    _nte_delete_dbcluster                  - Delete a db-cluster'
	@echo '    _nte_show_dbcluster                    - Show details of a db-cluster'
	@echo '    _nte_show_dbcluster_instances          - Show instances of a db-cluster'
	@echo '    _nte_show_dbcluster_overview           - Show overview of a db-cluster'
	@echo '    _nte_view_dbclusters                   - View db-clusters'
	@echo '    _nte_view_dbclusters_set               - View a db-clusters set'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_nte_create_dbcluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB-cluster "$(NTE_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'With neptune, several parameters are set at the dbcluster level instead of the instance one: database_name, ...'; $(NORMAL)
	$(AWS) neptune create-db-cluster $(__NTE_AVAILABILITY_ZONES) $(__NTE_BACKUP_RETENTION_PERIOD__DBCLUSTER) $(__NTE_CHARACTER_SET_NAME__DBCLUSTER) $(__NTE_DATABASE_NAME__DBCLUSTER) $(__NTE_DB_CLUSTER_IDENTIFIER) $(__NTE_DB_CLUSTER_PARAMETER_GROUP_NAME) $(__NTE_DB_SUBNET_GROUP_NAME__DBCLUSTER) $(__NTE_ENABLE_IAM_DATABASE_AUTHENTICATION) $(__NTE_ENGINE__DBCLUSTER) $(__NTE_ENGINE_VERSION__DBCLUSTER) $(__NTE_KMS_KEY_ID__DBCLUSTER) $(__NTE_MASTER_USER_PASSWORD__DBCLUSTER) $(__NTE_MASTER_USERNAME__DBCLUSTER) $(__NTE_OPTION_GROUP_NAME) $(__NTE_PORT__DBCLUSTER) $(__NTE_PRE_SIGNED_URL) $(__NTE_PREFERRED_BACKUP_WINDOW__DBCLUSTER) $(__NTE_PREFERRED_MAINTENANCE_WINDOW__DBCLUSTER) $(__NTE_REPLICATION_SOURCE_IDENTIFIER) $(__NTE_SOURCE_REGION) $(__NTE_STORAGE_ENCRYPTED) $(__NTE_TAGS__DBCLUSTER) $(__NTE_VPC_SECURITY_GROUP_IDS__DBCLUSTER)

_nte_delete_dbcluster:
	@$(INFO) '$(AWS_UI_LABEL)Delete DB-cluster "$(NTE_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) neptune delete-db-cluster $(__NTE_DB_CLUSTER_IDENTIFIER) $(__NTE_FINAL_DB_SNAPSHOT_IDENTIFIER) $(__NTE_SKIP_FINAL_SNAPSHOT)

_nte_show_dbcluster: _nte_show_dbcluster_instances _nte_show_dbcluster_description

_nte_show_dbcluster_instances:
	@$(INFO) '$(AWS_UI_LABEL)Showing instances in DB-cluster "$(NTE_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) neptune describe-db-instances  --query "DBInstances[?DBClusterIdentifier=='$(NTE_DBCLUSTER_IDENTIFIER)']$(NTE_UI_SHOW_DBCLUSTER_INSTANCES_FIELDS)"

_nte_show_dbcluster_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of DB-cluster "$(NTE_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) neptune describe-db-clusters $(__NTE_DB_CLUSTER_IDENTIFIER) $(_X__NTE_FILTERS__DBCLUSTERS) --query "DBClusters[]"

_nte_view_dbclusters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-clusters ...'; $(NORMAL)
	$(AWS) neptune describe-db-clusters $(_X__NTE_DB_CLUSTER_IDENTIFIER) $(__NTE_FILTERS__DBCLUSTERS) --query "DBClusters[]$(NTE_UI_VIEW_DBCLUSTERS_FIELDS)"

_X_nte_view_dbclusters_set:
