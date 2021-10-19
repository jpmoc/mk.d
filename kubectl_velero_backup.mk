_KUBECTL_VELERO_BACKUP_MK_VERSION= $(_KUBECTL_VELERO_MK_VERSION)

# KCL_BACKUP_NAME?=
# KCL_BACKUP_NAMESPACE_NAME?=
# KCL_BACKUPS_SET_NAME?= my-backups-set

# Derived parameters
KCL_BACKUP_NAMESPACE_NAME?= $(KCL_VELERO_NAMESPACE_NAME)

# Option parameters
__KCL_NAMESPACE__BACKUP= $(if $(KCL_BACKUP_NAMESPACE_NAME),--namespace $(KCL_BACKUP_NAMESPACE_NAME))

# UI parameters

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_kcl_view_framework_macros ::
	@echo 'KubeCtL::Backup ($(_KUBECTL_BACKUP_MK_VERSION)) macros:'
	@echo

_kcl_view_framework_parameters ::
	@echo 'KubeCtL::Backup ($(_KUBECTL_BACKUP_MK_VERSION)) parameters:'
	@echo '    KCL_BACKUP_NAME=$(KCL_BACKUP_NAME)'
	@echo '    KCL_BACKUP_NAMESPACE_NAME=$(KCL_BACKUP_NAMESPACE_NAME)'
	@echo '    KCL_BACKUPS_SET_NAME=$(KCL_BACKUPS_SET_NAME)'
	@echo

_kcl_view_framework_targets ::
	@echo 'KubeCtL::Backup ($(_KUBECTL_BACKUP_MK_VERSION)) targets:'
	@echo '    _kcl_create_backup             - Create a new backup'
	@echo '    _kcl_delete_backup             - Delete an existing backup'
	@echo '    _kcl_explain_backup            - Explain the backup'
	@echo '    _kcl_show_backup               - Show everything related to a backup'
	@echo '    _kcl_show_backup_description   - Show description of a backup'
	@echo '    _kcl_update_backup             - Update backup'
	@echo '    _kcl_view_backups              - View backups'
	@echo '    _kcl_view_backups_set          - View a set of backups'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kcl_create_backup:
	@$(INFO) '$(KCL_UI_LABEL)Creating backup "$(KCL_BACKUP_NAME)"  ...'; $(NORMAL)

_kcl_delete_backup:
	@$(INFO) '$(KCL_UI_LABEL)Deleting backup "$(KCL_BACKUP_NAME)" ...'; $(NORMAL)

_kcl_explain_backup:
	@$(INFO) '$(KCL_UI_LABEL)Explaining backup object ...'; $(NORMAL)
	$(KUBECTL) explain backup

_kcl_show_backup: _kcl_show_backup_description

_kcl_show_backup_description:
	@$(INFO) '$(KCL_UI_LABEL)Showing description of backup "$(KCL_BACKUP_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the backup does NOT exist'; $(NORMAL)
	-$(KUBECTL) describe backup $(KCL_BACKUP_NAME)

_kcl_update_backup:

_kcl_view_backups:
	@$(INFO) '$(KCL_UI_LABEL)Viewing backups ...'; $(NORMAL)
	$(KUBECTL) get backups

_kcl_view_backups_set:
	@$(INFO) '$(KCL_UI_LABEL)Viewing backups-set "$(KCL_BACKUPS_SET_NAME)" ...'; $(NORMAL)
