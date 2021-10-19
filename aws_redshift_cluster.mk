_AWS_REDSHIFT_MK_VERSION=0.99.6

# RST_CLUSTER_ADDITIONAL_INFO?= "This  is additional information"
RST_CLUSTER_ALLOW_UPGRADE?= true
RST_CLUSTER_AUTOMATEDSNAPSHOT_RETENTIONPERIOD?= 1
# RST_CLUSTER_AVAILABILITY_ZONE?= us-east-1a
RST_CLUSTER_DATABASE_ENCRYPTED?= false
# RST_CLUSTER_DATABASE_HOST?= examplecluster.cenibrw6lu0e.us-east-1.redshift.amazonaws.com
RST_CLUSTER_DATABASE_NAME?= dev
RST_CLUSTER_DATABASE_PORT?= 5439
# RST_CLUSTER_ELASTIC_IP?=
# RST_CLUSTER_ENDPOINT?=
# RST_CLUSTER_HSMCLIENTCERTIFICATE_IDENTIFIER?=
# RST_CLUSTER_HSMCONFIGURATION_IDENTIFIER?=
# RST_CLUSTER_IAM_ROLES?= myRedshiftRole 
# RST_CLUSTER_IDENTIFIER?= examplecluster
# RST_CLUSTER_KMSKEY_ID?=
# RST_CLUSTER_MAINTENANCE_WINDOW?=wed:04:00-wed:04:30
# RST_CLUSTER_MASTERUSER_PASSWORD?= my_password
# RST_CLUSTER_MASTERUSER_NAME?= my_username
# RST_CLUSTER_NODE_TYPE?= dc1.large
# RST_CLUSTER_PARAMETERGROUP_NAME?= default.redshift-1.0
RST_CLUSTER_PUBLICLY_ACCESSIBLE?= false
# RST_CLUSTER_SIZE?= 1
# RST_CLUSTER_SECURITY_GROUPS?=
# RST_CLUSTER_SUBNETGROUP_NAME?= default
# RST_CLUSTER_TAG_KEYS?=
# RST_CLUSTER_TAG_VALUES?=
# RST_CLUSTER_TAGS?=
# RST_CLUSTER_TYPE?= multi-node
# RST_CLUSTER_VERSION?= 1.0
# RST_CLUSTER_VPCSECURITYGROUP_IDS= sg-12345678 ...

# Derived parameters
RST_CLUSTER_ENDPOINT?= $(RST_CLUSTER_DATABASE_HOST):$(RST_CLUSTER_DATABASE_PORT)

