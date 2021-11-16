_SSH_MK_VERSION= 0.99.4

SSH_CONFIG_DIRPATH?= $(HOME)/.ssh/
SSH_CONFIG_FILENAME?= config
# SSH_CONFIG_FILEPATH?= $(HOME)/.ssh/config
SSH_HOST_KEYCHECKING_FLAG?= true
SSH_HOST_PORT?= 22
# SSH_OPTIONS?= -v
SSH_UI_LABEL?= [ssh] #

# Derived parameters
SSH_CONFIG_FILEPATH?= $(SSH_CONFIG_DIRPATH)$(SSH_CONFIG_FILENAME)

# Options
## __SSH_CONFIG= $(if $(SSH_CONFIG_FILEPATH),-F $(SSH_CONFIG_FILEPATH))
__SSH_HOST_KEY_CHECKING= $(if $(filter false,$(SSH_HOST_KEYCHECKING_FLAG)),-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no)

# Customizations

#--- Utilities
__SSH_OPTIONS+= $(__SSH_CONFIG)
__SSH_OPTIONS+= $(__SSH_HOST_KEY_CHECKING)
SSH_BIN?= ssh
SSH?= $(strip $(__SSH_ENVIRONMENT) $(SSH_ENVIRONMENT) $(SSH_BIN) $(__SSH_OPTIONS) $(SSH_OPTIONS))

SSHKEYGEN_BIN?= ssh-keygen
SSHKEYGEN?= $(strip $(__SSHKEYGEN_ENVIRONMENT) $(SSHKEYGEN_ENVIRONMENT) $(SSHKEYGEN_BIN) $(__SSHKEYGEN_OPTIONS) $(SSHKEYGEN_OPTIONS))

#--- Macros
_ssh_get_mypublicip= $(call dig +short myip.opendns.com @resolver1.opendns.com)

#----------------------------------------------------------------------
# USAGE
#

_list_macros :: _ssh_list_macros
_ssh_list_macros ::
	@echo 'SSH ($(_SSH_MK_VERSION)) macros:'
	@echo '    _ssh_get_mypublicip                - Get the public ip address'
	@echo

_list_parameters :: _ssh_list_parameters
_ssh_list_parameters ::
	@echo 'SSH ($(_SSH_MK_VERSION)) parameters:'
	@echo '    SSH=$(SSH)'
	@echo '    SSH_CONFIG_DIRPATH=$(SSH_CONFIG_DIRPATH)'
	@echo '    SSH_CONFIG_FILENAME=$(SSH_CONFIG_FILENAME)'
	@echo '    SSH_CONFIG_FILEPATH=$(SSH_CONFIG_FILEPATH)'
	@echo '    SSH_HOST_KEYCHECKING_FLAG=$(SSH_HOST_KEYCHEKING_FLAG)'
	@echo '    SSH_HOST_PORT=$(SSH_HOST_PORT)'
	@echo '    SSH_MYPUBLICIP=$(SSH_MYPUBLICIP)'
	@echo '    SSH_MYPUBLICIP=$(SSH_MYPUBLICIP)'
	@echo '    SSH_UI_LABEL=$(SSH_UI_LABEL)'
	@echo '    SSHKEYGEN=$(SSHKEYGEN)'
	@echo

_list_targets :: _ssh_list_targets
_ssh_list_targets ::
	@echo 'SSH ($(_SSH_MK_VERSION)) targets:'
	@echo '    _ssh_get_mypublicip                - Get the public IP of localhost'
	@echo '    _ssh_view_versions                 - View versions of depedencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/ssh_authorizedkey.mk
-include $(MK_DIR)/ssh_keypair.mk
-include $(MK_DIR)/ssh_knownhost.mk
-include $(MK_DIR)/ssh_localuser.mk
-include $(MK_DIR)/ssh_remoteuser.mk
-include $(MK_DIR)/ssh_sshagent.mk


#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_ssh_get_mypublicip:
	@$(INFO) '$(SSH_UI_LABEL)Getting my public IP address ...'; $(NORMAL)
	@$(WARN) 'To find the range of IP, use https://search.arin.net/rdap/?query=66.170.99.95&searchFilter=ipaddr'; $(NORMAL)
	dig +short myip.opendns.com @resolver1.opendns.com

_view_versions :: _ssh_view_versions
_ssh_view_versions:
	@$(INFO) '$(SSH_UI_LABEL)Viewing versions of dependencies ...'; $(NORMAL)
	$(SSH) -V
