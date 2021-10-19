ANSIBLE_VAULT_MK_VERSION= $(ANSIBLE_MK_VERSION)

# ABE_VAULT_FILEPATH?= ./vaults/secret_vars.yml
# ABE_VAULT_NAME?= secret_vars
# ABE_VAULT_PASSWORD_FILEPATH?= ./etc/password.txt
ABE_VAULT_PASSWORD_PROMPT?= false
# ABE_VAULT_SECRET_LABEL?= username
# ABE_VAULT_SECRET_PASSWORD?= ./bin/password.py 
# ABE_VAULT_SECRET_VAULTID?= label@password_source
# ABE_VAULTS_DIRPATH?= ./vaults

# Derived parameters
ABE_VAULT_NAME?= $(notdir $(ABE_VAULT_FILEPATH))
ABE_VAULT_SECRET_VAULTID?= $(if $(ABE_VAULT_SECRET_LABEL),$(ABE_VAULT_SECRET_LABEL)@$(ABE_VAULT_SECRET_PASSWORD))

# Option parameters
__ABE_ASK_VAULT_PASS__VAULT= $(if $(filter true, $(ABE_VAULT_PASSWORD_PROMPT)),--ask-vault-pass)
__ABE_VAULT_ID__VAULT= $(if $(ABE_VAULT_SECRET_VAULTID),--vault-id $(ABE_VAULT_SECRET_VAULTID))
__ABE_VAULT_PASSWORD_FILE__VAULT= $(if $(ABE_VAULT_PASSWORD_FILEPATH),--vault-password-file $(ABE_VAULT_PASSWORD_FILEPATH))

# Utilities
ANSIBLE_VAULT_BIN?= ansible-vault
ANSIBLE_VAULT= $(strip $(__ANSIBLE_VAULT_ENVIRONMENT) $(ANSIBLE_VAULT_ENVIRONMENT) $(ANSIBLE_VAULT_BIN) $(__ANSIBLE_VAULT_OPTIONS) $(ANSIBLE_VAULT_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_abe_view_framework_macros ::
	@#echo 'Ansible::Vault ($(ANSIBLE_VAULT_MK_VERSION)) macros:'
	@#echo

_abe_view_framework_parameters ::
	@echo 'Ansible::Vault ($(ANSIBLE_VAULT_MK_VERSION)) parameters:'
	@echo '    ABE_VAULT_FILEPATH=$(ABE_VAULT_FILEPATH)'
	@echo '    ABE_VAULT_NAME=$(ABE_VAULT_NAME)'
	@echo '    ABE_VAULT_PASSWORD_FILEPATH=$(ABE_VAULT_PASSWORD_FILEPATH)'
	@echo '    ABE_VAULT_PASSWORD_PROMT=$(ABE_VAULT_PASSWORD_PROMPT)'
	@echo '    ABE_VAULT_SECRET_LABEL=$(ABE_VAULT_SECRET_LABEL)'
	@echo '    ABE_VAULT_SECRET_PASSWORD=$(ABE_VAULT_SECRET_PASSWORD)'
	@echo '    ABE_VAULT_SECRET_VAULTID=$(ABE_VAULT_SECRET_VAULTID)'
	@echo '    ABE_VAULTS_DIRPATH=$(ABE_VAULTS_DIRPATH)'
	@echo '    ANSIBLE_VAULT=$(ANSIBLE_VAULT)'
	@echo

_abe_view_framework_targets ::
	@echo 'Ansible::Vault ($(ANSIBLE_VAULT_MK_VERSION)) targets:'
	@echo '    _abe_create_vault                  - Create a vault'
	@echo '    _abe_decrypt_vault                 - Decrypt a vault'
	@echo '    _abe_delete_vault                  - Delete a vault'
	@echo '    _abe_edit_vault                    - Edit secrets in a vault'
	@echo '    _abe_encrypt_vault                 - Encrypt a vault'
	@echo '    _abe_show_vault                    - Show everything related to a vault'
	@echo '    _abe_show_vault_content            - Show content of a vault'
	@echo '    _abe_show_vault_description        - Show description of a vault'
	@echo '    _abe_update_vault_password         - Update the password of a vault'
	@echo '    _abe_view_vaults                   - View vaults'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_abe_create_vault:
	@$(INFO) '$(ABE_UI_LABEL)Creating vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_VAULT) create $(__AVE_ASK_VAULT_PASS__VAULT) $(__ABE_VAULT_PASSWORD_FILE__VAULT) $(__ABE_VAULT_ID__VAULT) $(ABE_VAULT_FILEPATH)

_abe_decrypt_vault:
	@$(INFO) '$(ABE_UI_LABEL)Decrypting vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_VAULT) decrypt $(__AVE_ASK_VAULT_PASS__VAULT) $(__ABE_VAULT_PASSWORD_FILE__VAULT) $(__ABE_VAULT_ID__VAULT) $(ABE_VAULT_FILEPATH)

_abe_delete_vault:
	@$(INFO) '$(ABE_UI_LABEL)Deleting vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation is dangerous. Are you sure?'; $(NORMAL); read yesno
	rm -rf $(ABE_VAULT_FILEPATH)

_abe_edit_vault:
	@$(INFO) '$(ABE_UI_LABEL)Editing vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_VAULT) edit $(__AVE_ASK_VAULT_PASS__VAULT) $(__ABE_VAULT_PASSWORD_FILE__VAULT) $(__ABE_VAULT_ID__VAULT) $(ABE_VAULT_FILEPATH)

_abe_encrypt_vault:
	@$(INFO) '$(ABE_UI_LABEL)Encrypting vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_VAULT) encrypt $(__AVE_ASK_VAULT_PASS__VAULT) $(__ABE_VAULT_PASSWORD_FILE__VAULT) $(__ABE_VAULT_ID__VAULT) $(ABE_VAULT_FILEPATH)

_abe_show_vault: _abe_show_vault_content _abe_show_vault_description

_abe_show_vault_content:
	@$(INFO) '$(ABE_UI_LABEL)Showing content of vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_VAULT) view $(__AVE_ASK_VAULT_PASS__VAULT) $(__ABE_VAULT_PASSWORD_FILE__VAULT) $(__ABE_VAULT_ID__VAULT) $(ABE_VAULT_FILEPATH)

_abe_show_vault_description:
	@$(INFO) '$(ABE_UI_LABEL)Showing description of vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	ls -la $(ABE_VAULT_FILEPATH)

_abe_update_vault_password:
	@$(INFO) '$(ABE_UI_LABEL)Showing description of vault "$(ABE_VAULT_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_VAULT) rekey $(ABE_VAULT_FILEPATH)

_abe_view_vaults:
	@$(INFO) '$(ABE_UI_LABEL)Viewing vaults ...'; $(NORMAL)
	ls -la $(ABE_VAULTS_DIRPATH)
