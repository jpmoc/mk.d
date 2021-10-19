_CHEF_KNIFE_ROLE_MK_VERSION=$(_CHEF_KNIFE_MK_VERSION)

# KFE_ROLE_FILEPATH?= ./my-role-name.json
# KFE_ROLE_NAME?= my-role-name
# KFE_ROLES_SEARCH_QUERY?=

# Derived variables

# Options

# Command

# Macros
_kfe_get_role_name_from_file= $(call _kfe_get_role_name_from_file_F, $(KFE_ROLE_FILEPATH))
_kfe_get_role_name_from_file_F= $(shell jq -r '.name' $(1))

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros:
	@echo "Chef::KniFE::Role ($(_CHEF_KNIFE_ROLE_MK_VERSION)) targets:"
	@echo "    _kfe_get_role_name_from_file_{|F}       - Get role name from a role file"
	@echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::Role ($(_CHEF_KNIFE_ROLE_MK_VERSION)) targets:"
	@echo "    _kfe_create_role                        - Create a new role"
	@echo "    _kfe_delete_role                        - Delete an existing role"
	@echo "    _kfe_edit_role                          - Edit an existing role"
	@echo "    _kfe_import_role                        - Import a role from a json file"
	@echo "    _kfe_search_roles                       - Search roles based on a pattern"
	@echo "    _kfe_show_role                          - Show details on a role"
	@echo "    _kfe_upload_role                        - Upload a role to chef server"
	@echo "    _kfe_view_roles                         - View existing roles in organization"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::Role ($(_CHEF_KNIFE_ROLE_MK_VERSION)) variables:"
	@echo "    KFE_ROLE_NAME=$(KFE_ROLE_NAME)"
	@echo "    KFE_ROLES_SEARCH_QUERY=$(KFE_ROLES_SEARCH_QUERY)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_create_role:
	@$(INFO) "$(KFE_LABEL)Creating role '$(KFE_ROLE_NAME)' ..."; $(NORMAL)
	$(KNIFE) role create $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_ROLE_NAME)

_kfe_delete_role:
	@$(INFO) "$(KFE_LABEL)Deleting role '$(KFE_ROLE_NAME)' ..."; $(NORMAL)
	$(KNIFE) role delete $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_ROLE_NAME)

_kfe_edit_role:
	@$(INFO) "$(KFE_LABEL)Editing existing role '$(KFE_ROLE_NAME)' ..."; $(NORMAL)
	$(KNIFE) role edit $(__KFE_SUBCOMMAND_OPTIONS) \
		$(__KFE_EDITOR) $(KFE_ROLE_NAME)

_kfe_import_role:
	@$(INFO) "$(KFE_LABEL)Importing role from file ..."; $(NORMAL)
	@$(WARN) "Imported role name: $(call _kfe_get_role_name_from_file)"; $(NORMAL)
	$(KNIFE) role from file $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_ROLE_FILEPATH)

_kfe_search_roles:
	@$(INFO) "$(KFE_LABEL)Searching roles with pattern  '$(KFE_ROLES_SEARCH_QUERY)' ..."; $(NORMAL)
	$(KNIFE) search role "$(KFE_ROLES_SEARCH_QUERY)"

_kfe_show_role:
	@$(INFO) "$(KFE_LABEL)Showing role '$(KFE_ROLE_NAME)' ..."; $(NORMAL)
	$(KNIFE) role show $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_ROLE_NAME)

_kfe_upload_role:
	# TBD

_kfe_view_roles:
	@$(INFO) "$(KFE_LABEL)Viewing configured roles ..."; $(NORMAL)
	$(KNIFE) role list $(__KFE_SUBCOMMAND_OPTIONS) $(__KFE_WITH_URI)
