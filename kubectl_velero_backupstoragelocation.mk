_KUBECTL_VELERO_BACKUPSTORAGELOCATION_MK_VERSION= $(_KUBECTL_VELERO_MK_VERSION)

# KCL_BACKUPSTORAGELOCATION_NAME?=
# KCL_BACKUPSTORAGELOCATION_NAMESPACE_NAME?=
# KCL_BACKUPSTORAGELOCATIONS_SET_NAME?= my-backup-storage-locations-set

# Derived parameters
KCL_BACKUPSTORAGELOCATION_NAMESPACE_NAME?= $(KCL_VELERO_NAMESPACE_NAME)

# Option parameters
__KCL_NAMESPACE__BACKUPSTORAGELOCATION= $(if $(KCL_BACKUPSTORAGELOCATION_NAMESPACE_NAME),--namespace $(KCL_BACKUPSTORAGELOCATION_NAMESPACE_NAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::BackupStorageLocation ($(_KUBECTL_BACKUPSTORAGELOCATION_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::BackupStorageLocation ($(_KUBECTL_BACKUPSTORAGELOCATION_MK_VERSION)) parameters:'
	@echo '    KCL_BACKUPSTORAGELOCATION_NAME=$(KCL_BACKUPSTORAGELOCATION_NAME)'
	@echo '    KCL_BACKUPSTORAGELOCATION_NAMESPACE_NAME=$(KCL_BACKUPSTORAGELOCATION_NAMESPACE_NAME)'
	@echo '    KCL_BACKUPSTORAGELOCATIONS_SET_NAME=$(KCL_BACKUPSTORAGELOCATIONS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::BackupStorageLocation ($(_KUBECTL_BACKUPSTORAGELOCATION_MK_VERSION)) targets:'
	@echo '    _kcl_create_backupstoragelocation             - Create a new backup-storage-location'
	@echo '    _kcl_delete_backupstoragelocation             - Delete an existing backup-storage-location'
	@echo '    _kcl_explain_backupstoragelocation            - Explain the backup-storage-location object'
	@echo '    _kcl_show_backupstoragelocation               - Show everything related to a backup-storage-location'
	@echo '    _kcl_show_backupstoragelocation_description   - Show description of a backup-storage-location'
	@echo '    _kcl_update_backupstoragelocation             - Update backup-storage-location'
	@echo '    _kcl_view_backupstoragelocations              - View backup-storage-locations'
	@echo '    _kcl_view_backupstoragelocations_set          - View a set of backup-storage-locations'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_create_backupstoragelocation:
	@$(INFO) '$(KCL_UI_LABEL)Creating backup-storage-location "$(KCL_NAMESPACE_NAME)"  ...'; $(NORMAL)

_kcl_delete_backupstoragelocation:
	@$(INFO) '$(KCL_UI_LABEL)Deleting backup-storage-location "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)

_kcl_explain_backupstoragelocation:
	@$(INFO) '$(KCL_UI_LABEL)Explaining backup-storage-location object ...'; $(NORMAL)
	$(KUBECTL) explain backupstoragelocation

_kcl_show_backupstoragelocation: _kcl_show_backupstoragelocation_description

_kcl_show_backupstoragelocation_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of backup-storage-location "$(KCL_NAMESPACE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the backupstoragelocation does NOT exist'; $(NORMAL)
	-$(KUBECTL) describe backupstoragelocation $(KCL_NAMESPACE_NAME)

_kcl_update_backupstoragelocation:

_kcl_view_backupstoragelocations:
	@$(INFO) '$(KCL_UI_LABEL)Viewing backup-storage-locations ...'; $(NORMAL)
	$(KUBECTL) get backupstoragelocations

_kcl_view_backupstoragelocations_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing backup-storage-locations-set "$(KCL_NAMESPACES_SET_NAME)" ...'; $(NORMAL)
