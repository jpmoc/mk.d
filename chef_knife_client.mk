_CHEF_KNIFE_CLIENT_MK_VERSION=$(_CHEF_KNIFE_MK_VERSION)

# KFE_CLIENTS_SEARCH_QUERY?=

# Derived variables

# Options

# Command

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros ::
	@#echo "Chef::KniFE::Client ($(_CHEF_KNIFE_CLIENT_MK_VERSION)) targets:"
	@#echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::Client ($(_CHEF_KNIFE_CLIENT_MK_VERSION)) targets:"
	@echo "    _kfe_search_clients                     - Search clients based on a pattern"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::Client ($(_CHEF_KNIFE_CLIENT_MK_VERSION)) variables:"
	@echo "    KFE_CLIENTS_SEARCH_QUERY=$(KFE_CLIENTS_SEARCH_QUERY)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_search_clients:
	@$(INFO) "$(KFE_LABEL)Searching clients with pattern  '$(KFE_CLIENTS_SEARCH_QUERY)' ..."; $(NORMAL)
	$(KNIFE) search client "$(KFE_CLIENTS_SEARCH_QUERY)"
