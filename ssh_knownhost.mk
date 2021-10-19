_SSH_KNOWNHOST_MK_VERSION= $(_SSH_MK_VERSION)

# SSH_KNOWNHOST_IP?= 127.0.0.1
# SSH_KNOWNHOST_NAME?= localhost
# SSH_KNOWNHOST_IP_OR_NAME?= 127.0.0.1
SSH_KNOWNHOSTS_FILEPATH?= $(HOME)/.ssh/known_hosts

# Derived parameters 
SSH_KNOWNHOST_IP_OR_NAME?= $(if $(SSH_KNOWNHOST_IP),$(SSH_KNOWNHOST_IP),$(SSH_KNOWNHOST_NAME))

# Option parameters
__SSH_KNOWNHOSTS_FILE?= $(if $(SSH_KNOWNHOSTS_FILEPATH),-f $(SSH_KNOWNHOSTS_FILEPATH))

#--- Utilities

#--- Macros

#----------------------------------------------------------------------
# USAGE
#

_ssh_view_framework_macros ::
	@echo 'SSH::KnownHost ($(_SSH_KNWONHOST_MK_VERSION)) macros:'
	@echo

_ssh_view_framework_parameters ::
	@echo 'SSH::KnownHost ($(_SSH_KNWONHOST_MK_VERSION)) parameters:'
	@echo '    SSH_KNOWNHOST_IP=$(SSH_KNOWNHOST_IP)'
	@echo '    SSH_KNOWNHOST_IP_OR_NAME=$(SSH_KNOWNHOST_IP_OR_NAME)'
	@echo '    SSH_KNOWNHOST_NAME=$(SSH_KNOWNHOST_NAME)'
	@echo '    SSH_KNOWNHOSTS_FILEPATH=$(SSH_KNOWNHOSTS_FILEPATH)'
	@echo

_ssh_view_framework_targets ::
	@echo 'SSH::KnownHost ($(_SSH_KNWONHOST_MK_VERSION)) targets:'
	@echo '    _ssh_create_knownhost                - Create a known-host'
	@echo '    _ssh_delete_knownhost                - Delete a known-host'
	@echo '    _ssh_show_knownhost                  - Show everything related to a known-host'
	@echo '    _ssh_show_knownhost_description      - Show description of a known-host'
	@echo '    _ssh_view_knownhosts                 - View all known-hosts'
	@echo

#----------------------------------------------------------------------
# SSH KEY MANAGEMENT
#

_ssh_create_knownhost:
	@$(INFO) '$(SSH_UI_LABEL)Creating a known-host'; $(NORMAL)

_ssh_delete_knownhost:
	@$(INFO) '$(SSH_UI_LABEL)Deleting a known-host'; $(NORMAL)
	ssh-keygen $(__SSH_KNOWNHOSTS_FILE) -R $(SSH_KNOWNHOST_IP_OR_NAME)

_ssh_show_knownhost: _ssh_show_knownhost_description

_ssh_show_knownhost_description:
	@$(INFO) '$(SSH_UI_LABEL)Viewing known-hosts ...'; $(NORMAL)
	cat $(SSH_KNOWNHOSTS_FILEPATH) | grep $(SSH_KNWONHOST_IP_OR_NAME)

_ssh_view_knownhosts:
	@$(INFO) '$(SSH_UI_LABEL)Viewing known-hosts ...'; $(NORMAL)
	cat $(SSH_KNOWNHOSTS_FILEPATH)
