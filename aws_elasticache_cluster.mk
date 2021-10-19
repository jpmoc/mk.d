_AWS_ECE_CLUSTER_MK_VERSION= $(_AWS_ECE_MK_VERSION)

# ECE_CLUSTER_AUTH_TOKEN?=
# ECE_CLUSTER_ENGINE?=
# ECE_CLUSTER_ENGINE_VERSION?=
# ECE_CLUSTER_ID?=
# ECE_CLUSTER_MIORUPGRADE_ENABLE?= false
# ECE_CLUSTER_MAINTENANCE_WINDOW?=
# ECE_CLUSTER_NODE_COUNT?=
# ECE_CLUSTER_NODE_TYPE?=
# ECE_CLUSTER_NOTIFICATIONTOPIC_ARN?=
# ECE_CLUSTER_PARAMETERGROUP_NAME?= my-parameter-group 
# ECE_CLUSTER_PORT?=
# ECE_CLUSTER_PREFERRED_AVAILABILITYZONE?=
# ECE_CLUSTER_PREFERRED_AVAILABILITYZONES?=
# ECE_CLUSTER_REPLICATIONGROUP_ID?=
# ECE_CLUSTER_SECURITYGROUP_ID?=
# ECE_CLUSTER_SNAPSHOT_ARNS?=
# ECE_CLUSTER_SNAPSHOT_NAME?=
# ECE_CLUSTER_SNAPSHOT_RETENTIONLIMIT?=
# ECE_CLUSTER_SNAPSHOT_WINDOW?=
# ECE_CLUSTER_TAGS?= Key=string,Value=string ...
# ECE_CLUSTERS_NAMES?= my-cluster ...
# ECE_CLUSTERS_SET_NAME?= my-clusters-set 

# Derived parameters
ECE_CLUSTERS_NAMES?= $(ECE_CLUSTER_NAME)

# Option parameters
__ECE_AUTH_TOKEN= $(if $(ECE_CLUSTER_AUTH_TOKEN), --auth-token $(ECE_CLUSTER_AUTH_TOKEN))
__ECE_AUTO_MINOR_VERSION_UPGRADE= $(if $(filter true,$(ECE_CLUSTER_MINORUPGRADE_ENABLE)), --auto-minor-version-upgrade, --no-auto-minor-version-upgrade)
__ECE_AZ_MODE=
__ECE_CACHE_CLUSTER_ID= $(if $(ECE_CLUSTER_ID), --cache-cluster-id $(ECE_CLUSTER_ID))
__ECE_CACHE_NODE_TYPE= $(if $(ECE_CLUSTER_NODE_TYPE), --node-type $(ECE_CLUSTER_NODE_TYPE))
__ECE_CACHE_PARAMETER_GROUP_NAME__CLUSTER= $(if $(ECE_CLUSTER_PARAMETERGROUP_NAME), --parameter-group-name $(ECE_CLUSTER_PARAMETERGROUP_NAME))
__ECE_CACHE_SECURITY_GROUP_NAMES= $(if $(ECE_CLUSTER_SECURITYGROUP_NAME), --cache-security-group-names $(ECE_CLUSTER_SECURITYGROUP_NAMES))
__ECE_CACHE_SUBNET_GROUP_NAME= $(if $(ECE_CLUSTER_SUBNETGROUP_NAME), --subnet-group-name $(ECE_CLUSTER_SUBNETGROUP_NAME))
__ECE_ENGINE=
__ECE_ENGINE_VERSION=
__ECE_FINAL_SNAPSHOT_IDENTIFIER=
__ECE_NOTIFICATION_TOPIC_ARN= $(if $(ECE_CLUSTER_NOTIFICATIONTOPIC_ARN), --notification-topic-arn $(ECE_CLUSTER_NOTIFICATIONTOPIC_ARN))
__ECE_NUM_CACHE_NODE=
__ECE_PORT=
__ECE_PREFERRED_AVAILIBITY_ZONE=
__ECE_PREFERRED_AVAILIBITY_ZONES=
__ECE_PREFERRED_MAINTENANCE_WINDOW= $(if $(ECE_CLUSTER_MAINTENANCE_WINDOW), --replication-factor $(ECE_CLUSTER_MAINTENANCE_WINDOW))
__ECE_REPLICATION_GROUP_ID= $(if $(ECE_CLUSTER_REPLICATIONGROUP_ID), --replication-group-id $(ECE_CLUSTER_REPLICATIONGROUP_ID))
__ECE_SECURITY_GROUP_ID= $(if $(ECE_CLUSTER_SECURITYGROUP_ID), --security-group-id $(ECE_CLUSTER_SECURITYGROUP_ID))
__ECE_SHOW_CACHE_CLUSTERS_NOT_IN_REPLICATION_GROUP=
__ECE_SHOW_CACHE_NODE_INFO=
__ECE_SNAPSHOT_ARNS= $(if $(ECE_CLUSTER_SNAPSHOT_ARNS), --snapshot-arns $(ECE_CLUSTER_SNAPSHOT_ARNS))
__ECE_SNAPSHOT_NAME= $(if $(ECE_CLUSTER_SNAPSHOT_NAME), --snapshot-name $(ECE_CLUSTER_SNAPSHOT_NAME))
__ECE_SNAPSHOT_RETENTION_LIMIT= $(if $(ECE_CLUSTER_SNAPSHOT_RETENTIONLIMIT), --snapshot-retention-limit $(ECE_CLUSTER_SNAPSHOT_RETENTIONLIMIT))
__ECE_SNAPSHOT_WINDOW= $(if $(ECE_CLUSTER_SNAPSHOT_WINDOW), --snapshot-window $(ECE_CLUSTER_SNAPSHOT_WINDOW))
__ECE_RESOURCE_NAME__CLUSTER= $(if $(ECE_CLUSTER_NAME), --resource-name $(ECE_CLUSTER_NAME))
__ECE_TAG_KEYS__CLUSTER= $(if $(ECE_CLUSTER_TAG_KEYS), --tag-keys $(ECE_CLUSTER_TAG_KEYS))
__ECE_TAGS__CLUSTER= $(if $(ECE_CLUSTER_TAGS), --tags $(ECE_CLUSTER_TAGS))



