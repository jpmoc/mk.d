_VAULT_KVSECRET_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_KVSECRET_ENDPOINT_URL?=
# VLT_KVSECRET_KEY_NAME?=
# VLT_KVSECRET_KEY_VALUE?=
# VLT_KVSECRET_KEYVALUES?= foo=world
# VLT_KVSECRET_METADATA_PATH?= secret/metadata/hello
# VLT_KVSECRET_NAME?= my-secret
VLT_KVSECRET_PATH_PREFIX?= secret/
# VLT_KVSECRET_PATH_SUFFIX?= hello
# VLT_KVSECRET_PATH?= secret/hello
VLT_KVSECRET_VERSION_ID?= 0
# VLT_KVSECRET_VERSIONS_IDS?= 4 5
# VLT_KVSECRETS_SET_NAME?= my-secrets-set

# Derived variables
VLT_KVSECRET_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
VLT_KVSECRET_METADATA_PATH?= $(if $(VLT_KVSECRET_PATH_SUFFIX),$(VLT_KVSECRET_PATH_PREFIX)metadata/$(KLT_KVSECRET_PATH_SUFFIX))
VLT_KVSECRET_PATH?= $(if $(VLT_KVSECRET_PATH_SUFFIX),$(VLT_KVSECRET_PATH_PREFIX)$(VLT_KVSECRET_PATH_SUFFIX))
VLT_KVSECRET_PATH_SUFFIX?= $(VLT_KVSECRET_NAME)

# Options variables
__VLT_ADDRESS__KVSECRET= $(if $(VLT_KVSECRET_ENDPOINT_URL),--address $(VLT_KVSECRET_ENDPOINT_URL))
__VLT_VERSION__KVSECRET= $(if $(filter-out 0, $(VLT_KVSECRET_VERSION_ID)),--version $(VLT_KVSECRET_VERSION_ID))
__VLT_VERSIONS__KVSECRET= $(if $(filter-out 0, $(VLT_KVSECRET_VERSIONS_IDS)),--versions "$(foreach V, $(VLT_KVSECRET_VERSIONS_IDS),$(V)$(COMMA))")

# Pipe
_VLT_CREATE_KVSECRET_|?=#

# UI parameters

# Utilities

#--- MACROS
_vlt_get_kvsecret_key_value= $(call _vlt_get_kvsecret_key_value_K, $(VLT_KVSECRET_KEY_NAME))
_vlt_get_kvsecret_key_value_K= $(call _vlt_get_kvsecret_key_value_KP, $(1), $(VLT_KVSECRET_PATH))
_vlt_get_kvsecret_key_value_KP= $(call _vlt_kvsecret_key_value_KPU, $(1), $(2), $(VLT_KVSECRET_ENDPOINT_URL))
_vlt_get_kvsecret_key_value_KPU= $(shell $(VAULT) kv get --address $(3) --format json $(2) | jq -r '.data.data.$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::KvSecret ($(_VAULT_KVSECRET_MK_VERSION)) macros:'
	@echo '    _vlt_get_secret_key_value_{|K|KP|KPU}   - Get the value of a key ni a secret (Key,secretPath,endpointUrl)'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::KvSecret ($(_VAULT_KVSECRET_MK_VERSION)) parameters:'
	@echo '    VLT_KVSECRET_ENDPOINT_URL=$(VLT_KVSECRET_ENDPOINT_URL)'
	@echo '    VLT_KVSECRET_KEY_NAME=$(VLT_KVSECRET_KEY_NAME)'
	@echo '    VLT_KVSECRET_KEY_VALUE=$(VLT_KVSECRET_KEY_VALUE)'
	@echo '    VLT_KVSECRET_KEYVALUES=$(VLT_KVSECRET_KEYVALUES)'
	@echo '    VLT_KVSECRET_METADATA_PATH=$(VLT_KVSECRET_METADATA_PATH)'
	@echo '    VLT_KVSECRET_NAME=$(VLT_KVSECRET_NAME)'
	@echo '    VLT_KVSECRET_PATH_PREFIX=$(VLT_KVSECRET_PATH_PREFIX)'
	@echo '    VLT_KVSECRET_PATH_SUFFIX=$(VLT_KVSECRET_PATH_SUFFIX)'
	@echo '    VLT_KVSECRET_PATH=$(VLT_KVSECRET_PATH)'
	@echo '    VLT_KVSECRET_VERSION_ID=$(VLT_KVSECRET_VERSION_ID)'
	@echo '    VLT_KVSECRET_VERSIONS_IDS=$(VLT_KVSECRET_VERSIONS_IDS)'
	@echo '    VLT_KVSECRETS_SET_NAME=$(VLT_KVSECRETS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::KvSecret ($(_VAULT_KVSECRET_MK_VERSION)) targets:'
	@echo '    _vlt_create_kvsecret                  - Create a kv-secret'
	@echo '    _vlt_delete_kvsecret                  - Delete a kv-secret'
	@echo '    _vlt_destroy_kvsecret                 - Destroy a kv-secret'
	@echo '    _vlt_distclean_kvsecret               - Dist-clean a kv-secret'
	@echo '    _vlt_enable_kvsecret_versioning       - Enable versioning of a kv-secret'
	@echo '    _vlt_show_kvsecret                    - Show everything related to a kv-secret'
	@echo '    _vlt_show_kvsecret_description        - Show description of a kv-secret'
	@echo '    _vlt_show_kvsecret_metadata           - Show metadata of a kv-secret'
	@echo '    _vlt_update_kvsecret                  - Update kv-secret'
	@echo '    _vlt_view_kvsecrets                   - View kv-secrets'
	@echo '    _vlt_view_kvsecrets_set               - View set of kv-secrets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_kvsecret:
	@$(INFO) '$(VLT_UI_LABEL)Creating/updating kv-secret "$(VLT_KVSECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the kv-v2 secret-engine has not been enabled on this path'; $(NORMAL)
	@$(WARN) 'If successful, this operation automatically create a new version of the kv-secret'; $(NORMAL)
	$(_VLT_CREATE_KVSECRET_|) $(VAULT) kv put $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_KVSECRET_PATH) $(VLT_KVSECRET_KEYVALUES)

_vlt_delete_kvsecret:
	@$(INFO) '$(VLT_UI_LABEL)Deleting kv-secret "$(VLT_KVSECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation only prevents access to one-or-more versions of the kv-secret'; $(NORMAL)
	@$(WARN) 'For permanent deletion of one-or-more versions, use the destroy directive'; $(NORMAL)
	@$(WARN) 'For permanent deletion of all versions and the metadata, use the distclean directive'; $(NORMAL)
	$(VAULT) kv delete $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_VERSIONS__KVSECRET) $(VLT_KVSECRET_PATH)

_vlt_destroy_kvsecret:
	@$(INFO) '$(VLT_UI_LABEL)Destroying kv-secret "$(VLT_KVSECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation preserves the metadata, but permanently deletes one-or-more versions of the kv-secret'; $(NORMAL)
	$(VAULT) kv destroy $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_VERSIONS__KVSECRET) $(VLT_KVSECRET_PATH)

_vlt_distclean_kvsecret:
	@$(INFO) '$(VLT_UI_LABEL)Dist-cleaning kv-secret "$(VLT_KVSECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation delete the metadata and all versions of the kv-secret'; $(NORMAL)
	$(VAULT) kv metadata delete $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_KVSECRET_METADATA_PATH)

_vlt_enable_kvsecret_versioning:
	@$(INFO) '$(VLT_UI_LABEL)Enabling versioning for kv-secret-engine at "$(VLT_KVSECRET_PATH_PREFIX)" ...'; $(NORMAL)
	@$(WARN) 'This operation upgrades the key-value secret-engine to version 2, which supports versioning'; $(NORMAL)
	$(VAULT) kv enable-versioning $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_KVSECRET_PATH_PREFIX)

_vlt_show_kvsecret: _vlt_show_kvsecret_metadata _vlt_show_kvsecret_description

_vlt_show_kvsecret_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing description of kv-secret "$(VLT_KVSECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns metadata of the kv secret and the content of its current-version -- unless version is explicit'; $(NORMAL)
	$(VAULT) kv get $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(__VLT_VERSION__KVSECRET) $(VLT_KVSECRET_PATH)

_vlt_show_kvsecret_metadata:
	@$(INFO) '$(VLT_UI_LABEL)Showing metadata of kv-secret "$(VLT_KVSECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation returns metadata and the content of all-available versions of the kv-secret'; $(NORMAL)
	$(VAULT) kv metadata get $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_KVSECRET_PATH)

_vlt_update_kvsecret: _vlt_create_kvsecret

_vlt_view_kvsecrets:
	@$(INFO) '$(VLT_UI_LABEL)Viewing kv-secrets ...'; $(NORMAL)
	$(VAULT) kv list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_KVSECRET_PATH_PREFIX)

_vlt_view_kvsecrets_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing kv-secrets-set "$(VLT_KVSECRETS_SET_NAME)" ...'; $(NORMAL)
	$(VAULT) kv list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_KVSECRET_PATH_PREFIX)
