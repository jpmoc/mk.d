_AWS_ECSCLI_TASK_MK_VERSION= $(_AWS_ECSCLI_MK_VERSION)

# ECI_TASK_CLUSTER_NAME?=
ECI_TASK_CREATELOGGROUPS_FLAG?= false
# ECI_TASK_DIRPATH?= ./
# ECI_TASK_DOCKERCOMPOSE_DIRPATH?= ./
ECI_TASK_DOCKERCOMPOSE_FILENAME?= docker-compose.yml
# ECI_TASK_DOCKERCOMPOSE_FILEPATH?= ./docker-compose.yml
# ECI_TASK_ECSPARAMS_DIRPATH?= ./
ECI_TASK_ECSPARAMS_FILENAME?= ecs-params.yml
# ECI_TASK_ECSPARAMS_FILEPATH?= ./ecs-params.yml
# ECI_TASK_ID?=
# ECI_TASK_LAUNCH_TYPE?= EC2
# ECI_TASK_REGION_ID?= us-west-2
# ECI_TASK_TAGS_KEYVALUES?= key=value ...
# ECI_TASK_TAIL_FOLLOW?= true
# ECI_TASKS_CLUSTER_NAME?=
# ECI_TASKS_DESIRED_STATUS?=
# ECI_TASKS_REGION_ID?= us-west-2
# ECI_TASKS_SET_NAME?=

# Derived parameters
ECI_TASK_CLUSTER_NAME?= $(ECI_CLUSTER_NAME)
ECI_TASK_DIRPATH?= $(ECI_INPUTS_DIRPATH)
ECI_TASK_DOCKERCOMPOSE_DIRPATH?= $(ECI_TASK_DIRPATH)
ECI_TASK_DOCKERCOMPOSE_FILEPATH?= $(ECI_TASK_DOCKERCOMPOSE_DIRPATH)$(ECI_TASK_DOCKERCOMPOSE_FILENAME)
ECI_TASK_ECSPARAMS_DIRPATH?= $(ECI_TASK_DIRPATH)
ECI_TASK_ECSPARAMS_FILEPATH?= $(ECI_TASK_ECSPARAMS_DIRPATH)$(ECI_TASK_ECSPARAMS_FILENAME)
ECI_TASK_LAUNCH_TYPE?= $(ECI_LAUNCH_TYPE)
ECI_TASK_REGION_ID?= $(ECI_REGION_ID)
ECI_TASKS_REGION_ID?= $(ECI_TASK_REGION_ID)
ECI_TASKS_CLUSTER_NAME?= $(ECI_TASK_CLUSTER_NAME)

# Options parameters
__ECI_CLUSTER__TASK= $(if $(ECI_TASK_CLUSTER_NAME),--cluster $(ECI_TASK_CLUSTER_NAME))
__ECI_CLUSTER__TASKS= $(if $(ECI_TASKS_CLUSTER_NAME),--cluster $(ECI_TASKS_CLUSTER_NAME))
__ECI_CREATE_LOG_GROUPS__TASK= $(if $(filter true, $(ECI_TASK_CREATELOGGROUPS_FLAG)),--create-log-groups)
__ECI_DESIRED_STATUS= $(if $(ECI_TASKS_DESIRED_STATUS),--desired-status $(ECI_TASKS_DESIRED_STATUS))
# __ECI_ECS_PARAMS__TASK= $(if $(ECI_TASK_ECSPARAMS_FILEPATH),--ecs-params $(ECI_TASK_ECSPARAMS_FILEPATH))
__ECI_FOLLOW= $(if $(filter true, $(ECI_TASK_TAIL_FOLLOW)),--follow)
# __ECI_FILE__TASK= $(if $(ECI_TASK_DOCKERCOMPOSE_FILEPATH),--file $(ECI_TASK_DOCKERCOMPOSE_FILEPATH))
__ECI_LAUNCH_TYPE__TASK= $(if $(ECI_TASK_LAUNCH_TYPE),--launch-type $(ECI_TASK_LAUNCH_TYPE))
__ECI_REGION__TASK= $(if $(ECI_TASK_REGION_ID),--region $(ECI_TASK_REGION_ID))
__ECI_REGION__TASKS= $(if $(ECI_TASKS_REGION_ID),--region $(ECI_TASKS_REGION_ID))
__ECI_TAGS_TASK= $(if $(ECI_TASK_TAGS_KEYVALUES),--tags $(subst $(SPACE),$(COMMA),$(ECI_TASK_TAGS_KEYVALUES)))
__ECI_TASK_ID= $(if $(ECI_TASK_ID),--task-id $(ECI_TASK_ID))

# Pipe parameters

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_eci_view_framework_macros ::
	@echo 'AWS::EcsClI::Task ($(_AWS_ECSCLI_TASK_MK_VERSION)) macros:'
	@echo

