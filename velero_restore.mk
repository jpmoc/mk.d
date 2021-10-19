_VELERO_RESTORE_MK_VERSION= $(_VELERO_MK_VERSION)

# VLO_RESTORE_BACKUP_NAME?= nginx-backup
VLO_RESTORE_CREATE_WAIT?= false
# VLO_RESTORE_LABELS_KEYVALUES?= key1=value1 key2=value2
# VLO_RESTORE_NAME?= nginx-backup-20190809061751
# VLO_RESTORE_NAMESPACE_NAMES?= default
# VLO_RESTORE_NAMESPACE_NONAMES?= default
# VLO_RESTORE_RESOURCE_NAMES?= storageclasses.storage.k8s.io
# VLO_RESTORE_RESOURCE_NONAMES?= storageclasses.storage.k8s.io
# VLO_RESTORE_SCHEDULE_NAME?= nginx-backup-schedule
# VLO_RESTORE_SELECTOR_KEYVALUES?= 
# VLO_RESTORE_RESTOREVOLUMES_ENABLE?= false
# VLO_RESTORES_SELECTOR?= 

# Derived parameters
VLO_RESTORE_BACKUP_NAME?= $(VLO_BACKUP_NAME)
VLO_RESTORE_SELECTOR_KEYVALUES?= $(VLO_BACKUP_SELECTOR_KEYVALUES)
VLO_RESTORE_RESTOREVOLUMES_ENABLE?= $(VLO_BACKUP_SNAPSHOTVOLUMES_ENABLE)
VLO_RESTORES_NAMES?= $(VLO_RESTORE_NAME)
VLO_RESTORES_SELECTOR_KEYVALUES?= $(VLO_RESTORE_SELECTOR_KEYVALUES)

# Option parameters
__VLO_EXCLUDE_NAMESPACES__RESTORE= $(if $(VLO_RESTORE_NAMESPACE_NONAMES),--exclude-namespaces $(VLO_RESTORE_NAMESPACE_NAMES))
__VLO_FROM_BACKUP= $(if $(VLO_RESTORE_BACKUP_NAME),--from-backup $(VLO_RESTORE_BACKUP_NAME))
__VLO_FROM_SCHEDULE= $(if $(VLO_RESTORE_SCHEDULE_NAME),--from-schedule $(VLO_RESTORE_SCHEDULE_NAME))
__VLO_INCLUDE_NAMESPACES__RESTORE= $(if $(VLO_RESTORE_NAMESPACE_NAMES),--include-namespaces $(VLO_RESTORE_NAMESPACE_NAMES))
__VLO_LABELS__RESTORE= $(if $(VLO_RESTORE_LABELS_VALUES),--labels $(VLO_RESTORE_LABELS_KEYVALUES))
__VLO_RESTORE_VOLUMES= $(if $(VLO_RESTORE_RESTOREVOLUMES_ENABLE),--restore-volumes=$(VLO_RESTORE_RESTOREVOLUMES_ENABLE))
__VLO_SELECTOR__RESTORE= $(if $(VLO_RESTORE_SELECTOR_KEYVALUES),--selector $(VLO_RESTORE_SELECTOR_KEYVALUES))
__VLO_SELECTOR__RESTORES= $(if $(VLO_RESTORES_SELECTOR),--selector $(VLO_RESTORES_SELECTOR))
# __VLO_TTL= $(if $(VLO_RESTORE_TIMETOLIVE),--ttl $(VLO_RESTORE_TIMETOLIVE))
__VLO_WAIT__RESTORE= $(if $(filter true,$(VLO_RESTORE_CREATE_WAIT)),--wait)

