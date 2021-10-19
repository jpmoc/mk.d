_TERRAFORM_STACK_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_STACK_ASKFORMISSINGVARIABLES_FLAG?= true
# TFM_STACK_AUTOAPPROVE_FLAG?= false
# TFM_STACK_COLOR_FLAG?= true
# TFM_STACK_LOCK_FLAG?= false
# TFM_STACK_LOCK_TIMEOUT?= 0s
# TFM_STACK_NAME?= my-stack
# TFM_STACK_PARALLELISM_COUNT?= 10
# TFM_STACK_PLAN_FILEPATH?=
# TFM_STACK_REFRESHSTATE_FLAG?= true
# TFM_STACK_STATE_FILEPATH?= ./terraform.tfstate
# TFM_STACK_VARIABLES_FILEPATHS?=
# TFM_STACK_VARIABLES_KEYVALUES?=
# TFM_STACKS_SET_NAME?=

# Derived variables
TFM_STACK_ASKFORMISSINGVARIABLES_FLAG?= $(TFM_ASKFORMISSINGVARIABLES_FLAG)
TFM_STACK_AUTOAPPROVE_FLAG?= $(TFM_AUTOAPPROVE_FLAG)
TFM_STACK_COLOR_FLAG?= $(TFM_COLOR_FLAG)
TFM_STACK_ENVIRONMENT_DIRPATH?= $(TFM_ENVIRONMENT_DIRPATH)# Where commands are run
TFM_STACK_LOCK_FLAG?= $(TFM_LOCK_FLAG)
TFM_STACK_LOCK_TIMEOUT?= $(TFM_LOCK_TIMEOUT)
TFM_STACK_NAME?= $(TFM_PROJECT_NAME)
TFM_STACK_PARALLELISM_COUNT?= $(TFM_PARALLELISM_COUNT)
TFM_STACK_PLAN_FILEPATH?= $(TFM_PLAN_FILEPATH)
TFM_STACK_REFRESHSTATE_FLAG?= $(TFM_REFRESHSTATE_FLAG)
TFM_STACK_STATE_FILEPATH?= $(TFM_STATE_FILEPATH)
TFM_STACK_VARIABLES_FILEPATHS?= $(TFM_VARIABLES_FILEPATHS)
TFM_STACK_VARIABLES_KEYVALUES?= $(TFM_VARIABLES_KEYVALUES)

# Options variables
__TFM_AUTO_APPROVE__STACK= $(if $(filter true, $(TFM_STACK_AUTOAPPROVE_FLAG)),-auto-approve)
__TFM_BACKUP__STACK=
__TFM_FORCE_DESTROY= $(if $(filter true, $(TFM_STACK_FORCEDESTROY_FLAG)),--force)
__TFM_INPUT__STACK= $(if $(TFM_STACK_ASKFORMISSINGVARIABLES_FLAG),-input=$(TFM_STACK_ASKFORMISSINGVARIABLES_FLAG))
__TFM_JSON__STACK=
__TFM_LOCK__STACK= $(if $(TFM_STACK_LOCK_FLAG),-lock=$(TFM_STACK_LOCK_FLAG))
__TFM_LOCK_TIMEOUT__STACK= $(if $(TFM_STACK_LOCK_TIMEOUT),-lock-timeout=$(TFM_STACK_LOCK_TIMEOUT))
__TFM_NO_COLOR__STACK= $(if $(filter false, $(TFM_STACK_COLOR_FLAG)),-no-color)
__TFM_PARALLELISM__STACK= $(if $(TFM_STACK_PARALLELISM_COUNT),-parallelism=$(TFM_STACK_PARALLELISM_COUNT))
__TFM_REFRESH__STACK= $(if $(filter true, $(TFM_STACK_REFRESHSTATE_FLAG)),-refresh=$(TFM_STACK_REFRESHSTATE_FLAG))
__TFM_STATE__STACK= $(if $(TFM_STACK_STATE_FILEPATH),--state=$(TFM_STACK_STATE_FILEPATH))
__TFM_STATE_OUT__STACK=# $(if $(TFM_STATE_OUT_FILEPATH),--state-out=$(TFM_STATE_OUT_FILEPATH))
__TFM_TARGET__STACK= $(if $(TFM_TARGET_STACK),--target=$(subst $(SPACE), --state=,$(TFM_TARGET_STACK)))
__TFM_VAR__STACK= $(foreach KV, $(TFM_STACK_VARIABLES_KEYVALUES),-var '$(KV)' )# With ticks!
__TFM_VAR_FILE__STACK= $(foreach F, $(TFM_STACK_VARIABLES_FILEPATHS),-var-file=$(realpath $(F)) )

