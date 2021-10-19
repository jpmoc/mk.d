_AWS_ECS_TASK_MK_VERSION= $(_AWS_ECS_MK_VERSION)

# ECS_TASK_ACCOUNT_ID?=
# ECS_TASK_ARN?= arn:aws:ecs:us-east-1:123456789012:task/57fb883a-36b0-4e86-99c7-d7007634966c
# ECS_TASK_ARN_OR_ID?=
# ECS_TASK_CLUSTER_ARN?=
# ECS_TASK_CLUSTER_ARN_OR_NAME?=
# ECS_TASK_CLUSTER_NAME?= my-cluster
# ECS_TASK_CONTAINER_LOGGROUPNAME?= /fargate/task/web
# ECS_TASK_CONTAINER_LOGREGION?= us-west-1
# ECS_TASK_CONTAINER_LOGSTREAMPREFIX?= fargate
# ECS_TASK_CONTAINER_NAME?= web
# ECS_TASK_CONTAINERINSTANCE_ARN?=
# ECS_TASK_CONTAINERINSTANCE_ARN_OR_ID?=
# ECS_TASK_CONTAINERINSTANCE_ID?= f6bbb147-5370-4ace-8c73-c7181ded911f
# ECS_TASK_CONTAINERS_LOGGROUPNAMES?= /fargate/task/web ...
# ECS_TASK_CONTAINERS_LOGREGIONS?= us-west-1 ...
# ECS_TASK_CONTAINERS_LOGSTREAMPREFIXES?= fargate ...
# ECS_TASK_CONTAINERS_NAMES?= web ...
ECS_TASK_DELETE_REASON?= 'Task stopped by user'
# ECS_TASK_GROUP?= family:task_web
# ECS_TASK_ID?= 57fb883a-36b0-4e86-99c7-d7007634966c
ECS_TASK_INCLUDE?= TAGS
# ECS_TASK_NAME?= my-task
# ECS_TASK_NETWORK_CONFIGURATION?= awsvpcConfiguration={subnets=[string,string],securityGroups=[string,string],assignPublicIp=string}
# ECS_TASK_NETWORKINTERFACE_ID?= eni-5ad7e90c
# ECS_TASK_REGION_ID?= us-west-2
# ECS_TASK_RUN_COUNT?= 1
# ECS_TASK_TAGS_KEYVALUES?= key=string,value=string ...
# ECS_TASK_TASKDEFINITION_ARN?=
# ECS_TASK_TASKDEFINITION_ARN_OR_NAME?=
# ECS_TASK_TASKDEFINITION_FAMILY?=
# ECS_TASK_TASKDEFINITION_NAME?=
# ECS_TASKS_ARNS?= arn:aws:ecs:us-east-1:123456789012:task/57fb883a-36b0-4e86-99c7-d7007634966c ...
# ECS_TASKS_ARNS_OR_IDS?= arn:aws:ecs:us-east-1:123456789012:task/57fb883a-36b0-4e86-99c7-d7007634966c ...
# ECS_TASKS_ARNS_QUERYFILTER?= *
# ECS_TASKS_CONTAINERINSTANCE_ARN?= 
# ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID?= 
# ECS_TASKS_CONTAINERINSTANCE_ID?= 
ECS_TASKS_DESIREDSTATUS_ENUM?= RUNNING
# ECS_TASKS_FAMILY_NAME?=
# ECS_TASKS_IDS?= f6bbb147-5370-4ace-8c73-c7181ded911f ...
ECS_TASKS_INCLUDE?= TAGS
# ECS_TASKS_LAUNCH_TYPE?= FARGATE
# ECS_TASKS_MAX_ITEMS?= 10
# ECS_TASKS_SERVICE_NAME?= my-service
# ECS_TASKS_SET_NAME?= my-tasks-set

