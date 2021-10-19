_VELERO_SCHEDULE_MK_VERSION= $(_VELERO_MK_VERSION)

# VLO_SCHEDULE_CRON?= "0 */6 * * *"
VLO_SCHEDULE_DELETE_CONFIRM?= false
# VLO_SCHEDULES_SET_NAME?= my-schedules-set
# VLO_SCHEDULE_LABELS_KEYVALUES?= key1=value1 key2=value2
# VLO_SCHEDULE_NAME?= nginx-schedule
# VLO_SCHEDULE_NAMESPACE_NAMES?= default
# VLO_SCHEDULE_NAMESPACE_NONAMES?= default
# VLO_SCHEDULE_RESOURCE_NAMES?= storageclasses.storage.k8s.io
# VLO_SCHEDULE_RESOURCE_NONAMES?= storageclasses.storage.k8s.io
# VLO_SCHEDULE_SELECTOR_KEYVALUES?=
VLO_SCHEDULE_SNAPSHOTVOLUMES_ENABLE?= false
VLO_SCHEDULE_BACKUP_TIMETOLIVE?= 720h0m0s
# VLO_SCHEDULES_SELECTOR_KEYVALUES?=
# VLO_SCHEDULES_SHOWLABELS_ENABLE?=

# Derived parameters
VLO_SCHEDULE_NAMESPACE_NAMES?= $(VLO_BACKUP_NAMESPACE_NAMES)
VLO_SCHEDULE_NAMESPACE_NONAMES?= $(VLO_BACKUP_NAMESPACE_NONAMES)
VLO_SCHEDULE_RESOURCE_NAMES?= $(VLO_BACKUP_RESOURCE_NAMES)
VLO_SCHEDULE_RESOURCE_NONAMES?= $(VLO_BACKUP_RESOURCE_NONAMES)
VLO_SCHEDULES_NAMES?= $(VLO_SCHEDULE_NAME)
VLO_SCHEDULES_SELECTOR?= $(VLO_SCHEDULE_SELECTOR)
VLO_SCHEDULES_SHOWLABELS_ENABLE?= $(VLO_SHOWLABELS_ENABLE)

