ANSIBLE_GALAXYROLE_MK_VERSION=$(ANSIBLE_MK_VERSION)

# ABE_GALAXYROLE_AUTHOR?= geerlinguy
# ABE_GALAXYROLE_DELETE_FORCE?= true
# ABE_GALAXYROLE_NAME?= geerlinguy.elasticsearch
# ABE_GALAXYROLE_ROLE_NAME?= elasticsearch
# ABE_GALAXYROLES_METADATA_FILEPATH?= $(ABE_GALAXYROLE_DIRPATH)/galaxy_roles.yml
# ABE_GALAXYROLES_DIRPATH?= /etc/ansible/roles
ANSIBLE_GALAXY_SERVER_URL?= http://galaxy.ansible.com

# Derived parameters
ABE_GALAXYROLE_FILEPATH?= $(ABE_GALAXYROLE_DIRPATH)/galaxy_roles.yml
ABE_GALAXYROLE_NAME?= $(ABE_GALAXYROLE_AUTHOR).$(ABE_GALAXYROLE_ROLE_NAME)
ABE_GALAXYROLES_METADATA_FILEPATH?= $(ABE_GALAXYROLES_DIRPATH)/galaxy_roles.yml

# Option parameters
__ABE_AUTHOR= $(if $(ABE_GALAXYROLE_AUTHOR),--author $(ABE_GALAXYROLE_AUTHOR))
__ABE_FORCE__GALAXYROLE= $(if $(filter true, $(ABE_GALAXYROLE_DELETE_FORCE)),--force)
__ABE_ROLE_FILE= $(if $(ABE_GALAXYROLE_METADATA_FILEPATH),--role-file $(ABE_GALAXYROLE_METADATA_FILEPATH))
__ABE_ROLES_PATH= $(if $(ABE_GALAXYROLES_DIRPATH),--roles-path $(ABE_GALAXYROLES_DIRPATH))
__ABE_SERVER= $(if $(ABE_GALAXY_SERVER_URL),--server $(ABE_GALAXY_SERVER_URL))

# Utilities
__ANSIBLE_GALAXY_OPTIONS+= $(if $(ANSIBLE_GALAXY_SERVER_URL),--server $(ANSIBLE_GALAXY_SERVER_URL))
ANSIBLE_GALAXY_BIN?= ansible-galaxy
ANSIBLE_GALAXY= $(strip $(__ANSIBLE_GALAXY_ENVIRONMENT) $(ANSIBLE_GALAXY_ENVIRONMENT) $(ANSIBLE_GALAXY_BIN) $(__ANSIBLE_GALAXY_OPTIONS) $(ANSIBLE_GALAXY_OPTIONS))

#----------------------------------------------------------------------
# USAGE
#

_abe_view_framework_macros ::
	@#echo 'Ansible::GalaxyRole ($(ANSIBLE_GALAXYROLEMK_VERSION)) macros:'
	@#echo

_abe_view_framework_parameters ::
	@echo 'Ansible::GalaxyRole ($(ANSIBLE_GALAXYROLE_MK_VERSION)) parameters:'
	@echo '    ABE_GALAXYROLE_AUTHOR=$(ABE_GALAXYROLE_AUTHOR)'
	@echo '    ABE_GALAXYROLE_DELETE_FORCE=$(ABE_GALAXYROLE_DELETE_FORCE)'
	@echo '    ABE_GALAXYROLE_DIRPATH=$(ABE_GALAXYROLE_DIRPATH)'
	@echo '    ABE_GALAXYROLE_GITHUB_REPOSITORY=$(ABE_GALAXYROLE_GITHUB_REPOSITORY)'
	@echo '    ABE_GALAXYROLE_GITHUB_USERNAME=$(ABE_GALAXYROLE_GITHUB_USERNAME)'
	@echo '    ABE_GALAXYROLE_NAME=$(ABE_GALAXYROLE_NAME)'
	@echo '    ABE_GALAXYROLE_ROLE_NAME=$(ABE_GALAXYROLE_ROLE_NAME)'
	@echo '    ABE_GALAXYROLES_METADATA_FILEPATH=$(ABE_GALAXYROLES_METADATA_FILEPATH)'
	@echo '    ANSIBLE_GALAXY=$(ANSIBLE_GALAXY)'
	@echo

