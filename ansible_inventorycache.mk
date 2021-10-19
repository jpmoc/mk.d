ANSIBLE_INVENTORYCACHE_MK_VERSION= $(ANSIBLE_MK_VERSION)

# ABE_INVENTORYCACHE_CACHE_FILEPATH?= $(HOME)/.ansible/tmp/ansible-ec2-244311.cache
# ABE_INVENTORYCACHE_INDEX_FILEPATH?= $(HOME)/.ansible/tmp/ansible-ec2-244311.index
# ABE_INVENTORYCACHE_INVENTORY_NAME?= my-inventory
# ABE_INVENTORYCACHE_NAME?= my-inventory-cache
# ABE_INVENTORYCACHE_SCRIPT_FILEPATH?= ./inventories/ec2.py-cache.json
# ABE_INVENTORYCACHES_DIRPATH?= $(HOME)/.ansible/tmp

# Derived parameters
ABE_INVENTORYCACHE_INVENTORY_NAME?= $(ABE_INVENTORY_NAME)
ABE_INVENTORYCACHE_SCRIPT_FILEPATH?= $(ABE_INVENTORY_SCRIPT_FILEPATH)
# ABE_INVENTORYCACHES_DIRPATH?= $(shell grep cache_path ec2.ini | cut -d ' ' -f 3)

# Option parameters

# Pipe parameters
|_ABE_CREATE_INVENTORYCACHE?=# | tee $(ABE_INVENTORYCACHES_DIRPATH)/ec2.cache

# Utilities
__ANSIBLE_INVENTORYCACHE_ENVIRONMENT?= $(__ANSIBLE_ENVIRONMENT)
ANSIBLE_INVENTORYCACHE_ENVIRONMENT?= $(ANSIBLE_ENVIRONMENT)
ANSIBLE_INVENTORYCACHE_BIN?= $(ABE_INVENTORYCACHE_SCRIPT_FILEPATH)
ANSIBLE_INVENTORYCACHE?= $(strip $(__ANSIBLE_INVENTORYCACHE_ENVIRONMENT) $(ANSIBLE_INVENTORYCACHE_ENVIRONMENT) $(ANSIBLE_INVENTORYCACHE_BIN) $(__ANSIBLE_INVENTORY_OPTIONS) $(ANSIBLE_INVENTORY_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_abe_view_framework_macros ::
	@echo 'Ansible::InventoryCache ($(ANSIBLE_INVENTORYCACHE_MK_VERSION)) macros:'
	@echo

_abe_view_framework_parameters ::
	@echo 'Ansible::InventoryCache ($(ANSIBLE_INVENTORYCACHE_MK_VERSION)) parameters:'
	@echo '    ABE_INVENTORYCACHE_CACHE_FILEPATH=$(ABE_INVENTORYCACHE_CACHE_FILEPATH)'
	@echo '    ABE_INVENTORYCACHE_INDEX_FILEPATH=$(ABE_INVENTORYCACHE_INDEX_FILEPATH)'
	@echo '    ABE_INVENTORYCACHE_INVENTORY_NAME=$(ABE_INVENTORYCACHE_INVENTORY_NAME)'
	@echo '    ABE_INVENTORYCACHE_NAME=$(ABE_INVENTORYCACHE_NAME)'
	@echo '    ABE_INVENTORYCACHE_SCRIPT_FILEPATH=$(ABE_INVENTORYCACHE_SCRIPT_FILEPATH)'
	@echo '    ABE_INVENTORYCACHES_DIRPATH=$(ABE_INVENTORYCACHES_DIRPATH)'
	@echo '    ANSIBLE_INVENTORYCACHE=$(ANSIBLE_INVENTORYCACHE)'
	@echo

_abe_view_framework_targets ::
	@echo 'Ansible::InventoryCache ($(ANSIBLE_INVENTORYCACHE_MK_VERSION)) targets:'
	@echo '    _abe_create_inventorycache             - Create an inventory-cache'
	@echo '    _abe_delete_inventorycache             - Delete inventory-cache'
	@echo '    _abe_delete_inventorycaches            - Delete inventory-caches'
	@echo '    _abe_refresh_inventorycache            - Refresh the local inventory-cache'
	@echo '    _abe_show_inventorycache               - Show everything related to an inventory-cache'
	@echo '    _abe_show_inventorycache_description   - Show description of an inventory-cache'
	@echo '    _abe_view_inventorycache               - View inventory-caches'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_abe_create_inventorycache:
	@$(INFO) '$(ABE_UI_LABEL)Creating cache for inventory "$(ABE_INVENTORYCACHE_INVENTORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the inventory-script is not executable'; $(NORMAL)
	@$(WARN) 'This operation fails if you are using an AWS session token and credentials are not passed in the environment'; $(NORMAL)
	$(ANSIBLE_INVENTORYCACHE) --list $(|_ABE_CREATE_INVENTORYCACHE)
	@$(WARN) 'This operation fails if you are using an AWS session token and credentials are not passed in the environment'; $(NORMAL)

_abe_delete_inventorycache:
	@$(INFO) '$(ABE_UI_LABEL)Deleting cache for inventory "$(ABE_INVENTORYCACHE_INVENTORY_NAME)" ...'; $(NORMAL)
	rm $(ABE_INVENTORY_CACHE_FILEPATH)

_abe_delete_inventorycaches:
	@$(INFO) '$(ABE_UI_LABEL)Deleting all inventory-caches ...'; $(NORMAL)
	@$(WARN) 'This operation is dangerous. Are you sure? [Ctrl-C to break]'; read yesNo; $(NORMAL)
	rm -rf $(ABE_INVENTORYCACHE_DIRPATH)
	mkdir $(ABE_INVENTORYCACHE_DIRPATH) 

_abe_show_inventorycache: _Abe_show_inventorycache_description

_abe_show_inventorycache_description:
	@$(INFO) '$(ABE_UI_LABEL)Showing cache for inventory "$(ABE_INVENTORYCACHE_INVENTORY_NAME)" ...'; $(NORMAL)
	ls -alrt $(ABE_INVENTORYCACHE_FILEPATH)

_abe_refresh_inventorycache:
	@$(INFO) '$(ABE_UI_LABEL)Refreshing cache for inventory "$(ABE_INVENTORYCACHE_INVENTORY_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation fails if the inventory-script is not executable'; $(NORMAL)
	@$(WARN) 'This operation fails if you are using an AWS session token and credentials are not passed in the environment'; $(NORMAL)
	$(ANSIBLE_INVENTORYCACHE) --refresh-cache

_abe_view_inventorycaches:
	@$(INFO) '$(ABE_UI_LABEL)Viewing inventory-caches ...'; $(NORMAL)
	ls -alrt $(ABE_INVENTORYCACHES_DIRPATH)
	@$(WARN) 'Caches are ordered from oldest to newest'; $(NORMAL)
