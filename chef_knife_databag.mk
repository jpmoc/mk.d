_CHEF_KNIFE_DATABAG_MK_VERSION=$(_CHEF_KNIFE_MK_VERSION)

# KFE_DATABAGS_SEARCH_QUERY?=

# Derived variables

# Options

# Command

# Macros

#----------------------------------------------------------------------
# USAGE
#

_kfe_view_makefile_macros ::
	@#echo "Chef::KniFE::Databag ($(_CHEF_KNIFE_DATABAG_MK_VERSION)) targets:"
	@#echo

_kfe_view_makefile_targets ::
	@echo "Chef::KniFE::Databag ($(_CHEF_KNIFE_DATABAG_MK_VERSION)) targets:"
	@echo "    _kfe_search_databags                    - Search databags based on a pattern"
	@echo

_kfe_view_makefile_variables ::
	@echo "Chef::KniFE::Databag ($(_CHEF_KNIFE_DATABAG_MK_VERSION)) variables:"
	@echo "    KFE_DATABAGS_SEARCH_QUERY=$(KFE_DATABAGS_SEARCH_QUERY)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_kfe_search_databags:
	@$(INFO) "$(KFE_LABEL)Searching databags with pattern  '$(KFE_DATABAGS_SEARCH_QUERY)' ..."; $(NORMAL)
	$(KNIFE) search databag "$(KFE_DATABAGS_SEARCH_QUERY)"
