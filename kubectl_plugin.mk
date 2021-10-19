_KUBECTL_PLUGIN_MK_VERSION= $(_KUBECTL_MK_VERSION)

# KCL_PLUGIN_NAME?= my-plugin
KCL_PLUGINS_SET_NAME?= my-plugins-set
KCL_PLUGINS_REGEX?= *

# Derived parameters

# Option parameters

# UI parameters
|_KCL_VIEW_PLUGINS_SET?= | grep $(KCL_PLUGINS_REGEX)

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Plugin ($(_KUBECTL_PLUGIN_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Plugin ($(_KUBECTL_PLUGIN_MK_VERSION)) parameters:'
	@echo '    KCL_PLUGIN_NAME=$(KCL_PLUGIN_NAME)'
	@echo '    KCL_PLUGINS_REGEX=$(KCL_PLUGINS_REGEX)'
	@echo '    KCL_PLUGINS_SET_NAME=$(KCL_PLUGINS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Plugin ($(_KUBECTL_PLUGIN_MK_VERSION)) targets:'
	@echo '    _kcl_install_plugin                    - Install a plugin'
	@echo '    _kcl_search_plugin                     - Search repository for a plugin'
	@echo '    _kcl_show_plugin                       - Show everything related to a plugin'
	@echo '    _kcl_show_plugin_description           - Show the description of a plugin'
	@echo '    _kcl_uninstall_plugin                  - Uninstall a plugin'
	@echo '    _kcl_view_plugins                      - View all plugins'
	@echo '    _kcl_view_plugins_set                  - View a set of plugins'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_install_plugin:
	@$(INFO) '$(KCL_UI_LABEL)Installing plugin "$(KCL_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL_KREW) install $(KCL_PLUGIN_NAME)

_kcl_search_plugin:
	@$(INFO) '$(KCL_UI_LABEL)Searching for plugin "$(KCL_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL_KREW) search $(KCL_PLUGIN_NAME)

_kcl_show_plugin: _kcl_show_plugin_file _kcl_show_plugin_description

_kcl_show_plugin_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description plugin "$(KCL_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL_KREW) info $(KCL_PLUGIN_NAME)

_kcl_show_plugin_file:
	@$(INFO) '$(KCL_UI_LABEL)Showing file plugin "$(KCL_PLUGIN_NAME)" ...'; $(NORMAL)
	which kubectl-$(KCL_PLUGIN_NAME)

_kcl_uninstall_plugin:
	@$(INFO) '$(KCL_UI_LABEL)Un-installing plugin "$(KCL_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL_KREW) uninstall $(KCL_PLUGIN_NAME)

_kcl_upgrade_plugin:
	@$(INFO) '$(KCL_UI_LABEL)Upgrading plugin "$(KCL_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KUBECTL_KREW) upgrade $(KCL_PLUGIN_NAME)

_kcl_view_plugins:
	@$(INFO) '$(KCL_UI_LABEL)Viewing ALL plugins ...'; $(NORMAL)
	$(KUBECTL) plugin list 
	$(KUBECTL_KREW) list 

_kcl_view_plugins_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing plugins-set "$(KCL_PLUGINS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Plugins are grouped based on the provided ...'; $(NORMAL)
	# $(KUBECTL) plugin list $(|_KCL_VIEW_PLUGINS_SET)
	# $(KUBECTL_KREW) list $(|_KCL_PLUGINS_SET)