# UI parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::Restore ($(_VELERO_RESTORE_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::Restore ($(_VELERO_RESTORE_MK_VERSION)) parameters:'
	@echo '    VLO_RESTORE_CREATE_WAIT=$(VLO_RESTORE_CREATE_WAIT)'
	@echo '    VLO_RESTORE_LABELS_KEYVALUES=$(VLO_RESTORE_LABELS_KEYVALUES)'
	@echo '    VLO_RESTORE_NAME=$(VLO_RESTORE_NAME)'
	@echo '    VLO_RESTORE_NAMESPACE_NAMES=$(VLO_RESTORE_NAMESPACE_NAMES)'
	@echo '    VLO_RESTORE_NAMESPACE_NONAMES=$(VLO_RESTORE_NAMESPACE_NONAMES)'
	@echo '    VLO_RESTORE_RESOURCE_NAMES=$(VLO_RESTORE_RESOURCE_NAMES)'
	@echo '    VLO_RESTORE_RESOURCE_NONAMES=$(VLO_RESTORE_RESOURCE_NONAMES)'
	@echo '    VLO_RESTORE_RESTOREVOLUME_ENABLE=$(VLO_RESTORE_RESTOREVOLUME_ENABLE)'
	@echo '    VLO_RESTORE_SCHEDULE_NAME=$(VLO_RESTORE_SCHEDULE_NAME)'
	@echo '    VLO_RESTORE_SELECTOR_KEYVALUES=$(VLO_RESTORE_SELECTOR_KEYVALUES)'
	@echo '    VLO_RESTORE_TIMETOLIVE=$(VLO_RESTORE_TIMETOLIVE)'
	@echo '    VLO_RESTORES_NAMES=$(VLO_RESTORES_NAMES)'
	@echo '    VLO_RESTORES_SET_NAME=$(VLO_RESTORES_SET_NAME)'
	@echo '    VLO_RESTORES_SELECTOR_KEYVALUES=$(VLO_RESTORES_SELECTOR_KEYVALUES)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::Restore ($(_VELERO_RESTORE_MK_VERSION)) targets:'
	@echo '    _vlo_create_restore            - Create a restore' 
	@echo '    _vlo_delete_restore            - Create a restore' 
	@echo '    _vlo_restore_restore           - Restore a restore' 
	@echo '    _vlo_show_restore              - Show everything related to a restore' 
	@echo '    _vlo_show_restore_description  - Show description of a restore' 
	@echo '    _vlo_show_restore_logs         - Show logs of a restore' 
	@echo '    _vlo_view_restores             - View all restores' 
	@echo '    _vlo_view_restores_set         - View set of restores' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_create_restore:
	@$(INFO) '$(VLO_UI_LABEL)Creating restore "$(VLO_RESTORE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the name of the restore already exists!'; $(NORMAL)
	@$(WARN) 'If no name is provided, a name will automatically be generated as $(VLO_RESTORE_BACKUP_NAME)-<timestamp>'; $(NORMAL)
	$(VELERO) restore create $(strip $(__VLO_EXCLUDE_NAMESPACES) $(__VLO_EXCLUDE_RESOURCES) $(__VLO_FROM_BACKUP) $(__VLO_FROM_SCHEDULE) $(__VLO_INCLUDE_NAMESPACES) $(__VLO_INCLUDE_RESOURCES) $(__VLO_LABELS) $(__VLO_RESTORE_VOLUMES) $(__VLO_SELECTOR__LABEL) $(__VLO_TTL) $(__VLO_WAIT__RESTORE)) $(VLO_RESTORE_NAME)

_vlo_delete_restore:
	@$(INFO) '$(VLO_UI_LABEL)Deleting restore "$(VLO_RESTORE_NAME)" ...'; $(NORMAL)

_vlo_show_restore: _vlo_show_restore_logs _vlo_show_restore_yaml _vlo_show_restore_description

_vlo_show_restore_description:
	@$(INFO) '$(VLO_UI_LABEL)Showing description of restore "$(VLO_RESTORE_NAME)" ...'; $(NORMAL)
	$(VELERO) restore describe --details $(_X_VLO_SELECTOR__RESTORES) $(VLO_RESTORE_NAME)

_vlo_show_restore_logs:
	@$(INFO) '$(VLO_UI_LABEL)Showing logs of restore "$(VLO_RESTORE_NAME)" ...'; $(NORMAL)
	$(VELERO) restore logs $(VLO_RESTORE_NAME)

_vlo_show_restore_yaml:
	@$(INFO) '$(VLO_UI_LABEL)Showing yaml of restore "$(VLO_RESTORE_NAME)" ...'; $(NORMAL)
	#$(VELERO) restore describe --details --output yaml $(_X_VLO_SELECTOR__RESTORES) $(VLO_RESTORE_NAME)

_vlo_view_restores:
	@$(INFO) '$(VLO_UI_LABEL)Viewing restores ...'; $(NORMAL)
	$(VELERO) get restores $(__VLO_SELECTOR__RESTORES) $(VLO_RESTORES_NAMES)

_vlo_view_restores_set:
	@$(INFO) '$(VLO_UI_LABEL)Viewing restores-set "$(VLO_RESTORES_SET_NAME)"  ...'; $(NORMAL)
	$(VELERO) get restores $(__VLO_SELECTOR__RESTORES) $(VLO_RESTORES_NAMES)
