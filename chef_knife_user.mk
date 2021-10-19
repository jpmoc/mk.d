_CHEF_KNIFE_USER_MK_VERSION=$(_CHEF_KNIFE_MK_VERSION)

# KFE_USER_NAME?=

# Derived variables

# Options

# Command

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros ::
	@echo "Chef::KniFE::User ($(_CHEF_KNIFE_USER_MK_VERSION)) targets:"
	@echo "    _kfe_get_role_name_from_file_{|F}       - Get role name from a role file"
	@echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::User ($(_CHEF_KNIFE_USER_MK_VERSION)) targets:"
	@echo "    _kfe_show_user                          - Show details on an existing user"
	@echo "    _kfe_view_users                         - View available users on chef server"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::User ($(_CHEF_KNIFE_USER_MK_VERSION)) variables:"
	@echo "    KFE_USER_NAME=$(KFE_USER_NAME)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_show_user:
	@$(INFO) "$(KFE_LABEL)Showing user '$(KFE_USER_NAME)' ..."; $(NORMAL)
	$(KNIFE) user show $(__KFE_SUBCOMMAND_OPTIONS) $(KFE_USER_NAME)

_kfe_view_users:
	@$(INFO) "$(KFE_LABEL)Viewing users ..."; $(NORMAL)
	$(KNIFE) user list $(__KFE_SUBCOMMAND_OPTIONS) $(__KFE_WITH_URI)
