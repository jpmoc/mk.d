_VELERO_SNAPSHOTLOCATION_MK_VERSION= $(_VELERO_MK_VERSION)

# VLO_SNAPSHOTLOCATION_NAME?= nginx-snapshot
# VLO_SNAPSHOTLOCATIONS_SET_NAME?= my-Xes-set

# Derived parameters

# Option parameters

# UI parameters

#--- Utilities


#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_vlo_view_framework_macros ::
	@echo 'VeLerO::SnapshotLocation ($(_VELERO_SNAPSHOTLOCATION_MK_VERSION)) macros:'
	@echo

_vlo_view_framework_parameters ::
	@echo 'VeLerO::SnapshotLocation ($(_VELERO_SNAPSHOTLOCATION_MK_VERSION)) parameters:'
	@echo '    VLO_SNAPSHOTLOCATION_NAME=$(VLO_SNAPSHOTLOCATION_NAME)'
	@echo '    VLO_SNAPSHOTLOCATIONS_SET_NAME=$(VLO_SNAPSHOTLOCATIONS_SET_NAME)'
	@echo

_vlo_view_framework_targets ::
	@echo 'VeLerO::SnapshotLocation ($(_VELERO_SNAPSHOTLOCATION_MK_VERSION)) targets:'
	@echo '    _vlo_create_snapshotlocation            - Create a snapshot-location' 
	@echo '    _vlo_delete_snapshotlocation            - Delete a snapshot-location' 
	@echo '    _vlo_show_snapshotlocation              - Show everything related to a snapshot-location' 
	@echo '    _vlo_show_snapshotlocation_desription   - Show description of a snapshot-location' 
	@echo '    _vlo_view_snapshotlocations             - View all snapshot-locations' 
	@echo '    _vlo_view_snapshotlocations_set         - View set of snapshot-locations' 
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#
#

_vlo_create_snapshotlocation:
	@$(INFO) '$(VLO_UI_LABEL)Creating snapshot-location "$(VLO_SNAPSHOTLOCATION_NAME)" ...'; $(NORMAL)
	#$(VELERO) snapshot create $(strip $(__VLO_EXCLUDE_NAMESPACES) $(__VLO_EXCLUDE_RESOURCES) $(__VLO_INCLUDE_NAMESPACES) $(__VLO_INCLUDE_RESOURCES) $(__VLO_LABELS) $(__VLO_SELECTOR__LABEL) $(_XX_VLO_SNAPSHOT_VOLUME) $(__VLO_TTL) $(__VLO_WAIT__SNAPSHOT)) $(VLO_SNAPSHOT_NAME)

_vlo_delete_snapshotlocation:
	@$(INFO) '$(VLO_UI_LABEL)Deleting snapshot-location "$(VLO_SNAPSHOTLOCATION_NAME)" ...'; $(NORMAL)

_vlo_show_snapshotlocation: _vlo_show_snapshotlocation_description

_vlo_show_snapshotlocation_description:
	@$(INFO) '$(VLO_UI_LABEL)Showing description of snapshot-location "$(VLO_SNAPSHOTLOCATION_NAME)" ...'; $(NORMAL)
	#$(VELERO) snapshot describe --details $(_X_VLO_SELECTOR__SNAPSHOTS) $(VLO_SNAPSHOT_NAME)

_vlo_view_snapshotlocations:
	@$(INFO) '$(VLO_UI_LABEL)Viewing snapshot-locations ...'; $(NORMAL)
	$(VELERO) get snapshot-locations

_vlo_view_snapshotlocations_set:
	@$(INFO) '$(VLO_UI_LABEL)Viewing snapshot-locations-set "$(VLO_SNAPSHOTLOCATIONS_SET_NAME)"  ...'; $(NORMAL)
	#$(VELERO) snapshot describe $(__VLO_SELECTOR__SNAPSHOTS) $(VLO_SNAPSHOTS_NAMES)
