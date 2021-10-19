_VELERO_BACKUPLOCATION_MK_VERSION= $(_VELERO_MK_VERSION)

# VLO_BACKUPLOCATION_NAME?= nginx-backup
# VLO_BACKUPLOCATIONS_SET_NAME?= my-Xes-set

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::BackupLocation ($(_VELERO_BACKUPLOCATION_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::BackupLocation ($(_VELERO_BACKUPLOCATION_MK_VERSION)) parameters:'
	@echo '    VLO_BACKUPLOCATION_NAME=$(VLO_BACKUPLOCATION_NAME)'
	@echo '    VLO_BACKUPLOCATIONS_SET_NAME=$(VLO_BACKUPLOCATIONS_SET_NAME)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::BackupLocation ($(_VELERO_BACKUPLOCATION_MK_VERSION)) targets:'
	@echo '    _vlo_create_backuplocation            - Create a backup-location' 
	@echo '    _vlo_delete_backuplocation            - Delete a backup-location' 
	@echo '    _vlo_show_backuplocation              - Show everything related to a backup-location' 
	@echo '    _vlo_show_backuplocation_desription   - Show description of a backup-location' 
	@echo '    _vlo_view_backuplocations             - View all backup-locations' 
	@echo '    _vlo_view_backuplocations_set         - View set of backup-locations' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_create_backuplocation:
	@$(INFO) '$(VLO_UI_LABEL)Creating backup-location "$(VLO_BACKUPLOCATION_NAME)" ...'; $(NORMAL)
	#$(VELERO) backup create $(strip $(__VLO_EXCLUDE_NAMESPACES) $(__VLO_EXCLUDE_RESOURCES) $(__VLO_INCLUDE_NAMESPACES) $(__VLO_INCLUDE_RESOURCES) $(__VLO_LABELS) $(__VLO_SELECTOR__LABEL) $(_XX_VLO_SNAPSHOT_VOLUME) $(__VLO_TTL) $(__VLO_WAIT__BACKUP)) $(VLO_BACKUP_NAME)

_vlo_delete_backuplocation:
	@$(INFO) '$(VLO_UI_LABEL)Deleting backup-location "$(VLO_BACKUPLOCATION_NAME)" ...'; $(NORMAL)

_vlo_show_backuplocation: _vlo_show_backuplocation_description

_vlo_show_backuplocation_description:
	@$(INFO) '$(VLO_UI_LABEL)Showing description of backup-location "$(VLO_BACKUPLOCATION_NAME)" ...'; $(NORMAL)
	#$(VELERO) backup describe --details $(_X_VLO_SELECTOR__BACKUPS) $(VLO_BACKUP_NAME)

_vlo_view_backuplocations:
	@$(INFO) '$(VLO_UI_LABEL)Viewing backup-locations ...'; $(NORMAL)
	$(VELERO) get backup-locations

_vlo_view_backuplocations_set:
	@$(INFO) '$(VLO_UI_LABEL)Viewing backup-locations-set "$(VLO_BACKUPLOCATIONS_SET_NAME)"  ...'; $(NORMAL)
	#$(VELERO) backup describe $(__VLO_SELECTOR__BACKUPS) $(VLO_BACKUPS_NAMES)
