_SSH_KEYPAIR_MK_VERSION= $(_SSH_MK_VERSION)

SSH_KEYPAIR_BITLENGTH?= 4096
# SSH_KEYPAIR_COMMENT?= "emayssat@bionic64"
SSH_KEYPAIR_DIRPATH?= $(HOME)/.ssh/
SSH_KEYPAIR_NAME?= id_rsa
# SSH_KEYPAIR_PASSPHRASE?= "This is my pass-phrase!'
SSH_KEYPAIR_TYPE?= rsa
# SSH_KEYPAIR_PRIVATEKEY_DIRPATH?= $(HOME)/.ssh/
# SSH_KEYPAIR_PRIVATEKEY_FILENAME?= id_rsa
# SSH_KEYPAIR_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
# SSH_KEYPAIR_PUBLICKEY_FILEPATH?= $(HOME)/.ssh/id_rsa.pub

# Derived parameters 
SSH_KEYPAIR_COMMENT?= "$(USER)@$(HOST)"
SSH_KEYPAIR_PRIVATEKEY_DIRPATH?= $(SSH_KEYPAIR_DIRPATH)
SSH_KEYPAIR_PRIVATEKEY_FILENAME?= $(SSH_KEYPAIR_NAME)
SSH_KEYPAIR_PRIVATEKEY_FILEPATH?= $(SSH_KEYPAIR_PRIVATEKEY_DIRPATH)$(SSH_KEYPAIR_PRIVATEKEY_FILENAME)
SSH_KEYPAIR_PUBLICKEY_DIRPATH?= $(SSH_KEYPAIR_DIRPATH)
SSH_KEYPAIR_PUBLICKEY_FILENAME?= $(SSH_KEYPAIR_PRIVATEKEY_FILENAME).pub
SSH_KEYPAIR_PUBLICKEY_FILEPATH?= $(SSH_KEYPAIR_PUBLICKEY_DIRPATH)$(SSH_KEYPAIR_PUBLICKEY_FILENAME)
SSH_KEYPAIRS_DIRPATH?= $(SSH_KEYPAIR_DIRPATH)

# Option parameters
__SSH_B?= $(if $(SSH_KEYPAIR_BITLENGTH),-b $(SSH_KEYPAIR_BITLENGTH))
__SSH_C?= $(if $(SSH_KEYPAIR_COMMENT),-C $(SSH_KEYPAIR_COMMENT))
__SSH_F?= $(if $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH),-f $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH))
__SSH_N?= $(if $(SSH_KEYPAIR_PASSPHRASE),-N $(SSH_KEYPAIR_PASSPHRASE))
__SSH_T?= $(if $(SSH_KEYPAIR_TYPE),-t $(SSH_KEYPAIR_TYPE))

# Pipe parameters
|_SSH_LIST_KEYPAIRS?= | grep --extended-regexp -v 'authorized_keys|config|known_hosts'

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ssh_list_macros ::
	@#echo 'SSH::KeyPair ($(_SSH_KEYPAIR_MK_VERSION)) macros:'
	@#echo

_ssh_list_parameters ::
	@echo 'SSH::KeyPair ($(_SSH_KEYPAIR_MK_VERSION)) parameters:'
	@echo '    SSH_KEYPAIR_BITLENGTH=$(SSH_KEYPAIR_BITLENGTH)'
	@echo '    SSH_KEYPAIR_COMMENT=$(SSH_KEYPAIR_COMMENT)'
	@echo '    SSH_KEYPAIR_DIRPATH=$(SSH_KEYPAIR_DIRPATH)'
	@echo '    SSH_KEYPAIR_NAME=$(SSH_KEYPAIR_NAME)'
	@echo '    SSH_KEYPAIR_PASSPHRASE=$(SSH_KEYPAIR_PASSPHRASE)'
	@echo '    SSH_KEYPAIR_PRIVATEKEY_DIRPATH=$(SSH_KEYPAIR_PRIVATEKEY_DIRPATH)'
	@echo '    SSH_KEYPAIR_PRIVATEKEY_FILENAME=$(SSH_KEYPAIR_PRIVATEKEY_FILENAME)'
	@echo '    SSH_KEYPAIR_PRIVATEKEY_FILEPATH=$(SSH_KEYPAIR_PRIVATEKEY_FILEPATH)'
	@echo '    SSH_KEYPAIR_PUBLICKEY_DIRPATH=$(SSH_KEYPAIR_PUBLICKEY_DIRPATH)'
	@echo '    SSH_KEYPAIR_PUBLICKEY_FILENAME=$(SSH_KEYPAIR_PUBLICKEY_FILENAME)'
	@echo '    SSH_KEYPAIR_PUBLICKEY_FILEPATH=$(SSH_KEYPAIR_PUBLICKEY_FILEPATH)'
	@echo '    SSH_KEYPAIR_TYPE=$(SSH_KEYPAIR_TYPE)'
	@echo '    SSH_KEYPAIRS_DIRPATH=$(SSH_KEYPAIRS_DIRPATH)'
	@echo

