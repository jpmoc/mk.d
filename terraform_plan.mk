_TERRAFORM_PLAN_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_PLAN_ASKFORMISSINGVARIABLES_FLAG?= true
# TFM_PLAN_AUTOAPPROVE_FLAG?= false
# TFM_PLAN_COLOR_FLAG?= false
TFM_PLAN_DESTROY_FLAG?= false
TFM_PLAN_DETAILEXITCODE_FLAG?= false
# TFM_PLAN_DIRPATH?= ./out/
# TFM_PLAN_ENVIRONMENT_DIRPATH?= ./out/
# TFM_PLAN_FILENAME?= my-plan.tfplan
# TFM_PLAN_FILEPATH?= ./out/my-plan.tfplan
# TFM_PLAN_LOCK_FLAG?= true
# TFM_PLAN_LOCK_TIMEOUT?= 0s
# TFM_PLAN_NAME?= my-plan
# TFM_PLAN_PARALLELISM_COUNT?= 10
# TFM_PLAN_REFRESHSTATE_FLAG?= false
# TFM_PLAN_STATE_FILEPATH?= ./terraform.tfstate
# TFM_PLAN_TEMPLATE_DIRPATH?=
# TFM_PLAN_VARIABLES_FILEPATHS?=
# TFM_PLAN_VARIABLES_KEYVALUES?=

# Derived variables
TFM_PLAN_ASKFORMISSINGVARIABLES_FLAG?= $(TFM_ASKFORMISSINGVARIABLES_FLAG)
TFM_PLAN_AUTOAPPROVE_FLAG?= $(TFM_AUTOAPPROVE_FLAG)
TFM_PLAN_COLOR_FLAG?= $(TFM_COLOR_FLAG)
TFM_PLAN_DIRPATH?= $(TFM_PLAN_ENVIRONMENT_DIRPATH)
TFM_PLAN_ENVIRONMENT_DIRPATH?= $(TFM_ENVIRONMENT_DIRPATH)# Where commands are run
# TFM_PLAN_FILENAME?= $(if $(TFM_PLAN_NAME),$(TFM_PLAN_NAME).tfplan)
TFM_PLAN_FILEPATH?= $(if $(TFM_PLAN_FILENAME),$(TFM_PLAN_DIRPATH)$(TFM_PLAN_FILENAME))
TFM_PLAN_LOCK_FLAG?= $(TFM_LOCK_FLAG)
TFM_PLAN_LOCK_TIMEOUT?= $(TFM_LOCK_TIMEOUT)
TFM_PLAN_NAME?= $(TFM_PROJECT_NAME)
TFM_PLAN_PARALLELISM_COUNT?= $(TFM_PARALLELISM_COUNT)
TFM_PLAN_REFRESHSTATE_FLAG?= $(TFM_REFRESHSTATE_FLAG)
TFM_PLAN_STATE_FILEPATH?= $(TFM_STATE_FILEPATH)
TFM_PLAN_TEMPLATE_DIRPATH?= $(TFM_TEMPLATE_DIRPATH)
TFM_PLAN_VARIABLES_KEYVALUES?= $(TFM_VARIABLES_KEYVALUES)
TFM_PLAN_VARIABLES_FILEPATHS?= $(TFM_VARIABLES_FILEPATHS)