# Pipe 
_TFM_CREATE_STACK_|?= $(if $(TFM_STACK_ENVIRONMENT_DIRPATH),cd $(TFM_STACK_ENVIRONMENT_DIRPATH) &&)
_TFM_DELETE_STACK_|?= $(if $(TFM_STACK_ENVIRONMENT_DIRPATH),cd $(TFM_STACK_ENVIRONMENT_DIRPATH) &&)
_TFM_SHOW_STACK_RESOURCES_|?= $(if $(TFM_STACK_ENVIRONMENT_DIRPATH),cd $(TFM_STACK_ENVIRONMENT_DIRPATH) &&)

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::Stack ($(_TERRAFORM_STACK_MK_VERSION)) macros:'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Stack ($(_TERRAFORM_STACK_MK_VERSION)) parameters:'
	@echo '    TFM_STACK_ASKFORMISSINGVARIABLES_FLAG=$(TFM_STACK_ASKFORMISSINGVARIABLES_FLAG)'
	@echo '    TFM_STACK_AUTOAPPROVE_FLAG=$(TFM_STACK_AUTOAPPROVE_FLAG)'
	@echo '    TFM_STACK_COLOR_FLAG=$(TFM_STACK_COLOR_FLAG)'
	@echo '    TFM_STACK_ENVIRONMENT_DIRPATH=$(TFM_STACK_ENVIRONMENT_DIRPATH)'
	@echo '    TFM_STACK_LOCK_FLAG=$(TFM_STACK_LOCK_FLAG)'
	@echo '    TFM_STACK_LOCK_TIMEOUT=$(TFM_STACK_LOCK_TIMEOUT)'
	@echo '    TFM_STACK_NAME=$(TFM_STACK_NAME)'
	@echo '    TFM_STACK_PARALLELISM_COUNT=$(TFM_STACK_PARALLELISM_COUNT)'
	@echo '    TFM_STACK_REFRESHSTATE_FLAG=$(TFM_STACK_REFRESHSTATE_FLAG)'
	@echo '    TFM_STACK_STATE_FILEPATH=$(TFM_STACK_STATE_FILEPATH)'
	@echo '    TFM_STACK_PLAN_FILEPATH=$(TFM_STACK_PLAN_FILEPATH)'
	@echo '    TFM_STACK_VARIABLES_FILEPATHS=$(TFM_STACK_VARIABLES_FILEPATHS)'
	@echo '    TFM_STACK_VARIABLES_KEYVALUES=$(TFM_STACK_VARIABLES_KEYVALUES)'
	@echo '    TFM_STACKS_SET_NAME=$(TFM_STACKS_SET_NAME)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Stack ($(_TERRAFORM_STACK_MK_VERSION)) targets:'
	@echo '    _tfm_create_stack              - Create a stack'
	@echo '    _tfm_delete_stack              - Delete a stack'
	@echo '    _tfm_update_stack              - Update resources'
	@echo '    _tfm_show_stack                - Show everything related to a stack'
	@echo '    _tfm_show_stack_description    - Show description of a stack'
	@echo '    _tfm_show_stack_planfile       - Show the plan-file of a stack'
	@echo '    _tfm_show_stack_resources      - Show resources in a stack'
	@echo '    _tfm_show_stack_statefile      - Show the state-file of a stack'
	@echo '    _tfm_view_stacks               - View aLL stacks'
	@echo '    _tfm_view_stacks_set           - View a set of stacks'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_create_stack:
	@$(INFO) '$(TFM_UI_LABEL)Creating/updating the stack "$(TFM_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if variables and a plan-file are provided on the same command line'; $(NORMAL)
	@$(WARN) 'This operation fails if the plan provided in the plan-file is stale'; $(NORMAL)
	@$(WARN) 'If a plan-file and variables are provided, the plan-file is prioritized'; $(NORMAL)
	$(_TFM_CREATE_STACK_|)$(TERRAFORM) apply $(strip $(__TFM_AUTO_APPROVE__STACK) $(__TFM_INPUT__STACK) $(__TFM_NO_COLOR__STACK) $(__TFM_PARALLELISM__STACK) $(__TFM_STATE__STACK) $(__TFM_STATE_OUT__STACK) \
		$(if $(TFM_STACK_PLAN_FILEPATH),$(TFM_STACK_PLAN_FILEPATH),$(__TFM_VAR__STACK) $(__TFM_VAR_FILE__STACK)) \
	)

