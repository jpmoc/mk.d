_TERRAFORM_ENVIRONMENT_MK_VERSION= $(_TERRAFORM_MK_VERSION)

# TFM_ENVIRONMENT_ASKFORMISSINGVARIABLES_FLAG?= true
TFM_ENVIRONMENT_BACKEND_CONFIG?=
TFM_ENVIRONMENT_BACKEND_FLAG?= true
# TFM_ENVIRONMENT_COLOR_FLAG?= false
# TFM_ENVIRONMENT_DIRPATH?= ./in/my-env/
TFM_ENVIRONMENT_GETMODULES_FLAG?= true
TFM_ENVIRONMENT_GETPLUGINS_FLAG?= true
# TFM_ENVIRONMENT_LOCK_FLAG?= true
# TFM_ENVIRONMENT_LOCK_TIMEOUT?= 0s
# TFM_ENVIRONMENT_NAME?= my-env
# TFM_ENVIRONMENT_PLANS_DIRPATH?= $(HOME)/lib/terraform/plans/
# TFM_ENVIRONMENT_PLUGINS_DIRPATH?= $(HOME)/lib/terraform/plugins/
# TFM_ENVIRONMENT_PROVIDERS_DIRPATH?= ./in/my-env/.terraform/
# TFM_ENVIRONMENT_STATES_DIRPATH?= $(HOME)/lib/terraform/states/
TFM_ENVIRONMENT_UPGRADE_FLAG?= false
TFM_ENVIRONMENT_VERIFYPLUGINS_FLAG?= false
# TFM_ENVIRONMENTS_DIRPATH?= ./in/

# Derived variables
TFM_ENVIRONMENT_ASKFORMISSINGVARIABLES_FLAG?= $(TFM_ASKFORMISSINGVARIABLES_FLAG)
TFM_ENVIRONMENT_COLOR_FLAG?= $(TFM_COLOR_FLAG)
TFM_ENVIRONMENT_LOCK_FLAG?= $(TFM_LOCK_FLAG)
TFM_ENVIRONMENT_LOCK_TIMEOUT?= $(TFM_LOCK_TIMEOUT)
TFM_ENVIRONMENT_NAME?= $(TFM_PROJECT_NAME)
TFM_ENVIRONMENT_PROVIDERS_DIRPATH?= $(TFM_ENVIRONMENT_DIRPATH).terraform/

# Options variables
__TFM_BACKEND= $(if $(TFM_ENVIRONMENT_BACKEND_FLAG),-backend=$(TFM_ENVIRONMENT_BACKEND_FLAG))
__TFM_BACKEND_CONFIG=
__TFM_GET= $(if $(TFM_ENVIRONMENT_GETMODULES_FLAG),-get=$(TFM_ENVIRONMENT_GETMODULES_FLAG))
__TFM_GET_PLUGINS= $(if $(TFM_ENVIRONMENT_GETPLUGINS_FLAG),-get-plugins=$(TFM_ENVIRONMENT_GETPLUGINS_FLAG))
__TFM_INPUT__ENVIRONMENT= $(if $(TFM_ENVIRONMENT_ASKFORMISSINGVARIABLES_FLAG),-input=$(TFM_ENVIRONMENT_ASKFORMISSINGVARIABLES_FLAG))
__TFM_LOCK__ENVIRONMENT= $(if $(TFM_ENVIRONMENT_LOCK_FLAG),-lock=$(TFM_ENVIRONMENT_LOCK_FLAG))
__TFM_LOCK_TIMEOUT__ENVIRONMENT= $(if $(TFM_ENVIRONMENT_LOCK_TIMEOUT),-lock-timeout=$(TFM_ENVIRONMENT_LOCK_TIMEOUT))
__TFM_NO_COLOR__ENVIRONMENT= $(if $(filter false, $(TFM_ENVIRONMENT_COLOR_FLAG)),-no-color)
__TFM_PLUGIN_DIR= $(if $(TFM_ENVIRONMENT_PLUGINS_DIRPATH),--plugin-dir $(TFM_ENVIRONMENT_PLUGINS_DIRPATH))
__TFM_UPGRADE= $(if $(TFM_ENVIRONMENT_UPGRADE_FLAG),-upgrade=$(TFM_ENVIRONMENT_UPGRADE_FLAG))
__TFM_VERIFY_PLUGINS= $(if $(TFM_ENVIRONMENT_VERIFYPLUGINS_FLAG),-verify-plugins=$(TFM_ENVIRONMENT_VERIFYPLUGINS_FLAG))

# Pipe parameters
_TFM_INIT_ENVIRONMENT_|?= # cd $(TFM_ENVIRONMENT_DIRPATH) && 
_TFM_SHOW_ENVIRONMENT_DESCRIPTION_|?= # [ -d $(TFM_ENVIRONMENT_DIRPATH) ] &&
_TFM_VALIDATE_ENVIRONMENT_|?= # cd $(TFM_ENVIRONMENT_DIRPATH) && 

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'TerraForM::Environment ($(_TERRAFORM_ENVIRONMENT_MK_VERSION)) macros:'
	@echo

