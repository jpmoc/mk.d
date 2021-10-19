_JFROG_MK_VERSION= 0.99.3

# JFG_PARAMETER?= 123456789012

# Derived variables

# Options

# UI parameters
JFG_UI_LABEL?= [jfrog] #

# Utilities

JFROG_BIN?= jfrog
JFROG?= $(strip $(__JFROG_ENVIRONMENT) $(JFROG_ENVIRONMENT) $(JFRGO_BIN) $(__JFROG_OPTIONS) $(JFROG_OPTIONS))

#--- MACROS

#----------------------------------------------------------------------
# USAGE
#

_view_framework_macros :: _jfg_view_framework_macros
_jfg_view_framework_macros ::
	@echo "JFroG:: ($(_JFROG_MK_VERSION)) macros:"
	@echo

_view_framework_parameters :: _jfg_view_framework_parameters
_jfg_view_framework_parameters ::
	@echo "JFroG:: ($(_JFROG_MK_VERSION)) parameters:"
	@echo "    JFROG=$(JFROG)"
	@echo

_view_framework_targets :: _jfg_view_framework_targets
_jfg_view_framework_targets ::
	@echo "JFroG:: ($(_JFROG_MK_VERSION)) targets:"
	@echo

#----------------------------------------------------------------------
# PRIVATE TARGETS
#

MK_DIR?=.
-include $(MK_DIR)/jfrog_artifactory.mk
-include $(MK_DIR)/jfrog_binary.mk
-include $(MK_DIR)/jfrog_missioncontrol.mk
-include $(MK_DIR)/jfrog_xray.mk

#----------------------------------------------------------------------
# PUBLIC TARGETS
#

_install_framework_dependencies :: _jfg_install_dependencies
_jfg_install_dependencies ::
	@$(INFO) '$(JFG_UI_LABEL)Installing dependencies ...'; $(NORMAL)
	@$(WARN) 'Install docs at https://jfrog.com/getcli/'; $(NORMAL)
	curl -fL https://getcli.jfrog.io | sh
