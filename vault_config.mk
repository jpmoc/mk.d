_VAULT_CONFIG_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_CONFIG_DIRPATH?= ./in/
# VLT_CONFIG_FILENAME?= vault-config.hcl
# VLT_CONFIG_FILEPATH?= ./in/vault-config.hcl
# VLT_CONFIG_NAME?= local-file
# VLT_CONFIGS_DIRPATH?= ./in/
VLT_CONFIGS_REGEX?= *.hcl
# VLT_CONFIGS_SET_NAME?= my-configss-set

# Derived variables
VLT_CONFIG_DIRPATH?= $(VLT_INPUTS_DIRPATH)
VLT_CONFIG_FILEPATH?= $(if $(VLT_CONFIG_FILENAME),$(VLT_CONFIG_DIRPATH)$(VLT_CONFIG_FILENAME))
VLT_CONFIG_NAME?= $(VLT_CONFIG_FILENAME)
VLT_CONFIGS_DIRPATH?= $(VLT_CONFIG_DIRPATH)
VLT_CONFIGS_SET_NAME?= $(VLT_CONFIGS_REGEX)

# Options variables

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Config ($(_VAULT_CONFIG_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Config ($(_VAULT_CONFIG_MK_VERSION)) parameters:'
	@echo '    VLT_CONFIG_DIRPATH=$(VLT_CONFIG_DIRPATH)'
	@echo '    VLT_CONFIG_FILENAME=$(VLT_CONFIG_FILENAME)'
	@echo '    VLT_CONFIG_FILEPATH=$(VLT_CONFIG_FILEPATH)'
	@echo '    VLT_CONFIG_NAME=$(VLT_CONFIG_NAME)'
	@echo '    VLT_CONFIGS_DIRPATH=$(VLT_CONFIGS_DIRPATH)'
	@echo '    VLT_CONFIGS_REGEX=$(VLT_CONFIGS_REGEX)'
	@echo '    VLT_CONFIGS_SET_NAME=$(VLT_CONFIGS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Config ($(_VAULT_CONFIG_MK_VERSION)) targets:'
	@echo '    _vlt_show_config                     - Show everything related to a config'
	@echo '    _vlt_show_config_content             - Show the content of a config'
	@echo '    _vlt_show_config_description         - Show the description of a config'
	@echo '    _vlt_show_config_shellexports        - Show the shell-exports of a config'
	@echo '    _vlt_view_configs                    - View configs'
	@echo '    _vlt_view_configs_set                - View set of configs'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_show_config: _vlt_show_config_content _vlt_show_config_shellexports _vlt_show_config_description

_vlt_show_config_content:
	@$(INFO) '$(VLT_UI_LABEL)Showing content of config "$(VLT_CONFIG_NAME)" ...'; $(NORMAL)
	cat $(VLT_CONFIG_FILEPATH)

_vlt_show_config_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of config "$(VLT_CONFIG_NAME)" ...'; $(NORMAL)
	ls -ls $(VLT_CONFIG_FILEPATH)

_vlt_show_config_shellexports:
	@$(INFO) '$(VLT_UI_LABEL)Showing shell-exports of config "$(VLT_CONFIG_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Those environment variables are expected in the environment for vault to start with the provided config'; $(NORMAL)
	cat $(VLT_CONFIG_FILEPATH) | grep export | sed -e 's/#\s*//'

_vlt_view_configs:
	@$(INFO) '$(VLT_UI_LABEL)Viewing configs ...'; $(NORMAL)
	ls -la $(VLT_CONFIGS_DIRPATH)*.hcl

_vlt_view_configs_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing configs-set "$(VLT_CONFIGS_SET_NAME)" ...'; $(NORMAL)
	ls -la $(VLT_CONFIGS_DIRPATH)$(VLT_CONFIGS_REGEX)
