_VAULT_CLUSTER_MK_VERSION= $(_VAULT_MK_VERSION)

VLT_CLUSTER_AUTHMETHOD_TYPE?= token
# VLT_CLUSTER_CONFIG_FILEPATH?= ./in/config.hcl
# VLT_CLUSTER_DEVMODE_FLAG?= true
# VLT_CLUSTER_ENDPOINT_URL?= http://127.0.0.1:8200
# VLT_CLUSTER_NAME?= my-development-cluster
# VLT_CLUSTER_OPERATOR_RECOVERYKEYS?=
# VLT_CLUSTER_OPERATOR_UNSEALKEYS?=
# VLT_CLUSTER_TOKEN_ID?= s.Q5iiuCfjdFC44BdH2qAn3sR4
# VLT_CLUSTER_TOKENCACHE_FILEPATH?= $(HOME)/.vault-token

# Derived variables
VLT_CLUSTER_AUTHMETHOD_TYPE?= $(VLT_AUTHMETHOD_TYPE)
VLT_CLUSTER_CONFIG_FILEPATH?= $(VLT_CONFIG_FILEPATH)
VLT_CLUSTER_ENDPOINT_URL?= $(VLT_ENDPOINT_URL)
VLT_CLUSTER_OPERATOR_RECOVERYKEYS?= $(VLT_OPERATOR_RECOVERYKEYS)
VLT_CLUSTER_OPERATOR_UNSEALKEYS?= $(VLT_OPERATOR_UNSEALKEYS)
VLT_CLUSTER_TOKEN_ID?= $(VLT_TOKEN_ID)
VLT_CLUSTER_TOKENCACHE_FILEPATH?= $(VLT_TOKENCACHE_FILEPATH)
VLT_CLUSTER_WEBUI_URL?= $(VLT_CLUSTER_ENDPOINT_URL)/ui/

# Options variables
# __VLT_ADDRESS__CLUSTER= $(if $(VLT_CLUSTER_ENDPOINT_URL),-address=$(VLT_CLUSTER_ENDPOINT_URL))
__VLT_CONFIG= $(if $(VLT_CLUSTER_CONFIG_FILEPATH),-config=$(VLT_CLUSTER_CONFIG_FILEPATH))
__VLT_DEV= $(if $(filter true, $(VLT_CLUSTER_DEVMODE_FLAG)),-dev)
__VLT_METHOD= $(if $(VLT_CLUSTER_AUTHMETHOD_TYPE),--method $(VLT_CLUSTER_AUTHMETHOD_TYPE))

# Pipe

# UI parameters

# Utilities

#--- MACROS
_vlt_get_cluster_name= $(call _vlt_get_cluster_name_U, $(VLT_CLUSTER_ENDPOINT_URL))
_vlt_get_cluster_name_U= $(call _vlt_get_cluster_name_UD, $(1), "Vault-still-sealed" )
_vlt_get_cluster_name_UD= $(shell $(VAULT) status --address $(1) --format json | jq -r '.cluster_name // $(2)')

#----------------------------------------------------------------------
# USAGE
#

_tfm_view_framework_macros ::
	@echo 'VauLT::Cluster ($(_VAULT_XER_MK_VERSION)) macros:'
	@echo '    _vlt_get_cluster_name_{|U|UD}         - Get the cluster name (endpointUrl,Default)'
	@echo

_vlt_view_framework_parameters ::
	@echo 'VauLT::Cluster ($(_VAULT_CLUSTER_MK_VERSION)) parameters:'
	@echo '    VLT_CLUSTER_AUTHMETHOD_TYPE=$(VLT_CLUSTER_AUTHMETHOD_TYPE)'
	@echo '    VLT_CLUSTER_CONFIG_FILEPATH=$(VLT_CLUSTER_CONFIG_FILEPATH)'
	@echo '    VLT_CLUSTER_DEVMODE_FLAG=$(VLT_CLUSTER_DEVMODE_FLAG)'
	@echo '    VLT_CLUSTER_ENDPOINT_URL=$(VLT_CLUSTER_ENDPOINT_URL)'
	@echo '    VLT_CLUSTER_NAME=$(VLT_CLUSTER_NAME)'
	@echo '    VLT_CLUSTER_OPERATOR_RECOVERYKEYS=$(VLT_CLUSTER_OPERATOR_RECOVERYKEYS)'
	@echo '    VLT_CLUSTER_OPERATOR_UNSEALKEYS=$(VLT_CLUSTER_OPERATOR_UNSEALKEYS)'
	@echo '    VLT_CLUSTER_TOKEN_ID=$(VLT_CLUSTER_TOKEN_ID)'
	@echo '    VLT_CLUSTER_TOKENCACHE_FILEPATH=$(VLT_CLUSTER_TOKENCACHE_FILEPATH)'
	@echo '    VLT_CLUSTER_WEBUI_URL=$(VLT_CLUSTER_WEBUI_URL)'
	@echo