_tfm_view_framework_parameters ::
	@echo 'TerraForM::Environment ($(_TERRAFORM_ENVIRONMENT_MK_VERSION)) parameters:'
	@echo '    TFM_ENVIRONMENT_ASKFORMISSINGVARIABLES_FLAG=$(TFM_ENVIRONMENT_ASKFORMISSINGVARIABLES_FLAG)'
	@echo '    TFM_ENVIRONMENT_BACKEND_CONFIG=$(TFM_ENVIRONMENT_BACKEND_CONFIG)'
	@echo '    TFM_ENVIRONMENT_BACKEND_FLAG=$(TFM_ENVIRONMENT_BACKEND_FLAG)'
	@echo '    TFM_ENVIRONMENT_COLOR_FLAG=$(TFM_ENVIRONMENT_COLOR_FLAG)'
	@echo '    TFM_ENVIRONMENT_DIRPATH=$(TFM_ENVIRONMENT_DIRPATH)'
	@echo '    TFM_ENVIRONMENT_GETMODULES_FLAG=$(TFM_ENVIRONMENT_GETMODULES_FLAG)'
	@echo '    TFM_ENVIRONMENT_GETPLUGINS_FLAG=$(TFM_ENVIRONMENT_GETPLUGINS_FLAG)'
	@echo '    TFM_ENVIRONMENT_LOCK_FLAG=$(TFM_ENVIRONMENT_LOCK_FLAG)'
	@echo '    TFM_ENVIRONMENT_LOCK_TIMEOUT=$(TFM_ENVIRONMENT_LOCK_TIMEOUT)'
	@echo '    TFM_ENVIRONMENT_NAME=$(TFM_ENVIRONMENT_NAME)'
	@echo '    TFM_ENVIRONMENT_PLANS_DIRPATH=$(TFM_ENVIRONMENT_PLANS_DIRPATH)'
	@echo '    TFM_ENVIRONMENT_PLUGINS_DIRPATH=$(TFM_ENVIRONMENT_PROVIDERS_DIRPATH)'
	@echo '    TFM_ENVIRONMENT_PROVIDERS_DIRPATH=$(TFM_ENVIRONMENT_PROVIDERS_DIRPATH)'
	@echo '    TFM_ENVIRONMENT_STATES_DIRPATH=$(TFM_ENVIRONMENT_STATES_DIRPATH)'
	@echo '    TFM_ENVIRONMENT_UPGRADE_FLAG=$(TFM_ENVIRONMENT_UPGRADE_FLAG)'
	@echo '    TFM_ENVIRONMENT_VERIFYPLUGINS_FLAG=$(TFM_ENVIRONMENT_VERIFYPLUGINS_FLAG)'
	@echo '    TFM_ENVIRONMENTS_DIRPATH=$(TFM_ENVIRONMENTS_DIRPATH)'
	@echo

_tfm_view_framework_targets ::
	@echo 'TerraForM::Environment ($(_TERRAFORM_ENVIRONMENT_MK_VERSION)) targets:'
	@echo '    _tfm_init_environment              - Initialize environment'
	@echo '    _tfm_show_environment              - Show everything related to the environment'
	@echo '    _tfm_show_environment_description  - Show the description of an environment'
	@echo '    _tfm_show_environment_modules      - Show the modules in an environment'
	@echo '    _tfm_show_environment_plugins      - Show plugins in an environment'
	@echo '    _tfm_show_environment_providers    - Show providers in an environment'
	@echo '    _tfm_validate_environment          - Validate an environment'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_tfm_init_environment:
	@$(INFO) '$(TFM_UI_LABEL)Initializing environment "$(TFM_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates and populates the .../.terraform directory in your environment'; $(NORMAL)
	$(_TFM_INIT_ENVIRONMENT_|)$(TERRAFORM) init $(strip $(__TFM_GET) $(__TFM_GET_PLUGINS) $(__TFM_INPUT__ENVIRONMENT) $(__TFM_LOCK__ENVIRONMENT) $(__TFM_LOCK_TIMEOUT__ENVIRONMENT) $(__TFM_NO_COLOR__ENVIRONMENT) $(__TFM_PLUGIN_DIR) $(__TFM_UPGRADE) $(__TFM_VERIFY_PLUGINS) $(realpath $(TFM_ENVIRONMENT_DIRPATH)) )

_tfm_show_environment: _tfm_show_environment_modules _tfm_show_environment_plugins _tfm_show_environment_providers _tfm_show_environment_description

_tfm_show_environment_description:
	@$(INFO) '$(TFM_UI_LABEL)Showing description of environment "$(TFM_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(_TFM_SHOW_ENVIRONMENT_DESCRIPTION_|)ls -al $(TFM_ENVIRONMENT_DIRPATH)

_tfm_show_environment_modules:
	@$(INFO) '$(TFM_UI_LABEL)Showing modules in environment "$(TFM_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	# Not implemented yet!

_tfm_show_environment_plugins:
	@$(INFO) '$(TFM_UI_LABEL)Showing plugins in environment "$(TFM_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Custom plugins are often downloaded as part of a bundle'; $(NORMAL)
	$(if $(TFM_ENVIRONMENT_PLUGINS_DIRPATH), \
		tree $(TFM_ENVIRONMENT_PLUGINS_DIRPATH) ,\
		@echo "TFM_ENVIRONMENT_PLUGINS not set!" \
	)

_tfm_show_environment_providers:
	@$(INFO) '$(TFM_UI_LABEL)Showing providers in environment "$(TFM_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(if $(TFM_ENVIRONMENT_PROVIDERS_DIRPATH), \
		tree $(TFM_ENVIRONMENT_PROVIDERS_DIRPATH) ,\
		@echo "TFM_ENVIRONMENT_PROVIDERS_DIRPATH not set!" \
	)

_tfm_validate_environment:
	@$(INFO) '$(TFM_UI_LABEL)Validating environment "$(TFM_ENVIRONMENT_NAME)" ...'; $(NORMAL)
	$(_TFM_VALIDATE_ENVIRONMENT_|)$(TERRAFORM) validate $(__TFM_CHECK_VARIABLES) $(__TFM_NO_COLOR) $(__TFM_VAR) $(__TFM_VAR_FILE) $(TFM_TEMPLATE_DIR)
