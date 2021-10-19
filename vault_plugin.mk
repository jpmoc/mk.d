_VAULT_PLUGIN_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_PLUGIN_ARGS?= --with-glibc,--with-curl-bindings
# VLT_PLUGIN_NAME?= my-plugin
# VLT_PLUGIN_SHA356?= d3f0a8be02f6c074cf38c9c99d4d04c9c6466249
# VLT_PLUGIN_TYPE?= auth
# VLT_PLUGINS_SET_NAME?= my-secrets-set

# Derived variables

# Options variables
__VLT_ARGS= $(if $(VLT_PLUGIN_ARGS),--args=$(VLT_PLUGIN_ARGS))
__VLT_COMMAND=
__VLT_SHA256= $(if $(VLT_PLUGIN_SHA256),--sha256 $(VLT_PLUGIN_SHA256))

# Pipe

# UI parameters

# Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::SecretEngine ($(_VAULT_PLUGIN_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::SecretEngine ($(_VAULT_PLUGIN_MK_VERSION)) parameters:'
	@echo '    VLT_PLUGIN_ARGS=$(VLT_PLUGIN_ARGS)'
	@echo '    VLT_PLUGIN_NAME=$(VLT_PLUGIN_NAME)'
	@echo '    VLT_PLUGIN_SHA256=$(VLT_PLUGIN_SHA256)'
	@echo '    VLT_PLUGIN_TYPE=$(VLT_PLUGIN_TYPE)'
	@echo '    VLT_PLUGINS_SET_NAME=$(VLT_PLUGINS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::SecretEngine ($(_VAULT_PLUGIN_MK_VERSION)) targets:'
	@echo '    _vlt_create_plugin                  - Create a plugin'
	@echo '    _vlt_delete_plugin                  - Delete a plugin'
	@echo '    _vlt_show_plugin                    - Show everything related to a plugin'
	@echo '    _vlt_show_plugin_description        - Show desription of a plugin'
	@echo '    _vlt_view_plugins                   - View plugins'
	@echo '    _vlt_view_plugins_set               - View set of plugins'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_plugin:
	@$(INFO) '$(VLT_UI_LABEL)Creating/registering plugin "$(VLT_PLUGIN_NAME)" ...'; $(NORMAL)
	$(VAULT) plugin register $(__VLT_ARGS) $(__VLT_COMMAND) $(__VLT_SHA256) auth $(VLT_PLUGIN_NAME)

_vlt_delete_plugin:
	@$(INFO) '$(VLT_UI_LABEL)Deleting/deregistering plugin "$(VLT_PLUGIN_NAME)" ...'; $(NORMAL)
	$(VAULT) plugin deregister $(VLT_PLUGIN_TYPE) $(VLT_PLUGIN_NAME)

_vlt_show_plugin: _vlt_show_plugin_description

_vlt_show_plugin_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of plugin "$(VLT_PLUGIN_NAME)" ...'; $(NORMAL)
	$(VAULT) plugin info $(VLT_PLUGIN_TYPE) $(VLT_PLUGIN_NAME)

_vlt_view_plugins:
	@$(INFO) '$(VLT_UI_LABEL)Viewing plugins ...'; $(NORMAL)
	@$(WARN) 'This returned plugins can be used as either auth-methods or secret-engines'; $(NORMAL)
	$(VAULT) plugin list

_vlt_view_plugins_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing plugins-set "$(VLT_PLUGINS_SET_NAME)" ...'; $(NORMAL)
	# $(VAULT) plugin list