# Derived parameters
ECS_TASK_ACCOUNT_ID?= $(ECS_ACCOUNT_ID)
ECS_TASK_ARN_OR_ID?= $(if $(ECS_TASK_ARN),$(ECS_TASK_ARN),$(ECS_TASK_ID))
ECS_TASK_CLUSTER_ARN?= $(ECS_CLUSTER_ARN)
ECS_TASK_CLUSTER_ARN_OR_NAME?= $(if $(ECS_TASK_CLUSTER_ARN),$(ECS_TASK_CLUSTER_ARN),$(ECS_TASK_CLUSTER_NAME))
ECS_TASK_CLUSTER_NAME?= $(ECS_CLUSTER_NAME)
ECS_TASK_CONTAINER_LOGGROUPNAME?= $(LGS_LOGGROUP_NAME)
ECS_TASK_CONTAINER_LOGSTREAMNAME?= $(LGS_STREAM_NAME)
ECS_TASK_CONTAINER_LOGSTREAMPREFIX?= $(LGS_STREAM_PREFIX)
ECS_TASK_CONTAINER_NAME?= $(firstword $(ECS_TASK_CONTAINERS_NAMES))
ECS_TASK_CONTAINERINSTANCE_ARN?= $(ECS_CONTAINERINSTANCE_ARN)
ECS_TASK_CONTAINERINSTANCE_ARN_OR_ID?= $(if $(ECS_CONTAINERINSTANCE_ARN),$(ECS_CONTAINERINSTANCE_ARN),$(ECS_CONTAINERINSTANCE_ID))
ECS_TASK_CONTAINERINSTANCE_ID?= $(ECS_CONTAINERINSTANCE_ID)
ECS_TASK_NAME?= $(ECS_TASK_ID)
ECS_TASK_NETWORKINTERFACE_ID?= $(EC2_NETWORKINTERFACE_ID)
ECS_TASK_REGION_ID?= $(ECS_REGION_ID)
ECS_TASK_TASKDEFINITION_ARN?= $(ECS_TASKDEFINITION_ARN)
ECS_TASK_TASKDEFINITION_ARN_OR_NAME?= $(if $(ECS_TASKDEFINITION_ARN),$(ECS_TASKDEFINITION_ARN),$(ECS_TASKDEFINITION_NAME))
ECS_TASK_TASKDEFINITION_FAMILY?= $(ECS_TASKDEFINITION_FAMILY)
ECS_TASK_TASKDEFINITION_NAME?= $(ECS_TASKDEFINITION_NAME)
ECS_TASKS_ARNS_OR_IDS?= $(if $(ECS_TASKS_ARNS),$(ECS_TASKS_ARNS),$(ECS_TASKS_IDS))
ECS_TASKS_CLUSTER_ARN?= $(ECS_TASK_CLUSTER_ARN)
ECS_TASKS_CLUSTER_ARN_OR_NAME?= $(if $(ECS_TASKS_CLUSTER_ARN),$(ECS_TASKS_CLUSTER_ARN),$(ECS_TASKS_CLUSTER_NAME))
ECS_TASKS_CLUSTER_NAME?= $(ECS_TASK_CLUSTER_NAME)
ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID?= $(if $(ECS_TASKS_CONTAINERINSTANCE_ARN),$(ECS_TASKS_CONTAINERINSTANCE_ARN),$(ECS_TASKS_CONTAINERINSTANCE_ID))
ECS_TASKS_LAUNCH_TYPE?= $(ECS_TASK_LAUNCH_TYPE)
ECS_TASKS_SERVICE_NAME?= $(ECS_SERVICE_NAME)