# UI parameters
ECE_UI_VIEW_CLUSTERS_FIELDS?=
ECE_UI_VIEW_CLUSTERS_SET_FIELDS?= $(ECE_UI_VIEW_CLUSTERS_FIELDS)
ECE_UI_VIEW_CLUSTERS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_ece_view_framework_macros ::
	@echo 'AWS::ElastiCachE::Cluster ($(_AWS_ELASTICACHE_CLUSTER_MK_VERSION)) macros:'
	@echo

_ece_view_framework_parameters ::
	@echo 'AWS::ElastiCachE::Cluster ($(_AWS_ELASTICACHE_CLUSTER_MK_VERSION)) parameters:'
	@echo '    ECE_CLUSTER_AUTH_TOKEN=$(ECE_CLUSTER_AUTH_TOKEN)'
	@echo '    ECE_CLUSTER_ENGINE=$(ECE_CLUSTER_ENGINE)'
	@echo '    ECE_CLUSTER_ENGINE_VERSION=$(ECE_CLUSTER_ENGINE_VERSION)'
	@echo '    ECE_CLUSTER_ID=$(ECE_CLUSTER_ID)'
	@echo '    ECE_CLUSTER_MINORUPDATE_ENABLE=$(ECE_CLUSTER_MINORUPDATE_ENABLE)'
	@echo '    ECE_CLUSTER_MAINTENANCE_WINDOW=$(ECE_CLUSTER_MAINTENANCE_WINDOW)'
	@echo '    ECE_CLUSTER_NODE_TYPE=$(ECE_CLUSTER_NODE_TYPE)'
	@echo '    ECE_CLUSTER_NOTIFICATIONTOPIC_ARN=$(ECE_CLUSTER_NOTIFICATIONTOPIC_ARN)'
	@echo '    ECE_CLUSTER_PARAMETERGROUP_NAME=$(ECE_CLUSTER_PARAMETERGROUP_NAME)'
	@echo '    ECE_CLUSTER_PORT=$(ECE_CLUSTER_PORT)'
	@echo '    ECE_CLUSTER_PREFERRED_AVAILABILITYZONE=$(ECE_CLUSTER_PREFERRED_AVAILABILITYZONE)'
	@echo '    ECE_CLUSTER_PREFERRED_AVAILABILITYZONES=$(ECE_CLUSTER_PREFERRED_AVAILABILITYZONES)'
	@echo '    ECE_CLUSTER_REPLICATIONGROUP_ID=$(ECE_CLUSTER_REPLICATIONGROUP_ID)'
	@echo '    ECE_CLUSTER_SECURITYGROUP_ID=$(ECE_CLUSTER_SECURITYGROUP_ID)'
	@echo '    ECE_CLUSTER_SNAPSHOT_ARNS=$(ECE_CLUSTER_SNAPSHOT_ARNS)'
	@echo '    ECE_CLUSTER_SNAPSHOT_NAME=$(ECE_CLUSTER_SNAPSHOT_NAME)'
	@echo '    ECE_CLUSTER_SNAPSHOT_RETENTIONLIMIT=$(ECE_CLUSTER_SNAPSHOT_RETENTIONLIMIT)'
	@echo '    ECE_CLUSTER_SNAPSHOT_WINDOW=$(ECE_CLUSTER_SNAPSHOT_WINDOW)'
	@echo '    ECE_CLUSTER_TAGS=$(ECE_CLUSTER_SNAPSHOT_TAGS)'
	@echo '    ECE_CLUSTERS_NAMES=$(ECE_CLUSTERS_NAMES)'
	@echo '    ECE_CLUSTERS_SET_NAME=$(ECE_CLUSTERS_SET_NAME)'
	@echo

