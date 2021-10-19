_AWS_ECS_TASKDEFINITION_MK_VERSION= $(_AWS_ECS_MK_VERSION)

# ECS_TASKDEFINITION_ACCOUNT_ID?=
# ECS_TASKDEFINITION_ARN?= arn:aws:ecs:us-east-1:123456789012:task-definition/woodaaron-k8s-cluster-manager-2682897256:2
# ECS_TASKDEFINITION_ARN_OR_NAME?=
# ECS_TASKDEFINITION_CONFIG_DIRPATH?= ./in/
# ECS_TASKDEFINITION_CONFIG_FILENAME?= my-task-definition.json
# ECS_TASKDEFINITION_CONFIG_FILEPATH?= ./in/my-task-definition.json
# ECS_TASKDEFINITION_CONTAINERS_DEFINITIONS?=
# ECS_TASKDEFINITION_CONTAINERS_LOGGROUPNAMES?= /fargate/task/web ...
# ECS_TASKDEFINITION_CONTAINERS_LOGREGIONS?= us-east-1 ...
# ECS_TASKDEFINITION_CONTAINERS_LOGSTREAMPREFIXES?= fargate ...
# ECS_TASKDEFINITION_CPU?=
# ECS_TASKDEFINITION_EXECUTIONROLE_ARN?= arn:aws:iam::123456789012:role/ecsTaskExecutionRole
ECS_TASKDEFINITION_INCLUDE?= TAGS
# ECS_TASKDEFINITION_IPC_MODE?= host
# ECS_TASKDEFINITION_FAMILY_NAME?= woodaaron-k8s-cluster-manager-2682897256
# ECS_TASKDEFINITION_MEMORY?= 1024 
# ECS_TASKDEFINITION_NAME?= name:1
# ECS_TASKDEFINITION_NETWORK_MODE?= 
# ECS_TASKDEFINITION_PID_MODE?= host
# ECS_TASKDEFINITION_PLACEMENT_CONSTRAINTS?= type=string,expression=string ...
# ECS_TASKDEFINITION_REGION_ID?= us-west-2
# ECS_TASKDEFINITION_REQUIRES_COMPATIBILITIES?=
ECS_TASKDEFINITION_REVISION_ID?= 1
# ECS_TASKDEFINITION_TAGS_KEYVALUES?= key=string,value=string ...
# ECS_TASKDEFINITION_TAGS_KEYS?= key ...
# ECS_TASKDEFINITION_TASKROLE_ARN?=
# ECS_TASKDEFINITION_VOLUMES?= name=string,host={sourcePath=string},dockerVolumeConfiguration={scope=string,autoprovision=boolean,driver=string,driverOpts={KeyName1=string,KeyName2=string},labels={KeyName1=string,KeyName2=string}} ...
# ECS_TASKDEFINITIONS_FAMILY_NAME?=
ECS_TASKDEFINITIONS_INCLUDE?= TAGS
# ECS_TASKDEFINITIONS_MAX_ITEMS?= 10
# ECS_TASKDEFINITIONS_SORT?=
# ECS_TASKDEFINITIONS_STATUS?=
# ECS_TASKDEFINITIONS_SET_NAME?= my-task-definitions-set

# Derived parameters
ECS_TASKDEFINITION_ACCOUNT_ID?= $(ECS_ACCOUNT_ID)
ECS_TASKDEFINITION_ARN?= $(if $(ECS_TASKDEFINITION_NAME),arn:aws:ecs:$(ECS_TASKDEFINITION_REGION_ID):$(ECS_TASKDEFINITION_ACCOUNT_ID):task-definition/$(ECS_TASKDEFINITION_NAME))
ECS_TASKDEFINITION_ARN_OR_NAME?= $(if $(ECS_TASKDEFINITION_ARN),$(ECS_TASKDEFINITION_ARN),$(ECS_TASKDEFINITION_NANE))
ECS_TASKDEFINITION_CONFIG_DIRPATH?= $(ECS_INPUTS_DIRPATH)
ECS_TASKDEFINITION_CONFIG_FILEPATH?= $(ECS_TASKDEFINITION_CONFIG_DIRPATH)$(ECS_TASKDEFINITION_CONFIG_FILENAME)
ECS_TASKDEFINITION_NAME?= $(if $(ECS_TASKDEFINITION_FAMILY_NAME),$(ECS_TASKDEFINITION_FAMILY_NAME):$(ECS_TASKDEFINITION_REVISION_ID))
ECS_TASKDEFINITION_REGION_ID?= $(ECS_REGION_ID)

