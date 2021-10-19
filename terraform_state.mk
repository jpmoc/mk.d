_TERRAFORM_STATE_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_STATE_ASKFORMISSINGVARIABLES_FLAG?= true
# TFM_STATE_BACKUP_FILENAME?= terraform.tfstate.backup
# TFM_STATE_BACKUP_FILEPATH?= ./out/terraform.tfstate.backup
# TFM_STATE_DIRPATH?= ./out/
# TFM_STATE_ENVIRONMENT_DIRPATH?= ./out/environment
TFM_STATE_FILENAME?= terraform.tfstate
# TFM_STATE_FILEPATH?= ./out/terraform.tfstate
# TFM_STATE_LOCK_FLAG?= true
# TFM_STATE_LOCK_TIMEOUT?= true
# TFM_STATE_NAME?= my-state
# TFM_STATE_OUTPUTS_FORMAT?= json
# TFM_STATE_VARIABLES__KEYVALUES?=
# TFM_STATE_VARIABLES_FILEPATH?=

# Derived variables
TFM_STATE_ASKFORMISSINGVARIABLES_FLAG?= $(TFM_ASKFORMISSINGVARIABLES_FLAG)
TFM_STATE_COLOR_FLAG?= $(TFM_COLOR_FLAG)
TFM_STATE_BACKUP_FILEPATH?= $(if $(TFM_STATE_FILEPATH),$(TFM_STATE_FILEPATH).backup)
TFM_STATE_DIRPATH?= $(TFM_STATE_ENVIRONMENT_DIRPATH)# Where the state-file is stored
TFM_STATE_ENVIRONMENT_DIRPATH?= $(TFM_ENVIRONMENT_DIRPATH)# Where commands are executed
TFM_STATE_FILEPATH?= $(if $(TFM_STATE_FILENAME),$(TFM_STATE_DIRPATH)$(TFM_STATE_FILENAME))
TFM_STATE_LOCK_FLAG?= $(TFM_LOCK_FLAG)
TFM_STATE_LOCK_TIMEOUT?= $(TFM_LOCK_TIMEOUT)
TFM_STATE_NAME?= $(TFM_PROJECT_NAME)
TFM_STATE_VARIABLES__KEYVALUES?= $(TFM_VARIABLES__KEYVALUES)
TFM_STATE_VARIABLES_FILEPATHS?= $(TFM_VARIABLES_FILEPATHS)

# Options variables
__TFM_BACKUP?=
__TFM_INPUT__STATE?= $(if $(TFM_STATE_ASKFORMISSINGVARIABLES_FLAG),-input=$(TFM_STATE_ASKFORMISSINGVARIABLES_FLAG))
__TFM_JSON__STATE?= $(if $(filter json, $(TFM_STATE_OUTPUTS_FORMAT)),-json)
__TFM_LOCK__STATE?= $(if $(TFM_STATE_LOCK_FLAG),-lock=$(TFM_STATE_LOCK_FLAG))
__TFM_LOCK_TIMEOUT__STATE?= $(if $(TFM_STATE_LOCK_TIMEOUT),-lock-timeout=$(TFM_LOCK_TIMEOUT))
__TFM_NO_COLOR__STATE?= $(if $(filter false, $(TFM_PLAN_COLOR_FLAG)),-no-color)
__TFM_STATE?= $(if $(TFM_STATE_FILEPATH),-state $(TFM_STATE_FILEPATH))
__TFM_STATE_OUT?=# $(if $(TFM_STATE_OUT_FILEPATH), -state-out=$(TFM_STATE_OUT_FILEPATH))
__TFM_TARGET__STATE?=# $(if $(TFM_STATE_OUT_FILEPATH), -state-out=$(TFM_STATE_OUT_FILEPATH))
__TFM_VAR__STATE?= $(foreach KV, $(TFM_STATE_VARIABLES_KEYVALUES),-var '$(KV)' )# With ticks!
__TFM_VAR_FILE__STATE?= $(foreach F, $(TFM_STATE_VARIABLES_FILEPATHS),-var-file=$(F) )

