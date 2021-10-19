_AWS_ECS_CONTAINERINSTANCE_MK_VERSION= $(_AWS_ECS_MK_VERSION)

# ECS_CONTAINERINSTANCE_ACCOUNT_ID?=
# ECS_CONTAINERINSTANCE_ARN?= arn:aws:ecs:us-east-1:123456789012:container-instance/f6bbb147-5370-4ace-8c73-c7181ded911f
# ECS_CONTAINERINSTANCE_ARN_OR_ID?=
# ECS_CONTAINERINSTANCE_CLUSTER_ARN?=
# ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME?=
# ECS_CONTAINERINSTANCE_CLUSTER_NAME?=
# ECS_CONTAINERINSTANCE_ID?= f6bbb147-5370-4ace-8c73-c7181ded911f
# ECs_CONTAINERINSTANCE_INSTANCE_ID?= i-0cb5d6cdf42999fac
# ECS_CONTAINERINSTANCE_NAME?=
# ECS_CONTAINERINSTANCE_REGION_ID?= us-west-1
# ECS_CONTAINERINSTANCE_TAGS_KEYVALUES?= key=string,value=string ...
# ECS_CONTAINERINSTANCE_TAGS_KEYS?= key ...
# ECS_CONTAINERINSTANCE_VPC_ID?= vpc-024f299438bf1c3f5
# ECS_CONTAINERINSTANCES_ARNS?=
# ECS_CONTAINERINSTANCES_ARNS_OR_IDS?=
# ECS_CONTAINERINSTANCES_CLUSTER_ARN?=
# ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME?=
# ECS_CONTAINERINSTANCES_CLUSTER_NAME?=
ECS_CONTAINERINSTANCES_FILTER_EXPRESSION?= "agentVersion > 0.0.0"
# ECS_CONTAINERINSTANCES_IDS?=
# ECS_CONTAINERINSTANCES_SET_NAME?= my-task-definitions-set
# ECS_CONTAINERINSTANCES_STATUS_ID?= DRAINING

# Derived parameters
ECS_CONTAINERINSTANCE_ACCOUNT_ID?= $(AWS_ACCOUNT_ID) 
ECS_CONTAINERINSTANCE_ARN?= $(if $(ECS_CONTAINERINSTANCE_ID),arn:aws:ecs:$(ECS_CONTAINERINSTANCE_REGION_ID):$(ECS_CONTAINERINSTANCE_ACCOUNT_ID):container-instance/$(ECS_CONTAINERINSTANCE_ID))
ECS_CONTAINERINSTANCE_ARN_OR_ID?= $(if $(ECS_CONTAINERINSTANCE_ARN),$(ECS_CONTAINERINSTANCE_ARN),$(ECS_CONTAINERINSTANCE_ID))
ECS_CONTAINERINSTANCE_CLUSTER_ARN?= $(ECS_CLUSTER_ARN)
ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME?= $(if $(ECS_CONTAINERINSTANCE_CLUSTER_ARN),$(ECS_CONTAINERINSTANCE_CLUSTER_ARN),$(ECS_CONTAINERINSTANCE_CLUSTER_NAME))
ECS_CONTAINERINSTANCE_CLUSTER_NAME?= $(ECS_CLUSTER_NAME)
ECS_CONTAINERINSTANCE_NAME?= $(ECS_CONTAINERINSTANCE_ID)
ECS_CONTAINERINSTANCE_REGION_ID?= $(AWS_REGION_ID)
ECS_CONTAINERINSTANCES_ARNS?= $(ECS_CONTAINERINSTANCE_ARN)
ECS_CONTAINERINSTANCES_ARNS_OR_IDS?= $(if $(ECS_CONTAINERINSTANCES_ARNS),$(ECS_CONTAINERINSTANCES_ARNS),$(ECS_CONTAINERINSTANCES_IDS))
ECS_CONTAINERINSTANCES_CLUSTER_ARN?= $(ECS_CLUSTER_ARN)
ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME?= $(if $(ECS_CONTAINERINSTANCES_CLUSTER_ARN),$(ECS_CONTAINERINSTANCES_CLUSTER_ARN),$(ECS_CONTAINERINSTANCES_CLUSTER_NAME))
ECS_CONTAINERINSTANCES_CLUSTER_NAME?= $(ECS_CLUSTER_NAME)