# Option parameters
__VLO_CONFIRM__SCHEDULE= $(if $(filter true,$(VLO_SCHEDULE_DELETE_CONFIRM)),--confirm)
__VLO_EXCLUDE_NAMESPACES__SCHEDULE= $(if $(VLO_SCHEDULE_NAMESPACE_NONAMES),--exclude-namespaces $(VLO_SCHEDULE_NAMESPACE_NONAMES))
__VLO_EXCLUDE_RESOURCES__SCHEDULE= $(if $(VLO_SCHEDULE_RESOURCE_NONAMES),--exclude-resources $(VLO_SCHEDULE_RESOURCE_NONAMES))
__VLO_INCLUDE_NAMESPACES__SCHEDULE= $(if $(VLO_SCHEDULE_NAMESPACE_NAMES),--include-namespaces $(VLO_SCHEDULE_NAMESPACE_NAMES))
__VLO_INCLUDE_RESOURCES__SCHEDULE= $(if $(VLO_SCHEDULE_RESOURCE_NAMES),--include-resources $(VLO_SCHEDULE_RESOURCE_NAMES))
__VLO_LABELS__SCHEDULE= $(if $(VLO_SCHEDULE_LABELS_KEYVALUES),--labels $(subst $(SPACE),$(COMMA),$(VLO_SCHEDULE_LABELS_KEYVALUES)))
__VLO_SCHEDULE= $(if $(VLO_SCHEDULE_CRON),--schedule $(VLO_SCHEDULE_CRON))
__VLO_SELECTOR__SCHEDULE= $(if $(VLO_SCHEDULE_SELECTOR_KEYVALUES),--selector $(subst $(SPACE),$(COMMA),$(VLO_SCHEDULE_SELECTOR_KEYVALUES)))
__VLO_SELECTOR__SCHEDULES= $(if $(VLO_SCHEDULES_SELECTOR_KEYVALUES),--selector $(subst $(SPACE),$(COMMA),$(VLO_SCHEDULES_SELECTOR_KEYVALUES)))
__VLO_SHOW_LABELS__SCHEDULES= $(if $(filter true,$(VLO_SCHEDULES_SHOWLABELS_ENABLE)),--show-labels)
__VLO_SNAPSHOT_VOLUMES__SCHEDULE= $(if $(filter true,$(VLO_SCHEDULE_SNAPSHOTVOLUMES_ENABLE)),--snapshot-volumes)
__VLO_TTL__SCHEDULE= $(if $(VLO_SCHEDULE_BACKUP_TIMETOLIVE),--ttl $(VLO_SCHEDULE_BACKUP_TIMETOLIVE))

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::Schedule ($(_VELERO_SCHEDULE_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::Schedule ($(_VELERO_SCHEDULE_MK_VERSION)) parameters:'
	@echo '    VLO_SCHEDULE_CRON=$(VLO_SCHEDULE_CRON)'
	@echo '    VLO_SCHEDULE_DELETE_CONFIRM=$(VLO_SCHEDULE_DELETE_CONFIRM)'
	@echo '    VLO_SCHEDULE_LABELS_KEYVALUES=$(VLO_SCHEDULE_LABELS_KEYVALUES)'
	@echo '    VLO_SCHEDULE_NAME=$(VLO_SCHEDULE_NAME)'
	@echo '    VLO_SCHEDULE_NAMESPACE_NAMES=$(VLO_SCHEDULE_NAMESPACE_NAMES)'
	@echo '    VLO_SCHEDULE_NAMESPACE_NONAMES=$(VLO_SCHEDULE_NAMESPACE_NONAMES)'
	@echo '    VLO_SCHEDULE_RESOURCE_NAMES=$(VLO_SCHEDULE_RESOURCE_NAMES)'
	@echo '    VLO_SCHEDULE_RESOURCE_NONAMES=$(VLO_SCHEDULE_RESOURCE_NONAMES)'
	@echo '    VLO_SCHEDULE_SELECTOR_KEYVALUES=$(VLO_SCHEDULE_SELECTOR_KEYVALUES)'
	@echo '    VLO_SCHEDULE_SNAPSHOTVOLUMES_ENABLE=$(VLO_SCHEDULE_SNAPSHOTVOLUMES_ENABLE)'
	@echo '    VLO_SCHEDULE_BACKUP_TIMETOLIVE=$(VLO_SCHEDULE_BACKUP_TIMETOLIVE)'
	@echo '    VLO_SCHEDULES_NAMES=$(VLO_SCHEDULES_NAMES)'
	@echo '    VLO_SCHEDULES_SET_NAME=$(VLO_SCHEDULES_SET_NAME)'
	@echo '    VLO_SCHEDULES_SELECTOR_KEYVALUES=$(VLO_SCHEDULES_SELECTOR_KEYVALUES)'
	@echo '    VLO_SCHEDULES_SHOWLABELS_ENABLE=$(VLO_SCHEDULES_SHOWLABELS_ENABLE)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::Schedule ($(_VELERO_SCHEDULE_MK_VERSION)) targets:'
	@echo '    _vlo_create_schedule            - Create a schedule' 
	@echo '    _vlo_delete_schedule            - Delete a schedule' 
	@echo '    _vlo_delete_schedules           - Delete all schedules' 
	@echo '    _vlo_show_schedule              - Show everything related to a schedule' 
	@echo '    _vlo_show_schedule_description  - Show description of a schedule' 
	@echo '    _vlo_view_schedules             - View all schedules' 
	@echo '    _vlo_view_schedules_set         - View set of schedules' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_create_schedule:
	@$(INFO) '$(VLO_UI_LABEL)Creating schedule "$(VLO_SCHEDULE_NAME)" ...'; $(NORMAL)
	$(VELERO) schedule create $(strip $(__VLO_EXCLUDE_NAMESPACES__SCHEDULE) $(__VLO_EXCLUDE_RESOURCES__SCHEDULE) $(__VLO_INCLUDE_NAMESPACES__SCHEDULE) $(__VLO_INCLUDE_RESOURCES__SCHEDULE) $(__VLO_LABELS__SCHEDULE) $(__VLO_SCHEDULE) $(__VLO_SELECTOR__SCHEDULE) $(__VLO_SNAPSHOT_VOLUMES__SCHEDULE) $(__VLO_STORAGE_LOCATION__SCHEDULE) $(__VLO_TTL__SCHEDULE) $(__VLO_VOLUME_SNAPSHOT_LOCATION) $(__VLO_WAIT__SCHEDULE)) $(VLO_SCHEDULE_NAME)

_vlo_delete_schedule:
	@$(INFO) '$(VLO_UI_LABEL)Deleting schedule "$(VLO_SCHEDULE_NAME)" ...'; $(NORMAL)
	$(VELERO) schedule delete $(_X__VLO_ALL__SCHEDULE) $(__VLO_CONFIRM__SCHEDULE) $(VLO_SCHEDULE_NAME)

_vlo_delete_schedules:
	@$(INFO) '$(VLO_UI_LABEL)Deleting ALL schedules  ...'; $(NORMAL)
	$(VELERO) schedule delete -all $(_X__VLO_CONFIRM__SCHEDULE) $(X_VLO_SCHEDULE_NAME)

_vlo_show_schedule: _vlo_show_schedule_description

_vlo_show_schedule_description:
	@$(INFO) '$(VLO_UI_LABEL)Showing description of schedule "$(VLO_SCHEDULE_NAME)" ...'; $(NORMAL)
	$(VELERO) schedule describe $(_X_VLO_SELECTOR__SCHEDULES) $(VLO_SCHEDULE_NAME)

_vlo_view_schedules:
	@$(INFO) '$(VLO_UI_LABEL)Viewing schedules ...'; $(NORMAL)
	$(VELERO) get schedules $(__VLO_SHOW_LABELS__SCHEDULES)

_vlo_view_schedules_set:
	@$(INFO) '$(VLO_UI_LABEL)Viewing schedules-set "$(VLO_SCHEDULES_SET_NAME)"  ...'; $(NORMAL)
	@$(WARN) 'Schedules are grouped based on provided selector, name'; $(NORMAL)
	$(VELERO) get schedules $(__VLO_SELECTOR__SCHEDULES) $(__VLO_SHOW_LABELS__SCHEDULES) $(VLO_SCHEDULES_NAMES)