# Pipr
_TFM_REFRESH_STATE_|?= $(if $(TFM_STATE_ENVIRONMENT_DIRPATH),cd $(TFM_STATE_ENVIRONMENT_DIRPATH) &&)
_TFM_SHOW_STATE_|?= # [ -f $(TFM_STATE_FILEPATH) ] &&
_TFM_SHOW_STATE_CONTENT_|?= $(_TFM_SHOW_STATE_|)
_TFM_SHOW_STATE_DESCRIPTION_|?= $(_TFM_SHOW_STATE_|)
_TFM_SHOW_STATE_OUTPUT_|?= $(_TFM_SHOW_STATE_|)
_TFM_SHOW_STATE_OUTPUTS_|?= $(_TFM_SHOW_STATE_|)
_TFM_SHOW_STATE_RESOURCES_|?= $(_TFM_SHOW_STATE_|)
|_TFM_SHOW_STATE?= | head -10; echo '...'
|_TFM_SHOW_STATE_CONTENT?= $(|_TFM_SHOW_STATE)
|_TFM_SHOW_STATE_DESCRIPTION?=
|_TFM_SHOW_STATE_OUTPUT?= $(|_TFM_SHOW_STATE)
|_TFM_SHOW_STATE_OUTPUTS?= $(|_TFM_SHOW_STATE)
|_TFM_SHOW_STATE_RESOURCES?= $(|_TFM_SHOW_STATE)

# UI parameters

# Utilities

#--- MACROS
_tfm_get_state_output_value= $(call _tfm_get_state_output_value_K, $(TFM_STATE_OUTPUT_KEY))
_tfm_get_state_output_value_K= $(call _tfm_get_state_output_value_KF, $(1), $(TFM_STATE_FILEPATH))
_tfm_get_state_output_value_KF= $(shell terraform output --state $(strip $(2)) $(1) 2>/dev/null)

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::State ($(_TERRAFORM_MK_VERSION)) macros:'
	@echo '    _tfm_get_state_output_value_{|K|KF}   - Get the value for a state-output (Key,File)'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::State ($(_TERRAFORM_MK_VERSION)) parameters:'
	@echo '    TFM_STATE_ASKFORMISSINGVARIABLES_FLAG=$(TFM_STATE_ASKFORMISSINGVARIABLES_FLAG)'
	@echo '    TFM_STATE_BACKUP_FILENAME=$(TFM_STATE_BACKUP_FILENAME)'
	@echo '    TFM_STATE_BACKUP_FILEPATH=$(TFM_STATE_BACKUP_FILEPATH)'
	@echo '    TFM_STATE_ENVIRONMENT_DIRPATH=$(TFM_STATE_ENVIRONMENT_DIRPATH)'
	@echo '    TFM_STATE_FILENAME=$(TFM_STATE_FILENAME)'
	@echo '    TFM_STATE_FILEPATH=$(TFM_STATE_FILEPATH)'
	@echo '    TFM_STATE_LOCK_FLAG=$(TFM_STATE_LOCK_FLAG)'
	@echo '    TFM_STATE_LOCK_TIMEOUT=$(TFM_STATE_LOCK_TIMEOUT)'
	@echo '    TFM_STATE_OUTPUTS_FORMAT=$(TFM_STATE_OUTPUTS_FORMAT)'
	@echo '    TFM_STATE_OUTPUT_KEY=$(TFM_STATE_OUTPUT_KEY)'
	@echo '    TFM_STATE_OUTPUT_VALUE=$(TFM_STATE_OUTPUT_VALUE)'
	@echo '    TFM_STATE_VARIABLES_KEYVALUES=$(TFM_STATE_VARIABLES_KEYVALUES)'
	@echo '    TFM_STATE_VARIABLES_FILEPATH=$(TFM_STATE_VARIABLES_FILEPATH)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::State ($(_TERRAFORM_MK_VERSION)) targets:'
	@echo '    _tfm_refresh_state                 - Refresh the state'
	@echo '    _tfm_show_state                    - Show everything related to a state'
	@echo '    _tfm_show_state_content            - Show content of a state'
	@echo '    _tfm_show_state_description        - Show description of a state'
	@echo '    _tfm_show_state_output             - Show a single output of a state'
	@echo '    _tfm_show_state_outputs            - Show outputs of a state'
	@echo '    _tfm_show_state_resources          - Show resources in a state'
	@echo '    _tfm_start_shell                   - Start the interpolation shell'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_refresh_state:
	@$(INFO) '$(TFM_UI_LABEL)Refreshing state based on infrastructure ...'; $(NORMAL)
	@$(WARN) 'State file: $(TFM_STATE_FILEPATH)'; $(NORMAL)
	$(_TFM_REFRESH_STATE_|)$(TERRAFORM) refresh $(__TFM_BACKUP) $(__TFM_INPUT__STATE) $(__TFM_LOCK__STATE) $(__TFM_LOCK_TIMEOUT__STATE) $(__TFM_NO_COLOR__STATE) $(__TFM_STATE) $(__TFM_STATE_OUT) $(__TFM_TARGET__STATE) $(__TFM_VAR__STATE) $(__TFM_VAR_FILE__STATE)