# Option parameters
__ECS_ATTRIBUTES=
__ECS_CLI_INPUT_JSON__CONTAINERINSTANCE=
__ECS_CLUSTER__CONTAINERINSTANCE= $(if $(ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME),--cluster $(ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME))
__ECS_CLUSTER__CONTAINERINSTANCES= $(if $(ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME),--cluster $(ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME))
__ECS_CONTAINER_INSTANCE_ARN= $(if $(ECS_CONTAINERINSTANCE_ARN),--container-instance-arn $(ECS_CONTAINERINSTANCE_ARN))
__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCE= $(if $(ECS_CONTAINERINSTANCE_ARN_OR_ID),--container-instances $(ECS_CONTAINERINSTANCE_ARN_OR_ID))
__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCES= $(if $(ECS_CONTAINERINSTANCES_ARNS_OR_IDS),--container-instances $(ECS_CONTAINERINSTANCES_ARNS_OR_IDS))
__ECS_FILTER__CONTAINERINSTANCES= $(if $(ECS_CONTAINERINSTANCES_FILTER_EXPRESSION),--filter $(ECS_CONTAINERINSTANCES_FILTER_EXPRESSION))
__ECS_FORCE__CONTAINERINSTANCE=
__ECS_INCLUDE__CONTAINERINSTANCE=
__ECS_INCLUDE__CONTAINERINSTANCES=
__ECS_INSTANCE_IDENTITY_DOCUMENT=
__ECS_INSTANCE_IDENTITY_DOCUMENT_SIGNATURE=
__ECS_MAX_ITEMS__CONTAINERINSTANCES=
__ECS_RESOURCE_ARN__CONTAINERINSTANCE= $(if $(ECS_CONTAINERINSTANCE_ARN),--resource-arn $(ECS_CONTAINERINSTANCE_ARN))
__ECS_STATUS__CONTAINERINSTANCES= $(if $(ECS_CONTAINERINSTANCES_STATUS_ID),--status $(ECS_CONTAINERINSTANCES_STATUS_ID))
__ECS_TAGS__CONTAINERINSTANCE= $(if $(ECS_CONTAINERINSTANCE_TAGS_KEYVALUES),--tags $(ECS_CONTAINERINSTANCE_TAGS_KEYVALUES))
__ECS_TAG_KEYS__CONTAINERINSTANCE= $(if $(ECS_CONTAINERINSTANCE_TAGS_KEYS),--tag-keys $(ECS_CONTAINERINSTANCE_TAGS_KEYS))
__ECS_TOTAL_RESOURCES=
__ECS_VERSION_INFO=

# UI parameters
ECS_UI_SHOW_CONTAINERINSTANCE_FIELDS?= .{status:status,agentUpdateStatus:agentUpdateStatus,attachments:attachments,containerInstanceArn:containerInstanceArn,registeredAt:registeredAt,runningTasksCount:runningTasksCount,agentConnected:agentConnected,version:version,ec2InstanceId:ec2InstanceId,tags:tags,pendingTasksCount:pendingTasksCount,versionInfo:versionInfo}
ECS_UI_SHOW_CONTAINERINSTANCES_FIELDS?= .{status:status,runningTasks:runningTasksCount,agentConnected:agentConnected,Ec2InstanceId:ec2InstanceId,availabilityZone:attributes[?name=='ecs.availability-zone'].value | [0],agentVersion:versionInfo.agentVersion,cpuAvail:remainingResources[?name=='CPU'].integerValue|[0],memoryAvail:remainingResources[?name=='MEMORY'].integerValue|[0]}
ECS_UI_VIEW_CONTAINERINSTANCES_FIELDS?=
ECS_UI_VIEW_CONTAINERINSTANCES_SET_FIELDS?=
ECS_UI_VIEW_CONTAINERINSTANCES_SET_QUERYFILTER?=

#--- Utilities

#--- Macros
_ecs_get_containerinstance_arn= $(call _ecs_get_containerinstance_arn_I, $(ECS_CONTAINERINSTANCE_ID))
_ecs_get_containerinstance_arn_I= $(call _ecs_get_containerinstance_arn_IR, $(1), $(ECS_CONTAINERINSTANCE_REGION_ID))
_ecs_get_containerinstance_arn_IR= $(call _ecs_get_containerinstance_arn_IRA, $(1), $(2), $(ECS_CONTAINERINSTANCE_ACCOUNT_ID))
_ecs_get_containerinstance_arn_IRA= $(shell echo "arn:aws:ecs:$(strip $(2)):$(strip $(3)):container-instance/$(strip $(1))" )

