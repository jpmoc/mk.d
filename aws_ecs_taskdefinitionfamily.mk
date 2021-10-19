_AWS_ECS_TASKDEFINITIONFAMILY_MK_VERSION= $(_AWS_ECS_MK_VERSION)

# ECS_TASKDEFINITIONFAMILY_NAME?= task_web
# ECS_TASKDEFINITIONFAMILIES_NAME_PREFIX?= task_
# ECS_TASKDEFINITIONFAMILIES_STATUS?=
# ECS_TASKDEFINITIONFAMILIES_SET_NAME?= my-task-definitions-set

# Derived parameters

# Option parameters
__ECS_FAMILY_PREFIX__TASKDEFINITIONFAMILY= $(if $(ECS_TASKDEFINITIONFAMILY_NAME),--family-prefix $(ECS_TASKDEFINITIONFAMILY_NAME))
__ECS_FAMILY_PREFIX__TASKDEFINITIONFAMILIES= $(if $(ECS_TASKDEFINITIONFAMILIES_NAME_PREFIX),--family-prefix $(ECS_TASKDEFINITIONFAMILIES_NAME_PREFIX))
__ECS_STATUS__TASKDEFINITIONFAMILY= $(if $(ECS_TASKDEFINITIONFAMILY_STATUS),--status $(ECS_TASKDEFINITIONFAMILY_STATUS))
__ECS_STATUS__TASKDEFINITIONFAMILIES= $(if $(ECS_TASKDEFINITIONFAMILIES_STATUS),--status $(ECS_TASKDEFINITIONFAMILIES_STATUS))

# UI parameters
ECS_UI_SHOW_TASKDEFINITIONFAMILY_FIELDS?=
ECS_UI_VIEW_TASKDEFINITIONFAMILIES_FIELDS?=
ECS_UI_VIEW_TASKDEFINITIONFAMILIES_SET_FIELDS?= $(ECS_UI_VIEW_TASKDEFINITIONFAMILIES_FIELDS)
ECS_UI_VIEW_TASKDEFINITIONFAMILIES_SET_QUERYFILTER?=

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ecs_view_framework_macros ::
	@echo 'AWS::ECS::TaskDefinitionFamily ($(_AWS_ECS_TASKDEFINITIONFAMILY_MK_VERSION)) macros:'
	@echo

_ecs_view_framework_parameters ::
	@echo 'AWS::ECS::TaskDefinitionFamily ($(_AWS_ECS_TASKDEFINITIONFAMILY_MK_VERSION)) parameters:'
	@echo '    ECS_TASKDEFINITIONFAMILIES_NAME_PREFIX=$(ECS_TASKDEFINITIONFAMILIES_NAME_PREFIX)'
	@echo '    ECS_TASKDEFINITIONFAMILIES_STATUS=$(ECS_TASKDEFINITIONFAMILIES_STATUS)'
	@echo '    ECS_TASKDEFINITIONFAMILIES_SET_NAME=$(ECS_TASKDEFINITIONFAMILIES_SET_NAME)'
	@echo '    ECS_TASKDEFINITIONFAMILY_NAME=$(ECS_TASKDEFINITIONFAMILY_NAME)'
	@echo '    ECS_TASKDEFINITIONFAMILY_STATUS=$(ECS_TASKDEFINITIONFAMILY_STATUS)'
	@echo

_ecs_view_framework_targets ::
	@echo 'AWS::ECS::TaskDefinitionFamily ($(_AWS_ECS_TASKDEFINITIONFAMILY_MK_VERSION)) targets:'
	@echo '    _ecs_show_taskdefinitionfamily              - Show everything related to a task-definition-family'
	@echo '    _ecs_show_taskdefinitionfamily_description  - Show description of a task-definition-family'
	@echo '    _ecs_show_taskdefinitionfamily_revisions    - Show revisions of a task-definition-family'
	@echo '    _ecs_view_taskdefinitionfamilies            - View task-definition-families'
	@echo '    _ecs_view_taskdefinitionfamilies_set        - View a set of task-definition-families' 
	@echo

#----------------------------------------------------------------------
# PUBLIC_TARGETS
# 

_ecs_create_taskdefinitionfamily: _ecs_create_taskdefinition

_ecs_delete_taskdefinitionfamily:

_ecs_show_taskdefinitionfamily: _ecs_show_taskdefinitionfamily_revisions _ecs_show_taskdefinitionfamily_description

_ecs_show_taskdefinitionfamily_description:
	@$(INFO) '$(ECS_UI_LABEL)Showing description of task-definition-family "$(ECS_TASKDEFINITIONFAMILY_NAME)" ...'; $(NORMAL)
	$(AWS) ecs list-task-definition-families $(__ECS_FAMILY_PREFIX__TASKDEFINITIONFAMILY) $(__ECS_STATUS__TASKDEFINITIONFAMILY) --query "families[]$(ECS_UI_SHOW_TASKDEFINITIONFAMILY_FIELDS)"

_ecs_show_taskdefinitionfamily_revisions:
	@$(INFO) '$(ECS_UI_LABEL)Showing revisions of task-definition-family "$(ECS_TASKDEFINITIONFAMILY_NAME)" ...'; $(NORMAL)

_ecs_view_taskdefinitionfamilies:
	@$(INFO) '$(ECS_UI_LABEL)Viewing all task-definition-families ...'; $(NORMAL)
	$(AWS) ecs list-task-definition-families $(_X__ECS_FAMILY_PREFIX__TASKDEFININITIONFAMILIES) $(_X__ECS_STATUS__TASKDEFINITIONFAMILIES) --query 'families[]$(ECS_UI_VIEW_TASKDEFINITIONFAMILIES_FIELDS)'

_ecs_view_taskdefinitionfamilies_set:
	@$(INFO) '$(ECS_UI_LABEL)Viewing tasks-definition-families-set "$(ECS_TASKDEFINITIONFAMILIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Task-definition-families are grouped based on the provided family-prefix, status, and optional query-filter'; $(NORMAL)
	$(AWS) ecs list-task-definition-families $(__ECS_FAMILY_PREFIX__TASKDEFINITIONFAMILIES) $(__ECS_STATUS__TASKDEFINITIONFAMILIES) --query "families[$(ECS_UI_VIEW_TASKDEFINITIONFAMILIES_SET_QUERYFILTER)]$(ECS_UI_VIEW_TASKDEFINITIONFAMILIES_SET_FIELDS)"
