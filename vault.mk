_VAULT_MK_VERSION= 0.99.4

# VLT_API_URL?= http://127.0.0.1:8200/v1
# VLT_CACERT_DIRPATH?= ./in/
# VLT_CACERT_FILENAME?= cacert.pem
# VLT_CACERT_FILEPATH?= ./in/cacert.pem
# VLT_ENDPOINT_URL?= http://127.0.0.1:8200
# VLT_INPUTS_DIRPATH?= ./in/
# VLT_MODE_DEBUG?= false
VLT_OUTPUT_FORMAT?= table
# VLT_OUTPUTS_DIRPATH?= ./out/
VLT_TLSSKIPVERIFY_FLAG?= false
VLT_TOKENCACHE_FILEPATH?= $(HOME)/.vault-token

# Derived variables
VLT_CACERT_DIRPATH?= $(VLT_INPUTS_DIRPATH)
VLT_CACERT_FILEPATH?= $(if $(VLT_CACERT_FILENAME),$(VLT_CACERT_DIRPATH)$(VLT_CACERT_FILENAME))
VLT_INPUTS_DIRPATH?= $(CMN_INPUTS_DIRPATH)
VLT_MODE_DEBUG?= $(CMN_MODE_DEBUG)
VLT_OUTPUTS_DIRPATH?= $(CMN_OUTPUTS_DIRPATH)

# Options variables
__VLT_ADDRESS= $(if $(VLT_ENDPOINT_URL),--address $(VLT_ENDPOINT_URL))
__VLT_CA_CERT= $(if $(VLT_CACERT_FILEPATH),--ca-cert $(VLT_CACERT_FILEPATH))
__VLT_FORMAT= $(if $(VLT_OUTPUT_FORMAT),--format $(VLT_OUTPUT_FORMAT))
__VLT_TLS_SKIP_VERIFY= $(if $(filter false,$(VLT_TLSSKIPVERIFY_FLAG)),--tls-skip-very)

# UI parameters
VLT_UI_LABEL?= [vault] #

# Utilities
VAULT_BIN?= vault
VAULT?= $(strip $(__VAULT_ENVIRONMENT) $(VAULT_ENVIRONMENT) $(VAULT_BIN) $(__VAULT_OPTIONS) $(VAULT_OPTIONS))
VAULT_VERSION?= 1.3.0

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _vlt_view_framework_macros
_vlt_view_framework_macros ::
	@echo 'VauLT ($(_VAULT_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _vlt_view_framework_parameters
_vlt_view_framework_parameters ::
	@echo 'VauLT ($(_VAULT_MK_VERSION)) parameters:'
	@echo '    VAULT=$(VAULT)'
	@echo '    VLT_API_URL=$(VLT_API_URL)'
	@echo '    VLT_CACERT_DIRPATH=$(VLT_CACERT_DIRPATH)'
	@echo '    VLT_CACERT_FILENAME=$(VLT_CACERT_FILENAME)'
	@echo '    VLT_CACERT_FILEPATH=$(VLT_CACERT_FILEPATH)'
	@echo '    VLT_ENDPOINT_URL=$(VLT_ENDPOINT_URL)'
	@echo '    VLT_INPUTS_DIRPATH=$(VLT_INPUTS_DIRPATH)'
	@echo '    VLT_MODE_DEBUG=$(VLT_MODE_DEBUG)'
	@echo '    VLT_OUTPUT_FORMAT=$(VLT_OUTPUT_FORMAT)'
	@echo '    VLT_OUTPUTS_DIRPATH=$(VLT_OUTPUTS_DIRPATH)'
	@echo '    VLT_TLSSKIPVERIFY_FLAG=$(VLT_TLSSKIPVERIFY_FLAG)'
	@echo '    VLT_TOKENCACHE_FILEPATH=$(VLT_TOKENCACHE_FILEPATH)'
	@echo

_view_framework_targets :: _vlt_view_framework_targets
_vlt_view_framework_targets ::
	@echo 'VauLT ($(_VAULT_MK_VERSION)) targets:'
	@echo '    _vlt_install_dependencies          - Install dependencies'
	@echo '    _vlt_show_version                  - Show version of dependencies'
	@echo '    _vlt_view_secretenginertypes       - View supported secret-engine types'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/vault_auditdevice.mk