# Option parameters
__RST_ADDITIONAL_INFO= $(if $(RST_CLUSTER_ADDITIONAL_INFO), --additional-info $(RST_CLUSTER_ADDITIONAL_INFO))
__RST_AUTOMATED_SNAPSHOT_RETENTION_PERIOD= $(if $(RST_CLUSTER_AUTOMATEDSNAPSHOT_RETENTIONPERIOD), --automated-snapshot-retention-period $(RST_CLUSTER_AUTOMATEDSNAPSHOT_RETENTION_PERIOD))
__RST_ALLOW_VERSION_UPGRADE= $(if $(filter false, $(RST_CLUSTER_ALLOW_UPGRADE)), --no-allow-version-upgrade, --allow-version-upgrade)
__RST_AVAILABILITY_ZONE= $(if $(RST_CLUSTER_AVAILABILITY_ZONE), --availability-zone $(RST_CLUSTER_AVAILABILITY_ZONE))
__RST_CLUSTER_IDENTIFIER= $(if $(RST_CLUSTER_IDENTIFIER), --cluster-identifier $(RST_CLUSTER_IDENTIFIER))
__RST_CLUSTER_PARAMETER_GROUP_FAMILY= $(if $(RST_CLUSTER_PARAMETER_GROUP_FAMILY), --cluster-parameter-group-family $(RST_CLUSTER_PARAMETER_GROUP_FAMILY))
__RST_CLUSTER_PARAMETER_GROUP_NAME= $(if $(RST_CLUSTER_PARAMETERGROUP_NAME), --cluster-parameter-group-name $(RST_CLUSTER_PARAMETERGROUP_NAME))
__RST_CLUSTER_SECURITY_GROUPS= $(if $(RST_CLUSTER_SECURITY_GROUPS), --cluster-security-groups $(RST_CLUSTER_SECURITY_GROUPS))
__RST_CLUSTER_SUBNET_GROUP_NAME= $(if $(RST_CLUSTER_SUBNETGROUP_NAME), --cluster-subnet-group-name $(RST_CLUSTER_SUBNETGROUP_NAME))
__RST_CLUSTER_TYPE= $(if $(RST_CLUSTER_TYPE), --cluster-type $(RST_CLUSTER_TYPE))
__RST_CLUSTER_VERSION= $(if $(RST_CLUSTER_VERSION), --cluster-version $(RST_CLUSTER_VERSION))
__RST_DB_NAME= $(if $(RST_CLUSTER_DATABASE_NAME), --db-name $(RST_CLUSTER_DATABASE_NAME))
__RST_ELASTIC_IP= $(if $(RST_CLUSTER_ELASTIC_IP), --elastic-ip $(RST_CLUSTER_ELASTIC_IP))
__RST_ENCRYPTED= $(if $(RST_CLUSTER_DATABASE_NAME), --db-name $(RST_CLUSTER_DATABASE_NAME))
__RST_END_TIME= $(if $(RST_SNAPSHOT_END_TIME), --end-time $(RST_SNAPSHOT_END_TIME))
__RST_FINAL_CLUSTER_SNAPSHOT_IDENTIFIER= $(if $(filter true, $(RST_SNAPSHOT_ON_DELETE)), --final-cluster-snapshot-identifier $(RST_SNAPSHOT_IDENTIFIER))
__RST_HSM_CLIENT_CERTIFICATE_IDENTIFIER= $(if $(RST_CLUSTER_HSMCLIENTCERTIFICATE_IDENTIFIER), --hsm-client-certificate-identifier $(RST_CLUSTER_HSMCLIENTCERTIFICATE_IDENTIFIER))
__RST_HSM_CONFIGURATION_IDENTIFIER= $(if $(RST_CLUSTER_HSMCONFIGURATION_IDENTIFIER), --hsm-configuration-identifier $(RST_CLUSTER_HSMCONFIGURATION_IDENTIFIER))
__RST_IAM_ROLES= $(if $(RST_CLUSTER_IAM_ROLES), --iam-roles $(RST_CLUSTER_IAM_ROLES))
__RST_KMS_KEY_ID= $(if $(RST_CLUSTER_KMSKEY_ID), --kms-key-id $(RST_CLUSTER_KMSKEY_ID))
__RST_MASTER_USER_PASSWORD= $(if $(RST_CLUSTER_MASTERUSER_PASSWORD), --master-user-password $(RST_CLUSTER_MASTERUSER_PASSWORD))
__RST_MASTER_USERNAME= $(if $(RST_CLUSTER_MASTERUSER_NAME), --master-username $(RST_CLUSTER_MASTERUSER_NAME))
__RST_NODE_TYPE= $(if $(RST_CLUSTER_NODE_TYPE), --node-type $(RST_CLUSTER_NODE_TYPE))
__RST_NUMBER_OF_NODES= $(if $(RST_CLUSTER_SIZE), --number-of-nodes $(RST_CLUSTER_SIZE))
__RST_OWNER_ACCOUNT= $(if $(RST_SNAPSHOT_OWNER), --owner-account $(RST_SNAPSHOT_OWNER))
__RST_PARAMETER_GROUP_NAME= $(if $(RST_CLUSTER_PARAMETERGROUP_NAME), --parameter-group-name $(RST_CLUSTER_PARAMETERGROUP_NAME))
__RST_PORT= $(if $(RST_CLUSTER_DATABASE_PORT), --port $(RST_CLUSTER_DATABASE_PORT))
__RST_PREFERRED_MAINTENANCE_WINDOW= $(if $(RST_CLUSTER_MAINTENANCE_WINDOW), --preferred-maintenance-window $(RST_CLUSTER_MAINTENANCE_WINDOW))
__RST_PUBLICLY_ACCESSIBLE= $(if $(filter true, $(RST_CLUSTER_PUBLICLY_ACCESSIBLE)), --publicly-accessible, --no-publicly-accessible)
__RST_RESOURCE_NAME=
__RST_RESOURCE_TYPE=
__RST_SOURCE_IDENTIFIER= $(if $(RST_SOURCE_IDENTIFIER), --source-identifier $(RST_SOURCE_IDENTIFIER))
__RST_SKIP_FINAL_CLUSTER_SNAPSHOT= $(if $(filter true, $(RST_SNAPSHOT_ON_DELETE)), --no-skip-final-cluster-snapshot, --skip-final-cluster-snapshot)
__RST_SNAPSHOT_IDENTIFIER= $(if $(RST_SNAPSHOT_IDENTIFIER), --snapshot-identifier $(RST_SNAPSHOT_IDENTIFIER))
__RST_START_TIME= $(if $(RST_SNAPSHOT_START_TIME), --start-time $(RST_SNAPSHOT_START_TIME))
__RST_TAG_KEYS= $(if $(RST_TAG_KEYS), --tag-keys $(RST_TAG_KEYS))
__RST_TAG_VALUES= $(if $(RST_TAG_VALUES), --tag-values $(RST_TAG_VALUES))
__RST_TAGS_CLUSTER= $(if $(RST_CLUSTER_TAGS), --tags $(RST_CLUSTER_TAGS))
__RST_VPC_SECURITY_GROUP_IDS= $(if $(RST_VPC_SECURITY_GROUP_IDS), --vpc-security-group-ids $(RST_CLUSTER_VPCSECURITYGROUP_IDS))

