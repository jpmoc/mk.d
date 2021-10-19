_VAULT_TOKEN_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_TOKEN_CACHE_FILEPATH?= $(HOME)/.vault-token
# VLT_TOKEN_EDNPOINT_URL?=
# VLT_TOKEN_ID?= s.RpZ6bmeE9d2r3pENQtDkrpiz
# VLT_TOKEN_LEASE_DURATION?= 5m
# VLT_TOKEN_LEASE_ID?= aws/creds/my-role/SDVE2DqYOZmKMEfju7B8y7bd
# VLT_TOKEN_NAME?= my-token
# VLT_TOKENS_SET_NAME?= my-tokens-set

# Derived variables
VLT_TOKEN_CACHE_FILEPATH?= $(VLT_TOKENCACHE_FILEPATH)
VLT_TOKEN_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
VLT_TOKEN_SECRET_PATH?= $(VLT_SECRET_PATH)

# Options variables
__VLT_ADDRESS__TOKEN= $(if $(VLT_TOKEN_ENDPOINT_URL),--adress $(VLT_TOKEN_ENDPOINT_URL))

# Pipe

# UI parameters

# Utilities

#--- MACROS
_vlt_get_token_id= $(shell cat $(VLT_TOKEN_CACHE_FILEPATH))

_vlt_get_newtoken_id= $(shell $(VAULT) token create | grep -E '^token ' | sed -e 's/token *//g')

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Token ($(_VAULT_TOKEN_MK_VERSION)) macros:'
	@echo '    _vlt_get_token_id                  - Get the currently-active token id'
	@echo '    _vlt_get_newtoken_id               - Get a new token id'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Token ($(_VAULT_TOKEN_MK_VERSION)) parameters:'
	@echo '    VLT_TOKEN_CACHE_FILEPATH=$(VLT_TOKEN_CACHE_FILEPATH)'
	@echo '    VLT_TOKEN_ENDPOINT_URL=$(VLT_TOKEN_ENDPOINT_URL)'
	@echo '    VLT_TOKEN_ID=$(VLT_TOKEN_ID)'
	@echo '    VLT_TOKEN_LEASE_DURATION=$(VLT_TOKEN_LEASE_DURATION)'
	@echo '    VLT_TOKEN_LEASE_ID=$(VLT_TOKEN_LEASE_ID)'
	@echo '    VLT_TOKEN_NAME=$(VLT_TOKEN_NAME)'
	@echo '    VLT_TOKEN_SECRET_PATH=$(VLT_TOKEN_SECRET_PATH)'
	@echo '    VLT_TOKENS_SET_NAME=$(VLT_TOKENS_SET_NAME)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Token ($(_VAULT_TOKEN_MK_VERSION)) targets:'
	@echo '    _vlt_create_token                  - Create a token'
	@echo '    _vlt_delete_token                  - Delete a token'
	@echo '    _vlt_prolong_token                 - Prolong the lease of a token'
	@echo '    _vlt_revoke_token                  - Revoke the lease of a token'
	@echo '    _vlt_show_activetoken              - Show active-token'
	@echo '    _vlt_show_token                    - Show everything related to a token'
	@echo '    _vlt_show_token_description        - Show desription of a token'
	@echo '    _vlt_view_tokens                   - View tokens'
	@echo '    _vlt_view_tokens_set               - View set of tokens'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_create_token:
	@$(INFO) '$(VLT_UI_LABEL)Creating/updating token "$(VLT_TOKEN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation creates a token to be used in API calls to vault'; $(NORMAL)
	$(VAULT) token create $(__VLT_ADDRESS) $(__VLT_CA_CERT)

_vlt_delete_token:
	@$(INFO) '$(VLT_UI_LABEL)Deleting token "$(VLT_TOKEN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Token cannot be deleted, but can be revoked'; $(NORMAL)

_vlt_prolong_token:
	@$(INFO) '$(VLT_UI_LABEL)Prolonging lease of token "$(VLT_TOKEN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the token does not exist, has already been revoked, or is not renewable'; $(NORMAL)
	$(VAULT) token renew $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_TOKEN_ID)

_vlt_revoke_token:
	@$(INFO) '$(VLT_UI_LABEL)Revoking token "$(VLT_TOKEN_NAME)" ...'; $(NORMAL)
	$(VAULT) token revoke $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_TOKEN_ID)

_vlt_show_activetoken:
	@$(INFO) '$(VLT_UI_LABEL)Showing currently-active token ...'; $(NORMAL)
	[ ! -f $(VLT_TOKEN_CACHE_FILEPATH) ] || cat $(VLT_TOKEN_CACHE_FILEPATH); echo

_vlt_show_token: _vlt_show_token_capabilities _vlt_show_token_description

_vlt_show_token_capabilities:
	@$(INFO) '$(VLT_UI_LABEL)Showing capabilities of token "$(VLT_TOKEN_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the logged-in user doees NOT have right access to ...'; $(NORMAL)
	@$(WARN) 'If a secret-path is provided, this operation returns access right on secret'; $(NORMAL)
	-$(VAULT) token capabilities $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_TOKEN_ID) $(VLT_TOKEN_SECRET_PATH)

_vlt_show_token_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing desription of token "$(VLT_TOKEN_NAME)" ...'; $(NORMAL)
	$(VAULT) token lookup $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(VLT_TOKEN_ID)

_vlt_view_tokens:
	@$(INFO) '$(VLT_UI_LABEL)Viewing tokens ...'; $(NORMAL)

_vlt_view_tokens_set:
	@$(INFO) '$(VLT_UI_LABEL)Viewing tokens-set "$(VLT_TOKENS_SET_NAME)" ...'; $(NORMAL)

