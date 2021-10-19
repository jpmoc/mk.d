_AWS_REDSHIFT_MK_VERSION=0.99.6

# RST_AVAILABILITY_ZONE?=us-east-1a
# RST_CLUSTER_IDENTIFIER?= examplecluster
# RST_CLUSTER_PARAMETER_GROUP_NAME?= default.redshift-1.0
# RST_CLUSTER_SIZE?= 1
# RST_CLUSTER_SECURITY_GROUPS?=
# RST_CLUSTER_SUBNET_GROUP_NAME?= default
# RST_CLUSTER_TYPE?= multi-node
# RST_CLUSTER_VERSION?= 1.0
# RST_DATABASE_HOST?= examplecluster.cenibrw6lu0e.us-east-1.redshift.amazonaws.com
RST_DATABASE_NAME?= dev
RST_DATABASE_PORT?= 5439
# RST_EVENT_DURATION?=
# RST_EVENT_END?=
# RST_EVENT_SOURCE_IDENTIFIER?=
# RST_EVENT_SOURCE_TYPE?= cluster-snapshot
# RST_EVENT_START?=
# RST_IAM_ROLES?= myRedshiftRole 
# RST_MAINTENANCE_WINDOW?=wed:04:00-wed:04:30
# RST_NODE_TYPE?= dc1.large
# RST_SNAPSHOT_END_TIME?= 2012-07-16T18:00:00Z
# RST_SNAPSHOT_IDENTIFIER?= rs:examplecluster-2018-02-17-23-32-26
# RST_SNAPSHOT_ON_DELETE?= true
# RST_SNAPSHOT_OWNER?=
# RST_SNAPSHOT_START_TIME?= 2012-07-16T18:00:00Z
# RST_SNAPSHOT_TYPE?= automated
# RST_SOURCE?= engine-default
# RST_TAG_KEYS?=
# RST_TAG_VALUES?=
# RST_USER_PASSWORD?= my_password
# RST_USER_NAME?= my_username
# RST_VPC_SECURITY_GROUP_IDS+= sg-4c9dbc38

# Derived parameters
RST_CLUSTER_ENDPOINT?= $(RST_DATABASE_HOST):$(RST_DATABASE_PORT)

# Option parameters
__RST_AVAILABILITY_ZONE= $(if $(RST_AVAILABILITY_ZONE), --availability-zone $(RST_AVAILABILITY_ZONE))
__RST_CLUSTER_IDENTIFIER= $(if $(RST_CLUSTER_IDENTIFIER), --cluster-identifier $(RST_CLUSTER_IDENTIFIER))
__RST_CLUSTER_PARAMETER_GROUP_FAMILY= $(if $(RST_CLUSTER_PARAMETER_GROUP_FAMILY), --cluster-parameter-group-family $(RST_CLUSTER_PARAMETER_GROUP_FAMILY))
__RST_CLUSTER_PARAMETER_GROUP_NAME= $(if $(RST_CLUSTER_PARAMETER_GROUP_NAME), --cluster-parameter-group-name $(RST_CLUSTER_PARAMETER_GROUP_NAME))
__RST_CLUSTER_SECURITY_GROUPS= $(if $(RST_CLUSTER_SECURITY_GROUPS), --cluster-security-groups $(RST_CLUSTER_SECURITY_GROUPS))
__RST_CLUSTER_SUBNET_GROUP_NAME= $(if $(RST_CLUSTER_SUBNET_GROUP_NAME), --cluster-subnet-group-name $(RST_CLUSTER_SUBNET_GROUP_NAME))
__RST_CLUSTER_TYPE= $(if $(RST_CLUSTER_TYPE), --cluster-type $(RST_CLUSTER_TYPE))
__RST_CLUSTER_VERSION= $(if $(RST_CLUSTER_VERSION), --cluster-version $(RST_CLUSTER_VERSION))
__RST_DB_NAME= $(if $(RST_DATABASE_NAME), --db-name $(RST_DATABASE_NAME))
__RST_DURATION= $(if $(RST_EVENT_DURATION), --duration $(RST_EVENT_DURATION))
__RST_END_TIME= $(if $(RST_SNAPSHOT_END_TIME), --end-time $(RST_SNAPSHOT_END_TIME))
__RST_FINAL_CLUSTER_SNAPSHOT_IDENTIFIER= $(if $(filter true, $(RST_SNAPSHOT_ON_DELETE)), --final-cluster-snapshot-identifier $(RST_SNAPSHOT_IDENTIFIER))
__RST_IAM_ROLES= $(if $(RST_IAM_ROLES), --iam-roles $(RST_IAM_ROLES))
__RST_MASTER_USER_PASSWORD= $(if $(RST_USER_PASSWORD), --master-user-password $(RST_USER_PASSWORD))
__RST_MASTER_USERNAME= $(if $(RST_USER_NAME), --master-username $(RST_USER_NAME))
__RST_NODE_TYPE= $(if $(RST_NODE_TYPE), --node-type $(RST_NODE_TYPE))
__RST_NUMBER_OF_NODES= $(if $(RST_CLUSTER_SIZE), --number-of-nodes $(RST_CLUSTER_SIZE))
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
__RST_VPC_SECURITY_GROUP_IDS= $(if $(RST_VPC_SECURITY_GROUP_IDS), --vpc-security-group-ids $(RST_VPC_SECURITY_GROUP_IDS))