_ece_view_framework_targets ::
	@echo 'AWS::ElastiCachE::Cluster ($(_AWS_ELASTICACHE_CLUSTER_MK_VERSION)) targets:'A
	@echo '    _ece_create_cluster                           - Create a new cluster'
	@echo '    _ece_delete_cluster                           - Delete an existing cluster'
	@echo '    _ece_show_cluster                             - Show everything related to a cluster'
	@echo '    _ece_show_cluster_description                 - Show desription of a cluster'
	@echo '    _ece_show_cluster_tags                        - Show tags of a cluster'
	@echo '    _ece_tag_cluster                              - Tag a cluster'
	@echo '    _ece_untag_cluster                            - Untag a cluster'
	@echo '    _ece_view_clusters                            - View clusters'
	@echo '    _ece_view_clusters_set                        - View a set of clusters'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ece_create_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating cache-cluster "$(ECE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache create-cache-cluster $(__ECE_AUTH_TOKEN) $(__ECE_AUTO_MINOR_VERSION_UPGRADE) $(__ECE_AZ_MODE) $(__ECE_CACHE_CLUSTER_ID) $(__ECE_CACHE_NODE_TYPE) $(__ECE_CACHE_PARAMETER_GROUP_NAME__CLUSTER) $(__ECE_CACHE_SECURITY_GROUP_NAMES) $(__ECE_CACHE_SUBNET_GROUP_NAME) $(__ECE_ENGINE) $(__ECE_ENGINE_VERSION) $(__ECE_NOTIFICATION_TOPIC_ARN) $(__ECE_NUM_CACHE_NODES) $(__ECE_PORT) $(__ECE_PREFERRED_AVAILABILITY_ZONE) $(__ECE_PREFERRRED_AVAILABILITY_ZONES) $(__ECE_PREFERRED_MAINTENANCE_WINDOW) $(__ECE_REPLICATION_GROUP_ID__CLUSTER) $(__ECE_SECURITY_GROUP_IDS) $(__ECE_SNAPSHOT_ARNS) $(__ECE_SNAPSHOT_NAME) $(__ECE_SNAPSHOT_RETENTION_LIMIT) $(__ECE_SNAPSHOT_WINDOW) $(__ECE_TAGS__CLUSTER)

_ece_delete_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Deleting cluster "$(ECE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache delete-cluster $(__ECE_CACHE_CLUSTER_ID) $(__ECE_FINAL_SNAPSHOT_IDENTIFIER)

_ece_show_cluster: _ece_show_cluster_tags _ece_show_cluster_description

_ece_show_cluster_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of cluster "$(ECE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-clusters $(__ECE_CACHE_CLUSTER_ID) $(__ECE_SHOW_CACHE_CLUSTERS_NOT_IN_REPLICATION_GROUP) $(__ECE_SHOW_CACHE_NODE_INFO) # --cluster-names $(ECE_CLUSTER_NAME) # --query "StreamDescriptionSummary"

_ece_show_cluster_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of cluster "$(ECE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache list-tags-for-resource $(__ECE_RESOURCE_NAME__CLUSTER)

_ece_tag_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Tagging cluster "$(ECE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache add-tags-to-resource $(__ECE_RESOURCE_NAME__CLUSTER) $(__ECE_TAGS__CLUSTER)

_ece_untag_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from cluster "$(ECE_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) elasticache remove-tags-from-resource $(__ECE_RESOURCE_NAME__CLUSTER) $(__ECE_TAG_KEYS__CLUSTER)

_ece_view_clusters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(AWS) elasticache describe-cache-clusters $(__ECE_CACHE_CLUSTER_ID) $(__ECE_SHOW_CACHE_CLUSTERS_NOT_IN_REPLICATION_GROUP) $(__ECE_SHOW_CACHE_NODE_INFO) # --cluster-names $(ECE_CLUSTER_NAME) # --query "StreamDescriptionSummary"

_ece_view_clusters_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing clusters-set "$(ECE_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'Clusters are grouped based on the provided names and/or slice'; $(NORMAL)
	$(AWS) elasticache describe-cache-clusters $(__ECE_CACHE_CLUSTER_ID) $(__ECE_SHOW_CACHE_CLUSTERS_NOT_IN_REPLICATION_GROUP) $(__ECE_SHOW_CACHE_NODE_INFO) # --cluster-names $(ECE_CLUSTER_NAME) # --query "StreamDescriptionSummary"
