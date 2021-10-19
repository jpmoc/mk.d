_AZ_KEYVAULT_SECRET_MK_VERSION= $(_AZ_KEYVAULT_MK_VERSION)

# KVT_SECRET_BACKUP_DIRPATH?=
# KVT_SECRET_BACKUP_FILENAME?=
# KVT_SECRET_BACKUP_FILEPATH?=
# KVT_SECRET_DESCRIPTION?=
# KVT_SECRET_DISABLED_FLAG?= false
# KVT_SECRET_FILEPATH?=
# KVT_SECRET_ID?=
# KVT_SECRET_LOCATION_ID?= westus2
# KVT_SECRET_NAME?= my-secret
# KVT_SECRET_VALUE?=
# KVT_SECRET_VAULT_NAME?= my-vault
# KVT_SECRETS_VAULT_NAME?= my-vault
# KVT_SECRETS_SET_NAME?= my-secrets-set

# Derived parameters
KVT_SECRET_BACKUP_DIRPATH?= $(KVT_OUTPUTS_DIRPATH)
KVT_SECRET_BACKUP_FILEPATH?= $(KVT_SECRET_BACKUP_DIRPATH)$(KVT_SECRET_BACKUP_FILENAME)
KVT_SECRET_LOCATION_ID?= $(KVT_LOCATION_ID)
KVT_SECRET_VAULT_NAME?= $(KVT_VAULT_NAME)
KVT_SECRETS_VAULT_NAME?= $(KVT_SECRET_VAULT_NAME)

# Options parameters
__KVT_BACKUP_FILE__SECRET= $(if $(KVT_SECRET_BACKUP_FILEPATH),--file $(KVT_SECRET_BACKUP_FILEPATH))
__KVT_DISABLED__SECRET=
__KVT_ENCODING=
__KVT_EXPIRES=
__KVT_FILE__SECRET= $(if $(KVT_SECRET_FILEPATH),--file $(KVT_SECRET_FILEPATH))
__KVT_ID__SECRET= $(if $(KVT_SECRET_ID),--id $(KVT_SECRET_ID))
__KVT_LOCATION__SECRET= $(if $(KVT_SECRET_LOCATION_ID),--location $(KVT_SECRET_LOCATION_ID))
__KVT_MAXRESULTS__SECRET=
__KVT_NAME__SECRET= $(if $(KVT_SECRET_NAME),--name $(KVT_SECRET_NAME))
__KVT_NOT_BEFORE=
__KVT_TAGS__SECRET= $(if $(KVT_SECRET_TAGS_KEYVALUES),--tags $(KVT_SECRET_TAGS_KEYVALUES))
__KVT_VALUE__SECRET= $(if $(KVT_SECRET_VALUE),--value $(KVT_SECRET_VALUE))
__KVT_VAULT_NAME__SECRET= $(if $(KVT_SECRET_VAULT_NAME),--vault-name $(KVT_SECRET_VAULT_NAME))
__KVT_VAULT_NAME__SECRETS= $(if $(KVT_SECRETS_VAULT_NAME),--vault-name $(KVT_SECRETS_VAULT_NAME))

# UI parameters
KVT_UI_VIEW_SECRETS_FIELDS?= .id
KVT_UI_VIEW_SECRETS_SET_FIELDS?= $(KVT_UI_VIEW_SECRETS_FIELDS)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_kvt_view_framework_macros ::
	@#echo 'AZ::KeyVaulT::Secret ($(_AZ_KEYVAULT_SECRET_MK_VERSION)) macros:'
	@#echo

_kvt_view_framework_parameters ::
	@echo 'AZ::KeyVaulT::Secret ($(_AZ_KEYVAULT_SECRET_MK_VERSION)) parameters:'
	@echo '    KVT_SECRET_BACKUP_DIRPATH=$(KVT_SECRET_BACKUP_DIRPATH)'
	@echo '    KVT_SECRET_BACKUP_FILENAME=$(KVT_SECRET_BACKUP_FILENAME)'
	@echo '    KVT_SECRET_BACKUP_FILEPATH=$(KVT_SECRET_BACKUP_FILEPATH)'
	@echo '    KVT_SECRET_DESCRIPTION=$(KVT_SECRET_DESCRIPTION)'
	@echo '    KVT_SECRET_DISABLED_FLAG=$(KVT_SECRET_DISABLED_FLAG)'
	@echo '    KVT_SECRET_FILEPATH=$(KVT_SECRET_FILEPATH)'
	@echo '    KVT_SECRET_ID=$(KVT_SECRET_ID)'
	@echo '    KVT_SECRET_LOCATION_ID=$(KVT_SECRET_LOCATION_ID)'
	@echo '    KVT_SECRET_NAME=$(KVT_SECRET_NAME)'
	@echo '    KVT_SECRET_TAGS_KEYVALUES=$(KVT_SECRET_TAGS_KEYVALUES)'
	@echo '    KVT_SECRET_VALUE=$(KVT_SECRET_VALUE)'
	@echo '    KVT_SECRET_VAULT_NAME=$(KVT_SECRET_VAULT_NAME)'
	@echo '    KVT_SECRETS_SET_NAME=$(KVT_SECRETS_SET_NAME)'
	@echo