# Option parameters
__ECS_CLI_INPUT_JSON__TASKDEFINITION= $(if $(ECS_TASKDEFINITION_CONFIG_FILEPATH),--cli-input-json file://$(ECS_TASKDEFINITION_CONFIG_FILEPATH))
__ECS_CONTAINER_DEFINITIONS= $(if $(ECS_TASKDEFINITION_CONTAINERS_DEFINITIONS),--container-definitions $(ECS_TASKDEFINITION_CONTAINERS_DEFINITIONS))
__ECS_CPU= $(if $(ECS_TASKDEFINITION_CPU),--cpu $(ECS_TASKDEFINITION_CPU))
__ECS_EXECUTION_ROLE_ARN= $(if $(ECS_TASKDEFINITION_EXECUTIONROLE_ARN),--execution-role-arn $(ECS_TASKDEFINITION_EXECUTIONROLE_ARN))
__ECS_FAMILY= $(if $(ECS_TASKDEFINITION_FAMILY_NAME),--family $(ECS_TASKDEFINITION_FAMILY_NAME))
__ECS_FAMILY_PREFIX__TASKDEFINITION= $(if $(ECS_TASKDEFINITION_FAMILY_NAME),--family-prefix $(ECS_TASKDEFINITION_FAMILY_NAME))
__ECS_FAMILY_PREFIX__TASKDEFINITIONS= $(if $(ECS_TASKDEFINITIONS_FAMILY_NAME),--family-prefix $(ECS_TASKDEFINITIONS_FAMILY_NAME))
__ECS_INCLUDE__TASKDEFINITION= $(if $(ECS_TASKDEFINITION_INCLUDE),--include $(ECS_TASKDEFINITION_INCLUDE))
__ECS_INCLUDE__TASKDEFINITIONS= $(if $(ECS_TASKDEFINITIONS_INCLUDE),--include $(ECS_TASKDEFINITIONS_INCLUDE))
__ECS_IPC_MODE= $(if $(ECS_TASKDEFINITION_IPC_MODE),--ipc-mode $(ECS_TASKDEFINITION_IPC_MODE))
__ECS_MAX_ITEMS__TASKDEFINITIONS=
__ECS_MEMORY= $(if $(ECS_TASKDEFINITION_MEMORY),--memory $(ECS_TASKDEFINITION_MEMORY))
__ECS_NETWORK_MODE= $(if $(ECS_TASKDEFINITION_NETWORK_MODE),--network-mode $(ECS_TASKDEFINITION_NETWORK_MODE))
__ECS_PID_MODE= $(if $(ECS_TASKDEFINITION_PID_MODE),--pid-mode $(ECS_TASKDEFINITION_PID_MODE))
__ECS_PLACEMENT_CONSTRAINTS= $(if $(ECS_TASKDEFINITION_PLACEMENT_CONSTRAINTS),--placement-constraints $(ECS_TASKDEFINITION_PLACEMENT_CONSTRAINTS))
__ECS_REQUIRES_COMPATIBILITIES= $(if $(ECS_TASKDEFINITION_REQUIRES_COMPATIBILITIES),--requires-compatibilities $(ECS_TASKDEFINITION_REQUIRES_COMPATIBILITIES))
__ECS_RESOURCE_ARN__TASKDEFINITION= $(if $(ECS_TASKDEFINITION_ARN),--resource-arn $(ECS_TASKDEFINITION_ARN))
__ECS_SORT__TASKDEFINITIONS=
__ECS_STATUS__TASKDEFINITIONS= $(if $(ECS_TASKS_STATUS),--status $(ECS_TASKS_STATUS))
__ECS_TAGS__TASKDEFINITION= $(if $(ECS_TASKDEFINITION_TAGS_KEYVALUES),--tags $(ECS_TASKDEFINITION_TAGS_KEYVALUES))
__ECS_TAG_KEYS__TASKDEFINITION= $(if $(ECS_TASKDEFINITION_TAGS_KEYS),--tag-keys $(ECS_TASKDEFINITION_TAGS_KEYS))
__ECS_TASK_DEFINITION= $(if $(ECS_TASKDEFINITION_ARN_OR_NAME),--task-definition $(ECS_TASKDEFINITION_ARN_OR_NAME))
__ECS_TASK_ROLE_ARN= $(if $(ECS_TASKDEFINITION_TASKROLE_ARN),--task-role-arn $(ECS_TASKDEFINITION_TASKROLE_ARN))
__ECS_VOLUMES= $(if $(ECS_TASKDEFINITION_VOLUMES),--volumes $(ECS_TASKDEFINITION_VOLUMES))

# UI parameters
ECS_UI_SHOW_TASKDEFINITION_FIELDS?=
ECS_UI_SHOW_TASKDEFINITION_REVISIONS_QUERYFILTER?=
ECS_UI_VIEW_TASKDEFINITIONS_FIELDS?=
ECS_UI_VIEW_TASKDEFINITIONS_SET_FIELDS?= $(ECS_UI_VIEW_TASKDEFINITIONS_FIELDS)
ECS_UI_VIEW_TASKDEFINITIONS_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

_ecs_get_taskdefinition_arn= $(call _ecs_get_taskdefinition_arn_N, $(ECS_TASKDEFINITION_NAME))
_ecs_get_taskdefinition_arn_N= $(shell echo "arn:aws:ecs:$(ECS_TASKDEFINITION_REGION_ID):$(ECS_TASKDEFINITION_ACCOUNT_ID):task-definition/$(strip $(1))")

_ecs_get_taskdefinition_containers_loggroupnames= $(call _ecs_get_taskdefinition_containers_loggroupnames_A, $(ECS_TASKDEFINITION_ARN_OR_NAME))
_ecs_get_taskdefinition_containers_loggroupnames_A= $(shell $(AWS) ecs describe-task-definition --task-definition $(1) --query '@.taskDefinition.containerDefinitions[].logConfiguration.options[]."awslogs-group"' --output text)

_ecs_get_taskdefinition_containers_logregions= $(call _ecs_get_taskdefinition_containers_logregions_A, $(ECS_TASKDEFINITION_ARN_OR_NAME))
_ecs_get_taskdefinition_containers_logregions_A= $(shell $(AWS) ecs describe-task-definition --task-definition $(1) --query '@.taskDefinition.containerDefinitions[].logConfiguration.options[]."awslogs-region"' --output text)

_ecs_get_taskdefinition_containers_logstreamprefixes= $(call _ecs_get_taskdefinition_containers_logstreamprefixes_A, $(ECS_TASKDEFINITION_ARN_OR_NAME))
_ecs_get_taskdefinition_containers_logstreamprefixes_A= $(shell $(AWS) ecs describe-task-definition --task-definition $(1) --query '@.taskDefinition.containerDefinitions[].logConfiguration.options[]."awslogs-stream-prefix"' --output text)

_ecs_get_taskdefinition_containers_names= $(call _ecs_get_taskdefinition_containers_names_A, $(ECS_TASKDEFINITION_ARN_OR_NAME))
_ecs_get_taskdefinition_containers_names_A= $(shell $(AWS) ecs describe-task-definition --task-definition $(1) --query '@.taskDefinition.containerDefinitions[].name' --output text)


_ecs_get_taskdefinition_executionrole_arn= $(call _ecs_get_taskdefinition_executionrole_arn_A, $(ECS_TASKDEFINITION_ARN_OR_NAME))
_ecs_get_taskdefinition_executionrole_arn_A= $(shell $(AWS) ecs describe-task-definition --task-definition $(1) --query "taskDefinition.executionRoleArn" --output text)

_ecs_get_taskdefinition_family_name= $(call _ecs_get_taskdefinition_family_name_A, $(ECS_TASKDEFINITION_ARN))
_ecs_get_taskdefinition_family_name_A= $(firstword $(subst :,$(SPACE),$(lastword $(subst /,$(SPACE),$(1)))))

_ecs_get_taskdefinition_lastarn= $(call _ecs_get_taskdefinition_lastarn_F, $(ECI_TASKDEFINITION_FAMILITY_NAME))
_ecs_get_taskdefinition_lastarn_F= $(shell $(AWS) ecs list-task-definitions --family-prefix $(1) --query "taskDefinitionArns[-1]" --output text)

_ecs_get_taskdefinition_lastrevision_id= $(call _ecs_get_taskdefinition_lastrevision_id_F, $(ECI_TASKDEFINITION_FAMILY_NAME))
_ecs_get_taskdefinition_lastrevision_id_F= $(shell $(AWS) ecs list-task-definitions --family-prefix $(1) --query "taskDefinitionArns[] | length(@)" --output text)

_ecs_get_taskdefinition_name= $(call _ecs_get_taskdefinition_name_A, $(ECS_TASKDEFINITION_ARN))
_ecs_get_taskdefinition_name_A= $(lastword $(subst /,$(SPACE),$(1)))

_ecs_get_taskdefinition_revision_id= $(call _ecs_get_taskdefinition_revision_id_A, $(ECS_TASKDEFINITION_ARN))
_ecs_get_taskdefinition_revision_id_A= $(lastword $(subst :,$(SPACE),$(1)))


#----------------------------------------------------------------------
# USAGE
#

_ecs_view_framework_macros ::
	@echo 'AWS::ECS::TaskDefinition ($(_AWS_ECS_TASKDEFINITION_MK_VERSION)) macros:'
	@echo '    _ecs_get_taskdefinition_arn_{|N}                          - Get ARN of a task-definition (Name)'
	@echo '    _ecs_get_taskdefinition_containers_loggroupnames_{|A}     - Get the log-groups of containers in a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_containers_logregions_{|A}        - Get the log-regions of containers in a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_containers_logstreamprefixes_{|A} - Get the log-stream-prefixes of containers in a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_containers_names_{|A}             - Get the names of the containers in a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_executionrole_arn_{|A}            - Get execution-role of a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_family_name_{|A}                  - Get the family of a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_lastarn_{|F}                      - Get the ARN of the most-recent task-definition (Family)'
	@echo '    _ecs_get_taskdefinition_lastrevision_id_{|F}              - Get the revision of the most-recent task-definition (Family)'
	@echo '    _ecs_get_taskdefinition_name_{|A}                         - Get the name of a task-definition (Arn)'
	@echo '    _ecs_get_taskdefinition_revision_{|A}                     - Get the revision of a task-definition (Arn)'
	@echo

_ecs_view_framework_parameters ::
	@echo 'AWS::ECS::TaskDefinition ($(_AWS_ECS_TASKDEFINITION_MK_VERSION)) parameters:'
	@echo '    ECS_TASKDEFINITION_ACCOUNT_ID=$(ECS_TASKDEFINITION_ACCOUNT_ID)'
	@echo '    ECS_TASKDEFINITION_ARN=$(ECS_TASKDEFINITION_ARN)'
	@echo '    ECS_TASKDEFINITION_ARN_OR_NAME=$(ECS_TASKDEFINITION_ARN_OR_NAME)'
	@echo '    ECS_TASKDEFINITION_CONFIG_DIRPATH=$(ECS_TASKDEFINITION_CONFIG_DIRPATH)'
	@echo '    ECS_TASKDEFINITION_CONFIG_FILENAME=$(ECS_TASKDEFINITION_CONFIG_FILENAME)'
	@echo '    ECS_TASKDEFINITION_CONFIG_FILEPATH=$(ECS_TASKDEFINITION_CONFIG_FILEPATH)'
	@echo '    ECS_TASKDEFINITION_CONTAINERS_DEFINITIONS=$(ECS_TASKDEFINITION_CONTAINERS_DEFINITIONS)'
	@echo '    ECS_TASKDEFINITION_CONTAINERS_LOGGROUPNAMES=$(ECS_TASKDEFINITION_CONTAINERS_LOGGROUPNAMES)'
	@echo '    ECS_TASKDEFINITION_CONTAINERS_LOGREGIONS=$(ECS_TASKDEFINITION_CONTAINERS_LOGREGIONS)'
	@echo '    ECS_TASKDEFINITION_CONTAINERS_LOGSTREAMPREFIXES=$(ECS_TASKDEFINITION_CONTAINERS_LOGSTREAMPREFIXES)'
	@echo '    ECS_TASKDEFINITION_CONTAINERS_NAMES=$(ECS_TASKDEFINITION_CONTAINERS_NAMES)'
	@echo '    ECS_TASKDEFINITION_CPU=$(ECS_TASKDEFINITION_CPU)'
	@echo '    ECS_TASKDEFINITION_EXECUTIONROLE_ARN=$(ECS_TASKDEFINITION_EXECUTIONROLE_ARN)'
	@echo '    ECS_TASKDEFINITION_FAMILY_NAME=$(ECS_TASKDEFINITION_FAMILY_NAME)'
	@echo '    ECS_TASKDEFINITION_INCLUDE=$(ECS_TASKDEFINITION_INCLUDE)'
	@echo '    ECS_TASKDEFINITION_IPC_MODE=$(ECS_TASKDEFINITION_IPC_MODE)'
	@echo '    ECS_TASKDEFINITION_MEMORY=$(ECS_TASKDEFINITION_MEMORY)'
	@echo '    ECS_TASKDEFINITION_NAME=$(ECS_TASKDEFINITION_NAME)'
	@echo '    ECS_TASKDEFINITION_NETWORK_MODE=$(ECS_TASKDEFINITION_NETWORK_MODE)'
	@echo '    ECS_TASKDEFINITION_PID_MODE=$(ECS_TASKDEFINITION_PID_MODE)'
	@echo '    ECS_TASKDEFINITION_REGION_ID=$(ECS_TASKDEFINITION_REGION_ID)'
	@echo '    ECS_TASKDEFINITION_REVISION_ID=$(ECS_TASKDEFINITION_REVISION_ID)'
	@echo '    ECS_TASKDEFINITION_TAGS_KEYS=$(ECS_TASKDEFINITION_TAGS_KEYS)'
	@echo '    ECS_TASKDEFINITION_TAGS_KEYVALUES=$(ECS_TASKDEFINITION_TAGS_KEYVALUES)'
	@echo '    ECS_TASKDEFINITION_TASKROLE_ARN=$(ECS_TASKDEFINITION_TASKROLE_ARN)'
	@echo '    ECS_TASKDEFINITION_VOLUMES=$(ECS_TASKDEFINITION_VOLUMES)'
	@echo '    ECS_TASKDEFINITIONS_FAMILY_NAME=$(ECS_TASKDEFINITIONS_FAMILY_NAME)'
	@echo '    ECS_TASKDEFINITIONS_INCLUDE=$(ECS_TASKDEFINITIONS_INCLUDE)'
	@echo '    ECS_TASKDEFINITIONS_MAX_ITEMS=$(ECS_TASKDEFINITIONS_MAX_ITEMS)'
	@echo '    ECS_TASKDEFINITIONS_SORT=$(ECS_TASKDEFINITIONS_SORT)'
	@echo '    ECS_TASKDEFINITIONS_STATUS=$(ECS_TASKDEFINITIONS_STATUS)'
	@echo '    ECS_TASKDEFINITIONS_SET_NAME=$(ECS_TASKDEFINITIONS_SET_NAME)'
	@echo

_ecs_view_framework_targets ::
	@echo 'AWS::ECS::TaskDefinition ($(_AWS_ECS_TASKDEFINITION_MK_VERSION)) targets:'
	@echo '    _ecs_create_taskdefinition                      - Create a new task-definition'
	@echo '    _ecs_delete_taskdefinition                      - Delete an existing task-definition'
	@echo '    _ecs_show_taskdefinition                        - Show everything related to a task-definition'
	@echo '    _ecs_show_taskdefinition_containerdefinitions   - Show the container-definitions of a task-definition'
	@echo '    _ecs_show_taskdefinition_description            - Show the description of a task-definition'
	@echo '    _ecs_show_taskdefinition_revisions              - Show revisions of a task-definition'
	@echo '    _ecs_show_taskdefinition_tags                   - Show tags of a task-definition'
	@echo '    _ecs_tag_taskdefinition                         - Tag a task-definition'
	@echo '    _ecs_untag_taskdefinition                       - Untag a task-definition'
	@echo '    _ecs_view_taskdefinitions                       - View existing task-definitions'
	@echo '    _ecs_view_taskdefinitions_set                   - View a set of task-definitions' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_ecs_create_taskdefinition:
	@$(INFO) '$(ECS_UI_LABEL)Creating a new task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the task-definition family does NOT exist, this operation will create revision :1'; $(NORMAL)
	@$(WARN) 'If the task-definition family already exists, this operation will create a new revision'; $(NORMAL)
	$(AWS) ecs register-task-definition $(strip $(__ECS_CLI_INPUT_JSON__TASKDEFINITION) $(__ECS_CONTAINER_DEFINITIONS) $(__ECS_CPU) $(__ECS_EXECUTION_ROLE_ARN) $(__ECS_FAMILY) $(__ECS_IPC_MODE) $(__ECS_MEMORY) $(__ECS_NETWORK_MODE) $(__ECS_PID_MODE) $(__ECS_PLACEMENT_CONSTRAINTS) $(__ECS_REQUIRES_COMPATIBILITIES) $(__ECS_TAGS__TASK) $(__ECS_TASK_ROLE_ARN) $(__ECS_VOLUMES) )

_ecs_delete_taskdefinition:
	@$(INFO) '$(ECS_UI_LABEL)Deleting an existing task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation prevent new tasks from using this task-definition'; $(NORMAL)
	$(AWS) ecs deregister-task-definition $(__ECS_TASK_DEFINITION)

_ecs_show_taskdefinition: _ecs_show_taskdefinition_containerdefinitions _ecs_show_taskdefinition_revisions _ecs_show_taskdefinition_tags _ecs_show_taskdefinition_description

_ecs_show_taskdefinition_containerdefinitions:
	@$(INFO) '$(ECS_UI_LABEL)Showing container-definitions of task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-task-definition $(__ECS_TASK_DEFINITION) $(_X__ECS_INCLUDE__TASKDEFINITION) --query "taskDefinition.containerDefinitions[]" --output json

_ecs_show_taskdefinition_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) ecs describe-task-definition $(__ECS_TASK_DEFINITION) $(__ECS_INCLUDE__TASKDEFINITION) --query "taskDefinition$(ECS_UI_SHOW_TASKDEFINITION_FIELDS)"