_ecs_get_containerinstance_instance_id= $(call _ecs_get_containerinstance_instance_id_A, $(ECS_CONTAINERINSTANCE_ARN_OR_ID))
_ecs_get_containerinstance_instance_id_A= $(call _ecs_get_containerinstance_instance_id_AC, $(1), $(ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME))
_ecs_get_containerinstance_instance_id_AC= $(shell $(AWS) ecs describe-container-instances --cluster $(2) --container-instances $(1) --query "containerInstances[].ec2InstanceId" --output text)

_ecs_get_containerinstance_vpc_id= $(call _ecs_get_containerinstance_vpc_id_A, $(ECS_CONTAINERINSTANCE_ARN_OR_ID))
_ecs_get_containerinstance_vpc_id_A= $(call _ecs_get_containerinstance_vpc_id_AC, $(1), $(ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME))
_ecs_get_containerinstance_vpc_id_AC= $(shell $(AWS) ecs describe-container-instances --cluster $(2) --container-instances $(1) --query "containerInstances[].attributes[?name=='ecs.vpc-id'].value" --output text)

_ecs_get_containerinstances_arns= $(call _ecs_get_containerinstances_arns_C, $(ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME))
_ecs_get_containerinstances_arns_C= $(call _ecs_get_containerinstances_arns_CF, $(1), $(ECS_CONTAINERINSTANCES_FILTER_EXPRESSION))
_ecs_get_containerinstances_arns_CF= $(shell $(AWS) ecs list-container-instances --cluster $(1) --filter $(2) --query 'containerInstanceArns[]' --output text)

#----------------------------------------------------------------------
# USAGE
#

_ecs_view_framework_macros ::
	@echo 'AWS::ECS::ContainerInstance ($(_AWS_ECS_CONTAINERINSTANCE_MK_VERSION)) macros:'
	@echo '    _ecs_get_containerinstance_arn_{|I}            - Get the ARN of a container-instance (Id)'
	@echo '    _ecs_get_containerinstance_instace_id_{|A|AC}  - Get the instance-ID of a container-instance (Arn,Cluster)'
	@echo '    _ecs_get_containerinstance_vpc_id_{|A|AC}      - Get the VPC-ID of a container-instance (Arn,Cluster)'
	@echo '    _ecs_get_containerinstances_arns_{|C|CF}       - Get the ARNs of a container-instances (Cluster,Filter)'
	@echo

_ecs_view_framework_parameters ::
	@echo 'AWS::ECS::ContainerInstance ($(_AWS_ECS_CONTAINERINSTANCE_MK_VERSION)) parameters:'
	@echo '    ECS_CONTAINERINSTANCE_ACCOUNT_ID=$(ECS_CONTAINERINSTANCE_ACCOUNT_ID)'
	@echo '    ECS_CONTAINERINSTANCE_ARN=$(ECS_CONTAINERINSTANCE_ARN)'
	@echo '    ECS_CONTAINERINSTANCE_ARN_OR_ID=$(ECS_CONTAINERINSTANCE_ARN_OR_ID)'
	@echo '    ECS_CONTAINERINSTANCE_CLUSTER_ARN=$(ECS_CONTAINERINSTANCE_CLUSTER_ARN)'
	@echo '    ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME=$(ECS_CONTAINERINSTANCE_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_CONTAINERINSTANCE_CLUSTER_NAME=$(ECS_CONTAINERINSTANCE_CLUSTER_NAME)'
	@echo '    ECS_CONTAINERINSTANCE_ID=$(ECS_CONTAINERINSTANCE_ID)'
	@echo '    ECS_CONTAINERINSTANCE_INSTANCE_ID=$(ECS_CONTAINERINSTANCE_INSTANCE_ID)'
	@echo '    ECS_CONTAINERINSTANCE_NAME=$(ECS_CONTAINERINSTANCE_NAME)'
	@echo '    ECS_CONTAINERINSTANCE_REGION_ID=$(ECS_CONTAINERINSTANCE_REGION_ID)'
	@echo '    ECS_CONTAINERINSTANCE_TAGS_KEYS=$(ECS_CONTAINERINSTANCE_TAGS_KEYS)'
	@echo '    ECS_CONTAINERINSTANCE_TAGS_KEYVALUES=$(ECS_CONTAINERINSTANCE_TAGS_KEYVALUES)'
	@echo '    ECS_CONTAINERINSTANCE_VPC_ID=$(ECS_CONTAINERINSTANCE_VPC_ID)'
	@echo '    ECS_CONTAINERINSTANCES_ARNS=$(ECS_CONTAINERINSTANCES_ARNS)'
	@echo '    ECS_CONTAINERINSTANCES_ARNS_OR_IDS=$(ECS_CONTAINERINSTANCES_ARNS_OR_IDS)'
	@echo '    ECS_CONTAINERINSTANCES_CLUSTER_ARN=$(ECS_CONTAINERINSTANCES_CLUSTER_ARN)'
	@echo '    ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME=$(ECS_CONTAINERINSTANCES_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_CONTAINERINSTANCES_CLUSTER_NAME=$(ECS_CONTAINERINSTANCES_CLUSTER_NAME)'
	@echo '    ECS_CONTAINERINSTANCES_FILTER_EXPRESSION=$(ECS_CONTAINERINSTANCES_FILTER_EXPRESSION)'
	@echo '    ECS_CONTAINERINSTANCES_IDS=$(ECS_CONTAINERINSTANCES_IDS)'
	@echo '    ECS_CONTAINERINSTANCES_SET_NAME=$(ECS_CONTAINERINSTANCES_SET_NAME)'
	@echo '    ECS_CONTAINERINSTANCES_STATUS_ID=$(ECS_CONTAINERINSTANCES_STATUS_ID)'
	@echo

