_AZ_KEYVAULT_VAULT_MK_VERSION= $(_AZ_KEYVAULT_MK_VERSION)

KVT_VAULT_ENABLEDFORDEPLOYMENT_FLAG?= false
# KVT_VAULT_LOCATION_ID?= westus2
# KVT_VAULT_NAME?= kvbcc6589f5a8c3889
# KVT_VAULT_RESOURCEGROUP_NAME?=
KVT_VAULT_SKU_ENUM?= standard
# KVT_VAULT_TAGS_KEYVALUE?= key=value
# KVT_VAULTS_SET_NAME?= my-vaults-set

# Derived parameters
KVT_VAULT_LOCATION_ID?= $(KVT_LOCATION_ID)
KVT_VAULT_RESOURCEGROUP_NAME?= $(KVT_RESOURCEGROUP_NAME)

# Options parameters
__KVT_ADD=
__KVT_BYPASS=
__KVT_DEFAULT_ACTION=
__KVT_ENABLE_PURGE_PROTECTION=
__KVT_ENABLE_SOFT_DELETE=
__KVT_ENABLED_FOR_DEPLOYMENT= $(if $(KVT_VAULT_ENABLEDFORDEPLOYMENT_FLAG),--enabled-for-deployment $(KVT_VAULT_ENABLEDFORDEPLOYMENT_FLAG))
__KVT_ENABLED_FOR_DISK_ENCRYPTION=
__KVT_ENABLED_FOR_TEMPLATE_DEPLOYMENT=
__KVT_FORCE_STRING=
__KVT_LOCATION__VAULT= $(if $(KVT_VAULT_LOCATION_ID),--location $(KVT_VAULT_LOCATION_ID))
__KVT_MAXRESULTS__VAULT=
__KVT_NAME__VAULT= $(if $(KVT_VAULT_NAME),--name $(KVT_VAULT_NAME))
__KVT_NO_SELF_PERMS=
__KVT_REMOVE=
__KVT_RESOURCE_GROUP__VAULT= $(if $(KVT_VAULT_RESOURCEGROUP_NAME),--resource-group $(KVT_VAULT_RESOURCEGROUP_NAME))
__KVT_SET=
__KVT_SKU= $(if $(KVT_VAULT_SKU_ENUM),--sku $(KVT_VAULT_SKU_ENUM))
__KVT_TAGS__VAULT= $(if $(KVT_VAULT_TAGS_KEYVALUES),--tags $(KVT_VAULT_TAGS_KEYVALUES))
__KVT_VAULT_NAME__VAULT= $(if $(KVT_VAULT_NAME),--vault-name $(KVT_VAULT_NAME))

# UI parameters
KVT_UI_SHOW_VAULT_ACCESSPOLICIES_FIELDS?=  .{objectId:objectId,certificates:join(' ',permissions.certificates[]||['']),keys:join(' ',permissions.keys[]||['']),secrets:join(' ',permissions.secrets[]||['']),storage:join(' ',permissions.storage[]||[''])}

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_kvt_view_framework_macros ::
	@#echo 'AZ::KeyVaulT::Vault ($(_AZ_KEYVAULT_VAULT_MK_VERSION)) macros:'
	@#echo

_kvt_view_framework_parameters ::
	@echo 'AZ::KeyVaulT::Vault ($(_AZ_KEYVAULT_VAULT_MK_VERSION)) parameters:'
	@echo '    KVT_VAULT_ENABLEDFORDEPLOYMENT_FLAG=$(KVT_VAULT_ENABLEDFORDEPLOYMENT_FLAG)'
	@echo '    KVT_VAULT_LOCATION_ID=$(KVT_VAULT_LOCATION_ID)'
	@echo '    KVT_VAULT_NAME=$(KVT_VAULT_NAME)'
	@echo '    KVT_VAULT_RESOURCEGROUP_NAME=$(KVT_VAULT_RESOURCEGROUP_NAME)'
	@echo '    KVT_VAULT_SKU_ENUM=$(KVT_VAULT_SKU_ENUM)'
	@echo '    KVT_VAULT_TAGS_KEYVALUES=$(KVT_VAULT_TAGS_KEYVALUES)'
	@echo '    KVT_VAULTS_SET_NAME=$(KVT_VAULTS_SET_NAME)'
	@echo