# UI parameters
RST_UI_SHOW_CLUSTER_FIELDS?= .{ClusterCreateTime:ClusterCreateTime,ClusterIdentifier:ClusterIdentifier,DBName:DBName,MasterUsername:MasterUsername,VpcId:VpcId,AvailabilityZone:AvailabilityZone,NodeType:NodeType,NumberOfNodes:NumberOfNodes,ClusterStatus:ClusterStatus}
RST_UI_VIEW_CLUSTERS_FIELDS?= .{ClusterCreateTime:ClusterCreateTime,ClusterIdentifier:ClusterIdentifier,DBName:DBName,MasterUsername:MasterUsername,VpcId:VpcId,AvailabilityZone:AvailabilityZone,NodeType:NodeType,NumberOfNodes:NumberOfNodes,ClusterStatus:ClusterStatus}
RST_UI_VIEW_CLUSTER_SNAPSHOTS_FIELDS?= .{SnapshotCreateTime:SnapshotCreateTime,ClusterIdentifier:ClusterIdentifier,SnapshotIdentifier:SnapshotIdentifier,SnapshotType:SnapshotType,Status:Status}

#--- MACROS
_rst_get_cluster_database_name_I= $(call _rst_get_cluster_parameter_IP, $(1), DBName)
_rst_get_cluster_database_host_I= $(call _rst_get_cluster_parameter_IP, $(1), Endpoint.Address)
_rst_get_cluster_database_port_I= $(call _rst_get_cluster_parameter_IP, $(1), Endpoint.Port)
_rst_get_cluster_parameter_IP= $(shell $(AWS) redshift describe-clusters --cluster-identifier $(1) --query "Clusters[].$(strip $(2))" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _rst_view_framework_macros
_rst_view_framework_macros:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) macros:'
	@echo '    _rst_get_cluster_database_host_I    - Get the database host (Identifier)'
	@echo '    _rst_get_cluster_database_name_I    - Get the database name (Identifier)'
	@echo '    _rst_get_cluster_database_port_I    - Get the database port (Identifier)'
	@echo