-include $(MK_DIR)/vault_authmethod.mk
-include $(MK_DIR)/vault_authmethodrole.mk
-include $(MK_DIR)/vault_backend.mk
-include $(MK_DIR)/vault_cluster.mk
-include $(MK_DIR)/vault_config.mk
-include $(MK_DIR)/vault_curl.mk
-include $(MK_DIR)/vault_encryptionkey.mk
-include $(MK_DIR)/vault_kvsecret.mk
-include $(MK_DIR)/vault_operator.mk
-include $(MK_DIR)/vault_policy.mk
-include $(MK_DIR)/vault_plugin.mk
-include $(MK_DIR)/vault_secret.mk
-include $(MK_DIR)/vault_secretengine.mk
-include $(MK_DIR)/vault_token.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _vlt_install_dependencies
_vlt_install_dependencies ::
	@$(INFO) '$(VLT_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://www.vaultproject.io/intro/getting-started/index.html'; $(NORMAL)
	cd /tmp; wget https://releases.hashicorp.com/vault/$(VAULT_VERSION)/vault_$(VAULT_VERSION)_linux_amd64.zip
	cd /tmp; unzip vault_$(VAULT_VERSION)_linux_amd64.zip
	sudo mv /tmp/vault /usr/local/bin/vault
	which vault
	vault --version
	# Install auto-completion
	vault -autocomplete-install

_view_versions:: _vlt_show_version
_vlt_show_version:
	@$(INFO) '$(VLT_UI_LABEL)Show version ...'; $(NORMAL)
	vault --version

_vlt_view_authmethodtypes:
	@$(INFO) '$(VLT_UI_LABEL)View auth-method-types ...'; $(NORMAL)
	@$(WARN) 'The complete list of auth-method-types can be found at https://www.vaultproject.io/docs/auth/index.html'
	@$(WARN) 'The enabled auth-method-types correspond to enabled plugins'; $(NORMAL)
	@echo 'AppRole'
	@echo 'AliCloud'
	@echo 'AWS'
	@echo 'Azure'
	@echo 'Cloud Foundry'
	@echo 'Google Cloud'
	@echo 'JWT/OIDC'
	@echo 'Kubernetes'
	@echo 'GitHub'
	@echo 'LDAP'
	@echo 'Oracle Cloud Infrastructure'
	@echo 'Okta'
	@echo 'RADIUS'
	@echo 'TLS Certificates'
	@echo 'Tokens'
	@echo 'Username & Password'

_vlt_view_secretenginetypes:
	@$(INFO) '$(VLT_UI_LABEL)View secret-engine-types ...'; $(NORMAL)
	@$(WARN) 'The complete list of secret-engine-types can be found at https://www.vaultproject.io/api/secret/index.html'
	@$(WARN) 'The enabled secret-engine-types correspond to enabled plugins'; $(NORMAL)
	@echo 'Active Directory'
	@echo 'AliCloud'
	@echo 'AWS'
	@echo 'Azure'
	@echo 'Consul'
	@echo 'Cubbyhole'
	@echo 'Databases'
	@echo '    - Cassandra'
	@echo '    - Elasticsearch'
	@echo '    - InfluxdDB'
	@echo '    - HanaDB'
	@echo '    - MSSQL'
	@echo '    - MySQL/MariaDB'
	@echo '    - PostgreSQL'
	@echo '    - Oracle'
	@echo 'Google Cloud'
	@echo 'Google Cloud KMS'
	@echo 'KMIP'
	@echo 'Key/Value'
	@echo '    - K/V Version 1'
	@echo '    - K/V Version 2'
	@echo 'Identity'
	@echo '    - Entity'
	@echo '    - Entity Alias'
	@echo '    - Group'
	@echo '    - Group Alias'
	@echo '    - Identity Tokens'
	@echo '    - Lookup'
	@echo 'Nomad'
	@echo 'PKI'
	@echo 'RabbitMQ'
	@echo 'SSH'
	@echo 'TOTP'
	@echo 'Transit'