_ecs_show_taskdefinition_revisions:
	@$(INFO) '$(ECS_UI_LABEL)Showing other revisions of task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) ecs list-task-definitions $(__ECS_FAMILY_PREFIX__TASKDEFINITION) --query "taskDefinitionArns[$(ECS_UI_SHOW_TASKDEFINITION_REVISIONS_QUERYFILTER)]"

_ecs_show_taskdefinition_tags:
	@$(INFO) '$(ECS_UI_LABEL)Showing tags of task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) ecs list-tags-for-resource $(__ECS_RESOURCE_ARN__TASKDEFINITION) --query 'tags[]'

_ecs_tag_taskdefinition:
	@$(INFO) '$(ECS_UI_LABEL)Tagging task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) ecs tag-resource $(__ECS_RESOURCE_ARN__TASKDEFINITION) $(__ECS_TAGS__TASKDEFINITION)

_ecs_untag_taskdefinition:
	@$(INFO) '$(ECS_UI_LABEL)Untagging task-definition "$(ECS_TASKDEFINITION_NAME)" ...'; $(NORMAL)
	$(AWS) ecs untag-resource $(__ECS_RESOURCE_ARN__TASKDEFINITION) $(__ECS_TAG_KEYS__TASKDEFINITION)

_ecs_view_taskdefinitions:
	@$(INFO) '$(ECS_UI_LABEL)Viewing all task-definitions ...'; $(NORMAL)
	$(AWS) ecs list-task-definitions $(__ECS_FAMILY_PREFIX__TASKDEFINITIONS) $(__ECS_MAX_ITEMS__TASKDEFINITIONS) $(__ECS_SORT__TASKDEFINITIONS) $(__ECS_STATUS__TASKDEFINITIONS) --query 'taskDefinitionArns[]$(ECS_UI_VIEW_TASKDEFINITIONS_FIELDS)'

_ecs_view_taskdefinitions_set:
	@$(INFO) '$(ECS_UI_LABEL)Viewing tasks-definition-set "$(ECS_TASKDEFINITIONS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Task-definitions are grouped based on the provided cluster, arns/ids, and optional query-filter'; $(NORMAL)
	$(AWS) ecs list-task-definitions $(__ECS_FAMILY_PREFIX__TASKDEFINITIONS) $(__ECS_MAX_ITEMS__TASKDEFINITIONS) $(__ECS_SORT__TASKDEFINITIONS) $(__ECS_STATUS_TASKDEFINITIONS) --query "taskDefinitionArns[$(ECS_UI_VIEW_TASKDEFINITIONS_SET_QUERYFILTER)]$(ECS_UI_VIEW_TASKDEFINITIONS_SET_FIELDS)"
