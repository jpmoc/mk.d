_VAULT_CURL_MK_VERSION= $(_VAULT_MK_VERSION)

# VLT_CURL_API_URL?= http://127.0.0.1:8200/v1
VLT_CURL_API_VERSION?= v1
# VLT_CURL_CACERT_FILEPATH?= ./in/cacert.pem
# VLT_CURL_ENDPOINT_URL?= http://127.0.0.1:8200/v1
# VLT_CURL_TOKEN?=

# Derived variables
VLT_CURL_API_URL?= $(VLT_ENDPOINT_URL)/$(VLT_CURL_API_VERSION)
VLT_CURL_CACERT_FILEPATH?= $(VLT_CACERT_FILEPATH)
VLT_CURL_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
VLT_CURL_TOKEN?= $(VLT_OPERATOR_TOKEN)

# Options variables

# Pipe
|_VLT_CURL_SHOW_USER?= | jq '.'
|_VLT_CURL_PLUGIN?= | jq '.'
|_VLT_CURL_UNSEAL_OPERATOR?= | jq '.'

# UI parameters

# Utilities
__VLT_CURL_OPTIONS+= $(if $(VLT_CURL_CACERT_FILEPATH),--cacert $(VLT_CURL_CACERT_FILEPATH))
__VLT_CURL_OPTIONS+= --header "X-Vault-Token: $(VLT_CURL_TOKEN)"
__VLT_CURL_OPTIONS+= --silent

VLT_CURL_BIN?= curl
VLT_CURL?= $(strip $(__VLT_CURL_ENVIRONMENT) $(VLT_CURL_ENVIRONMENT) $(VLT_CURL_BIN) $(__VLT_CURL_OPTIONS) $(VLT_CURL_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_vlt_view_framework_macros ::
	@echo 'VauLT::Curl ($(_VAULT_CURL_MK_VERSION)) macros:'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Curl ($(_VAULT_CURL_MK_VERSION)) parameters:'
	@echo '    VLT_CURL_API_URL=$(VLT_CURL_API_URL)'
	@echo '    VLT_CURL_API_VERSION=$(VLT_CURL_API_VERSION)'
	@echo '    VLT_CURL_CACERT_FILEPATH=$(VLT_CURL_CACERT_FILEPATH)'
	@echo '    VLT_CURL_ENDPOINT_URL=$(VLT_CURL_ENDPOINT_URL)'
	@echo '    VLT_CULR_TOKEN=$(VLT_CURL_TOKEN)'
	@echo '    ... all other param are passed as-is ...'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Curl ($(_VAULT_CURL_MK_VERSION)) targets:'
	@echo '    _vlt_curl_plugin                    - Curl on a plugin'
	@echo '    _vlt_curl_show_user                 - Curl to show user config'
	@echo '    _vlt_curl_unseal_operator           - Unseal operator with curl'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_curl_authcert:
	$(VLT_CURL_BIN) -v --request POST --tlsv1.2 --cacert ./in/openssl/localhost.crt --cert ./in/openssl/bookinfo.com.crt --key ./in/openssl/bookinfo.com.pem -k --data '{"name":"openssl_certificates"}' https://localhost:8200/v1/auth/cert/login

_vlt_curl_plugin:
	@$(INFO) '$(VLT_UI_LABEL)Curling plugin "$(VLT_PLUGIN_NAME)" ...'; $(NORMAL)
	$(VLT_CURL) --request GET $(VLT_CURL_API_URL)/sys/plugins/catalog/$(VLT_PLUGIN_TYPE)/$(VLT_PLUGIN_NAME) $(|_VLT_CURL_PLUGIN)

_vlt_curl_show_user:
	curl --header "X-Vault-Token: s.wY5qQv0x8k5tJHJsLVDTdExX" --request GET  --cacert ./in/certbot_cacert.pem https://common-vault.azcp.horizon.vmware.com/v1/auth/userpass/users/emayssat
	$(VLT_CURL) --request GET $(VLT_CURL_API_URL)/auth/userpass/users/emayssat $(|_VLT_CURL_SHOW_USER)

_vlt_curl_unseal_operator:
	@$(INFO) '$(VLT_UI_LABEL)Curling to unseal operator ...'; $(NORMAL)
	@$(WARN) 'This operation does NOT require a vault-token in the headers or even a valid operator-keyi in the data'; $(NORMAL)
	$(VLT_CURL) --data '{"key": "$(VLT_OPERATOR_UNSEAL_KEY)"}' --request POST $(VLT_CURL_API_URL)/sys/unseal $(|_VLT_CURL_UNSEAL_OPERATOR)
