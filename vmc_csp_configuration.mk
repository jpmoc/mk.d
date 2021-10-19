_VMC_CSP_CONFIGURATION_MK_VERSION= $(_VMC_CSP_MK_VERSION)

# CSP_CONFIGURATION_ACCESS_KEY?= 
# CSP_CONFIGURATION_FILEPATH?= $(HOME)/.csp/config/conf.json
# CSP_CONFIGURATION_HOST_URL?= https://console.cloud.vmware.com
# CSP_CONFIGURATION_NAME?= 
# CSP_CONFIGURATION_OUTPUT?= json
# CSP_CONFIGURATION_USER_NAME?= 
# CSP_CONFIGURATION_USER_PASSWORD?= 

# Derived variables
CSP_CONFIGURATION_FILEPATH?= $(HOME)/.csp/config/conf.json
CSP_CONFIGURATION_HOST_URL?= $(CSP_HOST_URL)
CSP_CONFIGURATION_NAME?= $(CSP_ORGANIZATION_NAME)
CSP_CONFIGURATION_REFRESH_TOKEN?= $(CSP_REFRESH_TOKEN)

# Option variables
__CSP_ACCESS_KEY= $(if $(CSP_CONFIGURATION_ACCESS_KEY), --access-key $(CSP_CONFIGURATION_ACCESS_KEY))
__CSP_HOST= $(if $(CSP_CONFIGURATION_HOST_URL), --host $(CSP_CONFIGURATION_HOST_URL))
__CSP_PASSWORD= $(if $(CSP_CONFIGURATION_USER_PASSWORD), --password $(CSP_CONFIGURATION_USER_PASSWORD))
__CSP_REFRESH_TOKEN= $(if $(CSP_CONFIGURATION_REFRESH_TOKEN), --refresh-token $(CSP_CONFIGURATION_REFRESH_TOKEN))
__CSP_SCRIPT= $(if $(filter json, $(CSP_CONFIGURATION_OUTPUT)), --script)
__CSP_USERNAME= $(if $(CSP_CONFIGURATION_USER_NAME), --username $(CSP_CONFIGURATION_USER_NAME))

# UI variables
 
#--- Utilities

#--- MACROS
_csp_get_configuration_host_url= $(call _csp_get_configuration_host_url_F, $(CSP_CONFIGURATION_FILEPATH))
_csp_get_configuration_host_url_F= $(shell jq -r '.host' $(1))

_csp_get_configuration_refresh_token= $(call _csp_get_configuration_refresh_token_F, $(CSP_CONFIGURATION_FILEPATH))
_csp_get_configuration_refresh_token_F= $(shell jq -r '.refreshToken' $(1))

#----------------------------------------------------------------------
# USAGE
#

_csp_view_framework_macros ::
	@echo 'VmwareClouD::CSP::Configuration ($(_VMC_CSP_CONFIGURATION_MK_VERSION)) macros:'
	@echo '    _csp_get_configuration_host_url_{|F}       - Get the host-URLembedded in config (Filepath)'
	@echo '    _csp_get_configuration_refresh_token_{|F}  - Get the refresh token embedded in config (Filepath)'
	@echo

_csp_view_framework_parameters ::
	@echo 'VmwareClouD::CSP::Configuration ($(_VMC_CSP_CONFIGURATION_MK_VERSION)) parameters:'
	@echo '    CSP_CONFIGURATION_ACCESS_KEY=$(CSP_CONFIGURATION_ACCESS_KEY)'
	@echo '    CSP_CONFIGURATION_FILEPATH=$(CSP_CONFIGURATION_FILEPATH)'
	@echo '    CSP_CONFIGURATION_HOST_URL=$(CSP_CONFIGURATION_HOST_URL)'
	@echo '    CSP_CONFIGURATION_NAME=$(CSP_CONFIGURATION_NAME)'
	@echo '    CSP_CONFIGURATION_OUTPUT=$(CSP_CONFIGURATION_OUTPUT)'
	@echo '    CSP_CONFIGURATION_REFRESH_TOKEN=$(CSP_CONFIGURATION_REFRESH_TOKEN)'
	@echo '    CSP_CONFIGURATION_USER_NAME=$(CSP_CONFIGURATION_USER_NAME)'
	@echo '    CSP_CONFIGURATION_USER_PASSWORD=$(CSP_CONFIGURATION_USER_PASSWORD)'
	@echo

_csp_view_framework_targets ::
	@echo 'VmwareClouD::CSP::Configuration ($(_VMC_CSP_CONFIGURATION_MK_VERSION)) targets:'
	@echo '    _csp_create_configuration                  - Create a new configuration'
	@echo '    _csp_delete_configuration                  - Delete an existing configuration'
	@echo '    _csp_show_configuration                    - Show everything related to a configuration'
	@echo '    _csp_update_configuration                  - Update configuration'
	@echo '    _csp_view_configurations                   - View configurations'
	@echo

#-----------------------------------------------------------------------
# PRIVATE TARGETS
#

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_csp_create_configuration:
	@$(INFO) '$(CSP_UI_LABEL)Creating/Updating configuration "$(CSP_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(CSP) configure $(__CSP_ACCESS_TOKEN) $(__CSP_HOST) $(__CSP_PASSWORD) $(__CSP_REFRESH_TOKEN) $(__CSP_SCRIPT) $(CSP_USERNAME)

_csp_delete_configuration:
	@$(INFO) '$(CSP_UI_LABEL)Deleting configuration "$(CSP_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(CSP) cluster configuration delete $(__CSP_FOLDER__CONFIGURATION__CSP_PROJECT__CONFIGURATION_CLUSTER_NAME) $(CSP_CONFIGURATION_NAME)

_csp_edit_configuration:
	@$(INFO) '$(CSP_UI_LABEL)Editing configuration "$(CSP_CONFIGURATION_NAME)" ...'; $(NORMAL)
	$(EDITOR) $(CSP_CONFIGURATION_FILEPATH)	

_csp_show_configuration: _csp_show_configuration_file _csp_show_configuration_content

_csp_show_configuration_file:
	@$(INFO) '$(CSP_UI_LABEL)Showing file for configuration "$(CSP_CONFIGURATION_NAME)" ...'; $(NORMAL)
	ls -al $(CSP_CONFIGURATION_FILEPATH)

_csp_show_configuration_content:
	@$(INFO) '$(CSP_UI_LABEL)Showing content of configuration "$(CSP_CONFIGURATION_NAME)" ...'; $(NORMAL)
	cat $(CSP_CONFIGURATION_FILEPATH)

_csp_update_configuration: _csp_create_configuration

_csp_view_configurations:
	@$(INFO) '$(CSP_UI_LABEL)Viewing available configurations ...'; $(NORMAL)
	@$(WARN) 'Only one configuration is supported at this time'; $(NORMAL)
