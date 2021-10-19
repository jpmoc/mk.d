_VELERO_PLUGIN_MK_VERSION= $(_VELERO_MK_VERSION)

# VLO_PLUGIN_NAME?= nginx-backup
# VLO_PLUGINS_SET_NAME?= my-plugins-set

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::Plugin ($(_VELERO_PLUGIN_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::Plugin ($(_VELERO_PLUGIN_MK_VERSION)) parameters:'
	@echo '    VLO_PLUGIN_NAME=$(VLO_PLUGIN_NAME)'
	@echo '    VLO_PLUGINS_SET_NAME=$(VLO_PLUGINS_SET_NAME)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::Plugin ($(_VELERO_PLUGIN_MK_VERSION)) targets:'
	@echo '    _vlo_create_plugin            - Create a plugin' 
	@echo '    _vlo_delete_plugin            - Delete a plugin' 
	@echo '    _vlo_show_plugin              - Show everything related to a plugin' 
	@echo '    _vlo_show_plugin_desription   - Show description of a plugin' 
	@echo '    _vlo_view_plugins             - View all plugins' 
	@echo '    _vlo_view_plugins_set         - View set of plugins' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_create_plugin:
	@$(INFO) '$(VLO_UI_LABEL)Creating plugin "$(VLO_PLUGIN_NAME)" ...'; $(NORMAL)
	#$(VELERO) backup create $(strip $(__VLO_EXCLUDE_NAMESPACES) $(__VLO_EXCLUDE_RESOURCES) $(__VLO_INCLUDE_NAMESPACES) $(__VLO_INCLUDE_RESOURCES) $(__VLO_LABELS) $(__VLO_SELECTOR__LABEL) $(_XX_VLO_SNAPSHOT_VOLUME) $(__VLO_TTL) $(__VLO_WAIT__BACKUP)) $(VLO_BACKUP_NAME)

_vlo_delete_plugin:
	@$(INFO) '$(VLO_UI_LABEL)Deleting plugin "$(VLO_PLUGIN_NAME)" ...'; $(NORMAL)

_vlo_show_plugin: _vlo_show_plugin_description

_vlo_show_plugin_description:
	@$(INFO) '$(VLO_UI_LABEL)Showing description of plugin "$(VLO_PLUGIN_NAME)" ...'; $(NORMAL)
	#$(VELERO) backup describe --details $(_X_VLO_SELECTOR__BACKUPS) $(VLO_BACKUP_NAME)

_vlo_view_plugins:
	@$(INFO) '$(VLO_UI_LABEL)Viewing plugins ...'; $(NORMAL)
	$(VELERO) get plugins

_vlo_view_plugins_set:
	@$(INFO) '$(VLO_UI_LABEL)Viewing plugins-set "$(VLO_PLUGINS_SET_NAME)"  ...'; $(NORMAL)
	#$(VELERO) backup describe $(__VLO_SELECTOR__BACKUPS) $(VLO_BACKUPS_NAMES)
