_AWS_DAX_CLUSTER_MK_VERSION= $(_AWS_DAX_MK_VERSION)

# DAX_CLUSTER_AVAILABILITY_ZONES?=
# DAX_CLUSTER_DESCRIPTION?= "This is my cluster-description"
# DAX_CLUSTER_IAMROLE_ARN?=
# DAX_CLUSTER_MAINTENANCE_WINDOW?=
# DAX_CLUSTER_NODE_TYPE?=
# DAX_CLUSTER_NAME?= my-cluster 
# DAX_CLUSTER_PARAMETERGROUP_NAME?= my-parameter-group 
# DAX_CLUSTER_TAGS?= Key=string,Value=string ...
# DAX_CLUSTERS_NAMES?= my-cluster ...
# DAX_CLUSTERS_SET_NAME?= my-clusters-set 

# Derived parameters
DAX_CLUSTERS_NAMES?= $(DAX_CLUSTER_NAME)

# Option parameters
__DAX_AVAILABILITY_ZONES= $(if $(DAX_CLUSTER_AVAILABILITY_ZONES), --availability-zones $(DAX_CLUSTER_AVAILABILITY_ZONES))
__DAX_CLUSTER_NAME= $(if $(DAX_CLUSTER_NAME), --cluster-name $(DAX_CLUSTER_NAME))
__DAX_CLUSTER_NAMES= $(if $(DAX_CLUSTERS_NAMES), --cluster-names $(DAX_CLUSTERS_NAMES))
__DAX_DESCRIPTION__CLUSTER= $(if $(DAX_CLUSTER_DESCRIPTION), --description $(DAX_CLUSTER_DESCRIPTION))
__DAX_IAM_ROLE_ARN= $(if $(DAX_CLUSTER_IAMROLE_ARN), --iam-role-arn $(DAX_CLUSTER_IAMROLE_ARN))
__DAX_NODE_TYPE= $(if $(DAX_CLUSTER_NODE_TYPE), --node-type $(DAX_CLUSTER_NODE_TYPE))
__DAX_NOTIFICATION_TOPIC_ARN= $(if $(DAX_CLUSTER_NOTIFICATIONTOPIC_ARN), --notification-topic-arn $(DAX_CLUSTER_NOTIFICATIONTOPIC_ARN))
__DAX_PARAMETER_GROUP_NAME__CLUSTER= $(if $(DAX_CLUSTER_PARAMETERGROUP_NAME), --parameter-group-name $(DAX_CLUSTER_PARAMETERGROUP_NAME))
__DAX_PREFERRED_MAINTENANCE_WINDOW= $(if $(DAX_CLUSTER_MAINTENANCE_WINDOW), --replication-factor $(DAX_CLUSTER_MAINTENANCE_WINDOW))
__DAX_REPLICATION_FACTOR= $(if $(DAX_CLUSTER_REPLICATION_FACTOR), --replication-factor $(DAX_CLUSTER_REPLICATION_FACTOR))
__DAX_RESOURCE_NAME__CLUSTER= $(if $(DAX_CLUSTER_NAME), --resource-name $(DAX_CLUSTER_NAME))
__DAX_SECURITY_GROUP_IDS= $(if $(DAX_CLUSTER_SECURITYGROUP_IDS), --security-group-ids $(DAX_CLUSTER_SECURITYGROUP_IDS))
__DAX_SUBNET_GROUP_NAME= $(if $(DAX_CLUSTER_SUBNETGROUP_NAME), --subnet-group-name $(DAX_CLUSTER_SUBNETGROUP_NAME))
__DAX_TAG_KEYS__CLUSTER= $(if $(DAX_CLUSTER_TAG_KEYS), --tag-keys $(DAX_CLUSTER_TAG_KEYS))
__DAX_TAGS__CLUSTER= $(if $(DAX_CLUSTER_TAGS), --tags $(DAX_CLUSTER_TAGS))



# UI parameters
DAX_UI_VIEW_CLUSTERS_FIELDS?=
DAX_UI_VIEW_CLUSTERS_SET_FIELDS?= $(DAX_UI_VIEW_CLUSTERS_FIELDS)
DAX_UI_VIEW_CLUSTERS_SET_SLICE?=

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dax_view_framework_macros ::
	@echo 'AWS::DAX::Cluster ($(_AWS_DAX_CLUSTER_MK_VERSION)) macros:'
	@echo

