_AZ_KEYVAULT_KEY_MK_VERSION= $(_AZ_KEYVAULT_MK_VERSION)

## KVT_KEY_BACKUP_DIRPATH?=
## KVT_KEY_BACKUP_FILENAME?=
## KVT_KEY_BACKUP_FILEPATH?=
## KVT_KEY_DISABLED_FLAG?= false
## KVT_KEY_FILEPATH?=
# KVT_KEY_ID?=
## KVT_KEY_LOCATION_ID?= westus2
# KVT_KEY_NAME?= my-key
# KVT_KEY_TAGS_KEYVALUES?= key=value ...
# KVT_KEY_VAULT_NAME?= my-vault
# KVT_KEYS_VAULT_NAME?= my-vault
# KVT_KEYS_SET_NAME?= my-keys-set

# Derived parameters
## KVT_KEY_BACKUP_DIRPATH?= $(KVT_OUTPUTS_DIRPATH)
## KVT_KEY_BACKUP_FILEPATH?= $(KVT_KEY_BACKUP_DIRPATH)$(KVT_KEY_BACKUP_FILENAME)
## KVT_KEY_LOCATION_ID?= $(KVT_LOCATION_ID)
KVT_KEY_VAULT_NAME?= $(KVT_VAULT_NAME)
KVT_KEYS_VAULT_NAME?= $(KVT_KEY_VAULT_NAME)

# Options parameters
## __KVT_BACKUP_FILE__KEY= $(if $(KVT_KEY_BACKUP_FILEPATH),--file $(KVT_KEY_BACKUP_FILEPATH))
__KVT_DISABLED__KEY=
__KVT_EXPIRES__KEY=
__KVT_ID__KEY= $(if $(KVT_KEY_ID),--id $(KVT_KEY_ID))
## __KVT_LOCATION__KEY= $(if $(KVT_KEY_LOCATION_ID),--location $(KVT_KEY_LOCATION_ID))
## __KVT_MAXRESULTS__KEY=
__KVT_NAME__KEY= $(if $(KVT_KEY_NAME),--name $(KVT_KEY_NAME))
__KVT_NOT_BEFORE__KEY=
__KVT_TAGS__KEY= $(if $(KVT_KEY_TAGS_KEYVALUES),--tags $(KVT_KEY_TAGS_KEYVALUES))
__KVT_VAULT_NAME__KEY= $(if $(KVT_KEY_VAULT_NAME),--vault-name $(KVT_KEY_VAULT_NAME))
__KVT_VAULT_NAME__KEYS= $(if $(KVT_KEYS_VAULT_NAME),--vault-name $(KVT_KEYS_VAULT_NAME))

# UI parameters
KVT_UI_VIEW_KEYS_FIELDS?= .{kid:kid}
KVT_UI_VIEW_KEYS_SET_FIELDS?= $(KVT_UI_VIEW_FIELDS_FIELDS)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_kvt_view_framework_macros ::
	@#echo 'AZ::KeyVaulT::Key ($(_AZ_KEYVAULT_KEY_MK_VERSION)) macros:'
	@#echo

_kvt_view_framework_parameters ::
	@echo 'AZ::KeyVaulT::Key ($(_AZ_KEYVAULT_KEY_MK_VERSION)) parameters:'
	@#echo '    KVT_KEY_BACKUP_DIRPATH=$(KVT_KEY_BACKUP_DIRPATH)'
	@#echo '    KVT_KEY_BACKUP_FILENAME=$(KVT_KEY_BACKUP_FILENAME)'
	@#echo '    KVT_KEY_BACKUP_FILEPATH=$(KVT_KEY_BACKUP_FILEPATH)'
	@#echo '    KVT_KEY_DISABLED_FLAG=$(KVT_KEY_DISABLED_FLAG)'
	@#echo '    KVT_KEY_FILEPATH=$(KVT_KEY_FILEPATH)'
	@echo '    KVT_KEY_ID=$(KVT_KEY_ID)'
	@#echo '    KVT_KEY_LOCATION_ID=$(KVT_KEY_LOCATION_ID)'
	@echo '    KVT_KEY_NAME=$(KVT_KEY_NAME)'
	@echo '    KVT_KEY_TAGS_KEYVALUES=$(KVT_KEY_TAGS_KEYVALUES)'
	@echo '    KVT_KEY_VAULT_NAME=$(KVT_KEY_VAULT_NAME)'
	@echo '    KVT_KEYS_SET_NAME=$(KVT_KEYS_SET_NAME)'
	@echo