# Option parameters
__ESC_CLI_INPUT_JSON__TASK=
__ECS_CLUSTER__TASK= $(if $(ECS_TASK_CLUSTER_ARN_OR_NAME),--cluster $(ECS_TASK_CLUSTER_ARN_OR_NAME))
__ECS_CLUSTER__TASKS= $(if $(ECS_TASKS_CLUSTER_ARN_OR_NAME),--cluster $(ECS_TASKS_CLUSTER_ARN_OR_NAME))
__ECS_CONTAINER_INSTANCE__TASKS= $(if $(ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID),--container-instance $(ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID))
__ECS_CONTAINER_INSTANCES__TASK= $(if $(ECS_TASK_CONTAINERINSTANCE_ARN_OR_ID),--container-instances $(ECS_TASK_CONTAINERINSTANCE_ARN_OR_ID))
__ECS_COUNT= $(if $(ECS_TASK_RUN_COUNT),--count $(ECS_TASK_RUN_COUNT))
__ECS_DESIRED_STATUS= $(if $(ECS_TASKS_DESIREDSTATUS_ENUM),--desired-status $(ECS_TASKS_DESIREDSTATUS_ENUM))
__ECS_ENABLE_ECS_MANAGED_TAGS=
__ECS_FAMILY__TASKS= $(if $(ECS_TASKS_FAMILY_NAME),--family $(ECS_TASKS_FAMILY_NAME))
__ECS_GROUP= $(if $(ECS_TASK_GROUP),--group $(ECS_TASK_GROUP))
__ECS_INCLUDE__TASK= $(if $(ECS_TASK_INCLUDE),--include $(ECS_TASK_INCLUDE))
__ECS_INCLUDE__TASKS= $(if $(ECS_TASKS_INCLUDE),--include $(ECS_TASKS_INCLUDE))
__ECS_LAUNCH_TYPE__TASK= $(if $(ECS_TASK_LAUNCH_TYPE),--launch-type $(ECS_TASK_LAUNCH_TYPE))
__ECS_LAUNCH_TYPE__TASKS= $(if $(ECS_TASKS_LAUNCH_TYPE),--launch-type $(ECS_TASKS_LAUNCH_TYPE))
__ECS_NETWORK_CONFIGURATION= $(if $(ECS_TASK_NETWORK_CONFIGURATION),--network-configuration $(ECS_TASK_NETWORK_CONFIGURATION))
__ECS_OVERRIDES=
__ECS_PROPAGATE_TAGS=
__ECS_REASON= $(if $(ECS_TASK_DELETE_REASON),--reason $(ECS_TASK_DELETE_REASON))
__ECS_RESOURCE_ARN__TASK= $(if $(ECS_TASK_ARN),--resource-arn $(ECS_TASK_ARN))
__ECS_SERVICE_NAME__TASKS= $(if $(ECS_TASKS_SERVICE_NAME),--service-name $(ECS_TASKS_SERVICE_NAME))
__ECS_STARTED_BY=
__ECS_TAGS__TASK= $(if $(ECS_TASK_TAGS_KEVALUES),--tags $(ECS_TASK_TAGS_KEYVALUES))
__ECS_TASK= $(if $(ECS_TASK_ARN_OR_ID),--task $(ECS_TASK_ARN_OR_ID))
__ECS_TASK_DEFINITION__TASK= $(if $(ECS_TASK_TASKDEFINITION_ARN_OR_NAME),--task-definition $(ECS_TASK_TASKDEFINITION_ARN_OR_NAME))
__ECS_TASKS__TASK= $(if $(ECS_TASK_ARN_OR_ID),--tasks $(ECS_TASK_ARN_OR_ID))
__ECS_TASKS__TASKS= $(if $(ECS_TASKS_ARNS_OR_IDS),--tasks $(ECS_TASKS_ARNS_OR_IDS))

# UI parameters
ECS_UI_GET_TASKS_ARNS_QUERYFILTER?=
ECS_UI_SHOW_TASK_FIELDS?=
ECS_UI_SHOW_TASKS_FIELDS?= .{taskArn:taskArn,containerInstanceArn:containerInstanceArn,TaskName:containers[0].name,taskDefinitionArn:taskDefinitionArn}
ECS_UI_SHOW_TASKS_QUERYFILTER?=
ECS_UI_VIEW_TASKS_FIELDS?=
ECS_UI_VIEW_TASKS_SET_FIELDS?= $(ECS_UI_VIEW_TASKS_FIELDS)
ECS_UI_VIEW_TASKS_SET_QUERYFILTER?=

# Pipe parameters
|_ECS_SHOW_TASKS_DESCRIPTIONS?=

#--- Utilities

#--- Macros

_ecs_get_task_arn= $(call _ecs_get_task_arn_I, $(ECS_TASK_ID))
_ecs_get_task_arn_I= $(shell echo "arn:aws:ecs:$(ECS_TASK_REGION_ID):$(ECS_TASK_ACCOUNT_ID):task/$(strip $(1))")

_ecs_get_task_id= $(call _ecs_get_task_id_A, $(ECS_TASK_ARN))
_ecs_get_task_id_A= $(lastword $(subst /,$(SPACE),$(1)))

