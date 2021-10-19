_SSH_AGENT_MK_VERSION= $(_SSH_MK_VERSION)

# SSH_SSHAGENT_KEYPAIR_NAME?=
# SSH_SSHAGENT_PRIVATEKEY_FILEPATH?=

# Derived parameters 
SSH_SSHAGENT_KEYPAIR_NAME?= $(SSH_KEYPAIR_NAME)
SSH_SSHAGENT_PRIVATEKEY_FILEPATH?= $(SSH_KEYPAIR_PRIVATEKEY_FILEPATH)

# Option parameters

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ssh_view_framework_macros ::
	@echo 'SSH::SshAgent ($(_SSH_SSHAGENT_MK_VERSION)) macros:'
	@echo

_ssh_view_framework_parameters ::
	@echo 'SSH::SshAgent ($(_SSH_SSHAGENT_MK_VERSION)) parameters:'
	@echo '    SSH_KEYPAIR_NAME=$(SSH_KEYPAIR_NAME)'
	@echo '    SSH_PRIVATE_KEY=$(SSH_PRIVATE_KEY)'
	@echo

_ssh_view_framework_targets ::
	@echo 'SSH::SshAgent ($(_SSH_SSHAGENT_MK_VERSION)) targets:'
	@echo '    _ssh_add_sshagent_managedkey         - Add a key to the ssh-agent'
	@echo '    _ssh_remove_sshagent_managedkey      - Remove key from ssh-agent'
	@echo '    _ssh_show_sshagent                   - Show everything related to the ssh agent'
	@echo '    _ssh_show_sshagent_managedkeys       - Show keys managed by ssh agent'
	@echo '    _ssh_show_sshagent_process           - Show the process of the ssh agent'
	@echo '    _ssh_start_sshagent                  - Start the ssh-agent'
	@echo '    _ssh_stop_sshagent                   - Stop the ssh-agent'
	@echo

#----------------------------------------------------------------------
# SSH KEY MANAGEMENT
#

_ssh_add_sshagent_managedkey:
	@$(INFO) '$(SSH_UI_LABEL)Adding keypair "$(SSH_SSHAGENT_KEYPAIR_NAME)" to ssh-agent...'; $(NORMAL)
	ssh-add $(SSH_SSHAGENT_PRIVATEKEY_FILEPATH)

_ssh_remove_sshagent_managedkey:
	@$(INFO) '$(SSH_UI_LABEL)Removing keypair "$(SSH_SSHAGENT_KEYPAIR_NAME)" from ssh-agent ...'; $(NORMAL)
	ssh-add -d $(SSH_SSHAGENT_PRIVATEKEY_FILEPATH)

_ssh_show_sshagent: _ssh_show_sshagent_managedkeys _ssh_show_sshagent_process

_ssh_show_sshagent_managedkeys:
	@$(INFO) '$(SSH_UI_LABEL)Showing managed-keys in ssh-agent ...'; $(NORMAL)
	-ssh-add -l

_ssh_show_sshagent_process:
	@$(INFO) '$(SSH_UI_LABEL)Showing process for ssh-agent ...'; $(NORMAL)

_ssh_start_sshagent:
	@$(INFO) '$(SSH_UI_LABEL)Starting ssh-agent ...'; $(NORMAL)
	@$(WARN) 'This target will not work as expected because ssh-agent sets environment variables'; $(NORMAL)
	@$(WARN) 'Run this same command at the comand line'; $(NORMAL)
	eval "$$(ssh-agent -s)"

_ssh_stop_sshagent:
	@$(INFO) '$(SSH_UI_LABEL)Stopping ssh-agent ...'; $(NORMAL)