_eci_view_framework_parameters ::
	@echo 'AWS::EcsClI::Task ($(_AWS_ECSCLI_TASK_MK_VERSION)) parameters:'
	@echo '    ECI_TASK_CLUSTER_NAME=$(ECI_TASK_CLUSTER_NAME)'
	@echo '    ECI_TASK_CREATELOGGROUPS_FLAG=$(ECI_TASK_CREATELOGGROUPS_FLAG)'
	@echo '    ECI_TASK_DIRPATH=$(ECI_TASK_DIRPATH)'
	@echo '    ECI_TASK_DOCKERCOMPOSE_DIRPATH=$(ECI_TASK_DOCKERCOMPOSE_DIRPATH)'
	@echo '    ECI_TASK_DOCKERCOMPOSE_FILENAME=$(ECI_TASK_DOCKERCOMPOSE_FILENAME)'
	@echo '    ECI_TASK_DOCKERCOMPOSE_FILEPATH=$(ECI_TASK_DOCKERCOMPOSE_FILEPATH)'
	@echo '    ECI_TASK_ECSPARAMS_DIRPATH=$(ECI_TASK_ECSPARAMS_DIRPATH)'
	@echo '    ECI_TASK_ECSPARAMS_FILENAME=$(ECI_TASK_ECSPARAMS_FILENAME)'
	@echo '    ECI_TASK_ECSPARAMS_FILEPATH=$(ECI_TASK_ECSPARAMS_FILEPATH)'
	@echo '    ECI_TASK_ID=$(ECI_TASK_ID)'
	@echo '    ECI_TASK_LAUNCH_TYPE=$(ECI_TASK_LAUNCH_TYPE)'
	@echo '    ECI_TASK_NAME=$(ECI_TASK_NAME)'
	@echo '    ECI_TASK_REGION_ID=$(ECI_TASK_REGION_ID)'
	@echo '    ECI_TASK_TAGS_KEYVALUES=$(ECI_TASK_TAGS_KEYVALUES)'
	@echo '    ECI_TASKS_CLUSTER_NAME=$(ECI_TASKS_CLUSTER_NAME)'
	@echo '    ECI_TASKS_DESIRED_STATUS=$(ECI_TASKS_DESIRED_STATUS)'
	@echo '    ECI_TASKS_REGION_ID=$(ECI_TASKS_REGION_ID)'
	@echo '    ECI_TASKS_SET_NAME=$(ECI_TASKS_SET_NAME)'
	@echo

_eci_view_framework_targets ::
	@echo 'AWS::EcsClI::Task ($(_AWS_ECSCLI_TASK_MK_VERSION)) targets:'
	@echo '    _eci_create_task                  - Create a new task'
	@echo '    _eci_delete_task                  - Delete an existing task'
	@echo '    _eci_show_task                    - Show everything related to a task'
	@echo '    _eci_show_task_description        - Show the description of a task'
	@echo '    _eci_view_tasks                   - View tasks'
	@echo '    _eci_view_tasks_set               - View a set of tasks'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_eci_create_task:
	@$(INFO) '$(ECI_UI_LABEL)Creating task "$(ECI_TASK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if --create-log-group is selected and the log-group already exists'; $(NORMAL)
	@$(WARN) 'This operation fails if task-definition is referencing a role that does not have the ecs-tasks trust entities'; $(NORMAL)
	@$(WARN) 'This operation starts a task using the task-definition that matches the content of the docker-compose file'; $(NORMAL)
	@# The --ecs-arams and --file do NOT work :-(
	@# cd $(ECI_TASK_DIRPATH); $(ECSCLI) up start $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASK) $(__ECI_CREATE_LOG_GROUPS) $(_X__ECI_ECS_PARAMS__TASK) $(_X__ECI_FILE__TASK) $(__ECI_LAUNCH_TYPE__TASK) $(__ECI_REGION__TASK) $(__ECI_TAGS__TASK)
	cd $(ECI_TASK_DIRPATH); $(ECSCLI) compose start $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASK) $(__ECI_CREATE_LOG_GROUPS__TASK) $(__ECI_LAUNCH_TYPE__TASK) $(__ECI_REGION__TASK)

_eci_delete_task:
	@$(INFO) '$(ECI_UI_LABEL)Deleting task "$(ECI_TASK_NAME)" ...'; $(NORMAL)
	cd $(ECI_TASK_DIRPATH); $(ECSCLI) compose stop $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASK) $(__ECI_REGION__TASK)

_eci_show_task :: _eci_show_task_description

_eci_show_task_description: 
	@$(INFO) '$(ECI_UI_LABEL)Showing description of task "$(ECI_TASK_NAME)" ...'; $(NORMAL)

_eci_tail_task:
	@$(INFO) '$(ECI_UI_LABEL)Tailing logs of task "$(ECI_TASK_NAME)" ...'; $(NORMAL)
	$(ECSCLI) logs $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASK) $(__ECI_FOLLOW) $(__ECI_REGION__TASK) $(__ECI_TASK_ID)

_eci_view_tasks:
	@$(INFO) '$(ECI_UI_LABEL)Viewing tasks ...'; $(NORMAL)
	$(ECSCLI) ps $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASKS) $(_X__ECI_DESIRED_STATUS) $(__ECI_REGION__TASKS)

_eci_view_tasks_set:
	@$(INFO) '$(ECI_UI_LABEL)Viewing tasks-set "$(ECI_TASKS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Tasks are grouped based on the provided desired-status, ...'; $(NORMAL)
	$(ECSCLI) ps $(__ECI_AWS_PROFILE) $(__ECI_CLUSTER__TASKS) $(__ECI_DESIRED_STATUS) $(__ECI_REGION__TASKS)