_ecs_get_task_taskdefinition_arn= $(call _ecs_get_task_taskdefinition_arn_A, $(ECS_TASK_ARN_OR_ID))
_ecs_get_task_taskdefinition_arn_A= $(call _ecs_get_task_taskdefinition_arn_AC, $(1), $(ECS_TASK_CLUSTER_ARN_OR_NAME))
_ecs_get_task_taskdefinition_arn_AC= $(shell $(AWS) ecs describe-tasks --cluster $(2) --tasks $(1) --query "tasks[].taskDefinitionArn" --output text)

_ecs_get_task_networkinterface_id= $(call _ecs_get_task_networkinterface_id_A, $(ECS_TASK_ARN_OR_ID))
_ecs_get_task_networkinterface_id_A= $(call _ecs_get_task_networkinterface_id_AC, $(1), $(ECS_TASK_CLUSTER_ARN_OR_NAME))
_ecs_get_task_networkinterface_id_AC=$(shell $(AWS) ecs describe-tasks --cluster $(2) --tasks $(1) --query "tasks[].attachments[].details[?name=='networkInterfaceId'].value" --output text)

_ecs_get_tasks_arns= $(call _ecs_get_tasks_arns_I, $(ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID))
_ecs_get_tasks_arns_I= $(call _ecs_get_tasks_arns_IS, $(1), $(ECS_TASKS_DESIREDSTATUS_ENUM))
_ecs_get_tasks_arns_IS= $(call _ecs_get_tasks_arns_ISC, $(1), $(2), $(ECS_TASKS_CLUSTER_ARN_OR_NAME))
_ecs_get_tasks_arns_ISC= $(strip $(shell $(AWS) ecs list-tasks --cluster $(3) $(if $(1),--container-instance $(1)) --desired-status $(2) --query "taskArns[]" --output text))

#----------------------------------------------------------------------
# USAGE
#

_ecs_view_framework_macros ::
	@echo 'AWS::ECS::Task ($(_AWS_ECS_TASK_MK_VERSION)) macros:'
	@echo '    _ecs_get_task_arn_{|I}                    - Get the ARN of a task (Id)'
	@echo '    _ecs_get_task_id_{|A}                     - Get the ID of a task (Arn)'
	@echo '    _ecs_get_task_networkinterface_id_{|A}    - Get the network-interface ID of a task (Arn)'
	@echo '    _ecs_get_task_taskdefinition_arn_{|A|AC}  - Get the task-definition of a task (Arn,Cluster)'
	@echo '    _ecs_get_tasks_arns_{|I|IS|ISC}           - Get the ARNs of tasks (containerInstance,Status,Cluster)'
	@echo

