_AZ_KEYVAULT_ACCESSPOLICY_MK_VERSION= $(_AZ_KEYVAULT_MK_VERSION)

# KVT_ACCESSPOLICY_CERTIFICATE_PERMISSIONS?= backup ...
# KVT_ACCESSPOLICY_KEY_PERMISSIONS?= backup ...
# KVT_ACCESSPOLICY_NAME?= my-access-policy@my-vault
# KVT_ACCESSPOLICY_NAME_PREFIX?= my-access-policy
# KVT_ACCESSPOLICY_NAME_SUFFIX?= @my-vault
# KVT_ACCESSPOLICY_OBJECT_ID?= bd0e6eff-1f0a-402c-a700-aead1dac184e
# KVT_ACCESSPOLICY_RESOURCEGROUP_NAME?= my-resourcegroup-name
# KVT_ACCESSPOLICY_SECRET_PERMISSIONS?= backup ...
# KVT_ACCESSPOLICY_SERVICEPRINCIPAL_NAME?=
# KVT_ACCESSPOLICY_STORAGE_PERMISSIONS?= backup ...
# KVT_ACCESSPOLICY_USERPRINCIPAL_NAME?=
# KVT_ACCESSPOLICY_VAULT_NAME?= my-vault
# KVT_ACCESSPOLICYS_SET_NAME?= my-access-policies-set

# Derived parameters
KVT_ACCESSPOLICY_NAME?= $(KVT_ACCESSPOLICY_NAME_PREFIX)$(KVT_ACCESSPOLICY_NAME_SUFFIX)
KVT_ACCESSPOLICY_NAME_SUFFIX?= @$(KVT_ACCESSPOLICY_VAULT_NAME)
KVT_ACCESSPOLICY_RESOURCEGROUP_NAME?= $(KVT_VAULT_RESOURCEGROUP_NAME)
KVT_ACCESSPOLICY_VAULT_NAME?= $(KVT_VAULT_NAME)

# Options parameters
__KVT_CERTIFICATE_PERMISSIONS= $(if $(KVT_ACCESSPOLICY_CERTIFICATE_PERMISSIONS),--certificate-permissions $(KVT_ACCESSPOLICY_CERTIFICATE_PERMISSIONS))
__KVT_ID__ACCESSPOLICY= $(if $(KVT_ACCESSPOLICY_OBJECT_ID),--id $(KVT_ACCESSPOLICY_OBJECT_ID))
__KVT_KEY_PERMISSIONS= $(if $(KVT_ACCESSPOLICY_KEY_PERMISSIONS),--key-permissions $(KVT_ACCESSPOLICY_KEY_PERMISSIONS))
__KVT_NAME__ACCESSPOLICY= $(if $(KVT_ACCESSPOLICY_VAULT_NAME),--name $(KVT_ACCESSPOLICY_VAULT_NAME))
__KVT_OBJECT_ID__ACCESSPOLICY= $(if $(KVT_ACCESSPOLICY_OBJECT_ID),--object-id $(KVT_ACCESSPOLICY_OBJECT_ID))
__KVT_RESOURCE_GROUP__ACCESSPOLICY= $(if $(KVT_ACCESSPOLICY_RESOURCEGROUP_NAME),--resource-group $(KVT_ACCESSPOLICY_RESOURCEGROUP_NAME))
__KVT_SECRET_PERMISSIONS= $(if $(KVT_ACCESSPOLICY_SECRET_PERMISSIONS),--secret-permissions $(KVT_ACCESSPOLICY_SECRET_PERMISSIONS))
__KVT_SPN= $(if $(KVT_ACCESSPOLICY_SERVICEPRINCIPAL_NAME),--spn $(KVT_ACCESSPOLICY_SERVICEPRINCIPAL_NAME))
__KVT_STORAGE_PERMISSIONS= $(if $(KVT_ACCESSPOLICY_STORAGE_PERMISSIONS),--storage-permissions $(KVT_ACCESSPOLICY_STORAGE_PERMISSIONS))
__KVT_UPN= $(if $(KVT_ACCESSPOLICY_USERPRINCIPAL_NAME),--upn $(KVT_ACCESSPOLICY_USERPRINCIPAL_NAME))

