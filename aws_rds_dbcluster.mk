_AWS_RDS_DBCLUSTER_MK_VERSION= $(_AWS_RDS_MK_VERSION)

# RDS_DBCLUSTER_AVAILABILITY_ZONES?=
# RDS_DBCLUSTER_BACKTRACK_WINDOW?=
RDS_DBCLUSTER_BACKUP_RETENTION?= 1
# RDS_DBCLUSTER_BACKUP_WINDOW?= 07:23-07:53
# RDS_DBCLUSTER_CHARACTERSET_NAME?=
# RDS_DBCLUSTER_DATABASE_ENGINE?= aurora-mysql
# RDS_DBCLUSTER_DATABASE_PORT?= 3306
# RDS_DBCLUSTER_DATABASE_VERSION?=
# RDS_DBCLUSTER_DBSUBNETGROUP_NAME?= my-aurora-db-subnet-group
# RDS_DBCLUSTER_ENDPOINT_RO?= my-aurora-cluster.cluster-ro-cnjdk6gtaegw.us-west-2.rds.amazonaws.com
# RDS_DBCLUSTER_ENDPOINT_RW?= my-aurora-cluster.cluster-cnjdk6gtaegw.us-west-2.rds.amazonaws.com
# RDS_DBCLUSTER_FINALSNAPSHOT_IDENTIFIER?= my-final-snapshot
RDS_DBCLUSTER_FINALSNAPSHOT_SKIP?= false
RDS_DBCLUSTER_IAM_AUTHENTICATION?= false
# RDS_DBCLUSTER_IDENTIFIER?= my-aurora-db-cluster
# RDS_DBCLUSTER_KMSKEY_ID?=
# RDS_DBCLUSTER_MAINTENANCE_WINDOW?= fri:10:21-fri:10:51
# RDS_DBCLUSTER_SOURCE_REGION?=
RDS_DBCLUSTER_STORAGE_ENCRYPTED?= false
# RDS_DBCLUSTER_TAGS?= Key=string,Value=string ...
# RDS_DBCLUSTER_VPCSECURITYGROUP_IDS?=

# Derived variables
RDS_DBCLUSTER_DBSUBNETGROUP_NAME?= $(RDS_DBSUBNETGROUP_NAME)
RDS_DBCLUSTER_VPCSECURITYGROUP_IDS?= $(EC2_SECURITYGROUP_IDS)