# Options variables
__TFM_DESTROY__PLAN= $(if $(filter true, $(TFM_PLAN_DESTROY_FLAG)),-destroy)
__TFM_DETAILED_EXITCODE= $(if $(filter true, $(TFM_PLAN_DETAILEDEXITCODE_FLAG)),-detailed-exitcode)
__TFM_INPUT__PLAN= $(if $(filter true, $(TFM_PLAN_ASKFORMISSINGVARIABLES_FLAG)),-input=$(TFM_PLAN_ASKFORMISSINGVARIABLES_FLAG))
__TFM_LOCK__PLAN= $(if $(TFM_PLAN_LOCK_FLAG),-lock=$(TFM_PLAN_LOCK_FLAG))
__TFM_LOCK_TIMEOUT__PLAN= $(if $(TFM_PLAN_LOCK_TIMEOUT),-lock-timeout=$(TFM_PLAN_LOCK_TIMEOUT))
__TFM_MODULE_DEPTH= $(if $(TFM_PLAN_MODULE_DEPTH),-module-depth=$(TFM_PLAN_MODULE_DEPTH))
__TFM_NO_COLOR__PLAN= $(if $(filter false, $(TFM_PLAN_COLOR_FLAG)),-no-color)
__TFM_OUT= $(if $(TFM_PLAN_FILEPATH),-out=$(TFM_PLAN_FILEPATH))
__TFM_PARALLELISM__PLAN= $(if $(TFM_PLAN_PARALLELISM_COUNT),-parallelism=$(TFM_PLAN_PARALLELISM_COUNT))
__TFM_REFRESH= $(if $(filter true, $(TFM_PLAN_REFRESHSTATE_FLAG)),-refresh=$(TFM_PLAN_REFRESHSTATE_FLAG))
__TFM_STATE__PLAN= $(if $(TFM_PLAN_STATE_FILEPATH),-state=$(TFM_PLAN_STATE_FILEPATH))
__TFM_TARGET= $(if $(TFM_TARGET_RESOURCES),-target=$(subst $(SPACE), -state=,$(TFM_TARGET_RESOURCES)))
__TFM_VAR__PLAN= $(foreach KV, $(TFM_PLAN_VARIABLES_KEYVALUES),-var '$(KV)' )# With ticks!
__TFM_VAR_FILE__PLAN= $(foreach F, $(TFM_TEMPLATE_VARIABLES_FILEPATHS),-var-file=$(realpath $(F)) )

# Pipe parameters
_TFM_CREATE_PLAN_|?= $(if $(TFM_PLAN_ENVIRONMENT_DIRPATH),cd $(TFM_PLAN_ENVIRONMENT_DIRPATH) && )
_TFM_DELETE_PLAN_|?= [ ! -f $(TFM_PLAN_FILEPATH) ] ||
_TFM_EXECUTE_PLAN_|?= $(if $(TFM_PLAN_ENVIRONMENT_DIRPATH),cd $(TFM_PLAN_ENVIRONMENT_DIRPATH) && )
_TFM_SHOW_PLAN_CONTENT_|?= file $(TFM_PLAN_FILEPATH) && #
|_TFM_SHOW_PLAN_CONTENT?= | head -10; echo '...'

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@#echo 'TerraForM::Plan ($(_TERRAFORM_PLAN_MK_VERSION)) macros:'
	@#echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Plan ($(_TERRAFORM_PLAN_MK_VERSION)) parameters:'
	@echo '    TFM_PLAN_ASKFORMISSINGVARIABLES_FLAG=$(TFM_PLAN_ASKFORMISSINGVARIABLES_FLAG)'
	@echo '    TFM_PLAN_COLOR_FLAG=$(TFM_PLAN_COLOR_FLAG)'
	@echo '    TFM_PLAN_DESTROY_FLAG=$(TFM_PLAN_DESTROY_FLAG)'
	@echo '    TFM_PLAN_DETAILEXITCODE_FLAG=$(TFM_PLAN_DETAILEXITCODE_FLAG)'
	@echo '    TFM_PLAN_DIRPATH=$(TFM_PLAN_DIRPATH)'
	@echo '    TFM_PLAN_ENVIRONMENT_DIRPATH=$(TFM_PLAN_ENVIRONMENT_DIRPATH)'
	@echo '    TFM_PLAN_FILENAME=$(TFM_PLAN_FILENAME)'
	@echo '    TFM_PLAN_FILEPATH=$(TFM_PLAN_FILEPATH)'
	@echo '    TFM_PLAN_LOCK_FLAG=$(TFM_PLAN_LOCK_FLAG)'
	@echo '    TFM_PLAN_LOCK_TIMEOUT=$(TFM_PLAN_LOCK_TIMEOUT)'
	@echo '    TFM_PLAN_NAME=$(TFM_PLAN_NAME)'
	@echo '    TFM_PLAN_PARALLELISM_COUNT=$(TFM_PLAN_PARALLELISM_COUNT)'
	@echo '    TFM_PLAN_REFRESHSTATE_FLAG=$(TFM_PLAN_REFRESHSTATE_FLAG)'
	@echo '    TFM_PLAN_STATE_FILEPATH=$(TFM_PLAN_STATE_FILEPATH)'
	@echo '    TFM_PLAN_TEMPLATE_DIRPATH=$(TFM_PLAN_TEMPLATE_DIRPATH)'
	@echo '    TFM_PLAN_VARIABLES_FILEPATHS=$(TFM_PLAN_VARIABLES_FILEPATHS)'
	@echo '    TFM_PLAN_VARIABLES_KEYVALUES=$(TFM_PLAN_VARIABLES_KEYVALUES)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Plan ($(_TERRAFORM_PLAN_MK_VERSION)) targets:'
	@echo '    _tfm_create_plan                   - Create a plan'
	@echo '    _tfm_delete_plan                   - Delete an existing plan'
	@echo '    _tfm_show_plan                     - Show everything related to a plan'
	@echo '    _tfm_show_plan_content             - Show the content of a plan'
	@echo '    _tfm_show_plan_description         - Show the description of a plan'
	@echo '    _tfm_update_plan                   - Update the plan of an existing stack'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_create_plan:
	@$(INFO) '$(TFM_UI_LABEL)Creating plan "$(TFM_PLAN_NAME)" ...'; $(NORMAL)
	$(_TFM_CREATE_PLAN_|)$(TERRAFORM) plan $(strip $(__TFM_DESTROY__PLAN) $(__TFM_DETAILED_EXITCODE) $(__TFM_INPUT__PLAN) $(__TFM_LOCK__PLAN) $(__TFM_LOCK_TIMEOUT__PLAN) $(__TFM_OUT) $(__TFM_NO_COLOR__PLAN) $(__TFM_PARALLELISM) $(__TFM_REFRESH) $(__TFM_STATE__PLAN) $(__TFM_TARGET) $(__TFM_VAR__PLAN) $(__TFM_VAR_FILE__PLAN) )