# UI parameters
KVT_UI_CREATE_ACCESSPOLICY_FIELDS?= $(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)
KVT_UI_DELETE_ACCESSPOLICY_FIELDS?= $(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)
KVT_UI_SHOW_ACCESSPOLICY_FIELDS?= $(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)
KVT_UI_SHOW_ACCESSPOLICY_SERVICEPRINCIPAL_FIELDS?= .{objectid:objectId,displayName:displayName,servicePrincipalType:servicePrincipalType}
KVT_UI_SHOW_ACCESSPOLICY_USERPRINCIPAL_FIELDS?= .{objectid:objectId,displayName:displayName,userPrincipalName:userPrincipalName}
KVT_UI_UPDATE_ACCESSPOLICY_FIELDS?= $(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)
KVT_UI_VIEW_ACCESSPOLICIES_FIELDS?= .{objectId:objectId,certificates:join(' ',permissions.certificates[]||['']),keys:join(' ',permissions.keys[]||['']),secrets:join(' ',permissions.secrets[]||['']),storage:join(' ',permissions.storage[]||[''])}
KVT_UI_VIEW_ACCESSPOLICIES_SET_FIELDS?= $(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_kvt_view_framework_macros ::
	@#echo 'AZ::KeyVaulT::AccessPolicy ($(_AZ_KEYVAULT_ACCESSPOLICY_MK_VERSION)) macros:'
	@#echo

_kvt_view_framework_parameters ::
	@echo 'AZ::KeyVaulT::AccessPolicy ($(_AZ_KEYVAULT_ACCESSPOLICY_MK_VERSION)) parameters:'
	@echo '    KVT_ACCESSPOLICY_CERTIFICATE_PERMISSIONS=$(KVT_ACCESSPOLICY_CERTIFICATE_PERMISSIONS)'
	@echo '    KVT_ACCESSPOLICY_KEY_PERMISSIONS=$(KVT_ACCESSPOLICY_KEY_PERMISSIONS)'
	@echo '    KVT_ACCESSPOLICY_NAME=$(KVT_ACCESSPOLICY_NAME)'
	@echo '    KVT_ACCESSPOLICY_NAME_PREFIX=$(KVT_ACCESSPOLICY_NAME_PREFIX)'
	@echo '    KVT_ACCESSPOLICY_NAME_SUFFIX=$(KVT_ACCESSPOLICY_NAME_SUFFIX)'
	@echo '    KVT_ACCESSPOLICY_OBJECT_ID=$(KVT_ACCESSPOLICY_OBJECT_ID)'
	@echo '    KVT_ACCESSPOLICY_RESOURCEGROUP_NAME=$(KVT_ACCESSPOLICY_RESOURCEGROUP_NAME)'
	@echo '    KVT_ACCESSPOLICY_SECRET_PERMISSIONS=$(KVT_ACCESSPOLICY_SECRET_PERMISSIONS)'
	@echo '    KVT_ACCESSPOLICY_SERVICEPRINCIPAL_NAME=$(KVT_ACCESSPOLICY_SERVICEPRINCIPAL_NAME)'
	@echo '    KVT_ACCESSPOLICY_STORAGE_PERMISSIONS=$(KVT_ACCESSPOLICY_STORAGE_PERMISSIONS)'
	@echo '    KVT_ACCESSPOLICY_USERPRINCIPAL_NAME=$(KVT_ACCESSPOLICY_USERPRINCIPAL_NAME)'
	@echo '    KVT_ACCESSPOLICY_VAULT_NAME=$(KVT_ACCESSPOLICY_VAULT_NAME)'
	@echo '    KVT_ACCESSPOLICIES_SET_NAME=$(KVT_ACCESSPOLICIES_SET_NAME)'
	@echo

_kvt_view_framework_targets ::
	@echo 'AZ::KeyVaulT::AccessPolicy ($(_AZ_KEYVAULT_ACCESSPOLICY_MK_VERSION)) targets:'
	@echo '    _kvt_create_accesspolicy              - Create a access-policy'
	@echo '    _kvt_delete_accesspolicy              - Delete an existing access-policy'
	@echo '    _kvt_show_accesspolicy                - Show everything related to a access-policy'
	@echo '    _kvt_show_accesspolicy_description    - Show description of a access-policy'
	@echo '    _kvt_show_accesspolicy_secrets        - Show secrets in a access-policy'
	@echo '    _kvt_tag_accesspolicy                 - Tag a access-policy'
	@echo '    _kvt_update_accesspolicy              - Update a access-policy'
	@echo '    _kvt_view_accesspolicys               - View access-policy'
	@echo '    _kvt_view_accesspolicys_set           - View a set of access-policy'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kvt_create_accesspolicy:
	@$(INFO) '$(KVT_UI_LABEL)Creating access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault set-policy $(strip $(__KVT_CERTIFICATE_PERMISSIONS) $(__KVT_KEY_PERMISSIONS) $(__KVT_NAME__ACCESSPOLICY) $(__KVT_OBJECT_ID__ACCESSPOLICY) $(__KVT_OUTPUT) $(__KVT_RESOURCE_GROUP__ACCESSPOLICY) $(__KVT_SECRET_PERMISSIONS) $(__KVT_SPN) $(__KVT_STORAGE_PERMISSIONS) $(__KVT_SUBSCRIPTION) $(__KVT_UPN)) --query "properties.accessPolicies[?objectId=='$(KVT_ACCESSPOLICY_OBJECT_ID)']$(KVT_UI_CREATE_ACCESSPOLICY_FIELDS)"

_kvt_delete_accesspolicy:
	@$(INFO) '$(KVT_UI_LABEL)Deleting access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault delete-policy $(__KVT_NAME__ACCESSPOLICY) $(__KVT_OBJECT_ID__ACCESSPOLICY) $(__KVT_RESOURCE_GROUP__ACCESSPOLICY) $(__KVT_SPN) $(__KVT_SUBSCRIPTION) $(__KVT_UPN) --query "properties.accessPolicies[?objectId=='$(KVT_ACCESSPOLICY_OBJECT_ID)']$(KVT_UI_DELETE_ACCESSPOLICY_FIELDS)"

_kvt_show_accesspolicy: _kvt_show_accesspolicy_object _kvt_show_accesspolicy_principal _kvt_show_accesspolicy_description

_kvt_show_accesspolicy_description:
	@$(INFO) '$(KVT_UI_LABEL)Showing description of access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operations returns nothing if the policy does NOT exist'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_OUTPUT) $(__KVT_NAME__ACCESSPOLICY) $(__KVT_SUBSCRIPTION) --query "properties.accessPolicies[?objectId=='$(KVT_ACCESSPOLICY_OBJECT_ID)']$(KVT_UI_SHOW_ACCESSPOLICY_FIELDS)"