_aws_view_framework_parameters :: _rst_view_framework_parameters
_rst_view_framework_parameters:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) parameters:'
	@echo '    RST_CLUSTER_ADDITIONAL_INFO=$(RST_CLUSTER_ADDITIONAL_INFO)'
	@echo '    RST_CLUSTER_ALLOW_UPGRADE=$(RST_CLUSTER_ALLOW_UPGRADE)'
	@echo '    RST_CLUSTER_AUTOMATEDSNAPSHOT_RETENTIONPERIOD=$(RST_CLUSTER_AUTOMATEDSNAPSHOT_RETENTIONPERIOD)'
	@echo '    RST_CLUSTER_AVAILABILITY_ZONE=$(RST_CLUSTER_AVAILABILITY_ZONE)'
	@echo '    RST_CLUSTER_DATABASE_NAME=$(RST_CLUSTER_DATABASE_NAME)'
	@echo '    RST_CLUSTER_DATABASE_PORT=$(RST_CLUSTER_DATABASE_PORT)'
	@echo '    RST_CLUSTER_ELASTIC_IP=$(RST_CLUSTER_ELASTIC_IP)'
	@echo '    RST_CLUSTER_ENDPOINT=$(RST_CLUSTER_ENDPOINT)'
	@echo '    RST_CLUSTER_HSMCLIENTCERTIFICATE_IDENTIFIER=$(RST_CLUSTER_HSMCLIENTCERTIFICATE_IDENTIFIER)'
	@echo '    RST_CLUSTER_HSMCONFIGURATION_IDENTIFIER=$(RST_CLUSTER_HSMCONFIGURATION_IDENTIFIER)'
	@echo '    RST_CLUSTER_IAM_ROLES=$(RST_CLUSTER_IAM_ROLES)'
	@echo '    RST_CLUSTER_IAM_ROLES=$(RST_CLUSTER_IAM_ROLES)'
	@echo '    RST_CLUSTER_IDENTIFIER=$(RST_CLUSTER_IDENTIFIER)'
	@echo '    RST_CLUSTER_KMSKEY_ID=$(RST_CLUSTER_KMSKEY_ID)'
	@echo '    RST_CLUSTER_MAINTENANCE_WINDOW=$(RST_CLUSTER_MAINTENANCE_WINDOW)'
	@echo '    RST_CLUSTER_MASTERUSER_PASSWORD=$(RST_CLUSTER_MASTERUSER_PASSWORD)'
	@echo '    RST_CLUSTER_MASTERUSER_NAME=$(RST_CLUSTER_MASTERUSER_NAME)'
	@echo '    RST_CLUSTER_NODE_TYPE=$(RST_CLUSTER_NODE_TYPE)'
	@echo '    RST_CLUSTER_PARAMETERGROUP_NAME=$(RST_CLUSTER_PARAMETERGROUP_NAME)'
	@echo '    RST_CLUSTER_PUBLICLY_ACCESSIBLE=$(RST_CLUSTER_PUBLICLY_ACCESSIBLE)'
	@echo '    RST_CLUSTER_SECURITY_GROUP=$(RST_CLUSTER_SECURITY_GROUP)'
	@echo '    RST_CLUSTER_SIZE=$(RST_CLUSTER_SIZE)'
	@echo '    RST_CLUSTER_SUBNETGROUP_NAME=$(RST_CLUSTER_SUBNETGROUP_NAME)'
	@echo '    RST_CLUSTER_TAGS=$(RST_CLUSTER_TAGS)'
	@echo '    RST_CLUSTER_TYPE=$(RST_CLUSTER_TYPE)'
	@echo '    RST_CLUSTER_VERSION=$(RST_CLUSTER_VERSION)'
	@echo '    RST_CLUSTER_VPCSECURITYGROUP_IDS=$(RST_CLUSTER_VPCSECURITYGROUP_IDS)'
	@echo '    RST_CLUSTERS_SET_NAME=$(RST_CLUSTERS_SET_NAME)'
	@echo

_aws_view_framework_targets :: _rst_view_framework_targets
_rst_view_framework_targets:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) targets:'
	@echo '    _rst_create_cluster                 - Create a redshift cluster'
	@echo '    _rst_delete_cluster                 - Delete a redshift cluster'
	@echo '    _rst_show_cluster                   - Show everything related to a redshift cluster'
	@echo '    _rst_show_cluster_description       - Show description of a redshift cluster'
	@echo '    _rst_show_cluster_loggingstatus     - Show logging status of a redshift cluster'
	@echo '    _rst_show_cluster_resize            - Show resize of a redshift cluster'
	@echo '    _rst_show_cluster_snapshot          - Show details of a snapshot of a redshift cluster'
	@echo '    _rst_show_cluster_tags              - Show tags of a cluster'
	@echo '    _rst_view_cluster_parameters        - View parameters of a parameter group'
	@echo '    _rst_view_cluster_snapshots         - View snapshots of a cluster'
	@echo '    _rst_view_clusters                  - View redshift clusters'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rst_create_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating a RedShift clusters "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift create-cluster $(__RST_ADDITIONAL_INFO) $(__RST_ALLOW_VERSION_UPGRADE) $(__RST_AUTOMATED_SNAPSHOT_RETENTION_PERIOD) $(__RST_AVAILABILITY_ZONE) $(__RST_CLUSTER_IDENTIFIER) $(__RST_CLUSTER_PARAMETER_GROUP_NAME) $(__RST_CLUSTER_SECURITY_GROUPS) $(__RST_CLUSTER_SUBNET_GROUP_NAME) $(__RST_CLUSTER_TYPE) $(__RST_DB_NAME) $(__RST_ELASTIC_IP) $(__RST_ENCRYPTED) $(__RST_ENHANCED_VPC_ROUTING) $(__RST_HSM_CLIENT_CERTIFICATE_IDENTIFIER) $(__RST_HSM_CONFIGURATION_IDENTIFIER) $(__RST_IAM_ROLES) $(__KMS_KEY_ID) $(__RST_MASTER_USER_PASSWORD) $(__RST_MASTER_USERNAME) $(__RST_NODE_TYPE) $(__RST_NUMBER_OF_NODES) $(__RST_PORT) $(__RST_PREFERRED_MAINTENANCE_WINDOW) $(__RST_PUBLICLY_ACCESSIBLE) $(__RST_TAG_CLUSTER) $(__RST_VPC_SECURITY_GROUP_IDS)