_ssh_list_targets ::
	@echo 'SSH::KeyPair ($(_SSH_KEYPAIR_MK_VERSION)) targets:'
	@echo '    _ssh_create_keypair                     - Create a ssh key pair'
	@echo '    _ssh_delete_keypair                     - Delete a ssh key pair'
	@echo '    _ssh_list_keypairs                      - List all keypairs'
	@echo '    _ssh_list_keypairs_set                  - List a set of keypairs'
	@echo '    _ssh_show_keypair                       - Show everything related to a keypair'
	@echo '    _ssh_show_keypair_content               - Show content of a keypair'
	@echo '    _ssh_show_keypair_description           - Show description of a keypair'
	@echo '    _ssh_show_keypair_fingerprints          - Show the fingerprints of a keypair'
	@echo '    _ssh_show_keypair_fingerprints_md5      - Show the MD5-fingerprints of a keypair'
	@echo '    _ssh_show_keypair_fingerprints_sha256   - Show the SHA256-fingerprints of a keypair'
	@echo

#----------------------------------------------------------------------
# SSH KEY MANAGEMENT
#

_ssh_check_keypair: _ssh_check_keypair_rights
_ssh_check_keypair_rights:
	@$(INFO) '$(SSH_UI_LABEL)Checking rights on "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	chmod 600 $(SSH_PRIVATE_KEY)
	chmod 644 $(SSH_PUBLIC_KEY)

_ssh_create_keypair: 
	@$(INFO) '$(SSH_UI_LABEL)Creating keypair "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	mkdir -p $(SSH_KEYPAIR_DIRPATH)
	[ -e $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH) ] || ( \
		$(SSHKEYGEN) $(__SSH_B) $(__SSH_C) $(__SSH_F) $(__SSH_N) $(__SSH_T) -v \
	)

_ssh_delete_keypair:
	@$(INFO) '$(SSH_UI_LABEL)Deleting keypair "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	@read -p 'You are about to delete "$(SSH_KEYPAIR_PRIVATEKEY_FILEPATH)". Are you sure? (Ctrl-C to exit)' yesNo 
	rm -f $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH) $(SSH_KEYPAIR_PUBLICKEY_FILEPATH)

_ssh_list_keypairs:
	@$(INFO) '$(SSH_UI_LABEL)Listing ALL keypairs ...'; $(NORMAL)
	ls -l $(SSH_KEYPAIRS_DIRPATH) $(|_SSH_LIST_KEYPAIRS)

_ssh_list_keypairs_set:
	@$(INFO) '$(SSH_UI_LABEL)Listing keypairs-set NAME ...'; $(NORMAL)
	ls -l $(SSH_KEYPAIRS_DIRPATH) $(|_SSH_LIST_KEYPAIRS)

_SSH_SHOW_KEYPAIR_TARGETS?= _ssh_show_keypair_fingerprints _ssh_show_keypair_privatekey _ssh_show_keypair_publickey _ssh_show_keypair_description
_ssh_show_keypair: $(_SSH_SHOW_KEYPAIR_TARGETS)

_ssh_show_keypair_description:
	@$(INFO) '$(SSH_UI_LABEL)Showing files of keypair "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	@ls -al $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH) $(SSH_KEYPAIR_PUBLICKEY_FILEPATH)

_ssh_show_keypair_fingerprints: _ssh_show_keypair_fingerprints_md5 _ssh_show_keypair_fingerprints_sha256

_ssh_show_keypair_fingerprints_md5:
	@$(INFO) '$(SSH_UI_LABEL)Showing MD5-fingerprints of keypair "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The MD5 of the public and private keys should match'; $(NORMAL)
	$(SSHKEYGEN) -E md5 -f $(SSH_KEYPAIR_PUBLICKEY_FILEPATH) -l -v
	$(SSHKEYGEN) -E md5 -f $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH) -l -v

_ssh_show_keypair_fingerprints_sha256:
	@$(INFO) '$(SSH_UI_LABEL)Showing SHA256-fingerprints of keypair "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	@$(WARN) 'The SHa256 of the public and private keys should match'; $(NORMAL)
	$(SSHKEYGEN) -E sha256 -f $(SSH_KEYPAIR_PUBLICKEY_FILEPATH) -l -v
	$(SSHKEYGEN) -E sha256 -f $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH) -l -v

_ssh_show_keypair_privatekey::

_ssh_show_keypair_publickey:
	@$(INFO) '$(SSH_UI_LABEL)Showing public-key of keypair "$(SSH_KEYPAIR_NAME)" ...'; $(NORMAL)
	cat $(SSH_KEYPAIR_PUBLICKEY_FILEPATH)