_abe_view_framework_targets ::
	@echo 'Ansible::GalaxyRole ($(ANSIBLE_GALAXYROLE_MK_VERSION)) targets:'
	@echo '    _abe_delete_galaxyrole             - Delete a galxy-role'
	@echo '    _abe_install_galaxyrole            - Install a galxy-role'
	@echo '    _abe_search_galaxy                 - Search a role on galaxy'
	@echo '    _abe_login_galaxy                  - Login on galaxy'
	@echo '    _abe_show_galaxyrole               - Show everything related to a galaxy-role'
	@echo '    _abe_uninstall_galaxyrole          - Uninstall a galaxy-role'
	@echo '    _abe_view_galaxyroles              - View galaxy-hosted roles'
	@echo

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_abe_create_galaxyrole: _abe_install_galaxyrole

_abe_delete_galaxyrole: _abe_uninstall_galaxyrole
	@$(INFO) '$(ABE_UI_LABEL)Deleting galaxy-role "$(ABE_GALAXYROLE_NAME)" ...'; $(NORMAL)
	@$(WARN) 'This operation remove a role from the galaxy site'; $(NORMAL)
	$(ANSIBLE_GALAXY) delete $(ABE_GALAXYROLE_GITHUB_USERNAME) $(ABE_GALAXYROLE_GITHUB_REPOSITORY)

_abe_install_galaxyrole:
	@$(INFO) '$(ABE_UI_LABEL)Installing galaxy-role "$(ABE_GALAXYROLE_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_GALAXY) install $(__ABE_ROLE_FILE) $(__ABE_ROLES_PATH) $(__ABE_FORCE__GALAXYROLE) $(ABE_GALAXYROLE_NAME)

_abe_login_galaxy:
	@$(INFO) '$(ABE_UI_LABEL)Login in galaxy ...'; $(NORMAL)
	@$(WARN) 'Galaxy URL: https://galaxy.ansible.com/'; $(NORMAL)
	$(ANSIBLE_GALAXY) login

_abe_search_galaxy:
	@$(INFO) '$(ABE_UI_LABEL)Searching galaxy for matching-roles ...'; $(NORMAL)
	@$(WARN) 'This operation returns the galaxy-roles that meet all the provided constraints'; $(NORMAL)
	$(ANSIBLE_GALAXY) search $(__ABE_AUTHOR) $(__ABE_SERVER) $(ABE_GALAXYROLE_ROLE_NAME)

_abe_show_galaxyrole: _abe_show_galaxyrole_description

_abe_show_galaxyrole_description:
	@$(INFO) '$(ABE_UI_LABEL)Showing description of galaxy-role "$(ABE_GALAXYROLE_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_GALAXY) info $(ABE_GALAXYROLE_NAME)

_abe_uninstall_galaxyrole:
	@$(INFO) '$(ABE_UI_LABEL)Uninstalling galaxy-role "$(ABE_GALAXYROLE_NAME)" ...'; $(NORMAL)
	$(ANSIBLE_GALAXY) remove $(__ABE_ROLE_FILE) $(__ABE_ROLES_PATH) $(__ABE_FORCE__GALAXYROLE)

_abe_view_galaxyroles:
	@$(INFO) '$(ABE_UI_LABEL)Viewing local galaxy-roles ...'; $(NORMAL)
	@$(WARN) 'ROLE_DIR: $(ABE_GALAXYROLE_DIR)'; $(NORMAL)
	@$(ANSIBLE_GALAXY) list $(__ABE_ROLES_PATH)