_kvt_show_accesspolicy_object:
	@$(INFO) '$(KVT_UI_LABEL)Showing object of access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operations returns an empty array if the policy does NOT exist'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_NAME__ACCESSPOLICY) $(_X__KVT_OUTPUT) --output json $(__KVT_SUBSCRIPTION) --query "properties.accessPolicies[?objectId=='$(KVT_ACCESSPOLICY_OBJECT_ID)']"

_kvt_show_accesspolicy_principal: _kvt_show_accesspolicy_serviceprincipal _kvt_show_accesspolicy_userprincipal

_kvt_show_accesspolicy_serviceprincipal:
	@$(INFO) '$(KVT_UI_LABEL)Showing service-principal of access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation ignore-fails if the object-id is not a service-principal'; $(NORMAL)
	-$(AZ) ad sp show $(__KVT_ID__ACCESSPOLICY) $(__KVT_OUTPUT) --query "@$(KVT_UI_SHOW_ACCESSPOLICY_SERVICEPRINCIPAL_FIELDS)"

_kvt_show_accesspolicy_userprincipal:
	@$(INFO) '$(KVT_UI_LABEL)Showing user-principal of access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation ignore-fails if the object-id is not a user-principal'; $(NORMAL)
	-$(AZ) ad user show $(__KVT_ID__ACCESSPOLICY) $(__KVT_OUTPUT) --query "@$(KVT_UI_SHOW_ACCESSPOLICY_USERPRINCIPAL_FIELDS)"

_kvt_update_accesspolicy:
	@$(INFO) '$(KVT_UI_LABEL)Updating access-policy "$(KVT_ACCESSPOLICY_NAME)" ...'; $(NORMAL)
	$(AZ) keyvault set-policy $(strip $(__KVT_CERTIFICATE_PERMISSIONS) $(__KVT_KEY_PERMISSIONS) $(__KVT_NAME__ACCESSPOLICY) $(__KVT_OBJECT_ID__ACCESSPOLICY) $(__KVT_OUTPUT) $(__KVT_RESOURCE_GROUP__ACCESSPOLICY) $(__KVT_SECRET_PERMISSIONS) $(__KVT_SPN) $(__KVT_STORAGE_PERMISSIONS) $(__KVT_SUBSCRIPTION) $(__KVT_UPN)) --query "properties.accessPolicies[?objectId=='$(KVT_ACCESSPOLICY_OBJECT_ID)']$(KVT_UI_UPDATE_ACCESSPOLICY_FIELDS)"

_kvt_view_accesspolicies:
	@$(INFO) '$(KVT_UI_LABEL)Viewing access-policies ...'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_NAME__ACCESSPOLICY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) --query "properties.accessPolicies[]$(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)"

_kvt_view_accesspolicies_set:
	@$(INFO) '$(KVT_UI_LABEL)Viewing access-policies-set "$(KVT_ACCESSPOLICIES_SET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Access-policies are grouped basd on provided vault and query-filter'; $(NORMAL)
	$(AZ) keyvault show $(__KVT_NAME__ACCESSPOLICY) $(__KVT_OUTPUT) $(__KVT_SUBSCRIPTION) --query "properties.accessPolicies[]$(KVT_UI_VIEW_ACCESSPOLICIES_FIELDS)"
