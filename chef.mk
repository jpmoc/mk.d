_CHEF_MK_VERSION=0.99.0

CHF_LABEL=[chef] #

CHEF= $(__CHEF_ENVIORNMENT) $(CHEF_ENVIRONMENT) chef $(__CHEF_OPTIONS) $(CHEF_OPTIONS)

#----------------------------------------------------------------------
# USAGE
#

_view_makefile_macros :: _chf_view_makefile_macros
_chf_view_makefile_macros ::

_view_makefile_targets :: _chf_view_makefile_targets
_chf_view_makefile_targets ::
	@echo "Chef:: ($(_CHEF_MK_VERSION)) targets:"
	@echo "    _chf_view_versions           - View the versions of chef utilities"
	@echo 

_view_makefile_variables :: _chf_view_makefile_variables
_chf_view_makefile_variables ::
	@echo "Chef:: ($(_CHEF_MK_VERSION)) variables:"
	@echo "    CHEF=$(CHEF)"
	@echo "    CHF_LABEL=$(CHF_LABEL)"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

-include $(MK_DIR)/chef_knife.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_chf_view_versions:
	@$(INFO) "$(CHF_LABEL)View utility versions ..."; $(NORMAL)
	$(CHEF) --version