_tfm_delete_stack:
	@$(INFO) '$(TFM_UI_LABEL)Deleting stack "$(TFM_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation cannot be executed with a plan-file'; $(NORMAL)
	$(_TFM_DELETE_STACK_|)$(TERRAFORM) destroy $(strip $(__TFM_AUTO_APPROVE__STACK) $(__TFM_BACKUP__STACK) $(__TFM_FORCE_DESTROY) $(__TFM_LOCK__STACK) $(__TFM_LOCK_TIMEOUT__STACK) $(__TFM_NO_COLOR__STACK) $(__TFM_PARALLELISM__STACK) $(__TFM_REFRESH__STACK) $(__TFM_STATE__STACK) $(__TFM_TARGET__STACK) $(__TFM_VAR__STACK) $(__TFM_VAR_FILE__STACK) $(X_TFM_STACK_PLAN_FILEPATH) )

_tfm_update_stack: _tfm_create_stack

_tfm_show_stack :: _tfm_show_stack_planfile _tfm_show_stack_resources _tfm_show_stack_statefile _tfm_show_stack_statefile _tfm_show_stack_description

_tfm_show_stack_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of stack "$(TFM_STACK_NAME)" ...'; $(NORMAL)
	# To be implemented

_tfm_show_stack_planfile:
	@$(INFO) '$(TFM_UI_LABEL)Showing plan-file of stack "$(TFM_STACK_NAME)" ...'; $(NORMAL)
	$(if $(TFM_STACK_PLAN_FILEPATH), \
		ls -al $(TFM_STACK_PLAN_FILEPATH),
		@echo 'TFM_STACK_PLAN_FILEPATH not set ...' \
	)

_tfm_show_stack_resources:
	@$(INFO) '$(TFM_UI_LABEL)Showing resources in stack "$(TFM_STACK_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns the managed-resources on the provider'; $(NORMAL)
	$(_TFM_SHOW_STACK_RESOURCES_|) $(TERRAFORM) show $(__TFM_JSON__STACK) $(__TFM_NO_COLOR__STACK) $(TFM_STACK_STATE_FILEPATH)

_tfm_show_stack_statefile:
	@$(INFO) '$(TFM_UI_LABEL)Showing state-file of stack "$(TFM_STACK_NAME)" ...'; $(NORMAL)
	$(if $(TFM_STACK_STATE_FILEPATH), \
		ls -al $(TFM_STACK_STATE_FILEPATH),
		@echo 'TFM_STACK_STATE_FILEPATH not set ...' \
	)

_tfm_view_stacks:
	@$(INFO) "$(TFM_UI_LABEL)View ALL stacks ..."; $(NORMAL)
	# To be implemented

_tfm_view_stacks_set:
	@$(INFO) "$(TFM_UI_LABEL)View stacks-set "$(TFM_STACKS_SET_NAME)" ..."; $(NORMAL)
	# To be implemented
