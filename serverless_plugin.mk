_SERVERLESS_PLUGIN_MK_VERSION= $(_SERVERLESS_MK_VERSION)

# SLS_PLUGIN_NAME= serverless-domain-manager
# SLS_PLUGIN_PACKAGE_BASENAME= serverless-domain-manager
# SLS_PLUGIN_PACKAGE_NAME= serverless-domain-manager@latest
# SLS_PLUGIN_PACKAGE_VERSION= latest
# SLS_PLUGIN_SERVICE_DIRPATH= ./services/aws-python-simple-http-endpoint

# Derived parameters
SLS_PLUGIN_PACKAGE_BASENAME?= $(SLS_PLUGIN_NAME)
SLS_PLUGIN_PACKAGE_NAME?= $(SLS_PLUGIN_PACKAGE_BASENAME)
SLS_PLUGIN_SERVICE_DIRPATH?= $(SLS_SERVICE_DIRPATH)

# Options parameters

# Pipe parameters
_SLS_INSTALL_PLUGIN_|?= cd $(SLS_PLUGIN_SERVICE_DIRPATH) && 
_SLS_UNINSTALL_PLUGIN_|?= cd $(SLS_PLUGIN_SERVICE_DIRPATH) && 
_SLS_UPDATE_PLUGIN_|?= cd $(SLS_PLUGIN_SERVICE_DIRPATH) && 
_SLS_VIEW_PLUGINS_|?= cd $(SLS_PLUGIN_SERVICE_DIRPATH) && 

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_sls_view_framework_macros ::
	@echo 'ServerLesS::Plugin ($(_SERVERLESS_PLUGIN_MK_VERSION)) macros:'
	@echo

_sls_view_framework_parameters ::
	@echo 'ServerLesS::Plugin ($(_SERVERLESS_PLUGIN_MK_VERSION)) parameters:'
	@echo '    SLS_PLUGIN_NAME=$(SLS_PLUGIN_NAME)'
	@echo '    SLS_PLUGIN_PACKAGE_NAME=$(SLS_PLUGIN_PACKAGE_NAME)'
	@echo '    SLS_PLUGIN_PACKAGE_VERSION=$(SLS_PLUGIN_PACKAGE_VERSION)'
	@echo '    SLS_PLUGIN_SERVICE_DIRPATH=$(SLS_PLUGIN_SERVICE_DIRPATH)'
	@echo

_sls_view_framework_targets ::
	@echo 'ServerLesS::Plugin ($(_SERVERLESS_MK_SERVICE_VERSION)) targets:'
	@echo '    _sls_install_plugin       - Install a plugin'
	@echo '    _sls_uninstall_plugin     - Install a plugin'
	@echo '    _sls_update_plugin        - Update a plugin'
	@echo '    _sls_view_plugins         - View plugins'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_sls_install_plugin:
	@$(INFO) '$(SLS_UI_LABEL)Installing plugin "$(SLS_PLUGIN_NAME)" ...'; $(NORMAL)
	$(_SLS_INSTALL_PLUGIN_|) npm install $(SLS_PLUGIN_PACKAGE_NAME) $(__NO_SAVE) $(__SAVE) $(__SAVE_DEV) $(__SAVE_OPTIONAL) $(__SAVE_PROD)
	@$(WARN) 'Once installed the plugin can be refered to in serverless.yaml'; $(NORMAL)
	@$(WARN) 'New serverless CLI commands may also be available'; $(NORMAL)

_sls_show_plugin: _sls_show_plugin_description

_sls_show_plugin_description:
	@$(INFO) '$(SLS_UI_LABEL)Showing description of plugin "$(SLS_PLUGIN_NAME)" ...'; $(NORMAL)
	npm search $(SLS_PLUGIN_PACKAGE_BASENAME)

_sls_uninstall_plugin:
	@$(INFO) '$(SLS_UI_LABEL)Uninstalling plugin "$(SLS_PLUGIN_NAME)" ...'; $(NORMAL)
	$(_SLS_UNINSTALL_PLUGIN_|) npm uninstall $(SLS_PLUGIN_PACKAGE_NAME)

_sls_update_plugin:
	@$(INFO) '$(SLS_UI_LABEL)Updating plugin "$(SLS_PLUGIN_NAME)" ...'; $(NORMAL)
	$(_SLS_UPDATE_PLUGIN_|) npm update $(SLS_PLUGIN_NAME)

_sls_view_plugins:
	@$(INFO) '$(SLS_UI_LABEL)Viewing plugins ...'; $(NORMAL)
	$(_SLS_VIEW_PLUGINS_|) cat package.json && npm list