# UI parameters
RST_UI_SHOW_CLUSTER_FIELDS?=
RST_UI_SHOW_CLUSTER_FIELDS?=.{ClusterCreateTime:ClusterCreateTime,ClusterIdentifier:ClusterIdentifier,DBName:DBName,MasterUsername:MasterUsername,VpcId:VpcId,AvailabilityZone:AvailabilityZone,NodeType:NodeType,NumberOfNodes:NumberOfNodes,ClusterStatus:ClusterStatus}
RST_UI_VIEW_CLUSTERS_FIELDS?=.{ClusterCreateTime:ClusterCreateTime,ClusterIdentifier:ClusterIdentifier,DBName:DBName,MasterUsername:MasterUsername,VpcId:VpcId,AvailabilityZone:AvailabilityZone,NodeType:NodeType,NumberOfNodes:NumberOfNodes,ClusterStatus:ClusterStatus}
RST_UI_VIEW_CLUSTER_PARAMETERS_FIELDS?= .{ParameterName:ParameterName,ParameterValue:ParameterValue,DataType:DataType,IsModifiable:IsModifiable,AllowedValues:AllowedValues,Source:Source,ApplyType:ApplyType}
RST_UI_VIEW_CLUSTER_SNAPSHOTS_FIELDS?= .{SnapshotCreateTime:SnapshotCreateTime,ClusterIdentifier:ClusterIdentifier,SnapshotIdentifier:SnapshotIdentifier,SnapshotType:SnapshotType,Status:Status}

#--- MACROS
_rst_get_database_name_I=$(call _rst_get_parameter_IP, $(1), DBName)
_rst_get_database_host_I=$(call _rst_get_parameter_IP, $(1), Endpoint.Address)
_rst_get_database_port_I=$(call _rst_get_parameter_IP, $(1), Endpoint.Port)
_rst_get_parameter_IP=$(shell $(AWS) redshift describe-clusters --cluster-identifier $(1) --query "Clusters[].$(strip $(2))" --output text)

#----------------------------------------------------------------------
# USAGE
#

_aws_view_framework_macros :: _rst_view_framework_macros
_rst_view_framework_macros:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) macros:'
	@echo '    _rst_get_database_host_I               - Get the database host given a cluster identifier'
	@echo '    _rst_get_database_name_I               - Get the database name given a cluster identifier'
	@echo '    _rst_get_database_port_I               - Get the database port given a cluster identifier'
	@echo

_aws_view_framework_targets :: _rst_view_framework_targets
_rst_view_framework_targets:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) targets:'
	@echo '    _rst_create_cluster                 - Create a redshift cluster'
	@echo '    _rst_delete_cluster                 - Delete a redshift cluster'
	@echo '    _rst_show_cluster                   - Show everything related to a redshift cluster'
	@echo '    _rst_show_cluster_description       - Show description of a redshift cluster'
	@echo '    _rst_show_cluster_logging_status    - Show logging status of a redshift cluster'
	@echo '    _rst_show_cluster_snapshot          - Show details of a snapshot of a redshift cluster'
	@echo '    _rst_view_cluster_parameter_groups  - View cluster parameter groups'
	@echo '    _rst_view_cluster_parameters        - View parameters of a parameter group'
	@echo '    _rst_view_cluster_security_groups   - View security group of a cluster'
	@echo '    _rst_view_cluster_snapshots         - View snapshots of a cluster'
	@echo '    _rst_view_cluster_subnet_groups     - View subnet groups of a cluster'
	@echo '    _rst_view_clusters                  - View redshift clusters'
	@echo '    _rst_view_events                    - View redshift events'
	@echo '    _rst_view_tags                      - View redshift tags'
	@echo 

