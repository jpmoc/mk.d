_SSH_REMOTEUSER_MK_VERSION= $(_SSH_MK_VERSION)

# SSH_REMOTEUSER?=
# SSH_REMOTEUSER_CONFIG_DIRPATH?= $(HOME)/.ssh/
# SSH_REMOTEUSER_CONFIG_FILENAME?= config
# SSH_REMOTEUSER_CONFIG_FILEPATH?= $(HOME)/.ssh/config
# SSH_REMOTEUSER_EXEC_COMMAND?= -- /bin/ls -a
# SSH_REMOTEUSER_HOST_IP?= 127.0.0.1
SSH_REMOTEUSER_HOST_NAME?= localhost
# SSH_REMOTEUSER_HOST_IP_OR_NAME?=
# SSH_REMOTEUSER_HOST_PORT?= 22
# SSH_REMOTEUSER_NAME?= ubuntu@localhost
# SSH_REMOTEUSER_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
SSH_REMOTEUSER_PSEUDOTERMINAL_FLAG?= false
# SSH_REMOTEUSER_PUBLICKEY_FILEPATH?= $(HOME)/.ssh/id_rsa.pub
# SSH_REMOTEUSER_SHORTNAME?= ubuntu

# Derived parameters 
SSH_REMOTEUSER?= $(SSH) $(__SSH_IDENTITY__REMOTEUSER) $(__SSH_LOGIN__REMOTEUSER) $(__SSH_PORT__REMOTEUSER) $(__SSH_PSEUDO_TERMINAL__REMOTEUSER) $(SSH_REMOTEUSER_HOST_IP_OR_NAME)
SSH_REMOTEUSER_CONFIG_DIRPATH?= $(SSH_CONFIG_DIRPATH)
SSH_REMOTEUSER_CONFIG_FILENAME?= $(SSH_CONFIG_FILENAME)
SSH_REMOTEUSER_CONFIG_FILEPATH?= $(SSH_REMOTEUSER_CONFIG_DIRPATH)$(SSH_REMOTEUSER_CONFIG_FILENAME)
SSH_REMOTEUSER_HOST_IP_OR_NAME?= $(if $(SSH_REMOTEUSER_HOST_IP),$(SSH_REMOTEUSER_HOST_IP),$(SSH_REMOTEUSER_HOST_NAME))
SSH_REMOTEUSER_HOST_PORT?= $(SSH_HOST_PORT)
SSH_REMOTEUSER_NAME?= $(if $(SSH_REMOTEUSER_SHORTNAME),$(SSH_REMOTEUSER_SHORTNAME)@$(SSH_REMOTEUSER_HOST_IP_OR_NAME))
SSH_REMOTEUSER_PRIVATEKEY_FILEPATH?= $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH)
SSH_REMOTEUSER_PUBLICKEY_FILEPATH?= $(SSH_KEYPAIR_PUBLICKEY_FILEPATH)
SSH_REMOTEUSER_SHORTNAME?= $(USER)

# Option parameters
__SSH_CONFIG__REMOTEUSER= $(if $(SSH_REMOTEUSER_CONFIG_FILEPATH),-F $(SSH_REMOTEUSER_CONFIG_FILEPATH))
__SSH_IDENTITY__REMOTEUSER= $(if $(SSH_REMOTEUSER_PRIVATEKEY_FILEPATH),-i $(SSH_REMOTEUSER_PRIVATEKEY_FILEPATH))
__SSH_LOGIN__REMOTEUSER= $(if $(SSH_REMOTEUSER_SHORTNAME),-l $(SSH_REMOTEUSER_SHORTNAME))
__SSH_PORT__REMOTEUSER= $(if $(SSH_REMOTEUSER_HOST_PORT),-p $(SSH_REMOTEUSER_HOST_PORT))
__SSH_PSEUDO_TERMINAL__REMOTEUSER= $(if $(filter true, $(SSH_REMOTEUSER_PSEUDOTERMINAL_FLAG)),-t)

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ssh_list_macros ::
	@#echo 'SSH::RemoteUser ($(_SSH_REMOTEUSER_MK_VERSION)) macros:'
	@#echo