# Options variables
__RDS_AVAILABILITY_ZONES= $(if $(RDS_DBCLUSTER_AVAILABILITY_ZONES), --availability-zone $(RDS_DBCLUSTER_AVAILABILITY_ZONES))
__RDS_BACKTRACK_WINDOW= $(if $(RDS_DBCLUSTER_BACKTRACK_WINDOW), --backtrack-window $(RDS_DBCLUSTER_BACKTRACK_WINDOW))
__RDS_BACKUP_RETENTION_PERIOD_DBCLUSTER= $(if $(RDS_DBCLUSTER_BACKUP_RETENTION), --backup-retention-period $(RDS_DBCLUSTER_BACKUP_RETENTION))
__RDS_CHARACTER_SET_NAME_DBCLUSTER= $(if $(RDS_DBCLUSTER_CHARACTERSET_NAME), --character-set-name $(RDS_DBCLUSTER_CHARACTER_SET))
__RDS_DATABASE_NAME_DBCLUSTER= $(if $(RDS_DBCLUSTER_DATABASE_NAME), --database-name $(RDS_DBCLUSTER_DATABASE_NAME))
__RDS_DB_CLUSTER_IDENTIFIER= $(if $(RDS_DBCLUSTER_IDENTIFIER), --db-cluster-identifier $(RDS_DBCLUSTER_IDENTIFIER))
__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME=
__RDS_DB_SUBNET_GROUP_NAME_DBCLUSTER= $(if $(RDS_DBCLUSTER_DBSUBNETGROUP_NAME), --db-subnet-group-name $(RDS_DBCLUSTER_DBSUBNETGROUP_NAME))
__RDS_ENABLE_IAM_DATABASE_AUTHENTICATION= $(if $(filter true, $(RDS_DBCLUSTER_IAM_AUTHENTICATION)), --enable-iam-data-authentication, --no-enable-iam-data-authentication)
__RDS_ENGINE_DBCLUSTER= $(if $(RDS_DBCLUSTER_DATABASE_ENGINE), --engine $(RDS_DBCLUSTER_DATABASE_ENGINE))
__RDS_ENGINE_VERSION_DBCLUSTER= $(if $(RDS_DBCLUSTER_DATABASE_VERSION), --engine-version $(RDS_DBCLUSTER_DATABASE_VERSION))
__RDS_FINAL_DB_SNAPSHOT_IDENTIFIER= $(if $(RDS_FINALSNAPSHOT_IDENTIFIER), --final-db-snapshot-identifier $(RDS_FINALSANPSHOT_IDENTIFIER))
__RDS_KMS_KEY_ID_DBCLUSTER= $(if $(RDS_DBCLUSTER_KMSKEY_ID), --kms-key-id $(RDS_DBCLUSTER_KMSKEY_ID))
__RDS_MASTER_USER_PASSWORD_DBCLUSTER= $(if $(RDS_DBCLUSTER_MASTER_PASSWORD), --master-user-password $(RDS_DBCLUSTER_MASTER_PASSWORD))
__RDS_MASTER_USERNAME_DBCLUSTER= $(if $(RDS_DBCLUSTER_MASTER_USERNAME), --master-username $(RDS_DBCLUSTER_MASTER_USERNAME))
__RDS_OPTION_GROUP_NAME=
__RDS_PORT_DBCLUSTER= $(if $(RDS_DBCLUSTER_DATABASE_PORT), --port $(RDS_DBCLUSTER_DATABASE_PORT))
__RDS_PRE_SIGNED_URL=
__RDS_PREFERRED_BACKUP_WINDOW_DBCLUSTER= $(if $(RDS_DBCLUSTER_BACKUP_WINDOW), --backup-window $(RDS_DBCLUSTER_BACKUP_WINDOW))
__RDS_PREFERRED_MAINTENANCE_WINDOW_DBCLUSTER= $(if $(RDS_DBCLUSTER_MAINTENANCE_WINDOW), --preferred-maintenance-window $(RDS_DBCLUSTER_MAINTENANCE_WINDOW))
__RDS_REPLICATION_SOURCE_IDENTIFIER=
__RDS_SKIP_FINAL_SNAPSHOT= $(if $(filter true, $(RDS_DBCLUSTER_FINALSNAPSHOT_SKIP)), --skip-final-snapshot, --no-skip-final-snapshot)
__RDS_SOURCE_REGION= $(if $(RDS_DBCLUSTER_SOURCE_REGION), --source-region $(RDS_DBCLUSTER_SOURCE_REGION))
__RDS_STORAGE_ENCRYPTED= $(if $(filter true, $(RDS_DBCLUSTER_STORAGE_ENCRYPTED)), --storage-encrypted, --no-storage-encrypted)
__RDS_TAGS_DBCLUSTER= $(if $(RDS_DBCLUSTER_TAGS), --tags $(RDS_DBCLUSTER_TAGS))
__RDS_VPC_SECURITY_GROUP_IDS_DBCLUSTER= $(if $(RDS_DBCLUSTER_VPCSECURITYGROUP_IDS), --vpc-security-group-ids $(RDS_DBCLUSTER_VPCSECURITYGROUP_IDS), T)

# UI variables
RDS_UI_SHOW_DBCLUSTER_INSTANCES_FIELDS?= $(RDS_UI_VIEW_INSTANCES_FIELDS)
RDS_UI_VIEW_DBCLUSTERS_FIELDS?= .{DBClusterIdentifier:DBClusterIdentifier,dBClusterParameterGroup:DBClusterParameterGroup,dBSubnetGroup:DBSubnetGroup,DbClusterResourceId:DbClusterResourceId,engine:Engine}

#--- Utilities

#--- MACROS

_rds_get_dbcluster_endpoint_ro= $(call _rds_get_dbcluster_endpoint_ro_I, $(RDS_DBCLUSTER_IDENTIFIER))
_rds_get_dbcluster_endpoint_ro_I= $(shell $(AWS) rds describe-db-clusters  --db-cluster-identifier $(1)  --query "DBClusters[].ReaderEndpoint" --output text)

_rds_get_dbcluster_endpoint_rw= $(call _rds_get_dbcluster_endpoint_rw_I, $(RDS_DBCLUSTER_IDENTIFIER))
_rds_get_dbcluster_endpoint_rw_I= $(shell $(AWS) rds describe-db-clusters --db-cluster-identifier $(1) --query "DBClusters[].Endpoint" --output text)

#----------------------------------------------------------------------
# USAGE
#

_rds_view_makefile_macros ::
	@echo 'AWS::RDS::DbCluster ($(_AWS_RDS_DBCLUSTER_MK_VERSION)) macros:'
	@echo '    _rds_get_dbcluster_endopint_ro_{|I}    - Get the RO endpoint of a db-cluster (Identifier)'
	@echo '    _rds_get_dbcluster_endopint_rw_{|I}    - Get the RW endpoint of a db-cluster (Identifier)'
	@echo

