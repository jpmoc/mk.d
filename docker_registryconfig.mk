_DOCKER_REGISTRYCONFIG_MK_VERSION= $(_DOCKER_MK_VERSION)

# DKR_REGISTRYCONFIG_DIRPATH?= $(HOME)/.docker/
DKR_REGISTRYCONFIG_FILENAME?= config.json
# DKR_REGISTRYCONFIG_FILEPATH?= $(HOME)/.docker/config.json

# Derived parameters
DKR_REGISTRYCONFIG_DIRPATH?= $(DKR_CONFIG_DIRPATH)
DKR_REGISTRYCONFIG_FILEPATH?= $(DKR_REGISTRYCONFIG_DIRPATH)$(DKR_REGISTRYCONFIG_FILENAME)

# Option parameters

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_dkr_view_framework_macros ::
	@echo 'DocKeR::RegistryConfig ($(_DOCKER_REGISTRYCONFIG_MK_VERSION)) targets:'
	@echo

_dkr_view_framework_parameters ::
	@echo 'DocKeR::RegistryConfig ($(_DOCKER_REGISTRYCONFIG_MK_VERSION)) parameters:'
	@echo '    DKR_REGISTRYCONFIG_DIRPATH=$(DKR_REGISTRYCONFIG_DIRPATH)'
	@echo '    DKR_REGISTRYCONFIG_FILENAME=$(DKR_REGISTRYCONFIG_FILENAME)'
	@echo '    DKR_REGISTRYCONFIG_FILEPATH=$(DKR_REGISTRYCONFIG_FILEPATH)'
	@echo

_dkr_view_framework_targets ::
	@echo 'DocKeR::RegistryConfig ($(_DOCKER_REGISTRYCONFIG_MK_VERSION)) targets:'
	@echo '    _dkr_show_registryconfig               - Show everything related to the registry-config'
	@echo '    _dkr_show_registryconfig_content       - Show the content of the registry-config'
	@echo '    _dkr_show_registryconfig_description   - Show the description of the registry-config'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_dkr_edit_registryconfig:
	@$(INFO) '$(DKR_UI_LABEL)Editing the registry-config ...'; $(NORMAL)
	$(EDITOR) $(DKR_REGISTRYCONFIG_FILEPATH)

_dkr_show_registryconfig: _dkr_show_registryconfig_content  _dkr_show_registryconfig_description

_dkr_show_registryconfig_content:
	@$(INFO) '$(DKR_UI_LABEL)Showing content of the registry-config ...'; $(NORMAL)
	@$(WARN) 'This registry-config file is created by the docker-login command directed at the proper registry'; $(NORMAL)
	@$(WARN) 'The auths section includes an entry for each of the registries you previously successfully accessed'; $(NORMAL)
	@$(WARN) 'Beware, logins may use helper command-line utilities that are OS and system specific'; $(NORMAL)
	-cat $(DKR_REGISTRYCONFIG_FILEPATH); echo

_dkr_show_registryconfig_description:
	@$(INFO) '$(DKR_UI_LABEL)Showing description of the registry-config ...'; $(NORMAL)
	ls -al $(DKR_REGISTRYCONFIG_FILEPATH)
