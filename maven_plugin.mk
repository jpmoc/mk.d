_MAVEN_PLUGIN_MK_VERSION= $(_MAVEN_MK_VERSION)

# MVN_PLUGIN_DIRPATH?= ./
# MVN_PLUGIN_GOAL?= help
# MVN_PLUGIN_NAME?= my-plugin
# MVN_PLUGIN_PROPERTIES_KEYVALUES?= skipChecks!=true
# MVN_PLUGINS_DIRPATH?= ../plugins/
MVN_PLUGINS_REGEX?= .*
# MVN_PLUGINS_SET_NAME?= plugins@dir

# Derived parameters

# Options
__MVN_DEFINE__PLUGIN= $(foreach KV, $(MVN_PLUGIN_PROPERTIES_KEYVALUES), -D $(KV))

# Customizations

# Macros

#----------------------------------------------------------------------
# USAGE
#

_mvn_list_macros ::
	@#echo 'MaVeN::plugin ($(_MAVEN_MK_VERSION)) macros:'
	@#echo

_mvn_list_parameters ::
	@echo 'MaVeN::plugin ($(_MAVEN_PLUGIN_MK_VERSION)) parameters:'
	@echo '    MVN_PLUGIN_DIRPATH=$(MVN_PLUGIN_DIRPATH)'
	@echo '    MVN_PLUGIN_GOAL=$(MVN_PLUGIN_GOAL)'
	@echo '    MVN_PLUGIN_NAME=$(MVN_PLUGIN_NAME)'
	@echo '    MVN_PLUGIN_PROPERTIES_KEYVALUES=$(MVN_PLUGIN_PROPERTIES_KEYVALUES)'
	@echo '    MVN_PLUGINS_DIRPATH=$(MVN_PLUGINS_DIRPATH)'
	@echo '    MVN_PLUGINS_REGEX=$(MVN_PLUGINS_REGEX)'
	@echo '    MVN_PLUGINS_SET_NAME=$(MVN_PLUGINS_SET_NAME)'
	@echo

_mvn_list_targets ::
	@echo 'MaVeN::plugin ($(_MAVEN_PLUGIN_MK_VERSION)) targets:'
	@echo '    _mvn_list_plugins              - List all plugins'
	@echo '    _mvn_list_plugins_set          - List a set of plugins'
	@echo '    _mvn_run_plugin                - Run the goal of a plugin'
	@echo '    _mvn_show_plugin               - Show everything related to a plugin'
	@echo '    _mvn_show_plugin_description   - Show the description of a plugin'
	@echo '    _mvn_show_plugin_goals         - Show the goals of a plugin'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_mvn_list_plugins:
	@$(INFO) '$(MVN_UI_LABEL)Listing ALL plugins ...'; $(NORMAL)

_mvn_list_plugins_set:
	@$(INFO) '$(MVN_UI_LABEL)Listing plugins-set "$(MVN_PLUGINS_SET)" ...'; $(NORMAL)

_mvn_run_plugin:
	@$(INFO) '$(MVN_UI_LABEL)Running plugin "$(MVN_PLUGIN_)" ...'; $(NORMAL)
	$(_MVN_RUN_PLUGIN_|)$(MVN) $(MVN_PLUGIN_NAME):$(MVN_PLUGIN_GOAL) $(__MVN_DEFINE__PLUGIN)

_MVN_SHOW_PLUGIN_TARGETS?= _mvn_show_plugin_goals _mvn_show_plugin_description
_mvn_show_plugin: $(_MVN_SHOW_PLUGIN_TARGETS)

_mvn_show_plugin_description:
	@$(INFO) '$(MVN_UI_LABEL)Showing description of plugin "$(MVN_PLUGIN_NAME)" ...'; $(NORMAL)

_mvn_show_plugin_goals:
	@$(INFO) '$(MVN_UI_LABEL)Showing goals of plugin "$(MVN_PLUGIN_NAME)" ...'; $(NORMAL)
	$(_MVN_SHOW_PLUGIN_EFFECTIVEPOM_|)$(MVN) $(MVN_PLUGIN_NAME):help $(__MVN_DEFINE__PLUGIN)
