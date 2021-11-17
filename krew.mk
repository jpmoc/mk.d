_KREW_MK_VERSION= 0.99.0

# KRW_PLUGIN_NAME?= my-plugin
KRW_PLUGINS_SET_NAME?= my-plugins-set
KRW_PLUGINS_REGEX?= *
KRW_UI_LABEL?= [krew] #

# Derived parameters

# Options

# Customizations
|_KRW_LIST_PLUGINS_SET?= | grep $(KRW_PLUGINS_REGEX)

# Macros

# Utilities
KREW_BIN?= kubectl krew
KREW?= $(strip $(__KREW_ENVIRONMENT) $(KREW_ENVIRONMENT) $(KREW_BRIN) $(__KREW_OPTIONS) $(KREW_OPTIONS) )


#----------------------------------------------------------------------
# USAGE
#

_krw_list_macros ::
	@#echo 'KReW ($(_KREW_MK_VERSION)) macros:'
	@#echo

_krw_list_parameters ::
	@echo 'KReW ($(_KREW_MK_VERSION)) parameters:'
	@echo '    KRW_PLUGIN_NAME=$(KRW_PLUGIN_NAME)'
	@echo '    KRW_PLUGINS_REGEX=$(KRW_PLUGINS_REGEX)'
	@echo '    KRW_PLUGINS_SET_NAME=$(KRW_PLUGINS_SET_NAME)'
	@echo

_krw_list_targets ::
	@echo 'KReW ($(_KREW_MK_VERSION)) targets:'
	@echo '    _krw_install_plugin                    - Install a plugin'
	@echo '    _krw_list_plugins                      - List all plugins'
	@echo '    _krw_list_plugins_set                  - List a set of plugins'
	@echo '    _krw_search_plugin                     - Search repository for a plugin'
	@echo '    _krw_show_plugin                       - Show everything related to a plugin'
	@echo '    _krw_show_plugin_description           - Show the description of a plugin'
	@echo '    _krw_uninstall_plugin                  - Uninstall a plugin'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_krw_install_plugin:
	@$(INFO) '$(KRW_UI_LABEL)Installing plugin "$(KRW_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KREW) install $(KRW_PLUGIN_NAME)

_krw_list_plugins:
	@$(INFO) '$(KRW_UI_LABEL)Listing ALL plugins ...'; $(NORMAL)
	# $(KUBECTL) plugin list 
	$(KREW) list 

_krw_list_plugins_set:
	@$(INFO) '$(KRW_UI_LABEL)Listing plugins-set "$(KRW_PLUGINS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Plugins are grouped based on the provided ...'; $(NORMAL)
	# $(KUBECTL) plugin list $(|_KRW_LIST_PLUGINS_SET)
	# $(KREW) list $(|_KRW_PLUGINS_SET)

_krw_search_plugin:
	@$(INFO) '$(KRW_UI_LABEL)Searching for plugin "$(KRW_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KREW) search $(KRW_PLUGIN_NAME)

_KRW_SHOW_PLUGIN_TARGETS?= _krw_show_plugin_file _krw_show_plugin_description
_krw_show_plugin: $(_KRW_SHOW_PLUGIN_TARGETS)

_krw_show_plugin_description:
	@$(INFO) '$(KRW_UI_LABEL)Showing description plugin "$(KRW_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KREW) info $(KRW_PLUGIN_NAME)

_krw_show_plugin_file:
	@$(INFO) '$(KRW_UI_LABEL)Showing file plugin "$(KRW_PLUGIN_NAME)" ...'; $(NORMAL)
	which kubectl-$(KRW_PLUGIN_NAME)

_krw_uninstall_plugin:
	@$(INFO) '$(KRW_UI_LABEL)Un-installing plugin "$(KRW_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KREW) uninstall $(KRW_PLUGIN_NAME)

_krw_upgrade_plugin:
	@$(INFO) '$(KRW_UI_LABEL)Upgrading plugin "$(KRW_PLUGIN_NAME)" ...'; $(NORMAL)
	$(KREW) upgrade $(KRW_PLUGIN_NAME)
