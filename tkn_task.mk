_TKN_TASK_MK_VERSION= $(_TKN_MK_VERSION)

# TKN_TASK_NAME?= helloworld-go
# TKN_TASK_NAMESPACE_NAME?= eventing-example
# TKN_TASK_MANIFEST_DIRPATH?= ./in/
# TKN_TASK_MANIFEST_FILENAME?= task.yaml
# TKN_TASK_MANIFEST_FILEPATH?= ./in/task.yaml
# TKN_TASK_PARAMETERS_KEYVALUES?= param1=value1 ...
# TKN_TASK_SHOWLOG_FLAG?= false 
# TKN_TASK_USEDEFAULTS_FLAG?= false 
# TKN_TASKS_NAMESPACE_NAME?= eventing-example
# TKN_TASKS_SET_NAME?= my-task-set

# Derived parameters
TKN_TASK_MANIFEST_DIRPATH?= $(TKN_INPUTS_DIRPATH)
TKN_TASK_MANIFEST_FILEPATH?= $(TKN_TASK_MANIFEST_DIRPATH)$(TKN_TASK_MANIFEST_FILENAME)
TKN_TASK_NAMESPACE_NAME?= $(TKN_NAMESPACE_NAME)
TKN_TASK_SHOWLOG_FLAG?= $(TKN_SHOWLOG_FLAG)
TKN_TASKS_NAMESPACE_NAME?= $(TKN_TASK_NAMESPACE_NAME)
TKN_TASKS_SET_NAME?= tasks@@@$(TKN_TASKS_NAMESPACE_NAME)

# Option parameters
# __TKN_ALL_NAMESPACES__TASKS=
__TKN_NAMESPACE__TASK= $(if $(TKN_TASK_NAMESPACE_NAME),--namespace $(TKN_TASK_NAMESPACE_NAME))
__TKN_NAMESPACE__TASKS= $(if $(TKN_TASKS_NAMESPACE_NAME),--namespace $(TKN_TASKS_NAMESPACE_NAME))
__TKN_PARAM__TASK= $(if $(TKN_TASK_PARAMETERS_KEYVALUES),--param $(TKN_TASK_PARAMETERS_KEYVALUES))
__TKN_SHOWLOG__TASK= $(if $(filter true,$(TKN_TASK_SHOWLOG_FLAG)),--showlog)
__TKN_USE_PARAM_DEFAULTS__TASK= $(if $(filter true,$(TKN_TASK_USEDEFAULTS_FLAG)),--use-param-defaults)

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'TKN::Task ($(_TKN_TASK_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'TKN::Task ($(_TKN_TASK_MK_VERSION)) parameters:'
	@echo '    TKN_TASK_MANIFEST_DIRPATH=$(TKN_TASK_MANIFEST_DIRPATH)'
	@echo '    TKN_TASK_MANIFEST_FILENAME=$(TKN_TASK_MANIFEST_FILENAME)'
	@echo '    TKN_TASK_MANIFEST_FILEPATH=$(TKN_TASK_MANIFEST_FILEPATH)'
	@echo '    TKN_TASK_NAME=$(TKN_TASK_NAME)'
	@echo '    TKN_TASK_NAMESPACE_NAME=$(TKN_TASK_NAMESPACE_NAME)'
	@echo '    TKN_TASK_PARAMETERS_KEYVALUES=$(TKN_TASK_PARAMETERS_KEYVALUES)'
	@echo '    TKN_TASK_SHOWLOG_FLAG=$(TKN_TASK_SHOWLOG_FLAG)'
	@echo '    TKN_TASK_USEDEFAULTS_FLAG=$(TKN_TASK_USEDEFAULTS_FLAG)'
	@echo '    TKN_TASKS_NAMESPACE_NAME=$(TKN_TASKS_NAMESPACE_NAME)'
	@echo '    TKN_TASKS_SET_NAME=$(TKN_TASKS_SET_NAME)'
	@echo

_kn_view_framework_targets ::
	@echo 'TKN::Task ($(_TKN_TASK_MK_VERSION)) targets:'
	@echo '    _tkn_create_task                  - Create a new task'
	@echo '    _tkn_delete_task                  - Delete an existing task'
	@echo '    _tkn_show_task                    - Show everything related to a task'
	@echo '    _tkn_show_task_description        - Show the description of a task'
	@echo '    _tkn_show_task_taskruns           - Show the taskruns of a task'
	@echo '    _tkn_start_task                   - Start a task'
	@echo '    _tkn_view_tasks                   - View all tasks'
	@echo '    _tkn_view_tasks_set               - View a set of tasks'
	@#echo '    _tkn_watch_tasks                  - Watch tasks'
	@#echo '    _tkn_watch_tasks_set              - Watch a set of tasks'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tkn_create_task:
	@$(INFO) '$(TKN_UI_LABEL)Creating task "$(TKN_TASK_NAME)" ...'; $(NORMAL)
	$(TKN) task create ... $(__TKN_NAMESPACE__TASK) $(TKN_TASK_NAME)

_tkn_delete_task:
	@$(INFO) '$(TKN_UI_LABEL)Deleting task "$(TKN_TASK_NAME)" ...'; $(NORMAL)

_tkn_show_task: _tkn_show_task_parameters _tkn_show_task_taskruns _tkn_show_task_workspaces _tkn_show_task_description

_tkn_show_task_description:
	@$(INFO) '$(TKN_UI_LABEL)Showing description of task "$(TKN_TASK_NAME)" ...'; $(NORMAL)
	$(TKN) task describe $(__TKN_NAMESPACE__TASK) $(TKN_TASK_NAME)

_tkn_show_task_parameters:
	@$(INFO) '$(TKN_UI_LABEL)Showing parameters of task "$(TKN_TASK_NAME)" ...'; $(NORMAL)

_tkn_show_task_taskruns:
	@$(INFO) '$(TKN_UI_LABEL)Showing task-runs of task "$(TKN_TASK_NAME)" ...'; $(NORMAL)

_tkn_show_task_workspaces:
	@$(INFO) '$(TKN_UI_LABEL)Showing workspaces of task "$(TKN_TASK_NAME)" ...'; $(NORMAL)

_tkn_start_task:
	@$(INFO) '$(TKN_UI_LABEL)Starting task "$(TKN_TASK_NAME)" ...'; $(NORMAL)
	$(TKN) task start $(__TKN_PARAM__TASK) $(__TKN_SHOWLOG__TASK) $(__TKN_USE_PARAM_DEFAULTS__TASK) $(TKN_TASK_NAME)

_tkn_update_task:
	@$(INFO) '$(TKN_UI_LABEL)Updating task "$(TKN_TASK_NAME)" ...'; $(NORMAL)

_tkn_view_tasks:
	@$(INFO) '$(TKN_UI_LABEL)Viewing ALL tasks ...'; $(NORMAL)
	$(TKN) task list --all-namespaces=true $(_X__TKN_NAMESPACE__TASKS)

_tkn_view_tasks_set:
	@$(INFO) '$(TKN_UI_LABEL)Viewing tasks-set "$(TKN_TASKS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Tasks are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(TKN) task list --all-namespaces=false $(__TKN_NAMESPACE__TASKS)

_tkn_watch_tasks:
	@$(INFO) '$(TKN_UI_LABEL)Watching tasks ...'; $(NORMAL)

_tkn_watch_tasks_set:
	@$(INFO) '$(TKN_UI_LABEL)Watching tasks ...'; $(NORMAL)