_rds_view_makefile_targets ::
	@echo 'AWS::RDS::DbCluster ($(_AWS_RDS_DBCLUSTER_MK_VERSION)) targets:'
	@echo '    _rds_create_dbcluster                  - Create a db-cluster'
	@echo '    _rds_delete_dbcluster                  - Delete a db-cluster'
	@echo '    _rds_mysql_dbcluster_ro                - Establish read-only connection to db-cluster using mysql'
	@echo '    _rds_mysql_dbcluster_rw                - Establish read/write connection to db-cluster using mysql'
	@echo '    _rds_show_dbcluster                    - Show details of a db-cluster'
	@echo '    _rds_show_dbcluster_instances          - Show instances of a db-cluster'
	@echo '    _rds_show_dbcluster_overview           - Show overview of a db-cluster'
	@echo '    _rds_view_dbclusters                   - View db-clusters'
	@echo '    _rds_view_dbclusters_set               - View a db-clusters set'
	@echo

_rds_view_makefile_variables ::
	@echo 'AWS::RDS::DbCluster ($(_AWS_RDS_DBCLUSTER_MK_VERSION)) variables:'
	@echo '    RDS_DBCLUSTER_AVAILABILITY_ZONES=$(RDS_DBCLUSTER_AVAILABILITY_ZONES)'
	@echo '    RDS_DBCLUSTER_BACKUP_RETENTION=$(RDS_DBCLUSTER_BACKUP_RETENTION)'
	@echo '    RDS_DBCLUSTER_CHARACTERSET_NAME=$(RDS_DBCLUSTER_CHARACTERSET_NAME)'
	@echo '    RDS_DBCLUSTER_DATABASE_ENGINE=$(RDS_DBCLUSTER_DATABASE_ENGINE)'
	@echo '    RDS_DBCLUSTER_DATABASE_PORT=$(RDS_DBCLUSTER_DATABASE_PORT)'
	@echo '    RDS_DBCLUSTER_DATABASE_VERSION=$(RDS_DBCLUSTER_DATABASE_VERSION)'
	@echo '    RDS_DBCLUSTER_DBSUBNETGROUP_NAME=$(RDS_DBCLUSTER_DBSUBNETGROUP_NAME)'
	@echo '    RDS_DBCLUSTER_ENDPOINT_RO=$(RDS_DBCLUSTER_ENDPOINT_RO)'
	@echo '    RDS_DBCLUSTER_ENDPOINT_RW=$(RDS_DBCLUSTER_ENDPOINT_RW)'
	@echo '    RDS_DBCLUSTER_FINALSNAPSHOT_IDENTIFIER=$(RDS_FINALSNAPSHOT_IDENTIFIER)'
	@echo '    RDS_DBCLUSTER_FINALSNAPSHOT_SKIP=$(RDS_DBCLUSTER_FINALSNAPSHOT_SKIP)'
	@echo '    RDS_DBCLUSTER_IAM_AUTHENTICATION=$(RDS_DBCLUSTER_IAM_AUTHENTICATION)'
	@echo '    RDS_DBCLUSTER_IDENTIFIER=$(RDS_DBCLUSTER_IDENTIFIER)'
	@echo '    RDS_DBCLUSTER_KMSKEY_ID=$(RDS_DBCLUSTER_KMSKEY_ID)'
	@echo '    RDS_DBCLUSTER_KMSKEY_ID=$(RDS_DBCLUSTER_KMSKEY_ID)'
	@echo '    RDS_DBCLUSTER_MAINTENANCE_WINDOW=$(RDS_DBCLUSTER_MAINTENANCE_WINDOW)'
	@echo '    RDS_DBCLUSTER_MASTER_PASSWORD=$(RDS_DBCLUSTER_MASTER_PASSWORD)'
	@echo '    RDS_DBCLUSTER_MASTER_USERNAME=$(RDS_DBCLUSTER_MASTER_USERNAME)'
	@echo '    RDS_DBCLUSTER_SOURCE_REGION=$(RDS_DBCLUSTER_SOURCE_REGION)'
	@echo '    RDS_DBCLUSTER_STORAGE_ENCRYPTED=$(RDS_DBCLUSTER_STORAGE_ENCRYPTED)'
	@echo '    RDS_DBCLUSTER_TAGS=$(RDS_DBCLUSTER_TAGS)'
	@echo '    RDS_DBCLUSTER_VPCSECURITYGROUP_IDS=$(RDS_DBCLUSTER_VPCSECURITYGROUP_IDS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rds_connect_dbcluster:
	@$(INFO) '$(AWS_UI_LABEL)Connecting localhost to DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'This operation works only on publicly accessible clusters'; $(NORMAL)
	mysql -h $(RDS_DBCLUSTER_ENDPOINT_RW) -P $(RDS_DBCLUSTER_DATABASE_PORT) -u $(RDS_DBCLUSTER_MASTER_USERNAME) -p $(RDS_DBCLUSTER_MASTER_PASSWORD)
	# psql --host=$(RDS_DBCLUSTER_ENDPOINT_RW) --port=$(RDS_DBCLUSTER_DATABASE_PORT) --username=$(RDS_DBCLUSTER_MASTER_USERNAME) --password --dbname=$(RDS_DBCLUSTER_DATABASE_NAME) 