_ecs_view_framework_parameters ::
	@echo 'AWS::ECS::Task ($(_AWS_ECS_TASK_MK_VERSION)) parameters:'
	@echo '    ECS_TASK_ACCOUNT_ID=$(ECS_TASK_ACCOUNT_ID)'
	@echo '    ECS_TASK_ARN=$(ECS_TASK_ARN)'
	@echo '    ECS_TASK_ARN_OR_ID=$(ECS_TASK_ARN_OR_ID)'
	@echo '    ECS_TASK_CLUSTER_ARN=$(ECS_TASK_CLUSTER_ARN)'
	@echo '    ECS_TASK_CLUSTER_ARN_OR_NAME=$(ECS_TASK_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_TASK_CLUSTER_NAME=$(ECS_TASK_CLUSTER_NAME)'
	@echo '    ECS_TASK_CONTAINER_LOGGROUPNAME=$(ECS_TASK_CONTAINER_LOGGROUPNAME)'
	@echo '    ECS_TASK_CONTAINER_LOGREGION=$(ECS_TASK_CONTAINER_LOGREGION)'
	@echo '    ECS_TASK_CONTAINER_LOGSTREAMNAME=$(ECS_TASK_CONTAINER_LOGSTREAMNAME)'
	@echo '    ECS_TASK_CONTAINER_LOGSTREAMPREFIX=$(ECS_TASK_CONTAINER_LOGSTREAMPREFIX)'
	@echo '    ECS_TASK_CONTAINER_NAME=$(ECS_TASK_CONTAINER_NAME)'
	@echo '    ECS_TASK_CONTAINERINSTANCE_ARN=$(ECS_TASK_CONTAINERINSTANCE_ARN)'
	@echo '    ECS_TASK_CONTAINERINSTANCE_ARN_OR_ID=$(ECS_TASK_CONTAINERINSTANCE_ARN_OR_ID)'
	@echo '    ECS_TASK_CONTAINERINSTANCE_ID=$(ECS_TASK_CONTAINERINSTANCE_ID)'
	@echo '    ECS_TASK_CONTAINERS_LOGGROUPNAMES=$(ECS_TASK_CONTAINERS_LOGGROUPNAMES)'
	@echo '    ECS_TASK_CONTAINERS_LOGREGIONS=$(ECS_TASK_CONTAINERS_LOGREGIONS)'
	@echo '    ECS_TASK_CONTAINERS_LOGSTREAMNAME=$(ECS_TASK_CONTAINERS_LOGSTREAMPREFIXES)'
	@echo '    ECS_TASK_CONTAINERS_LOGSTREAMPREFIXES=$(ECS_TASK_CONTAINERS_LOGSTREAMPREFIXES)'
	@echo '    ECS_TASK_CONTAINERS_NAMES=$(ECS_TASK_CONTAINERS_NAMES)'
	@echo '    ECS_TASK_DELETE_REASON=$(ECS_TASK_DELETE_REASON)'
	@echo '    ECS_TASK_GROUP=$(ECS_TASK_GROUP)'
	@echo '    ECS_TASK_ID=$(ECS_TASK_ID)'
	@echo '    ECS_TASK_INCLUDE=$(ECS_TASK_INCLUDE)'
	@echo '    ECS_TASK_LAUNCH_TYPE=$(ECS_TASK_LAUNCH_TYPE)'
	@echo '    ECS_TASK_NAME=$(ECS_TASK_NAME)'
	@echo '    ECS_TASK_NETWORK_CONFIGURATION=$(ECS_TASK_NETWORK_CONFIGURATION)'
	@echo '    ECS_TASK_NETWORKINTERFACE_ID=$(ECS_TASK_NETWORKINTERFACE_ID)'
	@echo '    ECS_TASK_REGION_ID=$(ECS_TASK_REGION_ID)'
	@echo '    ECS_TASK_RUN_COUNT=$(ECS_TASK_RUN_COUNT)'
	@echo '    ECS_TASK_TAGS_KEYVALUES=$(ECS_TASK_TAGS_KEYVALUES)'
	@echo '    ECS_TASK_TASKDEFINITION_ARN=$(ECS_TASK_TASKDEFINITION_ARN)'
	@echo '    ECS_TASK_TASKDEFINITION_ARN_OR_NAME=$(ECS_TASK_TASKDEFINITION_ARN_OR_NAME)'
	@echo '    ECS_TASK_TASKDEFINITION_FAMILY=$(ECS_TASK_TASKDEFINITION_FAMILY)'
	@echo '    ECS_TASK_TASKDEFINITION_NAME=$(ECS_TASK_TASKDEFINITION_NAME)'
	@echo '    ECS_TASKS_ARNS=$(ECS_TASKS_ARNS)'
	@echo '    ECS_TASKS_ARNS_OR_IDS=$(ECS_TASKS_ARNS_OR_IDS)'
	@echo '    ECS_TASKS_ARNS_QUERYFILTER=$(ECS_TASKS_ARNS_QUERYFILTER)'
	@echo '    ECS_TASKS_CLUSTER_ARN=$(ECS_TASKS_CLUSTER_ARN)'
	@echo '    ECS_TASKS_CLUSTER_ARN_OR_NAME=$(ECS_TASKS_CLUSTER_ARN_OR_NAME)'
	@echo '    ECS_TASKS_CLUSTER_NAME=$(ECS_TASKS_CLUSTER_NAME)'
	@echo '    ECS_TASKS_CONTAINERINSTANCE_ARN=$(ECS_TASKS_CONTAINERINSTANCE_ARN)'
	@echo '    ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID=$(ECS_TASKS_CONTAINERINSTANCE_ARN_OR_ID)'
	@echo '    ECS_TASKS_CONTAINERINSTANCE_ID=$(ECS_TASKS_CONTAINERINSTANCE_ID)'
	@echo '    ECS_TASKS_DESIREDSTATUS_ENUM=$(ECS_TASKS_DESIREDSTATUS_ENUM)'
	@echo '    ECS_TASKS_FAMILY_NAME=$(ECS_TASKS_FAMILY_NAME)'
	@echo '    ECS_TASKS_IDS=$(ECS_TASKS_IDS)'
	@echo '    ECS_TASKS_INCLUDE=$(ECS_TASKS_INCLUDE)'
	@echo '    ECS_TASKS_LAUNCH_TYPE=$(ECS_TASKS_LAUNCH_TYPE)'
	@echo '    ECS_TASKS_MAX_ITEMS=$(ECS_TASKS_MAX_ITEMS)'
	@echo '    ECS_TASKS_NAMES=$(ECS_TASKS_NAMES)'
	@echo '    ECS_TASKS_SERVICE_NAME=$(ECS_TASKS_SERVICE_NAME)'
	@echo '    ECS_TASKS_SET_NAME=$(ECS_TASKS_SET_NAME)'
	@echo

