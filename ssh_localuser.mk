_SSH_LOCALUSER_MK_VERSION= $(_SSH_MK_VERSION)

# SSH_LOCALUSER_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
# SSH_LOCALUSER_PUBLICKEY_FILEPATH?= $(HOME)/.ssh/id_rsa.pub
SSH_LOCALUSER_HOST_IP?= 127.0.0.1
SSH_LOCALUSER_HOST_NAME?= localhost
# SSH_LOCALUSER_HOST_IP_OR_NAME?=
SSH_LOCALUSER_HOST_PORT?= 22
# SSH_LOCALUSER_RUN_COMMAND?= /bin/ls
# SSH_LOCALUSER_NAME?= ubuntu
SSH_LOCALUSER_SHORTNAME?= $(USER)

# Derived parameters 
SSH_LOCALUSER_AUTHORIZEDKEYS_FILEPATH?= $(SSH_AUTHORIZEDKEYS_FILEPATH)
SSH_LOCALUSER_HOST_IP_OR_NAME?= $(if $(SSH_LOCALUSER_HOST_IP),$(SSH_LOCALUSER_HOST_IP),$(SSH_LOCALUSER_HOST_NAME))
SSH_LOCALUSER_NAME?= $(SSH_LOCALUSER_SHORTNAME)@$(SSH_LOCALUSER_HOST_IP_OR_NAME)
SSH_LOCALUSER_PRIVATEKEY_FILEPATH?= $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH)
SSH_LOCALUSER_PUBLICKEY_FILEPATH?= $(SSH_KEYPAIR_PUBLICKEY_FILEPATH)

# Option parameters
__SSH_LOGIN__LOCALUSER= $(if $(SSH_LOCALUSER_SHORTNAME),-l $(SSH_LOCALUSER_SHORTNAME))
__SSH_PORT__LOCALUSER= $(if $(SSH_LOCALUSER_PORT),-p $(SSH_LOCALUSER_PORT))
__SSH_IDENTITY__LOCALUSER= $(if $(SSH_LOCALUSER_PRIVATEKEY_FILEPATH),-i $(SSH_LOCALUSER_PRIVATEKEY_FILEPATH))

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ssh_list_macros ::
	@#echo 'SSH::LocalUser ($(_SSH_LOCALUSER_MK_VERSION)) macros:'
	@#echo

_ssh_list_parameters ::
	@echo 'SSH::LocalUser ($(_SSH_LOCALUSER_MK_VERSION)) parameters:'
	@echo '    SSH_LOCALUSER_AUTHORIZEDKEY_FILEPATH=$(SSH_LOCALUSER_AUTHORIZEDKEY_FILEPATH)'
	@echo '    SSH_LOCALUSER_HOST_IP_OR_NAME=$(SSH_LOCALUSER_HOST_IP_OR_NAME)'
	@echo '    SSH_LOCALUSER_HOST_IP=$(SSH_LOCALUSER_HOST_IP)'
	@echo '    SSH_LOCALUSER_HOST_NAME=$(SSH_LOCALUSER_HOST_NAME)'
	@echo '    SSH_LOCALUSER_NAME=$(SSH_LOCALUSER_NAME)'
	@echo '    SSH_LOCALUSER_PRIVATEKEY_FILEPATH=$(SSH_LOCALUSER_PRIVATEKEY_FILEPATH)'
	@echo '    SSH_LOCALUSER_PUBLICKEY_FILEPATH=$(SSH_LOCALUSER_PUBLICKEY_FILEPATH)'
	@echo '    SSH_LOCALUSER_RUN_COMMAND=$(SSH_LOCALUSER_RUN_COMMAND)'
	@echo '    SSH_LOCALUSER_SHORTNAME=$(SSH_LOCALUSER_SHORTNAME)'
	@echo

_ssh_list_targets ::
	@echo 'SSH::LocalUser ($(_SSH_LOCALUSER_MK_VERSION)) targets:'
	@echo '    _ssh_connect_localuser            - Ssh to a local-user'
	@echo '    _ssh_run_localuser                - Run a command on a local-user'
	@echo '    _ssh_trust_localuser              - Trust a local-user'
	@echo

#----------------------------------------------------------------------
# SSH KEY MANAGEMENT
#

_ssh_connect_localuser:
	@$(INFO) '$(SSH_UI_LABEL)Connecting to local-user "$(SSH_LOCALUSER_NAME)" ...'; $(NORMAL)
	$(SSH) $(__SSH_IDENTITY__LOCALUSER) $(__SSH_LOGIN__LOCALUSER) $(__SSH_PORT__LOCALUSER) $(SSH_LOCALUSER_HOST_IP_OR_NAME)

_ssh_run_localuser:
	@$(INFO) '$(SSH_UI_LABEL)Executing a command as local-user "$(SSH_LOCALUSER_NAME)" ...'; $(NORMAL)
	$(SSH) $(__SSH_IDENTITY__LOCALUSER) $(__SSH_LOGIN__LOCALUSER) $(__SSH_PORT__LOCALUSER) $(SSH_LOCALUSER_HOST_IP_OR_NAME) $(SSH_LOCALUSER_RUN_COMMAND)

_ssh_trust_localuser:
	@$(INFO) '$(SSH_UI_LABEL)Trust private-key from local-user "$(SSH_LOCALUSER_NAME)" ...'; $(NORMAL)
	cat $(SSH_LOCALUSER_PUBLICKEY_FILEPATH) >> $(SSH_LOCALUSER_AUTHORIZEDKEYS_FILEPATH)
