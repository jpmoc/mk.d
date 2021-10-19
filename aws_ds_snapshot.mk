_AWS_DS_SNAPSHOT_MK_VERSION= $(_AWS_DS_MK_VERSION)

# DS_SNAPSHOT_DIRECTORY_ID?= d-926728bc5d
# DS_SNAPSHOT_ID?=
# DS_SNAPSHOT_IDS?=
# DS_SNAPSHOT_NAME?= my-snapshot
# DS_SNAPSHOTS_SET_NAME?= my-snapshots-set

# Derived parameters
DS_SNAPSHOT_DIRECTORY_ID?= $(DS_DIRECTORY_ID)
DS_SNAPSHOT_IDS?= $(DS_SNAPSHOT_ID)

# Option parameters
__DS_DIRECTORY_ID__SNAPSHOT= $(if $(DS_SNAPSHOT_DIRECTORY_ID), --directory-id $(DS_SNAPSHOT_DIRECTORY_ID))
__DS_NAME__SNAPSHOT= $(if $(DS_SNAPSHOT_NAME), --name $(DS_SNAPSHOT_NAME))
__DS_SNAPSHOT_ID= $(if $(DS_SNAPSHOT_ID), --snqpshot-id $(DS_SNAPSHOT_ID))

# UI parameters
DS_UI_VIEW_SNAPSHOTS_FIELDS?=
DS_UI_VIEW_SNAPSHOTS_SET_FIELDS?= $(DS_UI_VIEW_SNAPSHOTS_FIELDS)
DS_UI_VIEW_SNAPSHOTS_SET_SLICE?=

#--- Utilities

#--- MACROS
_ds_get_snapshot_id= $(call _ds_get_snapshotid_N, $(DS_SNAPSHOT_NAME))
_ds_get_snapshot_id_N= $(shell $(AWS) ds describe-snapshots ... --output text)

#----------------------------------------------------------------------
# USAGE
#

_ds_view_framework_macros ::
	@echo 'AWS::DirectoryService::Snapshot ($(_AWS_DS_SNAPSHOT_MK_VERSION)) macros:'
	@echo '    _ds_get_snapshot_id_{|N}          - Get the ID of a directory-snapshot'
	@echo

_ds_view_framework_parameters ::
	@echo 'AWS::DirectoryService::Snapshot ($(_AWS_DS_SNAPSHOT_MK_VERSION)) parameters:'
	@echo '    DS_SNAPSHOT_DIRECTORY_ID?=$(DS_SNAPSHOT_DIRECTORY_ID)'
	@echo '    DS_SNAPSHOT_ID?=$(DS_SNAPSHOT_ID)'
	@echo '    DS_SNAPSHOT_IDS?=$(DS_SNAPSHOT_IDS)'
	@echo '    DS_SNAPSHOT_NAME?=$(DS_SNAPSHOT_NAME)'
	@echo '    DS_SNAPSHOTS_SET_NAME?=$(DS_SNAPSHOTS_SET_NAME)'
	@echo

_ds_view_framework_targets ::
	@echo 'AWS::DirectoryService::Snapshot ($(_AWS_DS_SNAPSHOT_MK_VERSION)) targets:'
	@echo '    _ds_create_snapshot               - Create a new directory-snapshot'
	@echo '    _ds_delete_snapshot               - Delete an existing directory-snapshot'
	@echo '    _ds_show_snapshot                 - Show everything related to a directory-snapshot'
	@echo '    _ds_view_snapshots                - View available directory-snapshots'
	@echo '    _ds_view_snapshots_set            - View a set of directory-snapshots'
	@echo 

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ds_create_snapshot:
	@$(INFO) '$(AWS_UI_LABEL)Creating a new directory-snapshot "$(DS_SNAPSHOT_NAME)" ...'; $(NORMAL)
	$(AWS) ds create-directory $(__DS_DIRECTORY_ID__SNAPSHOT) $(__DS_NAME__SNAPSHOT)

_ds_delete_snapshot:
	@$(INFO) '$(AWS_UI_LABEL)Deleting directory-snapshot "$(DS_SNAPSHOT_NAME)" ...'; $(NORMAL)
	$(AWS) ds delete-snapshot $(__DS_SNAPSHOT_ID)

_ds_show_snapshot:
	@$(INFO) '$(AWS_UI_LABEL)Showing directory-snapshot "$(DS_SNAPSHOT_NAME)" ...'; $(NORMAL)
	$(AWS) ds describe-snapshots $(__DS_SNAPSHOT_IDS)

_ds_view_snapshots:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directory-snapshots ...'; $(NORMAL)
	$(AWS) ds describe-snapshots $(_X__DS_DIRECTORY_ID__SNAPSHOT) $(_X__DS_SNAPSHOT_IDS) --query "Snapshots[]$(DS_UI_VIEW_SNAPSHOTS_FIELDS)"

_ds_view_snapshots_set:
	@$(INFO) '$(AWS_UI_LABEL)Viewing directory-snapshots "$(DS_SNAPSHOTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Snapshots are grouped based on the provided directory-ID, snapshot-IDs, and/or slice'; $(NORMAL)
	$(AWS) ds describe-snapshots $(__DS_DIRECTORY_ID__SNAPSHOT) $(__DS_SNAPSHOT_IDS) --query "Snapshots[$(DS_UI_VIEW_SNAPSHOTS_SET_SLICE)]$(DS_UI_VIEW_SNAPSHOTS_SET_FIELDS)"