_kvt_view_framework_targets ::
	@echo 'AZ::KeyVaulT::Key ($(_AZ_KEYVAULT_KEY_MK_VERSION)) targets:'
	@echo '    _kvt_backup_key              - Backup a key'
	@echo '    _kvt_create_key              - Create a key'
	@echo '    _kvt_delete_key              - Delete an existing key'
	@echo '    _kvt_purge_key               - Purge an existing key'
	@echo '    _kvt_recover_key             - Recover a deleted key'
	@echo '    _kvt_restore_key             - Restore a backed-up key'
	@echo '    _kvt_show_key                - Show everything related to a key'
	@echo '    _kvt_show_key_description    - Show description of a key'
	@echo '    _kvt_show_key_details        - Show details of a key'
	@echo '    _kvt_show_key_versions       - Show versions of a key'
	@echo '    _kvt_update_key              - Update a key'
	@echo '    _kvt_view_keys_set           - View a set of keys'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kvt_backup_key:
	@$(INFO) '$(KVT_UI_LABEL)Backup a key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation backs up the name of the key and its content'; $(NORMAL)
	#$(AZ) keyvault key backup $(__KVT_ID__KEY) $(__KVT_BACKUP_FILE__KEY) $(__KVT_NAME__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_create_key:
	@$(INFO) '$(KVT_UI_LABEL)Creating key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault key create $(strip $(__KVT_CURVE) $(__KVT_DISABLED__KEY) $(__KVT_EXPIRES__KEY) $(__KVT_KTY) $(__KVT_NAME__KEY) $(__KVT_NOT_BEFORE__KEY) $(__KVT_OPS) $(__KVT_OUTPUT) $(__KVT_PROTECTION) $(__KVT_SIZE) $(__KVT_SUBSCRIPTION) $(__KVT_TAGS__KEY) $(__KVT_VAULT_NAME__KEY) )

_kvt_delete_key:
	@$(INFO) '$(KVT_UI_LABEL)Deleting key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation deletes a key, which can be recovered'; $(NORMAL)
	$(AZ) keyvault key delete $(__KVT_ID__KEY) $(__KVT_NAME__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_purge_key:
	@$(INFO) '$(KVT_UI_LABEL)Purging key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation permanently deletes a key'; $(NORMAL)
	#$(AZ) keyvault key purge $(__KVT_ID__KEY) $(__KVT_NAME__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_recover_key:
	@$(INFO) '$(KVT_UI_LABEL)Recovering key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation recovers from a key-backup the name and content of a key'; $(NORMAL)
	@#$(WARN) 'This operation fails if a key with the same name already exists'; $(NORMAL)
	#$(AZ) keyvault key recover $(__KVT_ID__KEY) $(__KVT_NAME__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_restore_key:
	@$(INFO) '$(KVT_UI_LABEL)Restoring key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	@#$(WARN) 'This operation restore the content of a key-backup'; $(NORMAL)
	#$(AZ) keyvault key restore $(__KVT_BACKUP_FILE__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_show_key: _kvt_show_key_details _kvt_show_key_versions _kvt_show_key_description

_kvt_show_key_description:
	@$(INFO) '$(KVT_UI_LABEL)Showing description of key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault key show $(__KVT_ID__KEY) $(__KVT_NAME__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_show_key_details:
	@$(INFO) '$(KVT_UI_LABEL)Showing details of key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault key show $(__KVT_ID__KEY) $(__KVT_NAME__KEY) $(_X__KVT_OUTPUT) --output json $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_show_key_versions:
	@$(INFO) '$(KVT_UI_LABEL)Showing versions of key "$(KVT_KEY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault key list-versions $(__KVT_MAXRESULTS__KEY) $(__KVT_NAME__KEY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEY)

_kvt_update_key: _kvt_create_key

_kvt_view_keys:
	@$(INFO) '$(KVT_UI_LABEL)Viewing keys ...'; $(NORMAL)
	$(AZ) keyvault key list $(_X__KVT_MAXRESULTS) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEYS) --query "[]$(KVT_UI_VIEW_KEYS_FIELDS)"

_kvt_view_keys_set:
	@$(INFO) '$(KVT_UI_LABEL)Viewing keys-set "$(KVT_KEYS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Keys are grouped basd on provided vault and query-filter'; $(NORMAL)
	$(AZ) keyvault key list $(__KVT_MAXRESULTS) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) $(__KVT_VAULT_NAME__KEYS) --query "[]$(KVT_UI_VIEW_KEYS_SET_FIELDS)"
