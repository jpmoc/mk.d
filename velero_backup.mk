_VELERO_BACKUP_MK_VERSION= $(_VELERO_MK_VERSION)

VLO_BACKUP_CREATE_WAIT?= false
VLO_BACKUP_DELETE_CONFIRM?= false
# VLO_BACKUP_LABELS_KEYVALUES?= key1=value1 key2=value2
# VLO_BACKUP_NAME?= nginx-backup
# VLO_BACKUP_NAMESPACE_NAMES?= default
# VLO_BACKUP_NAMESPACE_NONAMES?= default
# VLO_BACKUP_RESOURCE_NAMES?= storageclasses.storage.k8s.io
# VLO_BACKUP_RESOURCE_NONAMES?= storageclasses.storage.k8s.io
# VLO_BACKUP_SELECTOR_KEYVALUES?= 
VLO_BACKUP_SNAPSHOTVOLUMES_ENABLE?= false
VLO_BACKUP_TIMETOLIVE?= 720h0m0s# That's one month!
# VLO_BACKUPS_SELECTOR_KEYVALUES?=  date=20190224 time=080012
# VLO_BACKUPS_SHOWLABELS_ENABLE?= false

# Derived parameters
VLO_BACKUPS_SHOWLABELS_ENABLE?= $(VLO_SHOWLABELS_ENABLE)
# VLO_BACKUPS_NAMES?= $(VLO_BACKUP_NAME)
VLO_BACKUPS_SELECTOR?= $(VLO_BACKUP_SELECTOR)

