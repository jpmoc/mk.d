_AWS_STEPFUNCTIONS_ACTIVITY_MK_VERSION= $(_AWS_STEPFUNCTIONS_MK_VERSION)

# SFS_ACTIVITY_ARN?=
# SFS_ACTIVITY_NAME?= my-state-machine

# Derived parameters

# Options parameters
__SFS_ACTIVITY_ARN?= $(if $(SFS_ACTIVITY_ARN), --state-machine-arn $(SFS_ACTIVITY_ARN))
__SFS_NAME_ACTIVITY?= $(if $(SFS_ACTIVITY_NAME), --name $(SFS_ACTIVITY_NAME))

# UI parameters

#--- MACROS
_sfs_get_activity_arn= $(call _sfs_get_activity_arn_N, $(SFS_ACTIVITY_NAME))
_sfs_get_activity_arn_N= $(shell $(AWS) stepfunctions ...)

#----------------------------------------------------------------------
# USAGE
#
_sfs_view_framework_macros ::
	@echo 'AWS::StepFunctionS::Activity ($(_AWS_STEPFUNCTIONS_ACTIVITY_MK_VERSION)) macros:'
	@echo '    _sfs_get_activity_arn_{|N}         - Get the ARN of a state-machine (Name)'
	@echo

_sfs_view_framework_parameters ::
	@echo 'AWS::StepFunctionS::Activity ($(_AWS_STEPFUNCTIONS_ACTIVITY_MK_VERSION)) parameters:'
	@echo '    SFS_ACTIVITY_ARN=$(SFS_ACTIVITY_ARN)'
	@echo '    SFS_ACTIVITY_NAME=$(SFS_ACTIVITY_NAME)'
	@echo

_sfs_view_framework_targets ::
	@echo 'AWS::StepFunctionS::Activity ($(_AWS_STEPFUNCTIONS_ACTIVITY_MK_VERSION)) targets:'
	@echo '    _sfs_create_activity              - Create a new activity'
	@echo '    _sfs_delete_activity              - Delete an existing activity'
	@echo '    _sfs_show_activity                - Show an existing activity'
	@echo '    _sfs_view_activities              - View all existing activities'
	@echo '    _sfs_view_activities_set          - View a set of activities'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_sfs_create_activity:
	@$(INFO) '$(AWS_UI_LABEL)Creating activity "$(SFS_ACTIVITY_NAME)" ...'; $(NORMAL)
	$(AWS) stepfunctions create-activity $(__SFS_NAME_ACTIVITY)

_sfs_delete_activity:
	@$(INFO) '$(AWS_UI_LABEL)Deleting activity "$(SFS_ACTIVITY_NAME)" ...'; $(NORMAL)
	$(AWS) stepfunctions delete-activity $(__SFS_ACTIVITY_ARN)

_sfs_show_activity:
	@$(INFO) '$(AWS_UI_LABEL)Showing activity "$(SFS_ACTIVITY_NAME)" ...'; $(NORMAL)
	$(AWS) stepfunctions describe-activity $(__SFS_ACTIVITY_ARN)

_sfs_view_activities:
	@$(INFO) '$(AWS_UI_LABEL)Viewing activities ...'; $(NORMAL)
	$(AWS) stepfunctions list-activities

_sfs_view_activities_set:
