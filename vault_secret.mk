_VAULT_SECRET_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_SECRET_KEY_NAME?=
# VLT_SECRET_KEY_VALUE?=
# VLT_SECRET_KEYVALUES?= foo=world
# VLT_SECRET_LEASE_DURATION?= 5m
# VLT_SECRET_LEASE_ID?= aws/creds/my-role/SDVE2DqYOZmKMEfju7B8y7bd
# VLT_SECRET_NAME?= my-secret
# VLT_SECRET_PATH_PREFIX?= aws/roles
# VLT_SECRET_PATH_SUFFIX?= my-role
# VLT_SECRET_PATH?= aws/config/root
# VLT_SECRETS_SET_NAME?= my-secrets-set

# Derived variables
VLT_SECRET_PATH?= $(if $(VLT_SECRET_PATH_SUFFIX),$(VLT_SECRET_PATH_PREFIX)$(VLT_SECRET_PATH_SUFFIX))
VLT_SECRET_PATH_SUFFIX?= $(VLT_SECRET_NAME)

# Options variables

# Pipe
_VLT_CREATE_SECRET_|?=#

# UI parameters

# Utilities

#--- MACROS
_vlt_get_secret_key_value= $(call _vlt_get_secret_key_value_K, $(VLT_SECRET_KEY_NAME))
_vlt_get_secret_key_value_K= $(call _vlt_get_secret_key_value_KP, $(1), $(VLT_SECRET_PATH))
_vlt_get_secret_key_value_KP= $(shell $(VAULT) read --format json $(2) | jq -r '.data.data.$(strip $(1))')

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Secret ($(_VAULT_SECRET_MK_VERSION)) macros:'
	@echo '    _vlt_get_secret_key_value_{|K|KP}   - Get the value of a key ni a secret (Key,secretPath)'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Secret ($(_VAULT_SECRET_MK_VERSION)) parameters:'
	@echo '    VLT_SECRET_KEY_NAME=$(VLT_SECRET_KEY_NAME)'
	@echo '    VLT_SECRET_KEY_VALUE=$(VLT_SECRET_KEY_VALUE)'
	@echo '    VLT_SECRET_KEYVALUES=$(VLT_SECRET_KEYVALUES)'
	@echo '    VLT_SECRET_LEASE_DURATION=$(VLT_SECRET_LEASE_DURATION)'
	@echo '    VLT_SECRET_LEASE_ID=$(VLT_SECRET_LEASE_ID)'
	@echo '    VLT_SECRET_NAME=$(VLT_SECRET_NAME)'
	@echo '    VLT_SECRET_PATH_PREFIX=$(VLT_SECRET_PATH_PREFIX)'
	@echo '    VLT_SECRET_PATH_SUFFIX=$(VLT_SECRET_PATH_SUFFIX)'
	@echo '    VLT_SECRET_PATH=$(VLT_SECRET_PATH)'
	@echo '    VLT_SECRETS_SET_NAME=$(VLT_SECRETS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Secret ($(_VAULT_SECRET_MK_VERSION)) targets:'
	@echo '    _vlt_create_secret                  - Create a secret'
	@echo '    _vlt_delete_secret                  - Delete a secret'
	@echo '    _vlt_prolong_secret                 - Prolong the lease of a secret'
	@echo '    _vlt_revoke_secret                  - Revoke the lease of a secret'
	@echo '    _vlt_show_secret                    - Show everything related to a secret'
	@echo '    _vlt_show_secret_description        - Show desription of a secret'
	@echo '    _vlt_update_secret                  - Update secret'
	@echo '    _vlt_view_secrets                   - View secrets'
	@echo '    _vlt_view_secrets_set               - View set of secrets'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_secret:
	@$(INFO) '$(VLT_UI_LABEL)Creating/updating secret "$(VLT_SECRET_NAME)" ...'; $(NORMAL)
	$(_VLT_CREATE_SECRET_|) $(VAULT) write $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_SECRET_PATH) $(VLT_SECRET_KEYVALUES)

_vlt_delete_secret:
	@$(INFO) '$(VLT_UI_LABEL)Deleting secret "$(VLT_SECRET_NAME)" ...'; $(NORMAL)
	# $(VAULT) kv delete $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRET_PATH)

_vlt_prolong_secret:
	@$(INFO) '$(VLT_UI_LABEL)Prolonging lease of secret "$(VLT_SECRET_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the lease does not exist or has already been revoked'; $(NORMAL)
	$(VAULT) lease renew $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRET_LEASE_ID)

_vlt_revoke_secret:
	@$(INFO) '$(VLT_UI_LABEL)Revoking lease on secret "$(VLT_SECRET_NAME)" ...'; $(NORMAL)
	$(VAULT) lease revoke $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRET_LEASE_ID)

_vlt_show_secret: _vlt_show_secret_description

_vlt_show_secret_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing secret "$(VLT_SECRET_NAME)" ...'; $(NORMAL)
	$(VAULT) read $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_FORMAT) $(VLT_SECRET_PATH)

_vlt_update_secret: _vlt_create_secret

_vlt_view_secrets:
	@$(INFO) '$(VLT_UI_LABEL)Viewing secrets ...'; $(NORMAL)
	@$(WARN) 'This operation may or may not work, function of the secret-engine'; $(NORMAL)
	$(VAULT) list $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_SECRET_PATH_PREFIX)

_vlt_view_secrets_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing secrets-set "$(VLT_SECRETS_SET_NAME)" ...'; $(NORMAL)
