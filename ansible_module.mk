ANSIBLE_MODULE_MK_VERSION= $(ANSIBLE_MK_VERSION)

# ABE_MODULE_ARGUMENTS?= my-module
# ABE_MODULE_INVENTORY_GROUPNAMES?=
# ABE_MODULE_NAME?= my-module
# ABE_MODULE_PRIVATEKEY_FILEPATH?= $(HOME)/.ssh/id_rsa
# ABE_MODULE_REMOTEUSER_NAME?= ec2-user

# Derived parameters
ABE_MODULE_INVENTORY_GROUPNAMES?=$(ABE_INVENTORY_GROUP_NAMES)
ABE_MODULE_PRIVATEKEY_FILEPATH?= $(ABE_PRIVATEKEY_FILEPATH)
ABE_MODULE_REMOTEUSER_NAME?= $(ABE_REMOTEUSER_NAME)

# Option parameters
__ABE_ARGS?= $(if $(ABE_MODULE_ARGUMENTS), --args $(ABE_MODULE_ARGUMENTS))
__ABE_INVENTORY__MODULE?= $(__ABE_INVENTORY__INVENTORY)
__ABE_MODULE_NAME?= $(if $(ABE_MODULE_NAME),--module-name $(MODULE_NAME))
__ABE_PRIVATE_KEY__MODULE?= $(if $(ABE_MODULE_PRIVATEKEY_FILEPATH),--private-key $(ABE_MODULE_PRIVATEKEY_FILEPATH))
__ABE_USER__MODULE?= $(if $(ABE_MODULE_REMOTEUSER_NAME),--user $(ABE_MODULE_REMOTEUSER_NAME))

#----------------------------------------------------------------------
# USAGE
#

_abe_view_framework_macros ::
	@echo 'Ansible::Module ($(ANSIBLE_MODULE_MK_VERSION)) macros:'
	@echo

_abe_view_framework_parameters ::
	@echo 'Ansible::Module ($(ANSIBLE_MODULE_MK_VERSION)) parameters:'
	@echo '    ABE_MODULE_ARGUMENTS=$(ABE_MODULE_ARGUMENTS)'
	@echo '    ABE_MODULE_INVENTORY_GROUPNAMES=$(ABE_MODULE_INVENTORY_GROUPNAMES)'
	@echo '    ABE_MODULE_NAME=$(ABE_MODULE_NAME)'
	@echo '    ABE_MODULE_PRIVATEKEY_FILEPATH=$(ABE_MODULE_PRIVATEKEY_FILEPATH)'
	@echo '    ABE_MODULE_REMOTEUSER_NAME=$(ABE_MODULE_REMOTEUSER_NAME)'
	@echo

_abe_view_framework_targets ::
	@echo 'Ansible::Module ($(ANSIBLE_MODULE_MK_VERSION)) targets:'
	@echo '    _abe_run_module                   - Run a single module'
	@echo '    _abe_run_ec2facts                 - Run the ec2-fact module'
	@echo '    _abe_run_ping                     - Run the ping module'
	@echo '    _abe_run_setup                    - Run the setup module'
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_abe_run_module:
	@$(INFO) '$(ABE_UI_LABEL)Running module "$(ABE_MODULE_NAME)" ...'; $(NORMAL)
	$(ANSIBLE) $(__ABE_ARGS) $(__ABE_MODULE_NAME) $(__ABE_PRIVATE_KEY__MODULE) $(__ABE_USER__MODULE) $(ABE_MODULE_INVENTORY_GROUPNAMES) 

_abe_run_ec2facts:
	@$(INFO) '$(ABE_UI_LABEL)Checking ec2-facts gathering for inventory "$(ABE_INVENTORY_NAME)"...'; $(NORMAL)
	$(ANSIBLE) $(__ABE_INVENTORY__MODULE) $(_X__ABE_MODULE_NAME) -m ec2_facts $(__ABE_PRIVATE_KEY__MODULE) $(__ABE_USER__MODULE) $(ABE_MODULE_INVENTORY_GROUPNAMES)

_abe_run_ping:
	@$(INFO) '$(ABE_UI_LABEL)Pinging inventory "$(ABE_INVENTORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation uses ssh by default. Key must be provided on CLI or by ssh-agent'; $(NORMAL)
	$(ANSIBLE) $(__ABE_INVENTORY__MODULE) $(_X__ABE_MODULE_NAME) -m ping $(__ABE_PRIVATE_KEY__MODULE) $(__ABE_USER__MODULE) $(ABE_MODULE_INVENTORY_GROUPNAMES)

_abe_run_setup:
	@$(INFO) '$(ABE_UI_LABEL)Checking facts gathering for inventory "$(ABE_INVENTORY_NAME)"...'; $(NORMAL)
	$(ANSIBLE) $(__ABE_INVENTORY__MODULE) $(_X__ABE_MODULE_NAME) -m setup $(__ABE_PRIVATE_KEY__MODULE) $(__ABE_USER__MODULE) $(ABE_MODULE_INVENTORY_GROUPNAMES)