_ecs_view_framework_targets ::
	@echo 'AWS::ECS::ContainerInstance ($(_AWS_ECS_CONTAINERINSTANCE_MK_VERSION)) targets:'
	@echo '    _ecs_create_containerinstance                    - Create a new container-instance'
	@echo '    _ecs_delete_containerinstance                    - Delete an existing container-instance'
	@echo '    _ecs_show_containerinstance                      - Show everything related to a container-instance'
	@echo '    _ecs_show_containerinstance_description          - Show the description of a container-instance'
	@echo '    _ecs_show_containerinstance_instanceprofile      - Show the instance-profile of a container-instance'
	@echo '    _ecs_show_containerinstance_registeredresources  - Show registered-resources of a container-instance'
	@echo '    _ecs_show_containerinstance_remainingresources   - Show remaining-resources of a container-instance'
	@echo '    _ecs_show_containerinstance_tags                 - Show tags of a container-instance'
	@echo '    _ecs_show_containerinstanceS                     - Show everything related to container-instanceS'
	@echo '    _ecs_show_containerinstanceS_description         - Show the description of container-instanceS'
	@echo '    _ecs_tag_containerinstance                       - Tag a container-instance'
	@echo '    _ecs_untag_containerinstance                     - Untag a containe-instance'
	@echo '    _ecs_view_containerinstances                     - View existing container-instances'
	@echo '    _ecs_view_containerinstances_set                 - View a set of container-instances' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_ecs_create_containerinstance:
	@$(INFO) '$(ECS_UI_LABEL)Creating a new container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ecs register-container-instance $(strip $(__ECS_ATTRIBUTES) $(__ECS_CLI_INPUT_JSON__CONTAINERINSTANCE) $(__ECS_CLUSTER__CONTAINERINSTANCE) $(__ECS_CONTAINER_INSTANCE_ARN) $(__ECS_INSTANCE_IDENTITY_DOCUMENT) $(__ECS_INSTANCE_IDENTITY_DOCUMENT_SIGNATURE) $(__ECS_TAGS__CONTAINERINSTANCE) $(__ECS_TOTAL_RESOURCES) $(__ECS_VERSION_INFO) )

_ecs_delete_containerinstance:
	@$(INFO) '$(ECS_UI_LABEL)Deleting an existing container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation removes the instance from the cluster, but does NOT terminate the EC2 instance'; $(NORMAL)
	$(AWS) ecs deregister-container-instance $(__ECS_CLUSTER__CONTAINERINSTANCE) $(__ECS_CONTAINER_INSTANCE) $(__ECS_FORCE__CONTAINERINSTANCE)

_ecs_show_containerinstance :: _ecs_show_containerinstance_attributes _ecs_show_containerinstance_instanceprofile _ecs_show_containerinstance_registeredresources _ecs_show_containerinstance_remainingresources _ecs_show_containerinstance_tags _ecs_show_containerinstance_description

_ecs_show_containerinstance_attributes:
	@$(INFO) '$(ECS_UI_LABEL)Showing attributes of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCE) $(__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCE) $(_X_ECS_INCLUDE__CONTAINERINSTANCE) --query "containerInstances[].{attributes:attributes}"

