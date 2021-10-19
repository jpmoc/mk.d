ANSIBLE_INVENTORY_MK_VERSION= $(ANSIBLE_MK_VERSION)

# ABE_INVENTORY_CACHE_DIRPATH?= ./cache.d
# ABE_INVENTORY_DIR_DIRPATH?= ./inventories
# ABE_INVENTORY_FORMATS?= cache dir ini list script yaml
# ABE_INVENTORY_GROUP_NAMES?= all
# ABE_INVENTORY_INI_FILEPATH?= ./inventories/hosts.ini
# ABE_INVENTORY_HOST?= 127.0.0.1
# ABE_INVENTORY_HOSTS?= 127.0.0.1 127.0.0.1
# ABE_INVENTORY_NAME?= my-inventory
# ABE_INVENTORY_PRIVATEKEY_FILEPATH?= 
# ABE_INVENTORY_REMOTEUSER_NAME?= 
# ABE_INVENTORY_SCRIPT_FILEPATH?= ./inventories/ec2_$(AWS_PROFILE)
# ABE_INVENTORY_YAML_FILEPATH?= ./inventories/hosts.yaml
# ABE_INVENTORIES_DIRPATH?= ./inventories

# Derived parameters
ABE_INVENTORIES_DIRPATH?= $(ABE_INVENTORY_DIRPATH)
ABE_INVENTORY_DIRPATH?= $(dir $(ABE_INVENTORY_FILEPATH))
ABE_INVENTORY_HOSTS?= $(ABE_INVENTORY_HOST)
ABE_INVENTORY_PRIVATEKEY_FILEPATH?= $(ABE_PRIVATEKEY_FILEPATH)
ABE_INVENTORY_REMOTEUSER_NAME?= $(ABE_REMOTEUSER_NAME)

# Option parameters
__ABE_INVENTORY__INVENTORY+= $(if $(filter dir, $(ABE_INVENTORY_FORMATS)),--inventory $(ABE_INVENTORY_DIR_DIRPATH))
__ABE_INVENTORY__INVENTORY+= $(if $(filter ini, $(ABE_INVENTORY_FORMATS)),--inventory $(ABE_INVENTORY_INI_FILEPATH))
__ABE_INVENTORY__INVENTORY+= $(if $(filter list, $(ABE_INVENTORY_FORMATS)),--inventory $(subst $(SPACE),$(COMMA),$(ABE_INVENTORY_HOSTS))$(COMMA))
__ABE_INVENTORY__INVENTORY+= $(if $(filter script, $(ABE_INVENTORY_FORMATS)),--inventory $(ABE_INVENTORY_SCRIPT_FILEPATH))
__ABE_INVENTORY__INVENTORY+= $(if $(filter yaml, $(ABE_INVENTORY_FORMATS)),--inventory $(ABE_INVENTORY_YAML_FILEPATH))
__ABE_PRIVATE_KEY__INVENTORY= $(if $(ABE_INVENTORY_PRIVATEKEY_FILEPATH),--private-key $(ABE_INVENTORY_PRIVATEKEY_FILEPATH))
__ABE_USER__INVENTORY= $(if $(ABE_INVENTORY_REMOTEUSER_NAME),--user $(ABE_INVENTORY_REMOTEUSER_NAME))

# Utilities
ANSIBLE_INVENTORY_BIN?= ansible-inventory
ANSIBLE_INVENTORY= $(strip $(__ANSIBLE_INVENTORY_ENVIRONMENT) $(ANSIBLE_INVENTORY_ENVIRONMENT) $(ANSIBLE_INVENTORY_BIN) $(__ANSIBLE_INVENTORY_OPTIONS) $(ANSIBLE_INVENTORY_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_abe_view_framework_macros ::
	@#echo 'Ansible::Inventory ($(ANSIBLE_INVENTORY_MK_VERSION)) macros:'
	@#echo

_abe_view_framework_parameters ::
	@echo 'Ansible::Inventory ($(ANSIBLE_INVENTORY_MK_VERSION)) parameters:'
	@echo '    ABE_INVENTORIES_DIRPATH=$(ABE_INVENTORIES_DIRPATH)'
	@echo '    ABE_INVENTORY_CACHE_DIRPATH=$(ABE_INVENTORY_CACHE_DIRPATH)'
	@echo '    ABE_INVENTORY_DIR_DIRPATH=$(ABE_INVENTORY_DIRPATH)'
	@echo '    ABE_INVENTORY_DIRPATH=$(ABE_INVENTORY_DIRPATH)'
	@echo '    ABE_INVENTORY_FORMATS=$(ABE_INVENTORY_FORMATS)'
	@echo '    ABE_INVENTORY_GROUP_NAMES=$(ABE_INVENTORY_GROUP_NAMES)'
	@echo '    ABE_INVENTORY_HOSTS=$(ABE_INVENTORY_HOSTS)'
	@echo '    ABE_INVENTORY_INI_FILEPATH=$(ABE_INVENTORY_INI_FILEPATH)'
	@echo '    ABE_INVENTORY_NAME=$(ABE_INVENTORY_NAME)'
	@echo '    ABE_INVENTORY_PRIVATEKEY_FILEPATH=$(ABE_INVENTORY_PRIVATEKEY_FILEPATH)'
	@echo '    ABE_INVENTORY_REMOTEUSER_NAME=$(ABE_INVENTORY_REMOTEUSER_NAME)'
	@echo '    ABE_INVENTORY_SCRIPT_FILEPATH=$(ABE_INVENTORY_SCRIPT_FILEPATH)'
	@echo '    ABE_INVENTORY_YAML_FILEPATH=$(ABE_INVENTORY_YAML_FILEPATH)'
	@echo '    ABE_INVENTORIES_DIRPATH=$(ABE_INVENTORY_DIRPATH)'
	@echo '    ANSIBLE_INVENTORY=$(ANSIBLE_INVENTORY)'
	@echo

_abe_view_framework_targets ::
	@echo 'Ansible ($(ANSIBLE_MK_VERSION)) targets:'
	@echo '    _abe_check_inventory               - Check health of inventory'
	@echo '    _abe_check_inventory_ec2facts      - Check ec2-fact-gathering for inventory'
	@echo '    _abe_check_inventory_facts         - Check fact-gathering for inventory'
	@echo '    _abe_check_inventory_host          - Check host-properties for inventory'
	@echo '    _abe_check_inventory_ping          - Check connectivity with inventory'
	@echo '    _abe_show_inventory                - Show everything related to the inventory'
	@echo '    _abe_show_inventory_cache          - Show cache use in inventory'
	@echo '    _abe_show_inventory_content        - Show content of inventory'
	@echo '    _abe_show_inventory_scripthelp     - Show help for scripts in inventory'
	@echo '    _abe_view_inventories              - View inventories'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_abe_check_inventory: _abe_check_inventory_ec2facts _abe_check_inventory_facts _abe_check_inventory_host _abe_check_inventory_ping

_abe_check_inventory_ec2facts ::

_abe_check_inventory_facts ::

_abe_check_inventory_host:
	@$(INFO) '$(ABE_UI_LABEL)Checking properties of host in inventory "$(ABE_INVENTORY_NAME)" ...'; $(NORMAL)
	# $(ANSIBLE_INVENTORY) --host $(ABE_INVENTORY_HOST)

_abe_ping_inventory ::

_abe_show_inventory: _abe_show_inventory_cache _abe_show_inventory_content _abe_show_inventory_scripthelp

_abe_show_inventory_cache::

_abe_show_inventory_content:
	@$(INFO) '$(ABE_UI_LABEL)Showing content of inventory "$(ABE_INVENTORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Enabled inventory formats: $(ABE_INVENTORY_FORMATS)'; $(NORMAL)
	@$(if $(filter cache, $(ABE_INVENTORY_FORMATS)), echo '--- cache ---'; echo $(ABE_INVENTORYCACHE_NAME))
	@$(if $(filter dir, $(ABE_INVENTORY_FORMATS)), echo '--- dir ---'; cd $(ABE_INVENTORY_DIR_DIRPATH); cat *)
	@$(if $(filter ini, $(ABE_INVENTORY_FORMATS)), echo '--- ini ---'; cat $(ABE_INVENTORY_INI_FILEPATH))
	@$(if $(filter list, $(ABE_INVENTORY_FORMATS)), echo '--- list ---'; echo $(ABE_INVENTORY_HOSTS))
	@$(if $(filter script, $(ABE_INVENTORY_FORMATS)), echo '--- script ---'; echo $(ABE_INVENTORY_SCRIPT_FILEPATH))
	@$(if $(filter yaml, $(ABE_INVENTORY_FORMATS)), echo '--- yaml ---'; cat $(ABE_INVENTORY_YAML_FILEPATH))

_abe_show_inventory_scripthelp:
	@$(INFO) '$(ABE_UI_LABEL)Showing help for scripts in inventory "$(ABE_INVENTORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'Enabled inventory formats: $(ABE_INVENTORY_FORMATS)'; $(NORMAL)
	@$(if $(filter script, $(ABE_INVENTORY_FORMATS)), $(ANSIBLE_INVENTORY) --help, echo 'No inventory-script')

_abe_view_inventories:
	@$(INFO) '$(ABE_UI_LABEL)Viewing available inventories ...'; $(NORMAL)
	ls -la $(ABE_INVENTORIES_DIRPATH)