_rds_create_dbcluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'With aurora, several parameters are set at the dbcluster instead of the instance level: database_name, secgroup, ...'; $(NORMAL)
	$(AWS) rds create-db-cluster $(__RDS_AVAILABILITY_ZONES) $(__RDS_BACKTRACK_WINDOW) $(__RDS_BACKUP_RETENTION_PERIOD_DBCLUSTER) $(__RDS_CHARACTER_SET_NAME_DBCLUSTER) $(__RDS_DATABASE_NAME_DBCLUSTER) $(__RDS_DB_CLUSTER_IDENTIFIER) $(__RDS_DB_CLUSTER_PARAMETER_GROUP_NAME) $(__RDS_DB_SUBNET_GROUP_NAME_DBCLUSTER) $(__RDS_ENABLE_IAM_DATABASE_AUTHENTICATION) $(__RDS_ENGINE_DBCLUSTER) $(__RDS_ENGINE_VERSION_DBCLUSTER) $(__RDS_KMS_KEY_ID_DBCLUSTER) $(__RDS_MASTER_USER_PASSWORD_DBCLUSTER) $(__RDS_MASTER_USERNAME_DBCLUSTER) $(__RDS_OPTION_GROUP_NAME) $(__RDS_PORT_DBCLUSTER) $(__RDS_PRE_SIGNED_URL) $(__RDS_PREFERREDP_BACKUP_WINDOW_DBCLUSTER) $(__RDS_PREFERRED_MAINTENANCE_WINDOW_DBCLUSTER) $(__RDS_REPLICATION_SOURCE_IDENTIFIER) $(__RDS_SOURCE_REGION) $(__RDS_STORAGE_ENCRYPTED) $(__RDS_TAGS_DBCLUSTER) $(__RDS_VPC_SECURITY_GROUP_IDS_DBCLUSTER)

_rds_delete_dbcluster:
	@$(INFO) '$(AWS_UI_LABEL)Delete DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) rds delete-db-cluster $(__RDS_DB_CLUSTER_IDENTIFIER) $(__RDS_FINAL_DB_SNAPSHOT_IDENTIFIER) $(__RDS_SKIP_FINAL_SNAPSHOT)

_rds_mysql_dbcluster_ro:
	@$(INFO) '$(AWS_UI_LABEL)Connecting using mysql to DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)"...'; $(NORMAL)
	@$(WARN) 'This endpoint offers READ-ONLY access'; $(NORMAL)
	mysql --host=$(RDS_DBCLUSTER_ENDPOINT_RO) --user=$(RDS_DBCLUSTER_MASTER_USERNAME) --port=$(RDS_DBCLUSTER_DATABASE_PORT) --password $(RDS_DBCLUSTER_DATABASE_NAME)

_rds_mysql_dbcluster_rw:
	@$(INFO) '$(AWS_UI_LABEL)Connecting using mysql to DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)"...'; $(NORMAL)
	@$(WARN) 'This endpoint offers READ/WRITE access'; $(NORMAL)
	mysql --host=$(RDS_DBCLUSTER_ENDPOINT_RW) --user=$(RDS_DBCLUSTER_MASTER_USERNAME) --port=$(RDS_DBCLUSTER_DATABASE_PORT) --password $(RDS_DBCLUSTER_DATABASE_NAME)

_rds_show_dbcluster: _rds_show_dbcluster_instances _rds_show_dbcluster_overview

_rds_show_dbcluster_instances:
	@$(INFO) '$(AWS_UI_LABEL)Showing instances in DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) rds describe-db-instances  --query "DBInstances[?DBClusterIdentifier=='$(RDS_DBCLUSTER_IDENTIFIER)']$(RDS_UI_SHOW_DBCLUSTER_INSTANCES_FIELDS)"

_rds_show_dbcluster_overview:
	@$(INFO) '$(AWS_UI_LABEL)Showing DB-cluster "$(RDS_DBCLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) rds describe-db-clusters $(__RDS_DB_CLUSTER_IDENTIFIER) $(_X__RDS_FILTERS) --query "DBClusters[]"

_rds_view_dbclusters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing DB-clusters ...'; $(NORMAL)
	$(AWS) rds describe-db-clusters $(_X__RDS_DB_CLUSTER_IDENTIFIER) $(_X__RDS_FILTERS_CLUSTER) --query "DBClusters[]$(RDS_UI_VIEW_DBCLUSTERS_FIELDS)"

_rds_view_dbclusters_set:
