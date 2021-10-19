_AWS_ECS_CLUSTER_MK_VERSION= $(_AWS_ECS_MK_VERSION)

# ECS_CLUSTER_ARN?= arn:aws:ecs:us-west-2:123456789012:cluster/ci
# ECS_CLUSTER_ARN_OR_NAME?= my-cluster
# ECS_CLUSTER_ATTRIBUTE_NAME?= my-attribute
# ECS_CLUSTER_ATTRIBUTE_VALUE?= 
ECS_CLUSTER_INCLUDE?= STATISTICS TAGS
# ECS_CLUSTER_NAME?= my-cluster
# ECS_CLUSTER_STACK_NAME?=  EC2ContainerService-MyClusterName
# ECS_CLUSTER_TAGS_KEYVALUES?= key=string,value=string ...
# ECS_CLUSTERS_ARNS?=
# ECS_CLUSTERS_ARNS_OR_NAMES?=
# ECS_CLUSTERS_ARNS_QUERYFILTER?=
ECS_CLUSTERS_INCLUDE?= STATISTICS TAGS
# ECS_CLUSTERS_NAMES?=
# ECS_CLUSTERS_SET_NAME?=

# Derived parameters
ECS_CLUSTER_ARN_OR_NAME?= $(if $(ECS_CLUSTER_ARN),$(ECS_CLUSTER_ARN),$(ECS_CLUSTER_NAME))
# ECS_CLUSTER_STACK_NAME?=  $(if $(ECS_CLUSTER_NAME),EC2ContainerService-$(ECS_CLUSTER_NAME))
ECS_CLUSTERS_ARNS_OR_NAMES?= $(if $(ECS_CLUSTERS_ARNS),$(ECS_CLUSTERS_ARNS),$(ECS_CLUSTERS_NAMES))

# Option parameters
__ECS_ATTRIBUTE_NAME=
__ECS_ATTRIBUTE_VALUE=
__ECS_CLUSTER= $(if $(ECS_CLUSTER_ARN_OR_NAME),--cluster $(ECS_CLUSTER_ARN_OR_NAME))
__ECS_CLUSTERS__CLUSTER= $(if $(ECS_CLUSTER_ARN_OR_NAME),--clusters $(ECS_CLUSTER_ARN_OR_NAME))
__ECS_CLUSTERS__CLUSTERS= $(if $(ECS_CLUSTERS_ARNS_OR_NAMES),--clusters $(ECS_CLUSTERS_ARNS_OR_NAMES))
__ECS_CLUSTER_NAME= $(if $(ECS_CLUSTER_NAME),--cluster-name $(ECS_CLUSTER_NAME))
__ECS_INCLUDE__CLUSTER= $(if $(ECS_CLUSTER_INCLUDE),--include $(ECS_CLUSTER_INCLUDE))
__ECS_INCLUDE__CLUSTERS= $(if $(ECS_CLUSTERS_INCLUDE),--include $(ECS_CLUSTERS_INCLUDE))
__ECS_RESOURCE_ARN__CLUSTER= $(if $(ECS_CLUSTER_ARN),--resource-arn $(ECS_CLUSTER_ARN))
__ECS_TAGS__CLUSTER= $(if $(ECS_CLUSTER_TAGS_KEYVALUES),--tags $(ECS_CLUSTER_TAGS_KEYVALUES))

# UI parameters
ECS_UI_SHOW_CLUSTER_FIELDS?=
ECS_UI_VIEW_CLUSTERS_FIELDS?=
ECS_UI_VIEW_CLUSTERS_SET_FIELDS?= .{clusterName:clusterName,status:status,runningEC2TasksCount:statistics[0].value}
ECS_UI_VIEW_CLUSTERS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros
_ecs_get_cluster_arn= $(call _ecs_get_cluster_arn_N, $(ECS_CLUSTER_NAME))
_ecs_get_cluster_arn_N= $(shell echo 'arn:aws:ecs:$(AWS_REGION_ID):$(AWS_ACCOUNT_ID):cluster/$(strip $(1))' )

_ecs_get_clusters_arns= $(call _ecs_get_clusters_arns_F, $(ECS_CLUSTERS_ARNS_QUERYFILTER))
_ecs_get_clusters_arns_F= $(shell $(AWS) ecs list-clusters --query "clusterArns[$(strip $(1))]" --output text)

#----------------------------------------------------------------------
# USAGE
#

_ecs_view_framework_macros ::
	@echo 'AWS::ECS::Cluster ($(_AWS_ECS_CLUSTER_MK_VERSION)) macros:'
	@echo '    _ecs_get_cluster_arn_{|N}              - Get the ARN of a cluster (Name)'
	@echo '    _ecs_get_clusters_arns_{|F}            - Get the ARNs of clusters (Filter)'
	@echo