_ecs_show_containerinstance_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCE) $(__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCE) $(__ECS_INCLUDE__CONTAINERINSTANCE) --query "containerInstances[]$(ECS_UI_SHOW_CONTAINERINSTANCE_FIELDS)"

_ecs_show_containerinstance_instanceprofile ::
	@$(INFO) '$(ECS_UI_LABEL)Showing instance-profile of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	# SSH into the container-instance
	# $ curl -s 169.254.169.254/latest/meta-data/iam/info
	# {
	# "Code" : "Success",
	# "LastUpdated" : "2019-11-12T07:28:42Z",
	# "InstanceProfileArn" : "arn:aws:iam::123456789012:instance-profile/ecs-instance-role",
	# "InstanceProfileId" : "AIPAJGBJXWLBVQN3XJW7M"
	# }

_ecs_show_containerinstance_registeredresources:
	@$(INFO) '$(ECS_UI_LABEL)Showing registered-resources of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCE) $(__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCE) $(_X_ECS_INCLUDE__CONTAINERINSTANCE) --query "containerInstances[].{registeredResources:registeredResources}"

_ecs_show_containerinstance_remainingresources:
	@$(INFO) '$(ECS_UI_LABEL)Showing remaining-resources of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCE) $(__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCE) $(_X_ECS_INCLUDE__CONTAINERINSTANCE) --query "containerInstances[].{remainingResources:remainingResources}"

_ecs_show_containerinstance_tags:
	@$(INFO) '$(ECS_UI_LABEL)Showing tags of container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are not using long-arns'; $(NORMAL)
	-$(AWS) ecs list-tags-for-resource $(__ECS_RESOURCE_ARN__CONTAINERINSTANCE) --query 'tags[]'

_ecs_show_containerinstances :: _ecs_show_containerinstances_description

_ecs_show_containerinstances_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of container-instances in cluster "$(ECS_CONTAINERINSTANCES_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns entries ordered based on the container-instance-ARN order on the command line'; $(NORMAL)
	$(if $(ECS_CONTAINERINSTANCES_ARNS_OR_IDS), $(AWS) ecs describe-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCES) $(__ECS_CONTAINER_INSTANCES__CONTAINERINSTANCES) $(__ECS_INCLUDE__CONTAINERINSTANCES) --query "containerInstances[]$(ECS_UI_SHOW_CONTAINERINSTANCES_FIELDS)")

_ecs_tag_containerinstance:
	@$(INFO) '$(ECS_UI_LABEL)Tagging container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are not using long-arns'; $(NORMAL)
	-$(AWS) ecs tag-resource $(__ECS_RESOURCE_ARN__CONTAINERINSTANCE) $(__ECS_TAGS__CONTAINERINSTANCE)

_ecs_untag_containerinstance:
	@$(INFO) '$(ECS_UI_LABEL)Untagging container-instance "$(ECS_CONTAINERINSTANCE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if you are not using long-arns'; $(NORMAL)
	-$(AWS) ecs untag-resource $(__ECS_RESOURCE_ARN__CONTAINERINSTANCE) $(__ECS_TAG_KEYS__CONTAINERINSTANCE)

_ecs_view_containerinstances:
	@$(INFO) '$(ECS_UI_LABEL)Viewing all container-instances ...'; $(NORMAL)
	$(AWS) ecs list-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCES) $(_X__ECS_FILTER__CONTAINERINSTANCES) $(_X__ECS_MAX_ITEMS__CONTAINERINSTANCES) $(_X__ECS_STATUS__CONTAINERINSTANCES) --query "containerInstanceArns[]$(ECS_UI_VIEW_CONTAINERINSTANCES_FIELDS)"

_ecs_view_containerinstances_set:
	@$(INFO) '$(ECS_UI_LABEL)Viewing container-instances-set "$(ECS_CONTAINERINSTANCES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Container-instances are grouped based on the provided cluster, filter, status, and query-filter'; $(NORMAL)
	$(AWS) ecs list-container-instances $(__ECS_CLUSTER__CONTAINERINSTANCES) $(__ECS_FILTER__CONTAINERINSTANCES) $(_X__ECS_MAX_ITEMS__CONTAINERINSTANCES) $(__ECS_STATUS__CONTAINERINSTANCES) --query "containerInstanceArns[$(ECS_UI_VIEW_CONTAINERINSTANCES_SET_QUERYFILTER)]$(ECS_UI_VIEW_CONTAINERINSTANCES_SET_FIELDS)"