_tfm_show_state: _tfm_show_state_content _tfm_show_state_output _tfm_show_state_outputs _tfm_show_state_resources _tfm_show_state_description

_tfm_show_state_content:
	@$(INFO) '$(TFM_UI_LABEL)Showing content of state "$(TFM_STATE_NAME)" ...'; $(NORMAL)
	$(if $(TFM_STATE_FILEPATH), \
		$(_TFM_SHOW_STATE_CONTENT_|)cat $(TFM_STATE_FILEPATH) $(|_TFM_SHOW_STATE_CONTENT), \
		@echo 'TFM_STATE_FILEPATH not set ...'\
	)

_tfm_show_state_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of state "$(TFM_STATE_NAME)" ...'; $(NORMAL)
	$(if $(TFM_STATE_FILEPATH), \
		$(_TFM_SHOW_STATE_DESCRIPTION_|)ls -l $(TFM_STATE_FILEPATH), \
		@echo 'TFM_STATE_FILEPATH not set ...'\
	)

_tfm_show_state_output:
	@$(INFO) '$(TFM_UI_LABEL)Showing an output-value from state "$(TFM_STATE_NAME)" ...'; $(NORMAL)
	$(if $(TFM_STATE_OUTPUT_KEY), \
		$(_TFM_SHOW_STATE_OUTPUT_|)$(TERRAFORM) output $(__TFM_STATE) $(TFM_STATE_OUTPUT_KEY), \
		@echo 'TFM_STATE_OUTPUT_KEY not set ...' \
	)

_tfm_show_state_outputs:
	@$(INFO) '$(TFM_UI_LABEL)Showing outputs of state "$(TFM_STATE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the template does not export outputs'; $(NORMAL)
	$(_TFM_SHOW_STATE_OUTPUTS_|)$(TERRAFORM) output $(__TFM_JSON__STATE) $(__TFM_STATE)$(|_TFM_SHOW_STATE_OUTPUTS)

_tfm_show_state_resources:
	@$(INFO) '$(TFM_UI_LABEL)Showing resources in state "$(TFM_STATE_NAME)" ...'; $(NORMAL)
	$(_TFM_SHOW_STATE_RESOURCES_|)$(TERRAFORM) show $(__TFM_JSON__STATE) $(__TFM_NO_COLOR__STATE) $(TFM_STATE_FILEPATH)$(|_TFM_SHOW_STATE_RESOURCES)

_tfm_start_shell:
	@$(INFO) '$(TFM_UI_LABEL)Starting interpolation shell ...'; $(NORMAL)
	$(TERRAFORM) console $(__TFM_STATE)