_kvt_view_framework_targets ::
	@echo 'AZ::KeyVaulT::Vault ($(_AZ_KEYVAULT_VAULT_MK_VERSION)) targets:'
	@echo '    _kvt_create_vault              - Create a vault'
	@echo '    _kvt_delete_vault              - Delete an existing vault'
	@echo '    _kvt_show_vault                - Show everything related to a vault'
	@echo '    _kvt_show_vault_description    - Show description of a vault'
	@echo '    _kvt_show_vault_certificates   - Show certificates in a vault'
	@echo '    _kvt_show_vault_keys           - Show keys in a vault'
	@echo '    _kvt_show_vault_networkrules   - Show network-rules in a vault'
	@echo '    _kvt_show_vault_secrets        - Show secrets in a vault'
	@echo '    _kvt_show_vault_storages       - Show storages in a vault'
	@echo '    _kvt_tag_vault                 - Tag a vault'
	@echo '    _kvt_update_vault              - Update a vault'
	@echo '    _kvt_view_vaults               - View vaults'
	@echo '    _kvt_view_vaults_set           - View a set of vaults'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kvt_create_vault:
	@$(INFO) '$(KVT_UI_LABEL)Creating vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault create $(strip $(__KVT_BYPASS) $(__KVT_DEFAULT_ACTION) $(__KVT_ENABLE_PURGE_PROTECTION) $(__KVT_ENABLE_SOFT_DELETE) $(__KVT_ENABLED_FOR_DEPLOYMENT) $(__KVT_ENABLED_FOR_DISK_ENCRYPTION) $(__KVT_ENABLED_FOR_TEMPLATE_DEPLOYMENT) $(__KVT_LOCATION__VAULT) $(__KVT_NAME__VAULT) $(__KVT_NO_SELF_PERMS) $(__KVT_OUTPUT) $(__KVT_RESOURCE_GROUP__VAULT) $(__KVT_SKU) $(__KVT_SUBSCRIPTION) $(__KVT_TAGS__VAULT))

_kvt_delete_vault:
	@$(INFO) '$(KVT_UI_LABEL)Deleting vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault delete $(__KVT_NAME__VAULT) $(__KVT_RESOURCE_GROUP__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_show_vault: _kvt_show_vault_accesspolicies _kvt_show_vault_certificates _kvt_show_vault_keys _kvt_show_vault_networkrules _kvt_show_vault_object _kvt_show_vault_secrets _kvt_show_vault_storages _kvt_show_vault_description

_kvt_show_vault_accesspolicies:
	@$(INFO) '$(KVT_UI_LABEL)Showing vault access-policies of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_NAME__VAULT) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) --query "properties.accessPolicies[]$(KVT_UI_SHOW_VAULT_ACCESSPOLICIES_FIELDS)"

_kvt_show_vault_certificates:
	@$(INFO) '$(KVT_UI_LABEL)Showing certificates of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault certificate list $(__KVT_OUTPUT) $(__KVT_MAXRESULTS__VAULT) $(__KVT_VAULT_NAME__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_show_vault_description:
	@$(INFO) '$(KVT_UI_LABEL)Showing description of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_OUTPUT) $(__KVT_NAME__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_show_vault_keys:
	@$(INFO) '$(KVT_UI_LABEL)Showing keys of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault key list $(__KVT_OUTPUT) $(__KVT_MAXRESULTS__VAULT) $(__KVT_VAULT_NAME__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_show_vault_object:
	@$(INFO) '$(KVT_UI_LABEL)Showing object of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_NAME__VAULT) $(_X__KVT_OUTPUT) --output json $(__KVT_SUBSCRIPTION)

_kvt_show_vault_networkrules:
	@$(INFO) '$(KVT_UI_LABEL)Showing network-rules of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault network-rule list $(__KVT_NAME__VAULT) $(_X__KVT_OUTPUT) --output json $(__KVT_SUBSCRIPTION)

_kvt_show_vault_secrets:
	@$(INFO) '$(KVT_UI_LABEL)Showing secrets of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault secret list $(__KVT_OUTPUT) $(__KVT_MAXRESULTS__VAULT) $(__KVT_VAULT_NAME__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_show_vault_storages:
	@$(INFO) '$(KVT_UI_LABEL)Showing storages of vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault secret list $(__KVT_OUTPUT) $(__KVT_MAXRESULTS__VAULT) $(__KVT_VAULT_NAME__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_update_vault:
	@$(INFO) '$(KVT_UI_LABEL)Updating vault "$(KVT_VAULT_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault update $(strip $(__KVT_ADD) $(__KVT_BYPASS) $(__KVT_DEFAULT_ACTION) $(__KVT_ENABLE_PURGE_PROTECTION) $(__KVT_ENABLE_SOFT_DELETE) $(__KVT_ENABLED_FOR_DEPLOYMENT) $(__KVT_ENABLED_FOR_DISK_ENCRYPTION) $(__KVT_ENABLED_FOR_TEMPLATE_DEPLOYMENT) $(__KVT_FORCE_STRING) $(__KVT_LOCATION__VAULT) $(__KVT_NAME__VAULT) $(__KVT_NO_SELF_PERMS) $(__KVT_OUTPUT) $(__KVT_REMOVE) $(__KVT_RESOURCE_GROUP__VAULT) $(__KVT_SET) $(__KVT_SKU) $(__KVT_SUBSCRIPTION) $(__KVT_TAGS__VAULT))

_kvt_view_vaults:
	@$(INFO) '$(KVT_UI_LABEL)Viewing vaults ...'; $(NORMAL)
	$(AZ) keyvault list $(__KVT_OUTPUT) $(_X__KVT_RESOURCE_GROUP__VAULT) $(__KVT_SUBSCRIPTION)

_kvt_view_vaults_set:
	@$(INFO) '$(KVT_UI_LABEL)Viewing vaults-set "$(KVT_VAULTS_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Vaults are grouped basd on provided resource-group and query-filter'; $(NORMAL)
	$(AZ) keyvault list $(__KVT_OUTPUT) $(__KVT_RESOURCE_GROUP__VAULT) $(__KVT_SUBSCRIPTION)
