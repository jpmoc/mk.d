ANSIBLE_MK_VERSION= 0.99.2

# ABE_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
# ABE_REMOTEUSER_NAME?= ubuntu
# ANSIBLE_ENVIRONMENT?= $(ENVIRONMENT)
# ANSIBLE_HOST_KEY_CHECKING?= False
# ANSIBLE_OPTIONS?=

# UI parameters
ABE_UI_LABEL=[ansible] #

# Derived parameters


# Option parameters

# Utilities
__ANSIBLE_ENVIRONMENT+= $(if $(ANSIBLE_HOST_KEY_CHECKING), ANSIBLE_HOST_KEY_CHECKING=$(ANSIBLE_HOST_KEY_CHECKING))
ANSIBLE_BIN?= ansible
ANSIBLE= $(strip $(__ANSIBLE_ENVIRONMENT) $(ANSIBLE_ENVIRONMENT) $(ANSIBLE_BIN) $(__ANSIBLE_OPTIONS) $(ANSIBLE_OPTIONS))

ANSIBLE_CONSOLE_BIN?= ansible-console
ANSIBLE_CONSOLE= $(strip $(__ANSIBLE_CONSOLE_ENVIRONMENT) $(ANSIBLE_CONSOLE_ENVIRONMENT) $(ANSIBLE_CONSOLE_BIN) $(__ANSIBLE_CONSOLE_OPTIONS) $(ANSIBLE_CONSOLE_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _abe_view_framework_macros
_abe_view_framework_macros ::
	@echo 'Ansible:: ($(ANSIBLE_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _abe_view_framework_parameters
_abe_view_framework_parameters ::
	@echo 'Ansible:: ($(ANSIBLE_MK_VERSION)) parameters:'
	@echo '    ANSIBLE=$(ANSIBLE)'
	@echo '    ANSIBLE_CONSOLE=$(ANSIBLE_CONSOLE)'
	@echo

_view_framework_targets :: _abe_view_framework_targets
_abe_view_framework_targets ::
	@echo 'Ansible:: ($(ANSIBLE_MK_VERSION)) targets:'
	@echo '    _abe_install_dependencies          - Install the software dependencies'
	@echo '    _abe_show_version                  - Show version of dependencies'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?= .
-include $(MK_DIR)/ansible_galaxyrole.mk
-include $(MK_DIR)/ansible_inventory.mk
-include $(MK_DIR)/ansible_inventorycache.mk
-include $(MK_DIR)/ansible_module.mk
-include $(MK_DIR)/ansible_playbook.mk
-include $(MK_DIR)/ansible_vault.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _abe_install_dependencies
_abe_install_framework_dependencies ::
	sudo pip install ansible

_view_versions :: _abe_show_version
_abe_show_version:
	@$(INFO) '$(ABE_UI_LABEL)Showing version of dependencies'; $(NORMAL)
	$(ANSIBLE) --version
	$(ANSIBLE_CONSOLE) --version
	$(if $(ANSIBLE_INVENTORY),$(ANSIBLE_INVENTORY) --version)
	$(if $(ANSIBLE_GALAXY),$(ANSIBLE_GALAXY) --version)
	$(if $(ANSIBLE_PLAYBOOK),$(ANSIBLE_PLAYBOOK) --version)
	$(if $(ANSIBLE_VAULT),$(ANSIBLE_VAULT) --version)
