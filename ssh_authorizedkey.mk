_SSH_AUTHORIZEDKEY_MK_VERSION= $(_SSH_MK_VERSION)

# SSH_AUTHORIZEDKEY_NAME?= my-key-name
# SSH_AUTHORIZEDKEY_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
# SSH_AUTHORIZEDKEY_PUBLICEY_FILEPATH?= $(HOME)/.ssh/id_rsa
SSH_AUTHORIZEDKEYS_FILEPATH?= $(HOME)/.ssh/authorized_keys

# Derived parameters 
SSH_AUTHORIZEDKEY_NAME?= $(SSH_KEYPAIR_NAME)
SSH_AUTHORIZEDKEY_PRIVATEKEY_FILEPATH?= $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH)
SSH_AUTHORIZEDKEY_PUBLICKEY_FILEPATH?= $(SSH_KEYPAIR_PUBLICKEY_FILEPATH)

# Option parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ssh_view_framework_macros ::
	@echo 'SSH::AuthorizedKey ($(_SSH_AUTHORIZEDKEY_MK_VERSION)) macros:'
	@echo

_ssh_view_framework_parameters ::
	@echo 'SSH::AuthorizedKey ($(_SSH_AUTHORIZEDKEY_MK_VERSION)) parameters:'
	@echo '    SSH_AUTHORIZEDKEY_NAME=$(SSH_AUTHORIZEDKEY_NAME)'
	@echo '    SSH_AUTHORIZEDKEY_PRIVATEKEY_FILEPATH=$(SSH_AUTHORIZEDKEY_PRIVATEKEY_FILEPATH)'
	@echo '    SSH_AUTHORIZEDKEY_PUBLICKEY_FILEPATH=$(SSH_AUTHORIZEDKEY_PUBLICKEY_FILEPATH)'
	@echo '    SSH_AUTHORIZEDKEYS_FILEPATH=$(SSH_AUTHORIZEDKEYS_FILEPATH)'
	@echo

_ssh_view_framework_targets ::
	@echo 'SSH::AuthorizedKey ($(_SSH_AUTHORIZEDKEY_MK_VERSION)) targets:'
	@echo '    _ssh_create_authorizedkey                - Create an authorized-key'
	@echo '    _ssh_delete_authorizedkey                - Delete an authorized-key'
	@echo '    _ssh_show_authorizedkey                  - Show everything related to an authorized-key'
	@echo '    _ssh_show_authorizedkey_description      - Show description of an authorized-key'
	@echo '    _ssh_view_authorizedkeys                 - View all authorized-keys'
	@echo

#----------------------------------------------------------------------
# SSH KEY MANAGEMENT
#

_ssh_create_authorizedkey:
	@$(INFO) '$(SSH_UI_LABEL)Creating an authorized-key "$(SSH_AUTHORIZEDKEY_NAME)" ...'; $(NORMAL)

_ssh_delete_authorizedkey:
	@$(INFO) '$(SSH_UI_LABEL)Deleting a authorized-key "$(SSH_AUTHORIZEDKEY_NAME)" ...'; $(NORMAL)
	# ssh-copy-id $(__SSH_KNOWNHOSTS_FILE) -R $(SSH_KNOWNHOST_IP_OR_NAME)

_ssh_delete_authorizedkeys:
	@$(INFO) '$(SSH_UI_LABEL)Deleting a authorized-key "$(SSH_AUTHORIZEDKEY_NAME)" ...'; $(NORMAL)
	@echo 'This operation is dangerous. Are you sure?'; read ctrlC; $(NORMAL)
	rm -f $(SSH_AUTHORIZEDKEYS_FILEPATH)

_ssh_show_authorizedkey: _ssh_show_authorizedkey_description

_ssh_show_authorizedkey_description:
	@$(INFO) '$(SSH_UI_LABEL)Showing description of authorized-key  "$(SSH_AUTHORIZEDKEY_NAME)" ...'; $(NORMAL)
	cat $(SSH_AUTHORIZEDKEYS_FILEPATH) | grep $(SSH_AUTHORIZEDKEY_NAME)

_ssh_view_authorizedkeys:
	@$(INFO) '$(SSH_UI_LABEL)Viewing authorized-keys ...'; $(NORMAL)
	cat $(SSH_AUTHORIZEDKEYS_FILEPATH)