_ssh_list_parameters ::
	@echo 'SSH::RemoteUser ($(_SSH_REMOTEUSER_MK_VERSION)) parameters:'
	@echo '    SSH_REMOTEUSER=$(SSH_REMOTEUSER)'
	@echo '    SSH_REMOTEUSER_CONFIG_DIRPATH=$(SSH_REMOTEUSER_CONFIG_DIRPATH)'
	@echo '    SSH_REMOTEUSER_CONFIG_FILENAME=$(SSH_REMOTEUSER_CONFIG_FILENAME)'
	@echo '    SSH_REMOTEUSER_CONFIG_FILEPATH=$(SSH_REMOTEUSER_CONFIG_FILEPATH)'
	@echo '    SSH_REMOTEUSER_EXEC_COMMAND=$(SSH_REMOTE_EXEC_COMMAND)'
	@echo '    SSH_REMOTEUSER_HOST_IP_OR_NAME=$(SSH_REMOTEUSER_HOST_IP_OR_NAME)'
	@echo '    SSH_REMOTEUSER_HOST_IP=$(SSH_REMOTEUSER_HOST_IP)'
	@echo '    SSH_REMOTEUSER_HOST_PORT=$(SSH_REMOTEUSER_HOST_PORT)'
	@echo '    SSH_REMOTEUSER_HOST_NAME=$(SSH_REMOTEUSER_HOST_NAME)'
	@echo '    SSH_REMOTEUSER_NAME=$(SSH_REMOTEUSER_NAME)'
	@echo '    SSH_REMOTEUSER_PRIVATEKEY_FILEPATH=$(SSH_REMOTEUSER_PRIVATEKEY_FILEPATH)'
	@echo '    SSH_REMOTEUSER_PSEUDOTERMINAL_FLAG=$(SSH_REMOTEUSER_PSEUDOTERMINAL_FLAG)'
	@echo '    SSH_REMOTEUSER_PUBLICKEY_FILEPATH=$(SSH_REMOTEUSER_PUBLICKEY_FILEPATH)'
	@echo '    SSH_REMOTEUSER_SHORTNAME=$(SSH_REMOTEUSER_SHORTNAME)'
	@echo

_ssh_list_targets ::
	@echo 'SSH::RemoteUser ($(_SSH_REMOTEUSER_MK_VERSION)) targets:'
	@echo '    _ssh_connect_remoteuser              - Ssh to a remote-user'
	@echo '    _ssh_exec_remoteuser                 - Execute a command as a remote-user'
	@echo

#----------------------------------------------------------------------
# SSH KEY MANAGEMENT
#

_ssh_connect_remoteuser:
	@$(INFO) '$(SSH_UI_LABEL)Connecting to remote-user "$(SSH_REMOTEUSER_NAME)" ...'; $(NORMAL)
	$(SSH) $(__SSH_CONFIG__REMOTEUSER) $(__SSH_IDENTITY__REMOTEUSER) $(__SSH_LOGIN__REMOTEUSER) $(__SSH_PORT__REMOTEUSER) $(__SSH_PSEUDO_TERMINAL__REMOTEUSER) $(SSH_REMOTEUSER_HOST_IP_OR_NAME)

_ssh_exec_remoteuser:
	@$(INFO) '$(SSH_UI_LABEL)Executing a command as remote-user "$(SSH_REMOTEUSER_NAME)" ...'; $(NORMAL)
	$(SSH) $(__SSH_CONFIG__REMOTEUSER) $(__SSH_IDENTITY__REMOTEUSER) $(__SSH_LOGIN__REMOTEUSER) $(__SSH_PORT__REMOTEUSER) $(__SSH_PSEUDO_TERMINAL__REMOTEUSER) $(SSH_REMOTEUSER_HOST_IP_OR_NAME) $(SSH_REMOTEUSER_EXEC_COMMAND)
