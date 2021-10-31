_HELM_PLUGIN_MK_VERSION= $(_HELM_MK_VERSION)

# HLM_PLUGIN_NAME?= helm-diff
# HLM_PLUGIN_URL?= https://github.com/databus23/helm-diff
# HLM_PLUGIN_VERSION?= master

# Derived parameters

# Option parameters
__HLM_VERSION__PLUGIN= $(if $(HLM_PLUGIN_VERSION),--version $(HLM_PLUGIN_VERSION))

# UI parameters

#--- Utilities

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_hlm_list_macros ::
	@#echo 'HeLM::Plugin ($(_HELM_PLUGIN_MK_VERSION)) macros:'
	@#echo

_hlm_list_parameters ::
	@echo 'HeLM::Plugin ($(_HELM_PLUGIN_MK_VERSION)) parameters:'
	@echo '    HLM_PLUGIN_NAME=$(HLM_PLUGIN_NAME)'
	@echo '    HLM_PLUGIN_URL=$(HLM_PLUGIN_URL)'
	@echo '    HLM_PLUGIN_VERSION=$(HLM_PLUGIN_VERSION)'
	@echo

_hlm_list_targets ::
	@echo 'HeLM::Plugin ($(_HELM_PLUGIN_MK_VERSION)) targets:'
	@echo '    _hlm_install_plugin        - Install a new plugin'
	@echo '    _hlm_list_plugins          - List all plugins'
	@echo '    _hlm_list_plugins_set      - List a set of plugins'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_hlm_install_plugin:
	@$(INFO) '$(HLM_UI_LABEL)Installing plugin "$(HLM_PLUGIN_NAME)" ...'; $(NORMAL)
	$(HELM) install $(__HLM_VERSION__PLUGIN) $(HLM_PLUGIN_URL)

_hlm_list_plugins:
	@$(INFO) '$(HLM_UI_LABEL)Listing ALL plugins ...'; $(NORMAL)
	$(HELM) plugin list

_hlm_list_plugins_set:
	@$(INFO) '$(HLM_UI_LABEL)Listing plugins-set "$(HLM_PLUGINS_SET_NAME)" ...'; $(NORMAL)

_hlm_show_plugin:
	@$(INFO) '$(HLM_UI_LABEL)Showing plugin "$(HLM_PLUGIN_NAME)" ...'; $(NORMAL)

_hlm_uninstall_plugin:
	@$(INFO) '$(HLM_UI_LABEL)Uninstalling plugin "$(HLM_PLUGIN_NAME)" ...'; $(NORMAL)
	$(HELM) plugin remove ...

_hlm_update_plugin:
	@$(INFO) '$(HLM_UI_LABEL)Updating plugin "$(HLM_PLUGIN_NAME)" ...'; $(NORMAL)
	$(HELM) plugin update ...