_dax_view_framework_parameters ::
	@echo 'AWS::DAX::Cluster ($(_AWS_DAX_CLUSTER_MK_VERSION)) parameters:'
	@echo '    DAX_CLUSTER_AVAILABILITY_ZONES=$(DAX_CLUSTER_AVAILABILITY_ZONES)'
	@echo '    DAX_CLUSTER_DESCRIPTION=$(DAX_CLUSTER_DESCRIPTION)'
	@echo '    DAX_CLUSTER_IAMROLE_ARN=$(DAX_CLUSTER_IAMROLE_ARN)'
	@echo '    DAX_CLUSTER_MAINTENANCE_WINDOW=$(DAX_CLUSTER_MAINTENANCE_WINDOW)'
	@echo '    DAX_CLUSTER_NODE_TYPE=$(DAX_CLUSTER_NODE_TYPE)'
	@echo '    DAX_CLUSTER_NOTIFICATIONTOPIC_ARN=$(DAX_CLUSTER_NOTIFICATIONTOPIC_ARN)'
	@echo '    DAX_CLUSTER_NAME=$(DAX_CLUSTER_NAME)'
	@echo '    DAX_CLUSTER_PARAMETERGROUP_NAME=$(DAX_CLUSTER_PARAMETERGROUP_NAME)'
	@echo '    DAX_CLUSTERS_NAMES=$(DAX_CLUSTERS_NAMES)'
	@echo '    DAX_CLUSTERS_SET_NAME=$(DAX_CLUSTERS_SET_NAME)'
	@echo

_dax_view_framework_targets ::
	@echo 'AWS::DAX::Cluster ($(_AWS_DAX_CLUSTER_MK_VERSION)) targets:'A
	@echo '    _dax_create_cluster                           - Create a new cluster'
	@echo '    _dax_delete_cluster                           - Delete an existing cluster'
	@echo '    _dax_show_cluster                             - Show everything related to a cluster'
	@echo '    _dax_show_cluster_description                 - Show desription of a cluster'
	@echo '    _dax_show_cluster_tags                        - Show tags of a cluster'
	@echo '    _dax_tag_cluster                              - Tag a cluster'
	@echo '    _dax_untag_cluster                            - Untag a cluster'
	@echo '    _dax_view_clusters                            - View clusters'
	@echo '    _dax_view_clusters_set                        - View a set of clusters'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dax_create_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Creating cluster "$(DAX_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) dax create-cluster $(__DAX_AVAILABILITY_ZONES) $(__DAX_CLUSTER_NAME) $(__DAX_DESCRIPTION__CLUSTER) $(__DAX_IAM_ROLE_ARN) $(__DAX_NODE_TYPE) $(__DAX_NOTIFICATION_TOPIC_ARN) $(__DAX_PARAMETER_GROUP_NAME__CLUSTER) $(__DAX_PREFERRED_MAINTENANCE_WINDOW) $(__DAX_REPLICATION_FACTOR) $(__DAX_SECURITY_GROUP_IDS) $(__DAX_SUBNET_GROUP_NAME) $(__DAX_TAGS__CLUSTER)

_dax_delete_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Deleting cluster "$(DAX_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) dax delete-cluster $(__DAX_CLUSTER_NAME)

_dax_show_cluster: _dax_show_cluster_tags _dax_show_cluster_description

_dax_show_cluster_description:
	@$(INFO) '$(AWS_UI_LABEL)Showing description of cluster "$(DAX_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) dax describe-clusters $(_X__DAX_CLUSTER_NAMES) --cluster-names $(DAX_CLUSTER_NAME) # --query "StreamDescriptionSummary"

_dax_show_cluster_tags:
	@$(INFO) '$(AWS_UI_LABEL)Showing tags of cluster "$(DAX_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) dax list-tags $(__DAX_RESOURCE_NAME__CLUSTER)

_dax_tag_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Tagging cluster "$(DAX_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) dax tag-resource $(__DAX_RESOURCE_NAME__CLUSTER)

_dax_untag_cluster:
	@$(INFO) '$(AWS_UI_LABEL)Removing tags from cluster "$(DAX_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) dax untag-resource $(__DAX_CLUSTER_NAME) $(__DAX_TAG_KEYS__CLUSTER)

_dax_view_clusters:
	@$(INFO) '$(AWS_UI_LABEL)Viewing clusters ...'; $(NORMAL)
	$(AWS) dax describe-clusters $(__DAX_CLUSTER_NAMES) # --query "StreamNames[]"

_dax_view_clusters_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing clusters-set "$(DAX_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Clusters are grouped based on the provided names and/or slice'; $(NORMAL)
	$(AWS) dax describe-clusters $(__DAX_CLUSTER_NAMES) # --query "StreamNames[$(DAX_UI_VIEW_CLUSTERS_SET_SLICE)]"