_aws_view_framework_parameters :: _rst_view_framework_parameters
_rst_view_framework_parameters:
	@echo 'AWS::RedShifT ($(_AWS_REDSHIFT_MK_VERSION)) parameters:'
	@echo '    RST_AVAILABILITY_ZONE=$(RST_AVAILABILITY_ZONE)'
	@echo '    RST_CLUSTER_IDENTIFIER=$(RST_CLUSTER_IDENTIFIER)'
	@echo '    RST_CLUSTER_PARAMETER_GROUP_NAME=$(RST_CLUSTER_PARAMETER_GROUP_NAME)'
	@echo '    RST_CLUSTER_SECURITY_GROUP=$(RST_CLUSTER_SECURITY_GROUP)'
	@echo '    RST_CLUSTER_SIZE=$(RST_CLUSTER_SIZE)'
	@echo '    RST_CLUSTER_SUBNET_GROUP_NAME=$(RST_CLUSTER_SUBNET_GROUP_NAME)'
	@echo '    RST_CLUSTER_TYPE=$(RST_CLUSTER_TYPE)'
	@echo '    RST_CLUSTER_VERSION=$(RST_CLUSTER_VERSION)'
	@echo '    RST_DATABASE_NAME=$(RST_DATABASE_NAME)'
	@echo '    RST_DATABASE_PORT=$(RST_DATABASE_PORT)'
	@echo '    RST_EVENT_DURATION=$(RST_EVENT_DURATION)'
	@echo '    RST_EVENT_END=$(RST_EVENT_END)'
	@echo '    RST_EVENT_SOURCE_TYPE=$(RST_EVENT_SOURCE_TYPE)'
	@echo '    RST_EVENT_START=$(RST_EVENT_START)'
	@echo '    RST_IAM_ROLES=$(RST_IAM_ROLES)'
	@echo '    RST_MAINTENANCE_WINDOW=$(RST_MAINTENANCE_WINDOW)'
	@echo '    RST_NODE_TYPE=$(RST_NODE_TYPE)'
	@echo '    RST_SNAPSHOT_END_TIME=$(RST_SNAPSHOT_END_TIME)'
	@echo '    RST_SNAPSHOT_IDENTIFIER=$(RST_SNAPSHOT_IDENTIFIER)'
	@echo '    RST_SNAPSHOT_ON_DELETE=$(RST_SNAPSHOT_ON_DELETE)'
	@echo '    RST_SNAPSHOT_OWNER=$(RST_SNAPSHOT_OWNER)'
	@echo '    RST_SNAPSHOT_START_TIME=$(RST_SNAPSHOT_START_TIME)'
	@echo '    RST_SNAPSHOT_TYPE=$(RST_SNAPSHOT_TYPE)'
	@echo '    RST_SOURCE=$(RST_SOURCE)'
	@echo '    RST_USER_PASSWORD=$(RST_USER_PASSWORD)'
	@echo '    RST_USER_NAME=$(RST_USER_NAME)'
	@echo '    RST_VPC_SECURITY_GROUP_IDS=$(RST_VPC_SECURITY_GROUP_IDS)'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_rst_create_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating a RedShift clusters "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift create-cluster $(__RST_AVAILABILITY_ZONE) $(__RST_CLUSTER_IDENTIFIER) $(__RST_CLUSTER_PARAMETER_GROUP_NAME) $(__RST_CLUSTER_SECURITY_GROUPS) $(__RST_CLUSTER_SUBNET_GROUP_NAME) $(__RST_CLUSTER_TYPE) $(__RST_DB_NAME) $(__RST_IAM_ROLES) $(__RST_MASTER_USER_PASSWORD) $(__RST_MASTER_USERNAME) $(__RST_NODE_TYPE) $(__RST_NUMBER_OF_NODES) $(__RST_PORT) $(__RST_PREFERRED_MAINTENANCE_WINDOW) $(__RST_VPC_SECURITY_GROUP_IDS)

_rst_delete_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Deleting RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	@$(if $(filter-out true, $(RST_SNAPSHOT_ON_DELETE)), $(WARN) 'No snapshot required before deletion ...'; $(NORMAL))
	$(AWS) redshift delete-cluster $(__RST_CLUSTER_IDENTIFIER) $(__RST_FINAL_CLUSTER_SNAPSHOT_IDENTIFIER) $(__RST_SKIP_FINAL_CLUSTER_SNAPSHOT)

_rst_show_cluster: _rst_show_cluster_loggingstatus _rst_show_description