_kvt_view_framework_targets ::
	@echo 'AZ::KeyVaulT::Secret ($(_AZ_KEYVAULT_SECRET_MK_VERSION)) targets:'
	@echo '    _kvt_backup_secret              - Backup a secret'
	@echo '    _kvt_create_secret              - Create a secret'
	@echo '    _kvt_delete_secret              - Delete an existing secret'
	@echo '    _kvt_purge_secret               - Purge an existing secret'
	@echo '    _kvt_recover_secret             - Recover a deleted secret'
	@echo '    _kvt_restore_secret             - Restore a backed-up secret'
	@echo '    _kvt_show_secret                - Show everything related to a secret'
	@echo '    _kvt_show_secret_description    - Show description of a secret'
	@echo '    _kvt_show_secret_details        - Show details of a secret'
	@echo '    _kvt_show_secret_versions       - Show versions of a secret'
	@echo '    _kvt_update_secret              - Update a secret'
	@echo '    _kvt_view_secrets_set           - View a set of secrets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kvt_backup_secret:
	@$(INFO) '$(KVT_UI_LABEL)Backup a secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation backs up the name of the secret and its content'; $(NORMAL)
	$(AZ) keyvault secret backup $(__KVT_ID__SECRET) $(__KVT_BACKUP_FILE__SECRET) $(__KVT_NAME__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_create_secret:
	@$(INFO) '$(KVT_UI_LABEL)Creating/Updating secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault secret set $(__KVT_DESCRIPTION__SECRET) $(__KVT_DISABLED__SECRET) $(__KVT_ENCODING) $(__KVT_EXPIRES) $(__KVT_FILE__SECRET) $(__KVT_NAME__SECRET) $(__KVT_NOT_BEFORE) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_TAGS__SECRET) $(__KVT_VALUE__SECRET) $(__KVT_VAULT_NAME__SECRET)

_kvt_delete_secret:
	@$(INFO) '$(KVT_UI_LABEL)Deleting secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation deletes a secret, which can be recovered'; $(NORMAL)
	$(AZ) keyvault secret delete $(__KVT_ID__SECRET) $(__KVT_NAME__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_purge_secret:
	@$(INFO) '$(KVT_UI_LABEL)Purging secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation permanently deletes a secret'; $(NORMAL)
	$(AZ) keyvault secret purge $(__KVT_ID__SECRET) $(__KVT_NAME__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_recover_secret:
	@$(INFO) '$(KVT_UI_LABEL)Recovering secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation recovers from a secret-backup the name and content of a secret'; $(NORMAL)
	@$(WARN) 'This operation fails if a secret with the same name already exists'; $(NORMAL)
	$(AZ) keyvault secret recover $(__KVT_ID__SECRET) $(__KVT_NAME__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_restore_secret:
	@$(INFO) '$(KVT_UI_LABEL)Restoring secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation restore the content of a secret-backup'; $(NORMAL)
	$(AZ) keyvault secret restore $(__KVT_BACKUP_FILE__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_show_secret: _kvt_show_secret_details _kvt_show_secret_versions _kvt_show_secret_description

_kvt_show_secret_description:
	@$(INFO) '$(KVT_UI_LABEL)Showing description of secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault secret show $(__KVT_ID__SECRET) $(__KVT_NAME__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_show_secret_details:
	@$(INFO) '$(KVT_UI_LABEL)Showing details of secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault secret show $(__KVT_ID__SECRET) $(__KVT_NAME__SECRET) $(_X__KVT_OUTPUT) --output json $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_show_secret_versions:
	@$(INFO) '$(KVT_UI_LABEL)Showing versions of secret "$(KVT_SECRET_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault secret list-versions $(__KVT_MAXRESULTS__SECRET) $(__KVT_NAME__SECRET) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRET)

_kvt_update_secret: _kvt_create_secret

_kvt_view_secrets:
	@$(INFO) '$(KVT_UI_LABEL)Viewing secrets ...'; $(NORMAL)
	$(AZ) keyvault secret list $(__KVT_MAXRESULTS) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRETS) --query "[]$(KVT_UI_VIEW_SECRETS_FIELDS)"

_kvt_view_secrets_set:
	@$(INFO) '$(KVT_UI_LABEL)Viewing secrets-set "$(KVT_SECRETS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Secrets are grouped based on provided vault and query-filter'; $(NORMAL)
	$(AZ) keyvault secret list $(__KVT_MAXRESULTS) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__SECRETS) --query "[]$(KVT_UI_VIEW_SECRETS_SET_FIELDS)"