_ecs_view_framework_targets ::
	@echo 'AWS::ECS::Task ($(_AWS_ECS_TASK_MK_VERSION)) targets:'
	@echo '    _ecs_create_task                  - Create a new task'
	@echo '    _ecs_delete_task                  - Delete an existing task'
	@echo '    _ecs_run_task                     - Create a new task using the ECS scheduler'
	@echo '    _ecs_show_task                    - Show everything related to a task'
	@echo '    _ecs_show_task_description        - Show the description of a task'
	@echo '    _ecs_show_task_logs               - Show logs of main container in a task'
	@echo '    _ecs_show_task_networkinterface   - Show the network-interface of a task'
	@echo '    _ecs_show_task_tags               - Show tags of a task'
	@echo '    _ecs_show_task_taskdefinition     - Show taskdefinition of a task'
	@echo '    _ecs_show_tasks                   - Show everything related to a tasks-set'
	@echo '    _ecs_show_tasks_description       - Show the description of a tasks-set'
	@echo '    _ecs_start_task                   - Create a new task bypassing the ECS scheduler'
	@echo '    _ecs_tail_task                    - Tail the logs of th emain container in a task'
	@echo '    _ecs_view_tasks                   - View existing tasks'
	@echo '    _ecs_view_tasks_set               - View a set of tasks' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_ecs_create_task:
	@$(INFO) '$(ECS_UI_LABEL)Create a new task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Use _ecs_run_task to create a task using the ECS scheduler'; $(NORMAL)
	@$(WARN) 'Use _ecs_start_task to create a task bypassing the ECS scheduler'; $(NORMAL)

_ecs_delete_task:
	@$(INFO) '$(ECS_UI_LABEL)Deleting an existing task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	$(AWS) ecs stop-task $(__ECS_CLUSTER__TASK) $(__ECS_REASON) $(__ECS_TASK)

_ecs_run_task:
	@$(INFO) '$(ECS_UI_LABEL)Create a new task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a new task using the ECS scheduler'; $(NORMAL)
	$(AWS) ecs run-task $(strip $(__ECS_CLI_INPUT_JSON__TASK) $(__ECS_CLUSTER__TASK) $(__ECS_COUNT) $(__ECS_ENABLE_ECS_MANAGED_TAGS) $(__ECS_GROUP) $(__ECS_LAUNCH_TYPE__TASK) $(__ECS_NETWORK_CONFIGURATION) $(__ECS_OVERRIDES) $(__ECS_PLACEMENT_CONSTRAINTS) $(__ESC_PLACEMENT_STRATEGY) $(__ECS_PLACEMENT_VERSION) $(__ESC_PROPAGATE_TAGS) $(__ECS_STARTED_BY) $(__ECS_TAGS__TASK) $(__ECS_TASK_DEFINITION__TASK))

_ecs_show_task :: _ecs_show_task_logs _ecs_show_task_networkinterface _ecs_show_task_tags _ecs_show_task_taskdefinition _ecs_show_task_description