_vlt_view_framework_targets ::
	@echo 'VauLT::Cluster ($(_VAULT_CLUSTER_MK_VERSION)) targets:'
	@echo '    _vlt_login_cluster                   - Log in the cluster'
	@echo '    _vlt_recover_cluster                 - Recover a cluster using recover-keys'
	@echo '    _vlt_seal_cluster                    - Seal an unsealed cluster'
	@echo '    _vlt_show_cluster                    - Show everything related to a cluster'
	@echo '    _vlt_show_cluster_description        - Show desription of a cluster'
	@echo '    _vlt_show_cluster_webui              - Show web UI of a cluster'
	@echo '    _vlt_start_cluster                   - Start a development cluster'
	@echo '    _vlt_unseal_cluster                  - Unseal a cluster using unseal-keys'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_vlt_login_cluster:
	@$(INFO) '$(VLT_UI_LABEL)Logging in the vault cluster ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the vault is still sealed. Unseal it first!'; $(NORMAL)
	$(VAULT) login $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_METHOD) $(VLT_CLUSTER_TOKEN_ID)
	[ ! -f $(VLT_CLUSTER_TOKENCACHE_FILEPATH) ] || cat $(VLT_CLUSTER_TOKENCACHE_FILEPATH); echo

_vlt_recover_cluster:
	@$(INFO) '$(VLT_UI_LABEL)Recovering the vault/master-key using recovery-keys from operators ...'; $(NORMAL)
	@$(WARN) 'This operation executes commands that are normally meant to be executed on several hosts'; $(NORMAL)
	$(foreach K, $(VLT_CLUSTER_OPERATOR_RECOVERYKEYS),$(VAULT) operator unseal $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_MIGRATION) $(K); echo;)

_vlt_seal_cluster:
	@$(INFO) '$(VLT_UI_LABEL)Sealing the vault cluster ...'; $(NORMAL)
	@read -p 'This operation blocks all access to the vault cluster. Are you sure? (Ctrl-C)' yesNo
	$(VAULT) operator seal $(__VLT_ADDRESS) $(__VLT_CA_CERT)

_vlt_show_cluster: _vlt_show_cluster_webui _vlt_show_cluster_description

_vlt_show_cluster_description:
	@$(INFO) '$(VLT_UI_LABEL)Showing cluster "$(VLT_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the vault is still sealed'; $(NORMAL)
	@$(WARN) 'The cluster name is not set if the vault is still sealed'; $(NORMAL)
	$(VAULT) status $(__VLT_ADDRESS) $(__VLT_CA_CERT) || true

_vlt_show_cluster_webui:
	@$(INFO) '$(VLT_UI_LABEL)Showing webui for cluster "$(VLT_CLUSTER_NAME)" ...'; $(NORMAL)
	@$(WARN) 'If the UI has been enabled, it is available at $(VLT_CLUSTER_WEBUI_URL)vault/init'; $(NORMAL)
	curl --request GET --silent $(VLT_CLUSTER_WEBUI_URL)vault/init | head -10

_vlt_start_cluster:
	@$(INFO) '$(VLT_UI_LABEL)Starting development cluster ...'; $(NORMAL)
	@$(WARN) 'This operation starts a vault-cluster in the foreground'; $(NORMAL)
	@$(WARN) 'To point you vault client to the correct endpoint: export VAULT_ADDR=$(VLT_CLUSTER_ENDPOINT_URL)'
	@$(WARN) 'Press Ctrl-C to quit'; $(NORMAL)
	$(if $(VLT_CLUSTER_CONFIG_FILEPATH), cat $(VLT_CLUSTER_CONFIG_FILEPATH))
	$(VAULT) server $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_CONFIG) $(__VLT_DEV)

_vlt_unseal_cluster:
	@$(INFO) '$(VLT_UI_LABEL)Unsealing the vault/master-key using unseal-keys from operators ...'; $(NORMAL)
	@$(WARN) 'This operation executes commands that are normally meant to be executed on several hosts'; $(NORMAL)
	$(foreach K, $(VLT_CLUSTER_OPERATOR_UNSEALKEYS),$(VAULT) operator unseal $(__VLT_ADDRESS) $(__VLT_CA_CERT) $(__VLT_MIGRATION) $(K); echo;)