_tfm_delete_plan:
	@$(INFO) '$(TFM_UI_LABEL)Deleting plan "$(TFM_PLAN_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete "$(TFM_PLAN_FILEPATH)". Are you sure? (Ctrl-C to break)' yesNo
	$(_TFM_DELETE_PLAN_|)rm $(TFM_PLAN_FILEPATH) 

_tfm_show_plan: _tfm_show_plan_content _tfm_show_plan_description

_tfm_show_plan_content:
	@$(INFO) '$(TFM_UI_LABEL)Show content of plan "$(TFM_PLAN_NAME)" ...'; $(NORMAL)
	$(_TFM_SHOW_PLAN_CONTENT_|)zipinfo -1 $(TFM_PLAN_FILEPATH) $(|_TFM_SHOW_PLAN_CONTENT)

_tfm_show_plan_description:
	@$(INFO) '$(TFM_UI_LABEL)Show description of plan "$(TFM_PLAN_NAME)" ...'; $(NORMAL)
	ls -al $(TFM_PLAN_FILEPATH)

_tfm_update_plan:

## _tfm_plan_addition:
	## @$(INFO) '$(TFM_UI_LABEL)Planning for addition of resources in cluster "$(TFM_CLUSTER_NAME)" ...'; $(NORMAL)
	## cd $(TFM_INIT_DIR); $(TERRAFORM) plan $(__TFM_DETAILED_EXITCODE) $(__TFM_INPUT) $(__TFM_LOCK) $(__TFM_LOCK_TIMEOUT) $(__TFM_MODULE_DEPTH) $(__TFM_OUT) $(__TFM_NO_COLOR) $(__TFM_PARALLELISM) $(__TFM_REFRESH) $(__TFM_STATE) $(__TFM_TARGET) $(__TFM_VAR) $(__TFM_VAR_FILE) $(TFM_TEMPLATE_DIR)

## _tfm_plan_deletion:
	## @$(INFO) '$(TFM_UI_LABEL)Planning for deletion of resources in cluster "$(TFM_CLUSTER_NAME)" ...'; $(NORMAL)
	## ## cd $(TFM_INIT_DIR); $(TERRAFORM) plan --destroy $(__TFM_DETAILED_EXITCODE) $(__TFM_INPUT) $(__TFM_LOCK) $(__TFM_LOCK_TIMEOUT) $(__TFM_MODULE_DEPTH) $(__TFM_OUT) $(__TFM_NO_COLOR) $(__TFM_PARALLELISM) $(__TFM_REFRESH) $(__TFM_STATE) $(__TFM_TARGET) $(__TFM_VAR) $(__TFM_VAR_FILE) $(TFM_TEMPLATE_DIR)