_rst_show_cluster_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift describe-clusters $(__RST_CLUSTER_IDENTIFIER) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Clusters[]$(RST_UI_SHOW_CLUSTER_FIELDS)"

_rst_show_cluster_loggingstatus:
	@$(INFO) '$(AWS_UI_LABEL)Showing logging-status of RedShift cluster "$(RST_CLUSTER_IDENTIFIER)" ...'; $(NORMAL)
	$(AWS) redshift describe-logging-status $(__RST_CLUSTER_IDENTIFIER)

_rst_show_cluster_snapshot:
	@$(INFO) '$(AWS_UI_LABEL)Show details for snapshot "$(RST_SNAPSHOT_IDENTIFIER)" of cluster "$(RST_CLUSTER_IDENTIFIER)"  ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-snapshots $(_X__RST_CLUSTER_IDENTIFIER) $(__RST_END_TIME) $(__RST_OWNER_ACCOUNT) $(__RST_SNAPSHOT_IDENTIFIER) $(__RST_SNAPSHOT_TYPE) $(__RST_START_TIME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Snapshots[]$(RST_SHOW_CLUSTER_SNAPSHOT_FIELDS)"

_rst_view_cluster_parameter_groups:
	@$(INFO) '$(AWS_UI_LABEL)View RedShift cluster parameter groups ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-parameter-groups $(__RST_PARAMETER_GROUP_NAME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES)

_rst_view_cluster_parameters:
	@$(INFO) '$(AWS_UI_LABEL)View cluster parameters of group "$(RST_CLUSTER_PARAMETER_GROUP_NAME)" ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-parameters $(__RST_PARAMETER_GROUP_NAME) $(__RST_SOURCE) --query "Parameters[]$(RST_UI_VIEW_CLUSTER_PARAMETERS_FIELDS)"

_rst_view_cluster_security_groups:
	@$(INFO) '$(AWS_UI_LABEL)View cluster security groups ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-security-groups $(__RST_CLUSTER_SECURITY_GROUP_NAME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES)

_rst_view_cluster_snapshots:
	@$(INFO) '$(AWS_UI_LABEL)View cluster snapshots ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-snapshots $(__RST_CLUSTER_IDENTIFIER) $(__RST_END_TIME) $(__RST_OWNER_ACCOUNT) $(_X__RST_SNAPSHOT_IDENTIFIER) $(__RST_SNAPSHOT_TYPE) $(__RST_START_TIME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Snapshots[]$(RST_UI_VIEW_CLUSTER_SNAPSHOTS_FIELDS)"

_rst_view_cluster_subnet_groups:
	@$(INFO) '$(AWS_UI_LABEL)View cluster subnet groups ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-subnet-groups $(__RST_CLUSTER_SUBNET_GROUP_NAME) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES)

_rst_view_cluster_versions:
	@$(INFO) '$(AWS_UI_LABEL)View cluster versions ...'; $(NORMAL)
	$(AWS) redshift describe-cluster-versions $(__RST_CLUSTER_PARAMETER_GROUP_FAMILY) $(__RST_CLUSTER_VERSION) --query "ClusterVersions[]"

_rst_view_clusters:
	@$(INFO) '$(AWS_UI_LABEL)View RedShift clusters ...'; $(NORMAL)
	@# CLUSTER IDENTIFIER FOR SHOW CLUSTER
	$(AWS) redshift describe-clusters $(_X__RST_CLUSTER_IDENTIFIER) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES) --query "Clusters[]$(RST_UI_VIEW_CLUSTERS_FIELDS)"

_rst_view_events:
	@$(INFO) '$(AWS_UI_LABEL)View RedShift events ...'; $(NORMAL)
	$(AWS) redshift describe-events $(__RST_DURATION) $(__RST_END_TIME) $(__RST_SOURCE_IDENTIFIER) $(__RST_SOURCE_TYPE) $(__RST_START_TIME)

_rst_view_resize:
	@$(INFO) '$(AWS_UI_LABEL)View RedShift resize ...'; $(NORMAL)
	@$(WARN) 'No resize --> an error is returned!'; $(NORMAL)
	-$(AWS) redshift describe-resize $(__RST_CLUSTER_IDENTIFIER)

_rst_view_tags:
	@$(INFO) '$(AWS_UI_LABEL)View RedShift tags ...'; $(NORMAL)
	$(AWS) redshift describe-tags $(__RST_RESOURCE_NAME) $(__RST_RESOURCE_TYPE) $(__RST_TAG_KEYS) $(__RST_TAG_VALUES)