_rst_delete_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Deleting RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	@$(if $(filter-out true, $(RST_SNAPSHOT_ON_DELETE)), $(WARN) 'No snapshot required before deletion ...'; $(NORMAL))
	$(AWS) redshift delete-cluster $(__RST_CLUSTER_IDENTIFIER) $(__RST_FINAL_CLUSTER_SNAPSHOT_IDENTIFIER) $(__RST_SKIP_FINAL_CLUSTER_SNAPSHOT)

_rst_show_cluster: _rst_show_cluster_loggingstatus _rst_show_cluster_resize _rst_show_cluster_snapshots _rst_show_cluster_tags _rst_show_description

_rst_show_cluster_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift describe-clusters $(__RST_CLUSTER_IDENTIFIER) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Clusters[]$(RST_UI_SHOW_CLUSTER_FIELDS)"

_rst_show_cluster_loggingstatus:
	@$(INFO) '$(AWS_UI_LABEL)Showing logging-status of RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift describe-logging-status $(__RST_CLUSTER_IDENTIFIER)

_rst_show_cluster_resize:
	@$(INFO) '$(AWS_UI_LABEL)Showing resize of RedShift "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	@$(WARN) 'No resize --> an error is returned!'; $(NORMAL)
	-$(AWS) redshift describe-resize $(__RST_CLUSTER_IDENTIFIER)

_rst_show_cluster_snapshot:
	@$(INFO) '$(AWS_UI_LABEL)Show details for snapshot "$(RST_SNAPSHOT_IDENTIFIER)" of cluster "$(RST_CLUSTER_IDENTIFIER)"  ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-snapshots $(_X__RST_CLUSTER_IDENTIFIER) $(__RST_END_TIME) $(__RST_OWNER_ACCOUNT) $(__RST_SNAPSHOT_IDENTIFIER) $(__RST_SNAPSHOT_TYPE) $(__RST_START_TIME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Snapshots[]$(RST_SHOW_CLUSTER_SNAPSHOT_FIELDS)"

_rst_show_cluster_snapshots:
	@$(INFO) '$(AWS_UI_LABEL)View cluster snapshots ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-snapshots $(__RST_CLUSTER_IDENTIFIER) $(__RST_END_TIME) $(__RST_OWNER_ACCOUNT) $(_X__RST_SNAPSHOT_IDENTIFIER) $(__RST_SNAPSHOT_TYPE) $(__RST_START_TIME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Snapshots[]$(RST_UI_VIEW_CLUSTER_SNAPSHOTS_FIELDS)"

_rst_show_cluster_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift describe-tags $(__RST_RESOURCE_NAME) $(__RST_RESOURCE_TYPE) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES)

_rst_view_clusters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing RedShift clusters ...'; $(NORMAL)
	$(AWS) redshift describe-clusters $(_X__RST_CLUSTER_IDENTIFIER) $(_X__RST_TAG_KEYS) $(_X__RST_TAG_VALUES) --query "Clusters[]$(RST_UI_VIEW_CLUSTERS_FIELDS)"

_rst_view_clusters_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing set of RedShift clusters "$(RST_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Redshift clusters are grouped based on tags'; $(NORMAL)
	$(AWS) redshift describe-clusters $(_X__RST_CLUSTER_IDENTIFIER) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Clusters[]$(RST_UI_VIEW_CLUSTERS_FIELDS)"