# Option parameters
__VLO_CONFIRM__BACKUP= $(if $(filter true, $(VLO_BACKUP_DELETE_CONFIRM)),--confirm)
__VLO_EXCLUDE_NAMESPACES__BACKUP= $(if $(VLO_BACKUP_NAMESPACE_NONAMES),--exclude-namespaces $(VLO_BACKUP_NAMESPACE_NONAMES))
__VLO_EXCLUDE_RESOURCES__BACKUP= $(if $(VLO_BACKUP_RECOURCE_NONAMES),--exclude-resources $(VLO_BACKUP_RESOURCE_NONAMES))
__VLO_INCLUDE_NAMESPACES__BACKUP= $(if $(VLO_BACKUP_NAMESPACE_NAMES),--include-namespaces $(VLO_BACKUP_NAMESPACE_NAMES))
__VLO_INCLUDE_RESOURCES__BACKUP= $(if $(VLO_BACKUP_RESOURCE_NAMES),--include-resources $(VLO_BACKUP_RESOURCE_NAMES))
__VLO_LABELS__BACKUP= $(if $(VLO_BACKUP_LABELS_KEYVALUES),--labels $(subst $(SPACE),$(COMMA),$(VLO_BACKUP_LABELS_KEYVALUES)))
__VLO_SELECTOR__BACKUP= $(if $(VLO_BACKUP_SELECTOR_KEYVALUES),--selector $(subst $(SPACE),$(COMMA),$(VLO_BACKUP_SELECTOR_KEYVALUES)))
__VLO_SELECTOR__BACKUPS= $(if $(VLO_BACKUPS_SELECTOR_KEYVALUES),--selector $(subst $(SPACE),$(COMMA),$(VLO_BACKUPS_SELECTOR_KEYVALUES)))
__VLO_SHOW_LABELS__BACKUPS= $(if $(filter true,$(VLO_BACKUPS_SHOWLABELS_ENABLE)),--show-labels)
__VLO_SNAPSHOT_VOLUMES__BACKUP= $(if $(VLO_BACKUP_SNAPSHOTVOLUMES_ENABLE),--snapshot-volumes=$(VLO_BACKUP_SNAPSHOTVOLUMES_ENABLE))
__VLO_TTL__BACKUP= $(if $(VLO_BACKUP_TIMETOLIVE),--ttl $(VLO_BACKUP_TIMETOLIVE))
__VLO_WAIT__BACKUP= $(if $(filter true,$(VLO_BACKUP_CREATE_WAIT)),--wait)

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::Backup ($(_VELERO_BACKUP_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::Backup ($(_VELERO_BACKUP_MK_VERSION)) parameters:'
	@echo '    VLO_BACKUP_CREATE_WAIT=$(VLO_BACKUP_CREATE_WAIT)'
	@echo '    VLO_BACKUP_DELETE_CONFIRM=$(VLO_BACKUP_DELETE_CONFIRM)'
	@echo '    VLO_BACKUP_LABELS_KEYVALUES=$(VLO_BACKUP_LABELS_KEYVALUES)'
	@echo '    VLO_BACKUP_NAME=$(VLO_BACKUP_NAME)'
	@echo '    VLO_BACKUP_NAMESPACE_NAMES=$(VLO_BACKUP_NAMESPACE_NAMES)'
	@echo '    VLO_BACKUP_NAMESPACE_NONAMES=$(VLO_BACKUP_NAMESPACE_NONAMES)'
	@echo '    VLO_BACKUP_RESOURCE_NAMES=$(VLO_BACKUP_RESOURCE_NAMES)'
	@echo '    VLO_BACKUP_RESOURCE_NONAMES=$(VLO_BACKUP_RESOURCE_NONAMES)'
	@echo '    VLO_BACKUP_SELECTOR_KEYVALUES=$(VLO_BACKUP_SELECTOR_KEYVALUES)'
	@echo '    VLO_BACKUP_SNAPSHOTVOLUMES_ENABLE=$(VLO_BACKUP_SNAPSHOTVOLUMES_ENABLE)'
	@echo '    VLO_BACKUP_TIMETOLIVE=$(VLO_BACKUP_TIMETOLIVE)'
	@echo '    VLO_BACKUPS_NAMES=$(VLO_BACKUPS_NAMES)'
	@echo '    VLO_BACKUPS_SET_NAME=$(VLO_BACKUPS_SET_NAME)'
	@echo '    VLO_BACKUPS_SELECTOR_KEYVALUES=$(VLO_BACKUPS_SELECTOR_KEYVALUES)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::Backup ($(_VELERO_BACKUP_MK_VERSION)) targets:'
	@echo '    _vlo_create_backup            - Create a backup' 
	@echo '    _vlo_delete_backup            - Delete a backup' 
	@echo '    _vlo_delete_backups           - Delete all backup' 
	@echo '    _vlo_restore_backup           - Restore a backup' 
	@echo '    _vlo_show_backup              - Show everything related to a backup' 
	@echo '    _vlo_show_backup_desription   - Show description of a backup' 
	@echo '    _vlo_show_backup_errors       - Show errors of a backup' 
	@echo '    _vlo_show_backup_logs         - Show logs of a backup' 
	@echo '    _vlo_view_backups             - View all backups' 
	@echo '    _vlo_view_backups_set         - View set of backups' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_create_backup:
	@$(INFO) '$(VLO_UI_LABEL)Creating backup "$(VLO_BACKUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if a backup with the same name already exists!'; $(NORMAL)
	$(VELERO) backup create $(strip $(__VLO_EXCLUDE_NAMESPACES__BACKUP) $(__VLO_EXCLUDE_RESOURCES__BACKUP) $(__VLO_INCLUDE_NAMESPACES__BACKUP) $(__VLO_INCLUDE_RESOURCES__BACKUP) $(__VLO_LABELS__BACKUP) $(_XX_VLO_SELECTOR__BACKUP) $(__VLO_SNAPSHOT_VOLUMES__BACKUP) $(__VLO_TTL__BACKUP) $(__VLO_WAIT__BACKUP)) $(VLO_BACKUP_NAME)

_vlo_delete_backup:
	@$(INFO) '$(VLO_UI_LABEL)Deleting backup "$(VLO_BACKUP_NAME)" ...'; $(NORMAL)
	$(VELERO) backup delete $(_X_VLO_ALL) $(__VLO_CONFIRM__BACKUP) $(VLO_BACKUP_NAME)

_vlo_delete_backups:
	@$(INFO) '$(VLO_UI_LABEL)Deleting backup "$(VLO_BACKUP_NAME)" ...'; $(NORMAL)
	$(VELERO) backup delete --all $(_X__VLO_CONFIRM__BACKUP)

_vlo_restore_backup: _vlo_create_restore

_vlo_show_backup: _vlo_show_backup_errors _vlo_show_backup_logs _vlo_show_backup_description

_vlo_show_backup_description:
	@$(INFO) '$(VLO_UI_LABEL)Showing description of backup "$(VLO_BACKUP_NAME)" ...'; $(NORMAL)
	$(VELERO) backup describe --details $(_X_VLO_SELECTOR__BACKUPS) $(VLO_BACKUP_NAME)

_vlo_show_backup_errors:
	@$(INFO) '$(VLO_UI_LABEL)Showing errors of backup "$(VLO_BACKUP_NAME)" ...'; $(NORMAL)
	$(VELERO) backup logs $(_X_VLO_SELECTOR__BACKUPS) $(VLO_BACKUP_NAME) | grep -i level=error || true

_vlo_show_backup_logs:
	@$(INFO) '$(VLO_UI_LABEL)Showing logs of backup "$(VLO_BACKUP_NAME)" ...'; $(NORMAL)
	$(VELERO) backup logs $(_X_VLO_SELECTOR__BACKUPS) $(VLO_BACKUP_NAME)

_vlo_view_backups:
	@$(INFO) '$(VLO_UI_LABEL)Viewing backups ...'; $(NORMAL)
	@$(WARN) 'Backups are ordered from the newest to the oldest'; $(NORMAL)
	$(VELERO) get backups $(_X__VLO_SELECTOR__BACKUPS) $(__VLO_SHOW_LABELS__BACKUPS) $(X_VLO_BACKUP_NAMES)

_vlo_view_backups_set:
	@$(INFO) '$(VLO_UI_LABEL)Viewing backups-set "$(VLO_BACKUPS_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Backups are grouped based on selector, name'; $(NORMAL) 
	$(VELERO) get backup $(__VLO_SELECTOR__BACKUPS) $(__VLO_SHOW_LABELS__BACKUPS) $(VLO_BACKUPS_NAMES)