_ecs_show_task_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-tasks $(__ECS_CLUSTER__TASK) $(__ECS_TASKS__TASK) $(__ECS_INCLUDE__TASK) --query 'tasks[]$(ECS_UI_SHOW_TASK_FIELDS)'

_ecs_show_task_logs ::

_ecs_show_task_networkinterface ::

_ecs_show_task_tags:
	@$(INFO) '$(ECS_UI_LABEL)Showing tags of task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if taskLongArn are not enabled'; $(NORMAL)
	-$(AWS) ecs list-tags-for-resource $(__ECS_RESOURCE_ARN__TASK)

_ecs_show_task_taskdefinition:
	@$(INFO) '$(ECS_UI_LABEL)Showing task-definition of task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-task-definition $(_X__ECS_INCLUDE__TASK) --include TAGS $(__ECS_TASK_DEFINITION__TASK) --query 'taskDefinition'

_ecs_show_tasks :: _ecs_show_tasks_descriptions

_ecs_show_tasks_descriptions:
	@$(INFO) '$(ECS_UI_LABEL)Showing descriptions of tasks in tasks-set "$(ECS_TASKS_SET_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-tasks $(__ECS_CLUSTER__TASKS) $(__ECS_TASKS__TASKS) $(__ECS_INCLUDE__TASKS) --query 'tasks[$(ECS_UI_SHOW_TASKS_QUERYFILTER)]$(ECS_UI_SHOW_TASKS_FIELDS)' $(|_ECS_SHOW_TASKS_DESCRIPTIONS)

_ecs_start_task:
	@$(INFO) '$(ECS_UI_LABEL)Creating a new task "$(ECS_TASK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a new task without using the ECS scheduler'; $(NORMAL)
	@$(WARN) 'The task is started on the specified container-instance(s)'; $(NORMAL)
	$(AWS) ecs start-task $(strip $(__ECS_CLI_INPUT_JSON__TASK) $(__ECS_CLUSTER__TASK) $(__ECS_CONTAINER_INSTANCES__TASK) $(__ECS_ENABLE_ECS_MANAGED_TAGS) $(__ECS_GROUP) $(__ECS_NETWORK_CONFIGURATION) $(__ECS_OVERRIDES) $(__ECS_PROPAGATE_TAGS) $(__ECS_STARTED_BY) $(__ECS_TAGS__TASK) $(__ECS_TASK_DEFINITION__TASK) ) --query 'tasks[]'

_ecs_tail_task ::

_ecs_view_tasks:
	@$(INFO) '$(ECS_UI_LABEL)Viewing all tasks ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no cluster is provided'; $(NORMAL)
	@$(WARN) 'This operation returns tasks ordered based on thier ID'; $(NORMAL)
	$(AWS) ecs list-tasks $(__ECS_CLUSTER__TASKS) $(_X__ECS_CONTAINER_INSTANCE__TASKS) $(_X__ECS_DESIRED_STATUS) $(_X__ECS_FAMILY__TASKS) $(_X__ECS_LAUNCH_TYPE__TASKS) $(_X__ECS_SERVICE_NAME__TASKS) $(_X__ECS_START_BY) --query 'taskArns[]$(ECS_UI_VIEW_TASKS_FIELDS)'

_ecs_view_tasks_set:
	@$(INFO) '$(ECS_UI_LABEL)Viewing tasks-set "$(ECS_TASKS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if no cluster is provided'; $(NORMAL)
	@$(WARN) 'This operation returns tasks ordered based on thier ID'; $(NORMAL)
	@$(WARN) 'Tasks are grouped based on the provided cluster, container-instance, family, status, and query-filter'; $(NORMAL)
	$(AWS) ecs list-tasks $(__ECS_CLUSTER__TASKS) $(__ECS_CONTAINER_INSTANCE__TASKS) $(__ECS_DESIRED_STATUS) $(__ECS_FAMILY__TASKS) $(__ECS_LAUNCH_TYPE__TASKS) $(__ECS_SERVICE_NAME__TASKS) $(__ECS_START_BY) --query 'taskArns[$(ECS_UI_VIEW_TASKS_SET_QUERYFILTER)]$(ECS_UI_VIEW_TASKS_SET_FIELDS)'
