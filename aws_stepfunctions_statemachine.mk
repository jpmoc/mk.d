_AWS_STEPFUNCTIONS_STATEMACHINE__MK_VERSION= $(_AWS_STEPFUNCTIONS_MK_VERSION)

# SFS_STATEMACHINE_ARN?=
# SFS_STATEMACHINE_DESCRIPTION?= "This is my description"
# SFS_STATEMACHINE_NAME?= my-state-machine
# SFS_STATEMACHINE_ROLE_ARN?=

# Derived parameters

# Options parameters
__SFS_STATEMACHINE_ARN?= $(if $(SFS_STATEMACHINE_ARN), --state-machine-arn $(SFS_STATEMACHINE_ARN))
__SFS_DESCRIPTION_STATEMACHINE?= $(if $(SFS_STATEMACHINE_DESCRIPTION), --description $(SFS_STATEMACHINE_DESCRIPTION))
__SFS_NAME_STATEMACHINE?= $(if $(SFS_STATEMACHINE_NAME), --name $(SFS_STATEMACHINE_NAME))
__SFS_ROLE_ARN_STATEMACHINE?= $(if $(SFS_STATEMACHINE_ROLE_ARN), --role-arn $(SFS_STATEMACHINE_ROLE_ARN))

# UI parameters

#--- MACROS
_sfs_get_statemachine_arn= $(call _sfs_get_statemachine_arn_N, $(SFS_STATEMACHINE_NAME))
_sfs_get_statemachine_arn_N= $(shell $(AWS) stepfunctions ...)

#----------------------------------------------------------------------
# USAGE
#
_sfs_view_framework_macros ::
	@echo 'AWS::StepFunctionS::StateMachine ($(_AWS_STEPFUNCTIONS_STATEMACHINE_MK_VERSION)) macros:'
	@echo '    _sfs_get_statemachine_arn_{|N}         - Get the ARN of a state-machine (Name)'
	@echo

_sfs_view_framework_parameters ::
	@echo 'AWS::StepFunctionS::StateMachine ($(_AWS_STEPFUNCTIONS_STATEMACHINE_MK_VERSION)) parameters:'
	@echo '    SFS_STATEMACHINE_ARN=$(SFS_STATEMACHINE_ARN)'
	@echo '    SFS_STATEMACHINE_DESCRIPTION=$(SFS_STATEMACHINE_DESCRIPTION)'
	@echo '    SFS_STATEMACHINE_NAME=$(SFS_STATEMACHINE_NAME)'
	@echo '    SFS_STATEMACHINE_ROLE_ARN=$(SFS_STATEMACHINE_ROLE_ARN)'
	@echo

_sfs_view_framework_targets ::
	@echo 'AWS::StepFunctionS::StateMachine ($(_AWS_STEPFUNCTIONS_STATEMACHINE_MK_VERSION)) targets:'
	@echo '    _sfs_create_statemachine              - Create a new state-machine'
	@echo '    _sfs_delete_statemachine              - Delete an existing state-machine'
	@echo '    _sfs_show_statemachine                - Show an existing state-machine'
	@echo '    _sfs_view_statemachines               - View all existing state-machines'
	@echo '    _sfs_view_statemachines_set           - View a set of state-machines'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
# 

#----------------------------------------------------------------------
# PUBLIC TARGETS
# 

_sfs_create_statemachine:
	@$(INFO) '$(AWS_UI_LABEL)Creating state-machine "$(SFS_STATEMACHINE_NAME)" ...'; $(NORMAL)
	$(AWS) stepfunctions create-state-machine $(__SFS_DESCRIPTION_STATEMACHINE) $(__SFS_NAME_STATEMACHINE) $(__SFS_ROLE_ARN_STATEMACHINE)

_sfs_delete_statemachine:
	@$(INFO) '$(AWS_UI_LABEL)Deleting state-machine "$(SFS_STATEMACHINE_NAME)" ...'; $(NORMAL)
	$(AWS) stepfunctions delete-state-machine $(__SFS_STATE_MACHINE_ARN)

_sfs_show_statemachine:
	@$(INFO) '$(AWS_UI_LABEL)Showing state-machine "$(SFS_STATEMACHINE_NAME)" ...'; $(NORMAL)
	$(AWS) stepfunctions describe-state-machine $(__SFS_STATE_MACHINE_ARN)

_sfs_view_statemachines:
	@$(INFO) '$(AWS_UI_LABEL)Viewing state-machines ...'; $(NORMAL)
	$(AWS) stepfunctions list-state-machines

_sfs_view_statemachines_set:
