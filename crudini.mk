_CRUDINI_MK_VERSION= 0.99.0

# CII_PARAMETER?= value

# Derived parameters

# Option parameters

# UI parameters
CII_UI_LABEL?= [crudini] #

#--- Utilities
CRUDINI_BIN?= crudini
CRUDINI?= $(strip $(__CRUDINI_ENVIRONMENT) $(CRUDINI_ENVIRONMENT) $(CRUDINI_BIN) $(__CRUDINI_OPTIONS) $(CRUDINI_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _cii_view_framework_macros
_cii_view_framework_macros ::
	@echo 'CrudInI:: ($(_CRUDINI_MK_VERSION)) macros:'
	@echo

_view_framework_parameters :: _cii_view_framework_parameters
_cii_view_framework_parameters ::
	@echo 'CrudInI:: ($(_CRUDINI_MK_VERSION)) parameters:'
	@echo

_view_framework_targets :: _cii_view_framework_targets
_cii_view_framework_targets ::
	@echo 'CrudInI:: ($(_CRUDINI_MK_VERSION)) targets:'
	@echo '    _cii_install_dependencies        - install dependencies'
	@echo '    _cii_show_version                - show version of utility'
	@echo


#-----------------------------------------------------------------------
# PRIVATE TARGETS
#


MK_DIR?= .
-include $(MK_DIR)/crudini_file.mk
-include $(MK_DIR)/crudini_parameter.mk
-include $(MK_DIR)/crudini_section.mk

#-----------------------------------------------------------------------
# PUBLIC TARGETS
#

_cii_install_dependencies:
	@$(INFO) '$(CRUDINI_UI_LABEL)Install dependencies ...'; $(NORMAL)
	sudo -H pip install crudini

_cii_show_version:
	@$(INFO) '$(CRUDINI_UI_LABEL)Showing version ...'; $(NORMAL)
	$(CRUDINI) --version
