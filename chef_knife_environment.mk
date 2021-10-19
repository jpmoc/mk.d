_CHECF_KNIFE_ENVIRONMENT_MK_VERSION=$(_CHEF_KNIFE_MK_VERSION)

# KFE_ENVIRONMENTS_SEARCH_QUERY?=

# Derived variables

# Options

# Command

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros ::
	@#echo "Chef::KniFE::Environment ($(_CHEF_KNIFE_ENVIRONMENT_MK_VERSION)) targets:"
	@i#echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::Environment ($(_CHEF_KNIFE_ENVIRONMENT_MK_VERSION)) targets:"
	@echo "    _kfe_search_environments                - Search environments based on a pattern"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::Environment ($(_CHEF_KNIFE_ENVIRONMENT_MK_VERSION)) variables:"
	@echo "    KFE_ENVIRONMENTS_SEARCH_QUERY=$(KFE_ENVIRONMENTS_SEARCH_QUERY)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_search_environments:
	@$(INFO) "$(KFE_LABEL)Searching environments with pattern  '$(KFE_ENVIRONMENTS_SEARCH_QUERY)' ..."; $(NORMAL)
	$(KNIFE) search environment "$(KFE_ENVIRONMENTS_SEARCH_QUERY)"