_ecs_view_framework_parameters ::
	@echo 'AWS::ECS::Cluster ($(_AWS_ECS_CLUSTER_MK_VERSION)) parameters:'
	@echo '    ECS_CLUSTER_ARN=$(ECS_CLUSTER_ARN)'
	@echo '    ECS_CLUSTER_ARN_OR_NAME=$(ECS_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_CLUSTER_ATTRIBUTE_NAME=$(ECS_CLUSTER_ATTRIBUTE_NAME)'
	@echo '    ECS_CLUSTER_ATTRIBUTE_VALUE=$(ECS_CLUSTER_ATTRIBUTE_VALUE)'
	@echo '    ECS_CLUSTER_INCLUDE=$(ECS_CLUSTER_INCLUDE)'
	@echo '    ECS_CLUSTER_NAME=$(ECS_CLUSTER_NAME)'
	@#echo '    ECS_CLUSTER_STACK_NAME=$(ECS_CLUSTER_STACK_NAME)'
	@echo '    ECS_CLUSTER_TAGS_KEYVALUES=$(ECS_CLUSTER_TAGS_KEYVALUES)'
	@echo '    ECS_CLUSTERS_ARNS=$(ECS_CLUSTERS_ARNS)'
	@echo '    ECS_CLUSTERS_ARNS_OR_NAMES=$(ECS_CLUSTERS_ARNS_OR_NAMES)'
	@echo '    ECS_CLUSTERS_NAMES=$(ECS_CLUSTERS_NAMES)'
	@echo '    ECS_CLUSTERS_SET_NAME=$(ECS_CLUSTERS_SET_NAME)'
	@echo

_ecs_view_framework_targets ::
	@echo 'AWS::ECS::Cluster ($(_AWS_ECS_CLUSTER_MK_VERSION)) targets:'
	@echo '    _ecs_create_cluster                  - Create a new cluster'
	@echo '    _ecs_delete_cluster                  - Delete an existing cluster'
	@echo '    _ecs_show_cluster                    - Show everything related to a cluster'
	@echo '    _ecs_show_cluster_attributes         - Show the attributes of a cluster'
	@echo '    _ecs_show_cluster_description        - Show the description of a cluster'
	@echo '    _ecs_show_cluster_tags               - Show the tags of a cluster'
	@echo '    _ecs_show_cluster_tasks              - Show the tasks running on a cluster'
	@echo '    _ecs_view_clusters                   - View existing clusters'
	@echo '    _ecs_view_clusters_set               - View a set of clusters' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_ecs_create_cluster:
	@$(INFO) '$(ECS_UI_LABEL)Creating a new cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) ecs create-cluster $(__ECS_CLUSTER_NAME) $(__ECS_TAGS__CLUSTER)

_ecs_delete_cluster:
	@$(INFO) '$(ECS_UI_LABEL)Deleting an existing cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) ecs delete-cluster $(__ECS_CLUSTER)

_ecs_show_cluster :: _ecs_show_cluster_attributes _ecs_show_cluster_containerinstances _ecs_show_cluster_tags _ecs_show_cluster_tasks _ecs_show_cluster_description

_ecs_show_cluster_attributes:
	@$(INFO) '$(ECS_UI_LABEL)Show attributes of cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation only shows attributes that have been set'; $(NORMAL)
	$(AWS) ecs list-attributes $(__ECS_ATTRIBUTE_NAME) $(__ECS_ATTRIBUTE_VALUE) $(__ECS_CLUSTER) --target-type container-instance --query 'sort_by(attributes, &name)[?value].{name:name,value:value}'

_ecs_show_cluster_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-clusters $(__ECS_CLUSTERS__CLUSTER) $(__ECS_INCLUDE__CLUSTER)

_ecs_show_cluster_containerinstances:
	@$(INFO) '$(ECS_UI_LABEL)Showing the container-instances registered with cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the ARN of the ECS container agents who successfully registered to a cluster'; $(NORMAL)
	$(AWS) ecs list-container-instances $(__ECS_CLUSTER) $(_X__ECS_FILTER__CLUSTER) $(_X__ECS_MAX_ITEMS__CLUSTER) $(_X__ECS_STATUS__CLUSTER) --query 'containerInstanceArns[]'

_ecs_show_cluster_instances:
	@$(INFO) '$(ECS_UI_LABEL)Showing the instances in cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	# Check container instances

_ecs_show_cluster_tags:
	@$(INFO) '$(ECS_UI_LABEL)Showing tags of cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) ecs list-tags-for-resource $(__ECS_RESOURCE_ARN__CLUSTER)

_ecs_show_cluster_tasks:
	@$(INFO) '$(ECS_UI_LABEL)Showing tasks running on cluster "$(ECS_CLUSTER_NAME)" ...'; $(NORMAL)
	$(AWS) ecs list-tasks $(__ECS_CLUSTER) --query 'taskArns[]'

_ecs_view_clusters:
	@$(INFO) '$(ECS_UI_LABEL)Viewing all clusters ...'; $(NORMAL)
	$(AWS) ecs list-clusters $(_X__ECS_CLUSTERS__CLUSTERS) $(_X__ECS_INCLUDE__CLUSTERS) --query 'clusterArns[]$(ECS_UI_VIEW_CLUSTERS_FIELDS)'

_ecs_view_clusters_set:
	@$(INFO) '$(ECS_UI_LABEL)Viewing clusters-set "$(ECS_CLUSTERS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Clusters are grouped based on the required arns/names, and optional query-filter'; $(NORMAL)
	$(AWS) ecs describe-clusters $(__ECS_CLUSTERS__CLUSTERS) $(__ECS_INCLUDE__CLUSTERS) --query "clusters[$(ECS_UI_VIEW_CLUSTERS_SET_QUERYFILTER)]$(ECS_UI_VIEW_CLUSTERS_SET_FIELDS)"
