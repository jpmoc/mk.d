_TKN_TASKRUN_MK_VERSION= $(_TKN_MK_VERSION)

# TKN_TASKRUN_NAME?= helloworld-go
# TKN_TASKRUN_NAMESPACE_NAME?= eventing-example
# TKN_TASKRUN_PARAMETERS_KEYVALUES?= param1=value1 ...
# TKN_TASKRUN_SHOWLOG_FLAG?= false 
# TKN_TASKRUN_USEDEFAULTS_FLAG?= false 
# TKN_TASKRUNS_NAMESPACE_NAME?= eventing-example
# TKN_TASKRUNS_SET_NAME?= my-task-set

# Derived parameters
TKN_TASKRUN_NAMESPACE_NAME?= $(TKN_NAMESPACE_NAME)
TKN_TASKRUN_SHOWLOG_FLAG?= $(TKN_SHOWLOG_FLAG)
TKN_TASKRUNS_NAMESPACE_NAME?= $(TKN_TASKRUN_NAMESPACE_NAME)
TKN_TASKRUNS_SET_NAME?= tasks@@@$(TKN_TASKRUNS_NAMESPACE_NAME)

# Option parameters
# __TKN_ALL_NAMESPACES__TASKS=
__TKN_NAMESPACE__TASKRUN= $(if $(TKN_TASKRUN_NAMESPACE_NAME),--namespace $(TKN_TASKRUN_NAMESPACE_NAME))
__TKN_NAMESPACE__TASKRUNS= $(if $(TKN_TASKRUNS_NAMESPACE_NAME),--namespace $(TKN_TASKRUNS_NAMESPACE_NAME))
__TKN_PARAM__TASKRUN= $(if $(TKN_TASK_PARAMETERS_KEYVALUES),--param $(TKN_TASKRUN_PARAMETERS_KEYVALUES))
__TKN_SHOWLOG__TASKRUN= $(if $(filter true,$(TKN_TASKRUN_SHOWLOG_FLAG)),--showlog)
__TKN_USE_PARAM_DEFAULTS__TASKRUN= $(if $(filter true,$(TKN_TASKRUN_USEDEFAULTS_FLAG)),--use-param-defaults)

# Pipe parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kn_view_framework_macros ::
	@echo 'TKN::TaskRun ($(_TKN_TASKRUN_MK_VERSION)) macros:'
	@echo

_kn_view_framework_parameters ::
	@echo 'TKN::TaskRun ($(_TKN_TASKRUN_MK_VERSION)) parameters:'
	@echo '    TKN_TASKRUN_NAME=$(TKN_TASKRUN_NAME)'
	@echo '    TKN_TASKRUN_NAMESPACE_NAME=$(TKN_TASKRUN_NAMESPACE_NAME)'
	@echo '    TKN_TASKRUN_PARAMETERS_KEYVALUES=$(TKN_TASKRUN_PARAMETERS_KEYVALUES)'
	@echo '    TKN_TASKRUN_SHOWLOG_FLAG=$(TKN_TASKRUN_SHOWLOG_FLAG)'
	@echo '    TKN_TASKRUN_TASK_NAME=$(TKN_TASKRUN_TASK_NAME)'
	@echo '    TKN_TASKRUN_USEDEFAULTS_FLAG=$(TKN_TASKRUN_USEDEFAULTS_FLAG)'
	@echo '    TKN_TASKRUNS_NAMESPACE_NAME=$(TKN_TASKRUNS_NAMESPACE_NAME)'
	@echo '    TKN_TASKRUNS_SET_NAME=$(TKN_TASKRUNS_SET_NAME)'
	@echo

_kn_view_framework_targets ::
	@echo 'TKN::TaskRun ($(_TKN_TASKRUN_MK_VERSION)) targets:'
	@echo '    _tkn_create_tasrunk                  - Create a new task-run'
	@echo '    _tkn_delete_taskrun                  - Delete an existing task-run'
	@echo '    _tkn_show_taskrun                    - Show everything related to a task-run'
	@echo '    _tkn_show_taskrun_description        - Show the description of a task-run'
	@echo '    _tkn_show_taskrun_parameters         - Show the parameters of a task-run'
	@echo '    _tkn_show_taskrun_task               - Show the task of a task-run'
	@echo '    _tkn_view_taskruns                   - View all task-runs'
	@echo '    _tkn_view_taskruns_set               - View a set of task-runs'
	@#echo '    _tkn_watch_taskruns                  - Watch task-runs'
	@#echo '    _tkn_watch_taskruns_set              - Watch a set of task-runs'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tkn_create_taskrun:
	@$(INFO) '$(TKN_UI_LABEL)Creating task-run "$(TKN_TASKRUN_NAME)" ...'; $(NORMAL)
	$(TKN) task create ... $(__TKN_NAMESPACE__TASK) $(TKN_TASK_NAME)

_tkn_delete_taskrun:
	@$(INFO) '$(TKN_UI_LABEL)Deleting task-run "$(TKN_TASKRUN_NAME)" ...'; $(NORMAL)

_tkn_show_taskrun: _tkn_show_task_parameters _tkn_show_task_taskruns _tkn_show_task_workspaces _tkn_show_task_description

_tkn_show_taskrun_description:
	@$(INFO) '$(TKN_UI_LABEL)Showing description of task-run "$(TKN_TASKRUN_NAME)" ...'; $(NORMAL)
	$(TKN) taskrun describe $(__TKN_NAMESPACE__TASK) $(TKN_TASK_NAME)

_tkn_show_taskrun_parameters:
	@$(INFO) '$(TKN_UI_LABEL)Showing parameters of task-run "$(TKN_TASKRUN_NAME)" ...'; $(NORMAL)

_tkn_show_taskrun_task:
	@$(INFO) '$(TKN_UI_LABEL)Showing task-runs of task-run "$(TKN_TASKRUN_NAME)" ...'; $(NORMAL)

_tkn_show_taskrun_workspaces:
	@$(INFO) '$(TKN_UI_LABEL)Showing workspaces of task-run "$(TKN_TASKRUN_NAME)" ...'; $(NORMAL)

_tkn_view_taskruns:
	@$(INFO) '$(TKN_UI_LABEL)Viewing ALL task-runs ...'; $(NORMAL)
	$(TKN) taskruns list --all-namespaces=true $(_X__TKN_NAMESPACE__TASKRUNS)

_tkn_view_taskruns_set:
	@$(INFO) '$(TKN_UI_LABEL)Viewing task-runs-set "$(TKN_TASKRUNS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Task-runs are grouped based on the provided namespace, and ...'; $(NORMAL)
	$(TKN) taskruns list --all-namespaces=false $(__TKN_NAMESPACE__TASKRUNS)

_tkn_watch_taskruns:
	@$(INFO) '$(TKN_UI_LABEL)Watching task-runs ...'; $(NORMAL)

_tkn_watch_taskruns_set:
	@$(INFO) '$(TKN_UI_LABEL)Watching task-runs ...'; $(NORMAL)
